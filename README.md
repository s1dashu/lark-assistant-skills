<div align="center">

# lark-assistant-skills

> *「你的飞书工作副驾」*

飞书个人助理 Skill，自动读日历、任务、聊天记录，帮你写周报、做规划、诊断工作状态。

</div>

---

## 效果示例

### 周报生成

<img src="assets/screenshot-weekly.png" width="640" alt="周报示例" />

### 今日规划

<img src="assets/screenshot-plan.png" width="640" alt="今日规划示例" />

### 工作诊断

<img src="assets/screenshot-diagnosis.png" width="640" alt="工作诊断示例" />

> 💡 截图请放在 `assets/` 目录下提交到仓库，GitHub 会自动渲染。

---

## 安装

需要 Node.js 和 `lark-cli`：

```bash
# 安装 lark-cli
npm install -g @larksuite/cli

# 飞书登录
lark-cli auth login --domain calendar,task,docs,drive,im,mail,vc,minutes,okr

# 安装本 skill
npx skills add https://github.com/s1dashu/lark-assistant-skills
```

---

## 初始化配置

安装完成后，执行一次配置：

```
/lark-setup
```

按提示设置：
1. 数据源范围（日历 / 任务 / 消息 / 会议等）
2. 隐私边界（忽略的人、群、关键词）
3. 输出偏好（IM 发送 / 飞书文档 / 本地保存）

配置会保存在 `~/.lark-assistant.json`。

---

## 功能列表

| ✅ Command | 中文别名 | 功能 |
|-----------|---------|------|
| `/lark-daily-report` | `/日报` | 生成今日工作日报 |
| `/lark-weekly-report` | `/周报` | 生成本周工作周报 |
| `/lark-monthly-report` | `/月报` | 生成本月工作月报 |
| `/lark-today-plan` | `/今日规划` | 生成今日工作计划 |
| `/lark-tomorrow-plan` | `/明日规划` | 生成明日工作计划 |
| `/lark-weekly-plan` | `/本周规划` | 生成本周工作计划 |
| `/lark-meeting-brief` | `/会前简报` | 会议前自动准备背景资料 |
| `/lark-meeting-minutes` | `/会议纪要` | 整理单次会议纪要 |
| `/lark-project-summary` | `/项目总结` | 从聊天记录和文档生成项目回顾 |
| `/lark-mail-check` | `/邮箱检查` | 邮件分类和待办提取 |
| `/lark-work-diagnosis` | `/工作诊断` | 分析工作负荷、会议密度、阻塞点 |
| `/lark-knowledge-capture` | `/知识沉淀` | 将零散讨论沉淀为文档 |
| `/lark-setup` | `/设置` | 初始化配置 |

## License

MIT
