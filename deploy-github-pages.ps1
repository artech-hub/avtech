# Deploy to GitHub Pages Script
Write-Host "Building Angular project for GitHub Pages..." -ForegroundColor Green

# Build the project
ng build --configuration production --output-path=docs --base-href=/avtech/

# Check if build was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful! Updating GitHub Pages files..." -ForegroundColor Green
    
    # Remove old files from docs root
    Remove-Item -Path "docs\*.js" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "docs\*.css" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "docs\index.html" -Force -ErrorAction SilentlyContinue
    
    # Copy new files from browser folder to docs root
    Copy-Item -Path "docs\browser\index.html" -Destination "docs\index.html" -Force
    Copy-Item -Path "docs\browser\*.js" -Destination "docs\" -Force
    Copy-Item -Path "docs\browser\*.css" -Destination "docs\" -Force
    Copy-Item -Path "docs\browser\assets" -Destination "docs\assets" -Recurse -Force
    
    # Clean up duplicate browser folders
    Remove-Item -Path "docs\browser\browser" -Recurse -Force -ErrorAction SilentlyContinue
    
    Write-Host "Files updated successfully!" -ForegroundColor Green
    Write-Host "You can now commit and push the changes to GitHub." -ForegroundColor Yellow
} else {
    Write-Host "Build failed! Please check the error messages above." -ForegroundColor Red
}
