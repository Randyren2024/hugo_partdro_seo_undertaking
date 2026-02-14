# Hugo + Decap CMS 部署脚本
# 用于部署到 Netlify

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Hugo + Decap CMS 部署脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否在 exampleSite 目录
if (-not (Test-Path "hugo.toml")) {
    Write-Host "错误：请在 exampleSite 目录中运行此脚本" -ForegroundColor Red
    exit 1
}

# 检查 Git 是否初始化
if (-not (Test-Path ".git")) {
    Write-Host "正在初始化 Git 仓库..." -ForegroundColor Yellow
    git init
    
    # 创建 .gitignore
    @"
# Hugo
/public/
/resources/_gen/
.hugo_build.lock

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
}

# 检查远程仓库
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host ""
    Write-Host "请先添加远程仓库：" -ForegroundColor Yellow
    Write-Host "  git remote add origin https://github.com/你的用户名/你的仓库.git" -ForegroundColor White
    exit 1
}

Write-Host "远程仓库: $remote" -ForegroundColor Green
Write-Host ""

# 检查更改
$status = git status --porcelain
if ($status) {
    Write-Host "检测到未提交的更改：" -ForegroundColor Yellow
    git status -s
    Write-Host ""
    
    # 提交更改
    $commitMsg = Read-Host "请输入提交信息（直接回车使用默认信息）"
    if (-not $commitMsg) {
        $commitMsg = "Update site content"
    }
    
    git add .
    git commit -m "$commitMsg"
    Write-Host "更改已提交" -ForegroundColor Green
} else {
    Write-Host "没有需要提交的更改" -ForegroundColor Green
}

Write-Host ""
Write-Host "推送到远程仓库..." -ForegroundColor Yellow
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  部署成功！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "下一步：" -ForegroundColor Cyan
    Write-Host "1. 访问 Netlify 控制台查看部署状态" -ForegroundColor White
    Write-Host "2. 等待构建完成后访问你的网站" -ForegroundColor White
    Write-Host "3. 访问 /admin/ 路径进入 CMS" -ForegroundColor White
    Write-Host ""
    Write-Host "首次部署需要配置：" -ForegroundColor Yellow
    Write-Host "- 在 Netlify 启用 Identity" -ForegroundColor White
    Write-Host "- 启用 Git Gateway" -ForegroundColor White
    Write-Host "- 邀请管理员用户" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "推送失败，请检查网络连接和仓库权限" -ForegroundColor Red
}
