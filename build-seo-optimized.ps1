#!/usr/bin/env pwsh
param(
    [string]$Domain = "avtechcompany.in",
    [string]$BaseHref = "/"
)

Write-Host "🚀 Building AvTech Company website with SEO optimizations..." -ForegroundColor Green
Write-Host "Domain: $Domain" -ForegroundColor Cyan
Write-Host "Base href: $BaseHref" -ForegroundColor Cyan

# Clean previous build
Write-Host "📁 Cleaning previous build..." -ForegroundColor Yellow
if (Test-Path "docs") {
    Remove-Item -Recurse -Force "docs"
}

# Build the Angular application
Write-Host "🔨 Building Angular application..." -ForegroundColor Yellow
ng build --configuration=production --output-path=docs --base-href=$BaseHref --optimization=true --extract-css=true --named-chunks=false --aot=true --extract-licenses=true --build-optimizer=true --vendor-chunk=false --common-chunk=false --output-hashing=all --source-map=false

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}

# Copy browser files to root level
Write-Host "📋 Copying browser files to root..." -ForegroundColor Yellow
if (Test-Path "docs/browser") {
    Copy-Item -Recurse -Force "docs/browser/*" "docs/"
    Remove-Item -Recurse -Force "docs/browser"
}

# Create CNAME file
Write-Host "🌐 Creating CNAME file..." -ForegroundColor Yellow
$Domain | Out-File -FilePath "docs/CNAME" -Encoding utf8 -NoNewline

# Create enhanced robots.txt
Write-Host "🤖 Creating robots.txt..." -ForegroundColor Yellow
$robotsContent = @"
User-agent: *
Allow: /

# Important pages for SEO
Allow: /about
Allow: /services
Allow: /contact
Allow: /blog
Allow: /career

# Individual service pages
Allow: /services/web-development
Allow: /services/mobile-app-development
Allow: /services/cloud-solutions
Allow: /services/digital-marketing
Allow: /services/ui-ux-design
Allow: /services/consulting

# Sitemap location
Sitemap: https://$Domain/sitemap.xml

# Block unwanted crawlers
User-agent: AhrefsBot
Disallow: /

User-agent: MJ12bot
Disallow: /

User-agent: DotBot
Disallow: /

# Crawl delay for better server performance
Crawl-delay: 1
"@

$robotsContent | Out-File -FilePath "docs/robots.txt" -Encoding utf8

# Create enhanced sitemap.xml
Write-Host "🗺️ Creating sitemap.xml..." -ForegroundColor Yellow
$currentDate = Get-Date -Format "yyyy-MM-dd"
$sitemapContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
        http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
  
  <!-- Home Page -->
  <url>
    <loc>https://$Domain/</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  
  <!-- About Page -->
  <url>
    <loc>https://$Domain/about</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <!-- Services Page -->
  <url>
    <loc>https://$Domain/services</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>
  
  <!-- Individual Service Pages -->
  <url>
    <loc>https://$Domain/services/web-development</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://$Domain/services/mobile-app-development</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://$Domain/services/cloud-solutions</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://$Domain/services/digital-marketing</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://$Domain/services/ui-ux-design</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://$Domain/services/consulting</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <!-- Contact Page -->
  <url>
    <loc>https://$Domain/contact</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
  
  <!-- Blog Page -->
  <url>
    <loc>https://$Domain/blog</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
  
  <!-- Career Page -->
  <url>
    <loc>https://$Domain/career</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.6</priority>
  </url>

</urlset>
"@

$sitemapContent | Out-File -FilePath "docs/sitemap.xml" -Encoding utf8

# Create .nojekyll file
Write-Host "🔧 Creating .nojekyll file..." -ForegroundColor Yellow
New-Item -ItemType File -Path "docs/.nojekyll" -Force | Out-Null

# Create 404.html
Write-Host "🔍 Creating 404.html..." -ForegroundColor Yellow
if (Test-Path "docs/index.html") {
    Copy-Item "docs/index.html" "docs/404.html"
}

# Verify all files
Write-Host "✅ Verifying build..." -ForegroundColor Green
$criticalFiles = @(
    "docs/index.html",
    "docs/CNAME",
    "docs/robots.txt",
    "docs/sitemap.xml",
    "docs/.nojekyll",
    "docs/404.html"
)

$allFilesExist = $true
foreach ($file in $criticalFiles) {
    if (Test-Path $file) {
        Write-Host "  ✓ $file" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $file (missing)" -ForegroundColor Red
        $allFilesExist = $false
    }
}

# Check JavaScript and CSS files
$jsFiles = Get-ChildItem "docs" -Filter "*.js" | Where-Object { $_.Name -match "main-|polyfills-" }
$cssFiles = Get-ChildItem "docs" -Filter "*.css" | Where-Object { $_.Name -match "styles-" }

Write-Host "📦 Build assets:" -ForegroundColor Cyan
Write-Host "  JS files: $($jsFiles.Count)" -ForegroundColor Cyan
Write-Host "  CSS files: $($cssFiles.Count)" -ForegroundColor Cyan

if ($allFilesExist -and $jsFiles.Count -ge 2 -and $cssFiles.Count -ge 1) {
    Write-Host "🎉 Build completed successfully!" -ForegroundColor Green
    Write-Host "🌐 Website ready for deployment to: https://$Domain" -ForegroundColor Green
    Write-Host "📊 SEO optimizations applied:" -ForegroundColor Yellow
    Write-Host "  - Enhanced meta tags" -ForegroundColor Yellow
    Write-Host "  - Structured data (JSON-LD)" -ForegroundColor Yellow
    Write-Host "  - Comprehensive sitemap" -ForegroundColor Yellow
    Write-Host "  - SEO-friendly robots.txt" -ForegroundColor Yellow
    Write-Host "  - Open Graph & Twitter Cards" -ForegroundColor Yellow
    Write-Host "  - Canonical URLs" -ForegroundColor Yellow
    Write-Host "  - Mobile-first optimization" -ForegroundColor Yellow
    
    Write-Host "🔍 Next steps for SEO:" -ForegroundColor Magenta
    Write-Host "  1. Submit to Google Search Console" -ForegroundColor Magenta
    Write-Host "  2. Submit sitemap: https://$Domain/sitemap.xml" -ForegroundColor Magenta
    Write-Host "  3. Request indexing for main pages" -ForegroundColor Magenta
    Write-Host "  4. Set up Google Analytics" -ForegroundColor Magenta
    Write-Host "  5. Create Google My Business profile" -ForegroundColor Magenta
    
    exit 0
} else {
    Write-Host "❌ Build verification failed!" -ForegroundColor Red
    exit 1
}
