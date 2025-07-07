# 🌐 Custom Domain Build Guide

This guide explains how to build your Angular project for custom domains vs GitHub Pages URLs.

## 📋 Available Build Commands

### 1. **GitHub Pages Build** (for username.github.io/avtech/)
```bash
npm run build:github-pages
```
- Uses base href: `/avtech/`
- For URLs like: `https://username.github.io/avtech/`

### 2. **Custom Domain Build** (for avtechcompany.in)
```bash
npm run build:custom-domain
```
- Uses base href: `/` (root)
- For custom domains like: `https://avtechcompany.in/`
- Automatically sets domain to `avtechcompany.in`

### 3. **Flexible Domain Build** (for any custom domain)
```bash
# Direct PowerShell command with any domain
powershell -Command "./build-custom-domain.ps1 -Domain yourdomain.com"

# Or with custom base href
powershell -Command "./build-custom-domain.ps1 -Domain yourdomain.com -BaseHref /"
```

## 🔧 Script Parameters

The `build-custom-domain.ps1` script accepts the following parameters:

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `-Domain` | ✅ Yes | None | Your custom domain (e.g., `avtechcompany.in`) |
| `-BaseHref` | ❌ No | `/` | Base href for the application |

## 📁 What the Script Does

1. **Backs up important files**: CNAME, robots.txt, sitemap.xml
2. **Builds Angular app** with correct base href for custom domain
3. **Copies files** from browser folder to root level
4. **Creates/restores** important files with your domain
5. **Generates sitemap.xml** with your domain URLs
6. **Creates .nojekyll** file for GitHub Pages

## 🌍 Examples

### For avtechcompany.in (current setup):
```bash
npm run build:custom-domain
# or
powershell -Command "./build-custom-domain.ps1 -Domain avtechcompany.in"
```

### For a different domain:
```bash
powershell -Command "./build-custom-domain.ps1 -Domain mycompany.com"
```

### For subdirectory deployment:
```bash
powershell -Command "./build-custom-domain.ps1 -Domain mycompany.com -BaseHref /app/"
```

## 🚀 Deployment Workflow

### For Custom Domain (avtechcompany.in):
1. Run: `npm run build:custom-domain`
2. Commit changes: `git add . && git commit -m "Build for custom domain"`
3. Push: `git push origin main`
4. GitHub Actions will deploy to avtechcompany.in

### For GitHub Pages URL:
1. Run: `npm run build:github-pages`
2. Commit and push
3. Site available at: `https://username.github.io/avtech/`

## 🔍 Troubleshooting

### Issue: 404 errors for JS/CSS files
**Cause**: Wrong base href for your deployment type
**Solution**: Use the correct build command for your domain type

### Issue: Custom domain not working
**Cause**: CNAME file missing or incorrect
**Solution**: 
```bash
# Check CNAME file
cat docs/CNAME
# Should contain your domain: avtechcompany.in
```

### Issue: Sitemap has wrong URLs
**Cause**: Using wrong build script
**Solution**: Use `build:custom-domain` for custom domains

## 📊 Build Comparison

| Aspect | GitHub Pages Build | Custom Domain Build |
|--------|-------------------|-------------------|
| Base Href | `/avtech/` | `/` |
| CNAME | Not set | Your domain |
| Sitemap URLs | `username.github.io/avtech/` | `yourdomain.com/` |
| Robots.txt | Generic | Domain-specific |
| File Paths | `/avtech/main.js` | `/main.js` |

## 🎯 Quick Reference

```bash
# Current domain (avtechcompany.in)
npm run build:custom-domain

# Any other domain
powershell -Command "./build-custom-domain.ps1 -Domain newdomain.com"

# GitHub Pages fallback
npm run build:github-pages
```

Your website should now load correctly at https://avtechcompany.in without 404 errors! 🎉
