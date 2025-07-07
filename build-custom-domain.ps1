# Build script for custom domain deployment
param(
    [Parameter(Mandatory=$true)]
    [string]$Domain,
    [string]$BaseHref = "/"
)

Write-Host "Building Angular application for custom domain: $Domain" -ForegroundColor Green
Write-Host "Base href: $BaseHref" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Green

# Backup important files before build
Write-Host "Backing up important files..." -ForegroundColor Yellow
$backupFiles = @("docs/CNAME", "docs/robots.txt", "docs/sitemap.xml")
foreach ($file in $backupFiles) {
    if (Test-Path $file) {
        Copy-Item $file ($file + ".backup") -Force
        Write-Host "  Backed up: $file" -ForegroundColor Cyan
    }
}

# Build the Angular application with custom base href
Write-Host "Building Angular application..." -ForegroundColor Green
ng build --configuration=production --output-path=docs --base-href=$BaseHref

# Check if build was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful! Configuring for custom domain..." -ForegroundColor Green
    
    # Copy browser files to root level
    Write-Host "Copying browser files to root level..." -ForegroundColor Yellow
    Copy-Item -Recurse -Force "docs/browser/*" "docs/"
    
    # Create 404.html from index.html
    Write-Host "Creating 404.html..." -ForegroundColor Yellow
    Copy-Item "docs/index.html" "docs/404.html" -Force
    
    # Create .nojekyll file
    Write-Host "Creating .nojekyll file..." -ForegroundColor Yellow
    New-Item -ItemType File -Path "docs/.nojekyll" -Force | Out-Null
    
    # Restore backed up files
    Write-Host "Restoring important files..." -ForegroundColor Yellow
    foreach ($file in $backupFiles) {
        $backupFile = $file + ".backup"
        if (Test-Path $backupFile) {
            Copy-Item $backupFile $file -Force
            Remove-Item $backupFile -Force
            Write-Host "  Restored: $file" -ForegroundColor Cyan
        }
    }
    
    # Ensure CNAME file exists with correct domain
    if (-not (Test-Path "docs/CNAME")) {
        Write-Host "Creating CNAME file..." -ForegroundColor Yellow
        "$Domain" | Out-File -FilePath "docs/CNAME" -Encoding utf8 -NoNewline
    }
    
    # Ensure robots.txt exists
    if (-not (Test-Path "docs/robots.txt")) {
        Write-Host "Creating robots.txt..." -ForegroundColor Yellow
        @"
User-agent: *
Allow: /

# Important pages
Allow: /about
Allow: /services
Allow: /contact
Allow: /blog
Allow: /career

# Sitemap location
Sitemap: https://$Domain/sitemap.xml

# Block unwanted bots
User-agent: BadBot
Disallow: /

# Common crawl delays
Crawl-delay: 1
"@ | Out-File -FilePath "docs/robots.txt" -Encoding utf8
    }
    
    # Ensure sitemap.xml exists
    if (-not (Test-Path "docs/sitemap.xml")) {
        Write-Host "Creating sitemap.xml..." -ForegroundColor Yellow
        @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://$Domain/</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://$Domain/about</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://$Domain/services</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://$Domain/contact</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://$Domain/blog</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://$Domain/career</loc>
    <lastmod>2025-01-07</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.6</priority>
  </url>
</urlset>
"@ | Out-File -FilePath "docs/sitemap.xml" -Encoding utf8
    }
    
    Write-Host "Custom domain build completed successfully!" -ForegroundColor Green
    Write-Host "Files generated in docs/ directory" -ForegroundColor Yellow
    Write-Host "Base href set to: /" -ForegroundColor Green
    Write-Host "Custom domain: $Domain" -ForegroundColor Green
    Write-Host "Important files preserved:" -ForegroundColor Yellow
    Write-Host "  - CNAME: $(if(Test-Path 'docs/CNAME'){'✓'}else{'✗'})" -ForegroundColor Cyan
    Write-Host "  - robots.txt: $(if(Test-Path 'docs/robots.txt'){'✓'}else{'✗'})" -ForegroundColor Cyan
    Write-Host "  - sitemap.xml: $(if(Test-Path 'docs/sitemap.xml'){'✓'}else{'✗'})" -ForegroundColor Cyan
    
} else {
    Write-Host "Build failed! Please check the error messages above." -ForegroundColor Red
    exit 1
}
