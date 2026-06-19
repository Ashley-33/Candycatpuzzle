-- 喵喵糖果星 · 排行榜增加「难度」分级（简单/普通/困难）
-- 在 Supabase 后台 → SQL Editor → 粘贴本文件全部内容并 Run 一次即可。
-- 已有的旧记录会自动归为 'normal'（普通）。

-- 1) 加难度列（默认 normal，旧数据自动填充）
alter table public.candy_scores
  add column if not exists difficulty text not null default 'normal';

-- 2) 按「难度 + 分数」建索引，三个榜单查询都走索引
create index if not exists candy_scores_diff_rank_idx
  on public.candy_scores (difficulty, score desc, created_at asc);

-- 3) 更新匿名写入策略：在原有校验基础上，限定难度只能是这三种
drop policy if exists "candy anon insert" on public.candy_scores;
create policy "candy anon insert"
  on public.candy_scores for insert
  to anon
  with check (
    char_length(btrim(name)) between 1 and 12
    and score >= 0 and score < 100000
    and difficulty in ('easy','normal','hard')
  );
