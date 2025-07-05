#!/bin/bash
# Build script for GitHub Pages deployment

echo "Building Angular application for GitHub Pages..."
ng build --configuration=production --output-path=docs --base-href=/avtech/

echo "Creating root index.html and 404.html files..."
cp docs/browser/index.html docs/index.html
cp docs/browser/index.html docs/404.html

echo "Copying browser assets to root level..."
cp -r docs/browser/* docs/

echo "Updating file paths for GitHub Pages..."
# Update paths for favicon
sed -i 's|href="browser/favicon.ico"|href="favicon.ico"|g' docs/index.html docs/404.html

# Update paths for CSS files
sed -i 's|href="browser/styles-|href="styles-|g' docs/index.html docs/404.html

# Update paths for JavaScript files
sed -i 's|src="browser/polyfills-|src="polyfills-|g' docs/index.html docs/404.html
sed -i 's|src="browser/main-|src="main-|g' docs/index.html docs/404.html

echo "GitHub Pages build completed successfully!"
echo "Files generated in docs/ directory"
