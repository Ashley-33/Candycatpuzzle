# 喵喵糖果星 🍬

可爱风糖果消除小游戏（拖动糖果填满整排即消除）。纯前端单文件，联网排行榜基于 Supabase。

## 在线试玩
GitHub Pages 部署后访问仓库的 Pages 地址即可。

## 功能
- 4 种糖果（软糖 / 旋旋糖 / 巧克力 / 马卡龙）+ 星星能量驱动的 4 个工具
- 联网排行榜（Supabase）+ 留名上榜（含敏感词校验，前端 + 数据库 RLS 双重兜底）
- 首次玩法说明、帮助弹窗、加入主屏横幅（PWA，可加到手机主屏全屏运行）

## 联网排行榜建表
首次使用需在 Supabase SQL Editor 执行一次 `candy_scores.sql` 建表。

## 文件
- `index.html` — 游戏本体（含全部逻辑与样式）
- `manifest.json`、`*.png` — PWA 图标与配置
- `candy_scores.sql` — 排行榜建表脚本
