# Website Diagnosis Script
Write-Host "Website Diagnosis" -ForegroundColor Green
Write-Host "=================" -ForegroundColor Green
Write-Host ""

# Check if important files exist
Write-Host "Checking file existence:" -ForegroundColor Yellow
$files = @(
    "docs/index.html",
    "docs/404.html",
    "docs/main-66HYYMFX.js",
    "docs/polyfills-B6TNHZQ6.js",
    "docs/styles-UO5IXDN7.css",
    "docs/CNAME",
    "docs/robots.txt",
    "docs/sitemap.xml",
    "docs/.nojekyll"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "  ✓ $file" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "CNAME Configuration:" -ForegroundColor Yellow
if (Test-Path "docs/CNAME") {
    $cname = Get-Content "docs/CNAME" -Raw
    Write-Host "  Domain: $($cname.Trim())" -ForegroundColor Cyan
} else {
    Write-Host "  CNAME file not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "Testing URLs:" -ForegroundColor Yellow
$testUrls = @(
    "https://avtechcompany.in/",
    "https://avtechcompany.in/main-66HYYMFX.js",
    "https://avtechcompany.in/polyfills-B6TNHZQ6.js",
    "https://avtechcompany.in/styles-UO5IXDN7.css"
)

foreach ($url in $testUrls) {
    try {
        $response = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 10 -ErrorAction Stop
        Write-Host "  ✓ $url (Status: $($response.StatusCode))" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ $url (Error: Connection failed)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Recommendations:" -ForegroundColor Yellow
Write-Host "  1. Check GitHub Pages settings:" -ForegroundColor Cyan
Write-Host "     - Go to: https://github.com/artech-hub/avtech/settings/pages" -ForegroundColor White
Write-Host "     - Source: Deploy from a branch" -ForegroundColor White
Write-Host "     - Branch: main, Folder: /docs" -ForegroundColor White
Write-Host "     - Custom domain: avtechcompany.in" -ForegroundColor White

Write-Host ""
Write-Host "  2. Check GitHub Actions:" -ForegroundColor Cyan
Write-Host "     - Go to: https://github.com/artech-hub/avtech/actions" -ForegroundColor White
Write-Host "     - Look for Deploy to GitHub Pages workflow" -ForegroundColor White

Write-Host ""
Write-Host "  3. Test locally:" -ForegroundColor Cyan
Write-Host "     - Run: npm run serve:docs" -ForegroundColor White
Write-Host "     - Visit: http://localhost:8080/avtech/" -ForegroundColor White

Write-Host ""
Write-Host "Diagnosis complete!" -ForegroundColor Green
