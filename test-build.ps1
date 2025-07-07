# Test script to verify build process works on Windows
# Run this with: powershell -ExecutionPolicy Bypass -File test-build.ps1

Write-Host "Testing Angular build process..." -ForegroundColor Green
Write-Host "================================"

# Check Node.js version
Write-Host "Node.js version: $(node --version)"
Write-Host "npm version: $(npm --version)"

# Check if dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    npm install
}

# Check Angular CLI
Write-Host "Checking Angular CLI..." -ForegroundColor Cyan
if (Test-Path "node_modules/.bin/ng.cmd") {
    Write-Host "Angular CLI found at: node_modules/.bin/ng.cmd"
    & "node_modules/.bin/ng.cmd" version
} else {
    Write-Host "Angular CLI not found in node_modules" -ForegroundColor Red
}

# Test different build methods
Write-Host ""
Write-Host "Testing build methods..." -ForegroundColor Green
Write-Host "========================"

# Method 1: npm run build:ci
Write-Host "1. Testing npm run build:ci..." -ForegroundColor Cyan
try {
    npm run build:ci
    Write-Host "✅ npm run build:ci - SUCCESS" -ForegroundColor Green
} catch {
    Write-Host "❌ npm run build:ci - FAILED" -ForegroundColor Red
}

# Method 2: npm run build with args
Write-Host "2. Testing npm run build with args..." -ForegroundColor Cyan
try {
    npm run build -- --configuration production --output-path=docs-test --base-href=/
    Write-Host "✅ npm run build with args - SUCCESS" -ForegroundColor Green
    if (Test-Path "docs-test") { Remove-Item -Recurse -Force "docs-test" }
} catch {
    Write-Host "❌ npm run build with args - FAILED" -ForegroundColor Red
}

# Method 3: npx ng
Write-Host "3. Testing npx ng..." -ForegroundColor Cyan
try {
    npx ng build --configuration production --output-path=docs-test2 --base-href=/
    Write-Host "✅ npx ng - SUCCESS" -ForegroundColor Green
    if (Test-Path "docs-test2") { Remove-Item -Recurse -Force "docs-test2" }
} catch {
    Write-Host "❌ npx ng - FAILED" -ForegroundColor Red
}

# Method 4: Direct ng path
Write-Host "4. Testing direct ng path..." -ForegroundColor Cyan
try {
    & "node_modules/.bin/ng.cmd" build --configuration production --output-path=docs-test3 --base-href=/
    Write-Host "✅ Direct ng path - SUCCESS" -ForegroundColor Green
    if (Test-Path "docs-test3") { Remove-Item -Recurse -Force "docs-test3" }
} catch {
    Write-Host "❌ Direct ng path - FAILED" -ForegroundColor Red
}

Write-Host ""
Write-Host "Build testing completed!" -ForegroundColor Green
