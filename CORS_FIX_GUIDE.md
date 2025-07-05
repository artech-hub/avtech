# CORS Error Fix & Local Testing Guide

## The Problem Explained

The CORS (Cross-Origin Resource Sharing) errors you encountered occur because:

1. **File Protocol Limitation**: Modern browsers block local file access when using `file://` protocol
2. **ES Modules Security**: Angular uses ES modules (`type="module"`) which require HTTP/HTTPS
3. **Base Href Configuration**: The `/avtech/` base href expects a proper web server context

## ✅ SOLUTIONS

### 1. **For Development Testing** (Recommended)
Use the Angular development server:
```bash
ng serve
```
Then visit: `http://localhost:4200`

### 2. **For Testing Built Files Locally**
Use the custom HTTP server we created:
```bash
npm run serve:docs
```
Then visit: `http://localhost:8080/avtech/`

### 3. **Alternative: Python HTTP Server**
If you have Python installed:
```bash
python serve-python.py
```
Then visit: `http://localhost:8000/`

### 4. **Alternative: PowerShell Script**
Run the PowerShell script:
```powershell
.\serve-locally.ps1
```

## 🔧 WHAT WE FIXED

1. **Updated Build Process**: Modified scripts to copy files to root level of `docs/`
2. **Fixed File Paths**: Updated HTML to reference assets without `browser/` prefix
3. **Created Local Servers**: Added multiple ways to test locally
4. **GitHub Actions**: Updated workflow for correct deployment structure

## 📁 CORRECT FILE STRUCTURE

After running `.\build-github-pages.ps1`, your `docs/` folder should look like:

```
docs/
├── index.html          # Main entry point
├── 404.html            # Error page
├── favicon.ico         # Favicon
├── styles-*.css        # Styles
├── main-*.js           # Main app bundle
├── polyfills-*.js      # Polyfills
├── assets/             # Static assets
└── browser/            # Original Angular build (can be ignored)
```

## 🚀 DEPLOYMENT PROCESS

1. **Build for GitHub Pages**:
   ```powershell
   .\build-github-pages.ps1
   ```

2. **Test Locally**:
   ```bash
   npm run serve:docs
   ```

3. **Deploy to GitHub**:
   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin main
   ```

## 🎯 GITHUB PAGES SETUP

1. Go to your repository settings
2. Navigate to "Pages" section
3. Select "Deploy from a branch"
4. Choose "main" branch and "/docs" folder
5. Your site will be at: `https://yourusername.github.io/avtech/`

## 🐛 TROUBLESHOOTING

### If you still get CORS errors:
- ✅ Make sure you're using `http://localhost:8080/avtech/` (not `file://`)
- ✅ Ensure the build script completed successfully
- ✅ Check that all files exist in `docs/` root directory

### If assets don't load:
- ✅ Verify `favicon.ico`, `styles-*.css`, and `main-*.js` are in `docs/` root
- ✅ Check that paths in `index.html` don't include `browser/` prefix
- ✅ Ensure base href is set to `/avtech/`

### If routing doesn't work:
- ✅ Ensure `404.html` exists and is identical to `index.html`
- ✅ Check that wildcard route is configured in `app.routes.ts`

## 📝 COMMANDS SUMMARY

```bash
# Development
ng serve

# Build for GitHub Pages
.\build-github-pages.ps1

# Test built files locally
npm run serve:docs

# Alternative Python server
python serve-python.py

# Alternative PowerShell server
.\serve-locally.ps1
```

Your Angular application is now properly configured for GitHub Pages deployment! 🎉
