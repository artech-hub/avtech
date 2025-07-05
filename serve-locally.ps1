# PowerShell script to serve the built Angular app locally
# This script serves the contents of the docs folder at http://localhost:8080/avtech/

Write-Host "Starting local HTTP server for GitHub Pages testing..." -ForegroundColor Green
Write-Host "Make sure you have built the project first with: npm run build:github-pages" -ForegroundColor Yellow

if (!(Test-Path "docs")) {
    Write-Host "ERROR: docs folder not found. Please run 'npm run build:github-pages' first." -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "Using Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Start the server
Write-Host "Starting server..." -ForegroundColor Green
Write-Host "Your app will be available at: http://localhost:8080/avtech/" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow

node serve-docs.js
