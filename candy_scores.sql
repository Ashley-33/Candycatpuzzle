-- 喵喵糖果星 · 联网排行榜建表脚本
-- 在 Supabase 后台 → SQL Editor → New query 里粘贴本文件全部内容并 Run 一次即可。
-- 与 1024 项目的 scores 表相互独立，互不影响。

-- 1) 建表
create table if not exists public.candy_scores (
  id         bigint generated always as identity primary key,
  name       text        not null,
  score      integer     not null,
  created_at timestamptz not null default now()
);

-- 2) 排行榜查询用的索引（按分数降序、同分早达者靠前）
create index if not exists candy_scores_rank_idx
  on public.candy_scores (score desc, created_at asc);

-- 3) 开启行级安全（RLS）
alter table public.candy_scores enable row level security;

-- 4) 允许匿名（anon，前端用的 publishable key）读取榜单
drop policy if exists "candy anon read" on public.candy_scores;
create policy "candy anon read"
  on public.candy_scores for select
  to anon
  using (true);

-- 5) 允许匿名写入，并在数据库侧做基本兜底校验：
--    名字 1~12 字、分数 0~99999，防脏数据/刷分
drop policy if exists "candy anon insert" on public.candy_scores;
create policy "candy anon insert"
  on public.candy_scores for insert
  to anon
  with check (
    char_length(btrim(name)) between 1 and 12
    and score >= 0 and score < 100000
  );
