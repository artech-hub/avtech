#!/bin/bash
# Test script to verify build process works

echo "Testing Angular build process..."
echo "================================"

# Check Node.js version
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Check Angular CLI
echo "Checking Angular CLI..."
if [ -f "node_modules/.bin/ng" ]; then
    echo "Angular CLI found at: node_modules/.bin/ng"
    ./node_modules/.bin/ng version
else
    echo "Angular CLI not found in node_modules"
fi

# Test different build methods
echo ""
echo "Testing build methods..."
echo "========================"

# Method 1: npm run build:ci
echo "1. Testing npm run build:ci..."
if npm run build:ci; then
    echo "✅ npm run build:ci - SUCCESS"
else
    echo "❌ npm run build:ci - FAILED"
fi

# Method 2: npm run build with args
echo "2. Testing npm run build with args..."
if npm run build -- --configuration production --output-path=docs-test --base-href=/; then
    echo "✅ npm run build with args - SUCCESS"
    rm -rf docs-test
else
    echo "❌ npm run build with args - FAILED"
fi

# Method 3: npx ng
echo "3. Testing npx ng..."
if npx ng build --configuration production --output-path=docs-test2 --base-href=/; then
    echo "✅ npx ng - SUCCESS"
    rm -rf docs-test2
else
    echo "❌ npx ng - FAILED"
fi

# Method 4: Direct ng path
echo "4. Testing direct ng path..."
if ./node_modules/.bin/ng build --configuration production --output-path=docs-test3 --base-href=/; then
    echo "✅ Direct ng path - SUCCESS"
    rm -rf docs-test3
else
    echo "❌ Direct ng path - FAILED"
fi

echo ""
echo "Build testing completed!"
