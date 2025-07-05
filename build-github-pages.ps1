# PowerShell script for GitHub Pages deployment

Write-Host "Building Angular application for GitHub Pages..." -ForegroundColor Green
ng build --configuration=production --output-path=docs --base-href=/avtech/

Write-Host "Creating root index.html and 404.html files..." -ForegroundColor Green
Copy-Item "docs/browser/index.html" "docs/index.html"
Copy-Item "docs/browser/index.html" "docs/404.html"

Write-Host "Copying browser assets to root level..." -ForegroundColor Green
Copy-Item "docs/browser/*" "docs/" -Recurse -Force

Write-Host "Updating file paths for GitHub Pages..." -ForegroundColor Green

# Update paths for favicon
(Get-Content "docs/index.html") -replace 'href="browser/favicon.ico"', 'href="favicon.ico"' | Set-Content "docs/index.html"
(Get-Content "docs/404.html") -replace 'href="browser/favicon.ico"', 'href="favicon.ico"' | Set-Content "docs/404.html"

# Update paths for CSS files
(Get-Content "docs/index.html") -replace 'href="browser/styles-', 'href="styles-' | Set-Content "docs/index.html"
(Get-Content "docs/404.html") -replace 'href="browser/styles-', 'href="styles-' | Set-Content "docs/404.html"

# Update paths for JavaScript files
(Get-Content "docs/index.html") -replace 'src="browser/polyfills-', 'src="polyfills-' | Set-Content "docs/index.html"
(Get-Content "docs/404.html") -replace 'src="browser/polyfills-', 'src="polyfills-' | Set-Content "docs/404.html"

(Get-Content "docs/index.html") -replace 'src="browser/main-', 'src="main-' | Set-Content "docs/index.html"
(Get-Content "docs/404.html") -replace 'src="browser/main-', 'src="main-' | Set-Content "docs/404.html"

Write-Host "GitHub Pages build completed successfully!" -ForegroundColor Green
Write-Host "Files generated in docs/ directory" -ForegroundColor Yellow
