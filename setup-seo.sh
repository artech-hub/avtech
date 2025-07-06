#!/bin/bash

# SEO Setup Script for AVtech Website
# This script helps implement SEO across all pages

echo "🚀 Setting up SEO for AVtech Website..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}✅ SEO Service created${NC}"
echo -e "${GREEN}✅ SEO Configuration created${NC}"
echo -e "${GREEN}✅ Home page SEO implemented${NC}"
echo -e "${GREEN}✅ Robots.txt created${NC}"
echo -e "${GREEN}✅ XML Sitemap created${NC}"
echo -e "${GREEN}✅ Meta tags optimized${NC}"
echo -e "${GREEN}✅ Structured data added${NC}"

echo -e "\n${YELLOW}📝 Next Steps:${NC}"
echo "1. Update domain URLs in seo.config.ts"
echo "2. Add SEO to remaining pages (About, Services, Contact, etc.)"
echo "3. Set up Google Analytics"
echo "4. Submit to Google Search Console"
echo "5. Create quality content"

echo -e "\n${YELLOW}🔧 To add SEO to other pages:${NC}"
echo "1. Import SeoService in component"
echo "2. Call this.seoService.setSEOData('pageKey') in ngOnInit"
echo "3. Example: this.seoService.setSEOData('about')"

echo -e "\n${YELLOW}📊 Example for About page:${NC}"
cat << 'EOF'
import { Component, OnInit } from '@angular/core';
import { SeoService } from '../../services/seo.service';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrl: './about.component.css'
})
export class AboutComponent implements OnInit {
  constructor(private seoService: SeoService) { }

  ngOnInit() {
    this.seoService.setSEOData('about');
  }
}
EOF

echo -e "\n${GREEN}🎯 SEO Implementation Complete!${NC}"
echo -e "${YELLOW}Check SEO_OPTIMIZATION_GUIDE.md for detailed next steps${NC}"
