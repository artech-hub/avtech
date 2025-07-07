# GitHub Pages SSL Certificate Fix Script
# This script helps fix SSL certificate issues for custom domains

Write-Host "🔒 GitHub Pages SSL Certificate Fix Script" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

# Check if CNAME file exists and has correct content
Write-Host "1. Checking CNAME file..." -ForegroundColor Yellow
$cnameFile = "docs\CNAME"
if (Test-Path $cnameFile) {
    $cnameContent = Get-Content $cnameFile -Raw
    if ($cnameContent.Trim() -eq "avtechcompany.in") {
        Write-Host "   ✅ CNAME file is correct: avtechcompany.in" -ForegroundColor Green
    } else {
        Write-Host "   ❌ CNAME file content is incorrect" -ForegroundColor Red
        Write-Host "   🔧 Fixing CNAME file..." -ForegroundColor Yellow
        "avtechcompany.in" | Out-File -FilePath $cnameFile -Encoding utf8 -NoNewline
        Write-Host "   ✅ CNAME file updated" -ForegroundColor Green
    }
} else {
    Write-Host "   ❌ CNAME file does not exist" -ForegroundColor Red
    Write-Host "   🔧 Creating CNAME file..." -ForegroundColor Yellow
    "avtechcompany.in" | Out-File -FilePath $cnameFile -Encoding utf8 -NoNewline
    Write-Host "   ✅ CNAME file created" -ForegroundColor Green
}

Write-Host ""
Write-Host "2. Checking DNS configuration..." -ForegroundColor Yellow
try {
    $dnsResult = Resolve-DnsName -Name "avtechcompany.in" -Type A -ErrorAction SilentlyContinue
    if ($dnsResult) {
        Write-Host "   ✅ DNS resolution successful" -ForegroundColor Green
        Write-Host "   📍 IP addresses:" -ForegroundColor Cyan
        foreach ($record in $dnsResult) {
            Write-Host "      - $($record.IPAddress)" -ForegroundColor White
        }
    } else {
        Write-Host "   ❌ DNS resolution failed" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ Error checking DNS: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "3. Testing SSL certificate..." -ForegroundColor Yellow
try {
    $uri = "https://avtechcompany.in"
    $request = [System.Net.WebRequest]::Create($uri)
    $request.Method = "HEAD"
    $request.Timeout = 10000
    
    $response = $request.GetResponse()
    if ($response.StatusCode -eq "OK") {
        Write-Host "   ✅ SSL certificate is working" -ForegroundColor Green
        Write-Host "   🎉 Your site is secure!" -ForegroundColor Green
    }
    $response.Close()
} catch [System.Net.WebException] {
    if ($_.Exception.Message -contains "SSL") {
        Write-Host "   ❌ SSL certificate issue detected" -ForegroundColor Red
        Write-Host "   ⏰ SSL certificate may still be provisioning..." -ForegroundColor Yellow
    } else {
        Write-Host "   ❌ Connection error: $($_.Exception.Message)" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ Error testing SSL: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "4. Next steps for GitHub Pages configuration:" -ForegroundColor Yellow
Write-Host "   1. Go to: https://github.com/artech-hub/avtech/settings/pages" -ForegroundColor Cyan
Write-Host "   2. In Custom domain section:" -ForegroundColor Cyan
Write-Host "      - Remove avtechcompany.in and save" -ForegroundColor White
Write-Host "      - Wait 2-3 minutes" -ForegroundColor White
Write-Host "      - Re-enter avtechcompany.in and save" -ForegroundColor White
Write-Host "   3. Wait 5-10 minutes for SSL certificate provisioning" -ForegroundColor Cyan
Write-Host "   4. Enable Enforce HTTPS checkbox when it appears" -ForegroundColor Cyan
Write-Host ""

Write-Host "🚀 Automated commit and push (if CNAME was updated):" -ForegroundColor Yellow
$hasChanges = git status --porcelain
if ($hasChanges) {
    Write-Host "   📝 Committing changes..." -ForegroundColor Yellow
    git add docs/CNAME
    git commit -m "Update CNAME for SSL certificate fix"
    
    Write-Host "   📤 Pushing to GitHub..." -ForegroundColor Yellow
    git push origin main
    
    Write-Host "   ✅ Changes pushed successfully!" -ForegroundColor Green
} else {
    Write-Host "   ✅ No changes to commit" -ForegroundColor Green
}

Write-Host ""
Write-Host "🕐 SSL Certificate Timeline:" -ForegroundColor Yellow
Write-Host "   - Initial setup: 10-15 minutes" -ForegroundColor White
Write-Host "   - DNS propagation: Up to 24-48 hours" -ForegroundColor White
Write-Host "   - SSL activation: 5-10 minutes after DNS resolves" -ForegroundColor White
Write-Host ""

Write-Host "🔍 Monitor SSL status at:" -ForegroundColor Yellow
Write-Host "   - https://www.ssllabs.com/ssltest/analyze.html?d=avtechcompany.in" -ForegroundColor Cyan
Write-Host "   - https://whynopadlock.com/avtechcompany.in" -ForegroundColor Cyan
Write-Host ""

Write-Host "🎯 Expected result: https://avtechcompany.in should show a green padlock!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
