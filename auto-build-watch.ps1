# Auto Build Watch Script
# This script watches for changes in source files and automatically rebuilds the project

param(
    [string]$Mode = "github-pages",
    [int]$DebounceSeconds = 2
)

Write-Host "🔄 Starting Auto Build Watch for AVtech Project" -ForegroundColor Green
Write-Host "Mode: $Mode" -ForegroundColor Cyan
Write-Host "Debounce: $DebounceSeconds seconds" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Green
Write-Host ""

# Define paths to watch
$watchPaths = @(
    "src/app/**/*.ts",
    "src/app/**/*.html",
    "src/app/**/*.css",
    "src/app/**/*.scss",
    "src/index.html",
    "src/styles.css",
    "src/robots.txt",
    "src/sitemap.xml",
    "angular.json",
    "package.json"
)

# Function to perform the build
function Invoke-Build {
    param([string]$BuildMode)
    
    Write-Host "🔧 Changes detected! Building..." -ForegroundColor Yellow
    Write-Host "Time: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
    
    try {
        if ($BuildMode -eq "github-pages") {
            Write-Host "Building for GitHub Pages..." -ForegroundColor Cyan
            & "./build-enhanced.ps1"
        } else {
            Write-Host "Building for development..." -ForegroundColor Cyan
            ng build --configuration development --output-path=docs --base-href=/avtech/
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Build completed successfully!" -ForegroundColor Green
            Write-Host "🌐 Your website is updated and ready!" -ForegroundColor Green
        } else {
            Write-Host "❌ Build failed!" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ Error during build: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "👀 Watching for changes..." -ForegroundColor Yellow
    Write-Host ""
}

# Function to check if files have changed
function Test-FileChanges {
    param([hashtable]$FileHashes)
    
    $hasChanges = $false
    $changedFiles = @()
    
    foreach ($pattern in $watchPaths) {
        $files = Get-ChildItem -Path $pattern -Recurse -File -ErrorAction SilentlyContinue
        
        foreach ($file in $files) {
            $currentHash = Get-FileHash -Path $file.FullName -Algorithm MD5
            $relativePath = $file.FullName.Replace((Get-Location).Path, "").TrimStart('\')
            
            if ($FileHashes.ContainsKey($relativePath)) {
                if ($FileHashes[$relativePath] -ne $currentHash.Hash) {
                    $hasChanges = $true
                    $changedFiles += $relativePath
                    $FileHashes[$relativePath] = $currentHash.Hash
                }
            } else {
                $hasChanges = $true
                $changedFiles += $relativePath
                $FileHashes[$relativePath] = $currentHash.Hash
            }
        }
    }
    
    return @{
        HasChanges = $hasChanges
        ChangedFiles = $changedFiles
    }
}

# Initialize file hashes
Write-Host "📝 Initializing file monitoring..." -ForegroundColor Yellow
$fileHashes = @{}

foreach ($pattern in $watchPaths) {
    $files = Get-ChildItem -Path $pattern -Recurse -File -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        $hash = Get-FileHash -Path $file.FullName -Algorithm MD5
        $relativePath = $file.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        $fileHashes[$relativePath] = $hash.Hash
    }
}

Write-Host "📁 Monitoring $($fileHashes.Count) files" -ForegroundColor Cyan
Write-Host ""

# Perform initial build
Write-Host "🚀 Performing initial build..." -ForegroundColor Yellow
Invoke-Build -BuildMode $Mode

# Last build time to implement debouncing
$lastBuildTime = Get-Date

# Main watch loop
Write-Host "👀 Watching for changes... (Press Ctrl+C to stop)" -ForegroundColor Yellow
Write-Host ""

try {
    while ($true) {
        Start-Sleep -Seconds 1
        
        $changes = Test-FileChanges -FileHashes $fileHashes
        
        if ($changes.HasChanges) {
            $timeSinceLastBuild = (Get-Date) - $lastBuildTime
            
            if ($timeSinceLastBuild.TotalSeconds -ge $DebounceSeconds) {
                Write-Host "📝 Changed files:" -ForegroundColor Cyan
                foreach ($file in $changes.ChangedFiles) {
                    Write-Host "   - $file" -ForegroundColor White
                }
                Write-Host ""
                
                Invoke-Build -BuildMode $Mode
                $lastBuildTime = Get-Date
            }
        }
    }
} catch [System.Management.Automation.PipelineStoppedException] {
    Write-Host ""
    Write-Host "🛑 Auto build watch stopped." -ForegroundColor Yellow
} catch {
    Write-Host ""
    Write-Host "❌ Error in watch loop: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "👋 Auto build watch terminated." -ForegroundColor Green
