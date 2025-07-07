const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

class AutoBuildWatcher {
    constructor() {
        this.watchPaths = [
            'src/app',
            'src/index.html',
            'src/styles.css',
            'src/robots.txt',
            'src/sitemap.xml',
            'angular.json',
            'package.json'
        ];
        
        this.debounceTime = 2000; // 2 seconds
        this.buildTimeout = null;
        this.isBuilding = false;
        this.buildMode = process.argv[2] || 'github-pages';
        
        console.log('🔄 Starting Auto Build Watch for AVtech Project');
        console.log('Mode:', this.buildMode);
        console.log('Debounce:', this.debounceTime / 1000, 'seconds');
        console.log('=========================================');
        console.log('');
    }
    
    start() {
        console.log('📝 Initializing file monitoring...');
        
        // Perform initial build
        this.performBuild();
        
        // Start watching files
        this.watchPaths.forEach(watchPath => {
            if (fs.existsSync(watchPath)) {
                const stats = fs.statSync(watchPath);
                
                if (stats.isDirectory()) {
                    this.watchDirectory(watchPath);
                } else {
                    this.watchFile(watchPath);
                }
            }
        });
        
        console.log('👀 Watching for changes... (Press Ctrl+C to stop)');
        console.log('');
    }
    
    watchDirectory(dirPath) {
        fs.watch(dirPath, { recursive: true }, (eventType, filename) => {
            if (filename && this.shouldWatch(filename)) {
                this.onFileChange(path.join(dirPath, filename));
            }
        });
    }
    
    watchFile(filePath) {
        fs.watch(filePath, (eventType, filename) => {
            this.onFileChange(filePath);
        });
    }
    
    shouldWatch(filename) {
        const ext = path.extname(filename).toLowerCase();
        const watchExtensions = ['.ts', '.html', '.css', '.scss', '.json'];
        return watchExtensions.includes(ext) || filename === 'index.html';
    }
    
    onFileChange(filePath) {
        if (this.isBuilding) return;
        
        console.log('📝 Change detected:', filePath);
        
        // Clear existing timeout
        if (this.buildTimeout) {
            clearTimeout(this.buildTimeout);
        }
        
        // Set new timeout for debouncing
        this.buildTimeout = setTimeout(() => {
            this.performBuild();
        }, this.debounceTime);
    }
    
    performBuild() {
        if (this.isBuilding) return;
        
        this.isBuilding = true;
        console.log('🔧 Changes detected! Building...');
        console.log('Time:', new Date().toLocaleTimeString());
        
        const buildCommand = this.buildMode === 'github-pages' 
            ? 'powershell -Command "./build-enhanced.ps1"'
            : 'ng build --configuration development --output-path=docs --base-href=/avtech/';
        
        exec(buildCommand, (error, stdout, stderr) => {
            this.isBuilding = false;
            
            if (error) {
                console.log('❌ Build failed!');
                console.error(stderr);
            } else {
                console.log('✅ Build completed successfully!');
                console.log('🌐 Your website is updated and ready!');
            }
            
            console.log('');
            console.log('👀 Watching for changes...');
            console.log('');
        });
    }
}

// Handle graceful shutdown
process.on('SIGINT', () => {
    console.log('');
    console.log('🛑 Auto build watch stopped.');
    console.log('👋 Auto build watch terminated.');
    process.exit(0);
});

// Start the watcher
const watcher = new AutoBuildWatcher();
watcher.start();
