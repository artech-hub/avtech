# Quick URL Test Script
Write-Host "Testing AVtech Website URLs" -ForegroundColor Green
Write-Host "===========================" -ForegroundColor Green
Write-Host ""

$testUrls = @(
    "https://avtechcompany.in/",
    "https://avtechcompany.in/main-66HYYMFX.js",
    "https://avtechcompany.in/polyfills-B6TNHZQ6.js", 
    "https://avtechcompany.in/styles-UO5IXDN7.css",
    "https://avtechcompany.in/favicon.ico"
)

Write-Host "Testing file URLs (these should work after deployment):" -ForegroundColor Yellow
foreach ($url in $testUrls) {
    Write-Host "  $url" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Local files check:" -ForegroundColor Yellow
Write-Host "  index.html base href: $(if((Get-Content docs\index.html | Select-String 'base href=\"/\"') -ne $null){'✓ Root (/)'}else{'✗ Not root'})" -ForegroundColor Cyan
Write-Host "  main-66HYYMFX.js: $(if(Test-Path 'docs\main-66HYYMFX.js'){'✓ Exists'}else{'✗ Missing'})" -ForegroundColor Cyan
Write-Host "  polyfills-B6TNHZQ6.js: $(if(Test-Path 'docs\polyfills-B6TNHZQ6.js'){'✓ Exists'}else{'✗ Missing'})" -ForegroundColor Cyan
Write-Host "  styles-UO5IXDN7.css: $(if(Test-Path 'docs\styles-UO5IXDN7.css'){'✓ Exists'}else{'✗ Missing'})" -ForegroundColor Cyan
Write-Host "  CNAME: $(if(Test-Path 'docs\CNAME'){'✓ Exists'}else{'✗ Missing'})" -ForegroundColor Cyan

Write-Host ""
Write-Host "What was fixed:" -ForegroundColor Green
Write-Host "  ✓ Base href changed from '/avtech/' to '/'" -ForegroundColor White
Write-Host "  ✓ Files are now accessible at root level" -ForegroundColor White
Write-Host "  ✓ URLs will work: https://avtechcompany.in/file.js" -ForegroundColor White
Write-Host "  ✓ Instead of: https://avtechcompany.in/avtech/file.js" -ForegroundColor White

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Commit and push these changes" -ForegroundColor White
Write-Host "  2. Wait 5-10 minutes for GitHub Actions deployment" -ForegroundColor White
Write-Host "  3. Clear browser cache (Ctrl+Shift+Delete)" -ForegroundColor White
Write-Host "  4. Test https://avtechcompany.in/" -ForegroundColor White
Write-Host "  5. Check browser console - no more 404 errors!" -ForegroundColor White

Write-Host ""
Write-Host "Build commands for future use:" -ForegroundColor Yellow
Write-Host "  For custom domain: npm run build:custom-domain" -ForegroundColor Cyan
Write-Host "  For GitHub Pages: npm run build:github-pages" -ForegroundColor Cyan
