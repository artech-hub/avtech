# 🔄 Auto Build Watch System

This system automatically monitors your source files and rebuilds your Angular project whenever changes are detected. No more manual builds!

## 🚀 Quick Start

### Method 1: Node.js Watcher (Recommended)
```bash
# Watch and auto-build for GitHub Pages
npm run watch:github-pages

# Watch and auto-build for development
npm run watch:dev
```

### Method 2: PowerShell Watcher (Windows)
```powershell
# Direct PowerShell execution
.\auto-build-watch.ps1

# With parameters
.\auto-build-watch.ps1 -Mode github-pages -DebounceSeconds 3
```

### Method 3: Batch File (Windows)
```cmd
# Simple batch file execution
auto-build-watch.bat
```

## 📁 Monitored Files

The system watches for changes in:
- ✅ `src/app/**/*.ts` - TypeScript components
- ✅ `src/app/**/*.html` - HTML templates
- ✅ `src/app/**/*.css` - CSS stylesheets
- ✅ `src/app/**/*.scss` - SCSS stylesheets
- ✅ `src/index.html` - Main HTML file
- ✅ `src/styles.css` - Global styles
- ✅ `src/robots.txt` - SEO robots file
- ✅ `src/sitemap.xml` - SEO sitemap
- ✅ `angular.json` - Angular configuration
- ✅ `package.json` - NPM configuration

## 🔧 How It Works

1. **File Monitoring**: Continuously monitors specified files and directories
2. **Change Detection**: Detects when files are modified, added, or deleted
3. **Debouncing**: Waits 2 seconds after last change to avoid excessive builds
4. **Automatic Build**: Runs the enhanced build process automatically
5. **File Preservation**: Maintains CNAME, robots.txt, and sitemap.xml files
6. **Status Updates**: Provides real-time feedback on build status

## 📋 Available Scripts

| Script | Description |
|--------|-------------|
| `npm run watch:github-pages` | Auto-build for GitHub Pages deployment |
| `npm run watch:dev` | Auto-build for development |
| `npm run auto-build` | Manual enhanced build |
| `npm run dev:auto` | Development server + auto-build |

## ⚙️ Configuration

### Node.js Watcher (`auto-build-watch.js`)
```javascript
// Default settings
debounceTime: 2000,     // 2 seconds
buildMode: 'github-pages' // or 'development'
```

### PowerShell Watcher (`auto-build-watch.ps1`)
```powershell
# Parameters
-Mode "github-pages"    # Build mode
-DebounceSeconds 2      # Debounce time
```

## 🎯 Benefits

### ✅ **Automatic Updates**
- No manual `npm run build` commands
- Index.html always reflects latest changes
- Real-time website updates

### ✅ **Smart Building**
- Debounced builds prevent excessive rebuilding
- Only builds when actual changes detected
- Preserves important files (CNAME, robots.txt, sitemap.xml)

### ✅ **Development Efficiency**
- Focus on coding, not building
- Instant feedback on changes
- Reduced context switching

### ✅ **File Integrity**
- Maintains custom domain settings
- Preserves SEO configurations
- Keeps manual sitemap.xml edits

## 🛠️ Troubleshooting

### Issue: Watcher not detecting changes
**Solution**: Ensure you're running the command from the project root directory.

### Issue: Build fails repeatedly
**Solution**: Check if there are TypeScript compilation errors in your source files.

### Issue: CNAME file gets deleted
**Solution**: The enhanced build script automatically restores CNAME files.

### Issue: Too many builds triggered
**Solution**: Increase the debounce time in the configuration.

## 📊 Watch System Status

When running, you'll see:
- 🔄 **Starting**: System initialization
- 📝 **Monitoring**: File change detection
- 🔧 **Building**: Build process running
- ✅ **Success**: Build completed successfully
- ❌ **Failed**: Build encountered errors
- 👀 **Watching**: Ready for next changes

## 🔧 Advanced Usage

### Custom Build Commands
You can modify the build commands in `auto-build-watch.js`:
```javascript
const buildCommand = this.buildMode === 'github-pages' 
    ? 'powershell -Command "./build-enhanced.ps1"'
    : 'ng build --configuration development --output-path=docs --base-href=/avtech/';
```

### Adding New Watch Paths
Update the `watchPaths` array in the watcher files:
```javascript
this.watchPaths = [
    'src/app',
    'src/assets',      // Add new path
    'src/index.html',
    // ... existing paths
];
```

## 🎉 Getting Started

1. **Open Terminal**: Navigate to your project directory
2. **Start Watching**: Run `npm run watch:github-pages`
3. **Make Changes**: Edit any source file
4. **See Magic**: Watch as your site rebuilds automatically!

## 📞 Support

If you encounter issues:
1. Check the console output for error messages
2. Ensure all dependencies are installed
3. Verify file permissions
4. Try restarting the watcher

**Happy coding! 🚀**
