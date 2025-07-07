#!/usr/bin/env pwsh
# Comprehensive deployment verification script for AvTech Company

Write-Host "🔍 COMPREHENSIVE DEPLOYMENT VERIFICATION" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

$errorCount = 0
$warningCount = 0

# Function to report errors
function Report-Error {
    param([string]$message)
    Write-Host "❌ ERROR: $message" -ForegroundColor Red
    $global:errorCount++
}

# Function to report warnings
function Report-Warning {
    param([string]$message)
    Write-Host "⚠️  WARNING: $message" -ForegroundColor Yellow
    $global:warningCount++
}

# Function to report success
function Report-Success {
    param([string]$message)
    Write-Host "✅ SUCCESS: $message" -ForegroundColor Green
}

Write-Host "1. CHECKING CRITICAL FILES..." -ForegroundColor Cyan

# Check if docs directory exists
if (Test-Path "docs") {
    Report-Success "docs directory exists"
} else {
    Report-Error "docs directory missing - run build first"
    exit 1
}

# Check critical files
$criticalFiles = @(
    "docs/index.html",
    "docs/CNAME",
    "docs/robots.txt",
    "docs/sitemap.xml",
    "docs/.nojekyll",
    "docs/404.html"
)

foreach ($file in $criticalFiles) {
    if (Test-Path $file) {
        Report-Success "$file exists"
    } else {
        Report-Error "$file missing"
    }
}

Write-Host "`n2. CHECKING BASE HREF..." -ForegroundColor Cyan

if (Test-Path "docs/index.html") {
    $indexContent = Get-Content "docs/index.html" -Raw
    if ($indexContent -match '<base href="/">') {
        Report-Success "Base href correctly set to /"
    } elseif ($indexContent -match '<base href="/avtech/">') {
        Report-Error "Base href incorrectly set to /avtech/ - this will cause 404 errors on custom domain!"
    } else {
        Report-Warning "Base href not found or in unexpected format"
    }
} else {
    Report-Error "Cannot check base href - index.html missing"
}

Write-Host "`n3. CHECKING CNAME..." -ForegroundColor Cyan

if (Test-Path "docs/CNAME") {
    $cnameContent = Get-Content "docs/CNAME" -Raw
    $cnameContent = $cnameContent.Trim()
    if ($cnameContent -eq "avtechcompany.in") {
        Report-Success "CNAME correctly set to avtechcompany.in"
    } else {
        Report-Error "CNAME content incorrect: '$cnameContent' (should be 'avtechcompany.in')"
    }
} else {
    Report-Error "CNAME file missing"
}

Write-Host "`n4. CHECKING JAVASCRIPT/CSS BUNDLES..." -ForegroundColor Cyan

$jsFiles = Get-ChildItem "docs" -Filter "*.js" | Where-Object { $_.Name -match "main-|polyfills-" }
$cssFiles = Get-ChildItem "docs" -Filter "*.css" | Where-Object { $_.Name -match "styles-" }

if ($jsFiles.Count -ge 2) {
    Report-Success "JavaScript bundles found ($($jsFiles.Count) files)"
    foreach ($js in $jsFiles) {
        Write-Host "  - $($js.Name) ($([math]::Round($js.Length/1024, 1)) KB)" -ForegroundColor Gray
    }
} else {
    Report-Error "Missing JavaScript bundles (found $($jsFiles.Count), expected at least 2)"
}

if ($cssFiles.Count -ge 1) {
    Report-Success "CSS bundles found ($($cssFiles.Count) files)"
    foreach ($css in $cssFiles) {
        Write-Host "  - $($css.Name) ($([math]::Round($css.Length/1024, 1)) KB)" -ForegroundColor Gray
    }
} else {
    Report-Error "Missing CSS bundles (found $($cssFiles.Count), expected at least 1)"
}

Write-Host "`n5. CHECKING ASSET REFERENCES..." -ForegroundColor Cyan

if (Test-Path "docs/index.html") {
    $indexContent = Get-Content "docs/index.html" -Raw
    
    # Check JS references
    $jsMatches = [regex]::Matches($indexContent, 'src="([^"]*\.js)"')
    foreach ($match in $jsMatches) {
        $jsFile = $match.Groups[1].Value
        if (Test-Path "docs/$jsFile") {
            Report-Success "JS reference found: $jsFile"
        } else {
            Report-Error "Missing JS file: $jsFile"
        }
    }
    
    # Check CSS references
    $cssMatches = [regex]::Matches($indexContent, 'href="([^"]*\.css)"')
    foreach ($match in $cssMatches) {
        $cssFile = $match.Groups[1].Value
        if (Test-Path "docs/$cssFile") {
            Report-Success "CSS reference found: $cssFile"
        } else {
            Report-Error "Missing CSS file: $cssFile"
        }
    }
} else {
    Report-Error "Cannot check asset references - index.html missing"
}

Write-Host "`n6. CHECKING SEO OPTIMIZATIONS..." -ForegroundColor Cyan

if (Test-Path "docs/index.html") {
    $indexContent = Get-Content "docs/index.html" -Raw
    
    # Check meta tags
    $metaTags = @(
        "description",
        "keywords",
        "author",
        "robots",
        "og:title",
        "og:description",
        "og:image",
        "twitter:card"
    )
    
    foreach ($tag in $metaTags) {
        if ($indexContent -match $tag) {
            Report-Success "Meta tag found: $tag"
        } else {
            Report-Warning "Meta tag missing: $tag"
        }
    }
    
    # Check structured data
    if ($indexContent -match "application/ld\+json") {
        Report-Success "Structured data (JSON-LD) found"
    } else {
        Report-Warning "Structured data (JSON-LD) missing"
    }
} else {
    Report-Error "Cannot check SEO optimizations - index.html missing"
}

Write-Host "`n7. CHECKING ROBOTS.TXT..." -ForegroundColor Cyan

if (Test-Path "docs/robots.txt") {
    $robotsContent = Get-Content "docs/robots.txt" -Raw
    if ($robotsContent -match "Sitemap: https://avtechcompany.in/sitemap.xml") {
        Report-Success "Robots.txt contains correct sitemap URL"
    } else {
        Report-Warning "Robots.txt missing or incorrect sitemap URL"
    }
    
    if ($robotsContent -match "User-agent: \*") {
        Report-Success "Robots.txt has user-agent directive"
    } else {
        Report-Warning "Robots.txt missing user-agent directive"
    }
} else {
    Report-Error "robots.txt missing"
}

Write-Host "`n8. CHECKING SITEMAP.XML..." -ForegroundColor Cyan

if (Test-Path "docs/sitemap.xml") {
    $sitemapContent = Get-Content "docs/sitemap.xml" -Raw
    if ($sitemapContent -match "https://avtechcompany.in/") {
        Report-Success "Sitemap contains correct domain URLs"
    } else {
        Report-Warning "Sitemap missing or incorrect domain URLs"
    }
    
    $urlCount = ([regex]::Matches($sitemapContent, "<loc>")).Count
    if ($urlCount -ge 5) {
        Report-Success "Sitemap contains $urlCount URLs"
    } else {
        Report-Warning "Sitemap contains only $urlCount URLs (consider adding more)"
    }
} else {
    Report-Error "sitemap.xml missing"
}

Write-Host "`n9. CHECKING BUILD SCRIPTS..." -ForegroundColor Cyan

$buildScripts = @(
    "build-custom-domain.ps1",
    "package.json",
    ".github/workflows/deploy.yml"
)

foreach ($script in $buildScripts) {
    if (Test-Path $script) {
        Report-Success "$script exists"
    } else {
        Report-Error "$script missing"
    }
}

# Check package.json scripts
if (Test-Path "package.json") {
    $packageContent = Get-Content "package.json" -Raw
    if ($packageContent -match "build:custom-domain") {
        Report-Success "package.json contains build:custom-domain script"
    } else {
        Report-Warning "package.json missing build:custom-domain script"
    }
}

Write-Host "`n10. CHECKING GITHUB ACTIONS WORKFLOW..." -ForegroundColor Cyan

if (Test-Path ".github/workflows/deploy.yml") {
    $workflowContent = Get-Content ".github/workflows/deploy.yml" -Raw
    if ($workflowContent -match "base-href=/") {
        Report-Success "GitHub Actions workflow uses correct base-href"
    } else {
        Report-Error "GitHub Actions workflow has incorrect base-href"
    }
    
    if ($workflowContent -match "cname: avtechcompany.in") {
        Report-Success "GitHub Actions workflow sets correct CNAME"
    } else {
        Report-Warning "GitHub Actions workflow missing CNAME configuration"
    }
} else {
    Report-Error ".github/workflows/deploy.yml missing"
}

Write-Host "`n11. FINAL VERIFICATION..." -ForegroundColor Cyan

# Check if all critical files are present and correct
$readyForDeployment = $true

if ($errorCount -eq 0) {
    Report-Success "No critical errors found"
} else {
    Report-Error "Found $errorCount critical errors that must be fixed"
    $readyForDeployment = $false
}

if ($warningCount -eq 0) {
    Report-Success "No warnings found"
} else {
    Report-Warning "Found $warningCount warnings (recommended to fix)"
}

Write-Host "`n" -NoNewline
Write-Host "=========================================" -ForegroundColor Green
Write-Host "DEPLOYMENT VERIFICATION SUMMARY" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

if ($readyForDeployment) {
    Write-Host "🎉 READY FOR DEPLOYMENT!" -ForegroundColor Green
    Write-Host "✅ All critical checks passed" -ForegroundColor Green
    Write-Host "🌐 Website will work correctly on: https://avtechcompany.in" -ForegroundColor Green
    
    Write-Host "`n📋 NEXT STEPS:" -ForegroundColor Cyan
    Write-Host "1. Commit and push changes to GitHub" -ForegroundColor White
    Write-Host "2. GitHub Actions will automatically deploy" -ForegroundColor White
    Write-Host "3. Submit sitemap to Google Search Console" -ForegroundColor White
    Write-Host "4. Monitor deployment in GitHub Actions" -ForegroundColor White
    
    exit 0
} else {
    Write-Host "❌ NOT READY FOR DEPLOYMENT" -ForegroundColor Red
    Write-Host "🔧 Fix the above errors before deploying" -ForegroundColor Red
    Write-Host "📞 Run this script again after fixes" -ForegroundColor Red
    
    exit 1
}
