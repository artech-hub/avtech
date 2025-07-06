#!/bin/bash

# GitHub Pages Auto-Deploy Setup Script

echo "🚀 Setting up GitHub Pages Auto-Deploy for AVtech..."
echo "=================================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}✅ GitHub Actions workflow created${NC}"
echo -e "${GREEN}✅ Build scripts optimized${NC}"
echo -e "${GREEN}✅ Custom domain configured (avtechcompany.in)${NC}"
echo -e "${GREEN}✅ Documentation created${NC}"

echo ""
echo -e "${YELLOW}📋 NEXT STEPS:${NC}"
echo "1. Create GitHub repository"
echo "2. Push your code to main branch"
echo "3. Enable GitHub Pages in repository settings"
echo "4. Configure DNS records for avtechcompany.in"
echo "5. Set up Google Search Console verification"

echo ""
echo -e "${YELLOW}🌐 DNS RECORDS TO ADD:${NC}"
echo "A Record: @ → 185.199.108.153"
echo "A Record: @ → 185.199.109.153"
echo "A Record: @ → 185.199.110.153"
echo "A Record: @ → 185.199.111.153"
echo "TXT Record: @ → google-site-verification=YOUR_CODE"

echo ""
echo -e "${YELLOW}🔄 AUTOMATED PROCESS:${NC}"
echo "• Push to main branch → Triggers build"
echo "• Build Angular app → Production optimized"
echo "• Deploy to gh-pages → Automatic"
echo "• Update website → Live in minutes"

echo ""
echo -e "${GREEN}🎯 GITHUB REPOSITORY SETUP:${NC}"
echo "git init"
echo "git add ."
echo "git commit -m 'Initial commit with auto-deploy'"
echo "git branch -M main"
echo "git remote add origin https://github.com/YOUR_USERNAME/avtech.git"
echo "git push -u origin main"

echo ""
echo -e "${GREEN}📊 BENEFITS:${NC}"
echo "• No more manual builds"
echo "• Automatic deployment on push"
echo "• Custom domain support"
echo "• SSL certificate included"
echo "• SEO optimized setup"

echo ""
echo -e "${YELLOW}📚 CHECK THESE FILES:${NC}"
echo "• .github/workflows/deploy-github-pages.yml"
echo "• GITHUB_PAGES_SETUP.md"
echo "• package.json (updated build scripts)"

echo ""
echo -e "${GREEN}🚀 READY TO DEPLOY!${NC}"
echo -e "${YELLOW}Read GITHUB_PAGES_SETUP.md for detailed instructions${NC}"
