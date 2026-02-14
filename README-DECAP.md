# Decap CMS 本地开发指南

## 项目概述

本项目已集成 Decap CMS（前身为 Netlify CMS），提供了一个可视化内容管理界面。

## 本地开发

### 1. 启动 Hugo 开发服务器

```bash
cd exampleSite
npm install
npm start
```

Hugo 服务器将在 http://localhost:1313/ 运行

### 2. 启动 Decap CMS 本地后端（可选）

如果你想在本地测试 CMS 功能，需要启动本地后端：

```bash
# 在另一个终端窗口
npx decap-server
```

这将启动一个本地后端服务，允许你在本地测试 CMS 功能。

### 3. 访问 CMS

打开浏览器访问 http://localhost:1313/admin/

**注意**：本地开发时，CMS 会自动使用本地文件系统作为后端，不需要 Netlify Identity。

## 生产环境部署

### 部署到 Netlify

1. **推送代码到 Git 仓库**
   ```bash
   git add .
   git commit -m "Add Decap CMS"
   git push origin main
   ```

2. **在 Netlify 上创建站点**
   - 登录 Netlify
   - 点击 "New site from Git"
   - 选择你的仓库
   - 构建设置：
     - Build command: `npm run build`
     - Publish directory: `public`

3. **启用 Netlify Identity**
   - 进入 Site settings → Identity
   - 点击 "Enable Identity"
   - 设置注册偏好（建议使用 Invite only）

4. **启用 Git Gateway**
   - 在 Identity 设置中，启用 Git Gateway
   - 这将允许 CMS 通过 Git 提交更改

5. **添加管理员**
   - 在 Identity 标签页，邀请用户
   - 用户会收到邮件设置密码

6. **更新站点 URL**
   修改 `static/admin/config.yml` 中的 `site_url` 为你的实际域名：
   ```yaml
   site_url: https://your-site.netlify.app
   ```

### 部署后配置

部署完成后，需要：

1. 禁用本地后端（生产环境）
   编辑 `static/admin/config.yml`：
   ```yaml
   # 生产环境禁用本地后端
   # local_backend: true
   ```

2. 提交并推送更改
   ```bash
   git add static/admin/config.yml
   git commit -m "Disable local backend for production"
   git push origin main
   ```

## CMS 功能

### 内容集合

已配置以下内容类型：

- **博客文章** - 创建和管理博客内容
- **功能页面** - 产品功能介绍
- **招聘职位** - 招聘信息管理
- **普通页面** - 通用页面内容
- **首页** - 首页内容编辑
- **站点设置** - Hugo 配置

### 媒体管理

- 上传路径：`static/images/uploads/`
- 支持的格式：jpg, png, gif, webp, svg
- 自动优化：Netlify 会自动优化图片

### 编辑器功能

- Markdown 编辑器
- 富文本编辑
- 图片上传和预览
- 实时预览
- 草稿/发布状态管理

## 常见问题

### 本地开发时 CMS 显示错误

本地开发需要启用 `local_backend: true`，这在 `config.yml` 中已经配置。

### 生产环境无法登录

1. 确认 Netlify Identity 已启用
2. 确认 Git Gateway 已启用
3. 确认用户已被邀请并激活

### 图片上传失败

1. 检查 `media_folder` 路径是否正确
2. 确认仓库有写入权限
3. 检查图片大小和格式

### 内容保存失败

1. 检查 Git Gateway 配置
2. 查看 Netlify 构建日志
3. 确认分支名称正确

## 文件结构

```
exampleSite/
├── static/
│   └── admin/
│       ├── index.html      # CMS 入口页面
│       └── config.yml      # CMS 配置文件
├── content/                # 内容目录
│   ├── blog/              # 博客文章
│   ├── features/          # 功能页面
│   ├── jobs/              # 招聘职位
│   └── ...
├── netlify.toml           # Netlify 配置
└── hugo.toml              # Hugo 配置
```

## 自定义配置

### 添加新的内容集合

编辑 `static/admin/config.yml`，在 `collections` 部分添加：

```yaml
collections:
  - name: "products"
    label: "产品"
    folder: "content/products"
    create: true
    fields:
      - { label: "产品名称", name: "title", widget: "string" }
      - { label: "价格", name: "price", widget: "number" }
      - { label: "描述", name: "body", widget: "markdown" }
```

### 修改字段

每个内容集合的 `fields` 数组定义了编辑表单中的字段：

```yaml
fields:
  - { label: "标题", name: "title", widget: "string" }
  - { label: "日期", name: "date", widget: "datetime" }
  - { label: "正文", name: "body", widget: "markdown" }
```

可用的小部件类型：
- `string` - 单行文本
- `text` - 多行文本
- `markdown` - Markdown 编辑器
- `datetime` - 日期时间选择器
- `image` - 图片上传
- `boolean` - 开关
- `list` - 列表
- `select` - 下拉选择
- `object` - 对象/嵌套字段

## 更多资源

- [Decap CMS 官方文档](https://decapcms.org/docs/)
- [Netlify Identity 文档](https://docs.netlify.com/visitor-access/identity/)
- [Hugo 文档](https://gohugo.io/documentation/)

## 技术支持

遇到问题？

1. 查看 [Decap CMS GitHub Issues](https://github.com/decaporg/decap-cms/issues)
2. 访问 [Netlify Community](https://community.netlify.com/)
3. 查阅 [Hugo Forums](https://discourse.gohugo.io/)
