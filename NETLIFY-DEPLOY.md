# Netlify 部署指南

本指南将帮助你将 Hugo 网站部署到 Netlify，并启用 Decap CMS 进行可视化内容管理。

## 前置要求

- GitHub/GitLab/Bitbucket 账号
- Netlify 账号（可使用 GitHub 账号直接登录）
- 已安装 Hugo Extended 版本（本地开发使用）

## 部署步骤

### 1. 创建 Git 仓库

将项目代码推送到 Git 仓库：

```bash
# 初始化 Git 仓库（如果还没有）
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "Initial commit with Decap CMS"

# 添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/yourusername/your-repo.git

# 推送到远程仓库
git push -u origin main
```

### 2. 在 Netlify 上部署

#### 方法一：通过 Netlify UI 部署

1. 登录 [Netlify](https://www.netlify.com/)
2. 点击 "Add new site" → "Import an existing project"
3. 选择你的 Git 提供商（GitHub/GitLab/Bitbucket）
4. 授权并选择你的仓库
5. 配置构建设置：
   - **Build command**: `npm run build`
   - **Publish directory**: `public`
6. 点击 "Deploy site"

#### 方法二：使用 Netlify CLI

```bash
# 安装 Netlify CLI
npm install -g netlify-cli

# 登录 Netlify
netlify login

# 初始化项目
netlify init

# 部署
netlify deploy --prod
```

### 3. 启用 Netlify Identity

1. 在 Netlify 控制台中，进入 **Site settings** → **Identity**
2. 点击 **Enable Identity**
3. 在 **Registration** 设置中，选择：
   - **Invite only**（推荐用于生产环境）
   - 或 **Open**（允许任何人注册）

### 4. 启用 Git Gateway

1. 在 Identity 设置页面，向下滚动到 **Services** 部分
2. 点击 **Enable Git Gateway**
3. 这将自动创建 GitHub/GitLab OAuth 授权

### 5. 添加管理员用户

1. 在 Identity 标签页，点击 **Invite users**
2. 输入你的邮箱地址
3. 点击 **Send invite**
4. 检查邮箱，点击邀请链接设置密码

### 6. 访问 Decap CMS

部署完成后，访问 `https://your-site.netlify.app/admin/` 即可进入 Decap CMS 管理界面。

## 配置说明

### 已配置的功能

- ✅ Hugo 静态站点生成
- ✅ Decap CMS 内容管理
- ✅ Netlify Identity 身份验证
- ✅ Git Gateway 内容同步
- ✅ 图片上传和媒体管理
- ✅ 响应式预览

### 内容集合

Decap CMS 已配置以下内容类型：

1. **博客文章** (`blog`) - 创建和管理博客文章
2. **功能页面** (`features`) - 产品功能介绍页面
3. **招聘职位** (`jobs`) - 公司招聘信息
4. **普通页面** (`pages`) - 通用页面内容
5. **首页** (`homepage`) - 首页内容编辑
6. **站点设置** (`settings`) - Hugo 配置编辑

### 本地开发

```bash
# 安装依赖
npm install

# 启动开发服务器
npm start

# 访问本地 CMS（需要本地后端）
# 1. 安装本地后端
npx decap-server
# 2. 访问 http://localhost:1313/admin/
```

## 故障排除

### 无法登录 CMS

1. 确认 Netlify Identity 已启用
2. 确认 Git Gateway 已启用
3. 检查用户是否已被邀请并激活

### 内容无法保存

1. 确认 Git Gateway 配置正确
2. 检查仓库权限设置
3. 查看 Netlify 构建日志

### 图片上传失败

1. 确认 `media_folder` 路径正确
2. 检查仓库写入权限
3. 确认图片格式和大小符合要求

## 自定义配置

### 修改 CMS 配置

编辑 `static/admin/config.yml` 文件：

```yaml
backend:
  name: git-gateway
  branch: main  # 修改默认分支

media_folder: "static/images/uploads"  # 修改媒体上传路径
public_folder: "/images/uploads"

site_url: https://your-site.netlify.app  # 修改站点 URL
```

### 添加新的内容集合

在 `config.yml` 的 `collections` 部分添加：

```yaml
collections:
  - name: "new-collection"
    label: "新集合"
    folder: "content/new-folder"
    create: true
    fields:
      - { label: "标题", name: "title", widget: "string" }
      - { label: "正文", name: "body", widget: "markdown" }
```

## 安全建议

1. **使用 Invite only 注册模式** - 防止未授权访问
2. **定期备份仓库** - 防止数据丢失
3. **启用 2FA** - 为 Git 和 Netlify 账号启用双因素认证
4. **审查权限** - 定期检查 Identity 用户列表

## 相关链接

- [Decap CMS 文档](https://decapcms.org/docs/)
- [Netlify Identity 文档](https://docs.netlify.com/visitor-access/identity/)
- [Hugo 文档](https://gohugo.io/documentation/)
- [Git Gateway 文档](https://docs.netlify.com/visitor-access/git-gateway/)

## 获取帮助

遇到问题？请查看：

1. [Decap CMS GitHub Issues](https://github.com/decaporg/decap-cms/issues)
2. [Netlify Community](https://community.netlify.com/)
3. [Hugo Forums](https://discourse.gohugo.io/)
