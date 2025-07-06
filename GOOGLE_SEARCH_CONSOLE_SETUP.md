# Google Search Console Setup Guide

## 🚀 Step 1: Verify Your Website

1. **Go to Google Search Console**: https://search.google.com/search-console/
2. **Add Property**: Click "Add Property"
3. **Choose Domain or URL prefix**: 
   - Domain: `avtechcompany.in` (requires DNS verification)
   - URL prefix: `https://avtechcompany.in` (easier with HTML file)

## 🔧 Step 2: Verification Methods

### Method 1: HTML File Upload (GitHub Pages)
1. Download the HTML verification file from Google
2. Add the file to your `src` folder or `public` folder
3. Update `angular.json` to include the file in assets:
   ```json
   "assets": [
     "src/favicon.ico",
     "src/assets",
     "src/robots.txt",
     "src/sitemap.xml",
     "src/google[verification-code].html"
   ]
   ```
4. Push to GitHub and wait for deployment
5. Click "Verify" in Search Console

### Method 2: HTML Meta Tag (Recommended for GitHub Pages)
Add this meta tag to your `src/index.html` file:
```html
<meta name="google-site-verification" content="YOUR_VERIFICATION_CODE" />
```

### Method 3: DNS Record (Best for Custom Domain)
**For GitHub Pages with Custom Domain (avtechcompany.in):**

Add these DNS records to your domain registrar:

**GitHub Pages DNS Setup:**
```
Type: A
Host: @
Value: 185.199.108.153

Type: A
Host: @
Value: 185.199.109.153

Type: A
Host: @
Value: 185.199.110.153

Type: A
Host: @
Value: 185.199.111.153
```

**Google Verification:**
```
Type: TXT
Host: @
Value: google-site-verification=YOUR_VERIFICATION_CODE
```

**Domain Registrar Instructions:**
- **GoDaddy**: DNS Management → Add A Records and TXT Record
- **Namecheap**: Advanced DNS → Add New Record
- **Cloudflare**: DNS → Records → Add Record

## 📊 Step 3: Submit Your Sitemap

1. In Google Search Console, go to "Sitemaps"
2. Add sitemap URL: `https://avtechcompany.in/sitemap.xml`
3. Click "Submit"

**Note**: After GitHub Pages deployment, your sitemap will be automatically available at the root of your domain.

## 🔍 Step 4: Monitor Performance

### Key Metrics to Track:
- **Impressions**: How often your site appears in search results
- **Clicks**: How many people click on your site
- **CTR (Click-Through Rate)**: Clicks ÷ Impressions
- **Average Position**: Your average ranking position

### Performance Monitoring:
- Check weekly for new issues
- Monitor keyword rankings
- Track page loading speed
- Check mobile usability

## 📈 Step 5: Optimize Based on Data

### Common Issues to Fix:
1. **Coverage Issues**: Pages not indexed
2. **Mobile Usability**: Mobile-friendly issues
3. **Core Web Vitals**: Page speed and user experience
4. **Security Issues**: HTTPS and security problems

### Optimization Actions:
1. **Improve Page Speed**:
   - Optimize images
   - Minify CSS/JS
   - Enable compression
   - Use CDN

2. **Fix Mobile Issues**:
   - Responsive design
   - Touch-friendly buttons
   - Readable text size

3. **Enhance Content**:
   - Add more relevant keywords
   - Improve meta descriptions
   - Create quality content
   - Internal linking

## 🎯 Step 6: Advanced Features

### URL Inspection Tool
- Check if specific pages are indexed
- Test live URLs
- Request indexing for new pages

### Performance Reports
- Monitor search performance
- Track keyword rankings
- Analyze user behavior

### Enhancement Reports
- Structured data validation
- Breadcrumb markup
- Product markup (if applicable)

## 📋 Monthly Checklist

- [ ] Check coverage report for errors
- [ ] Review performance metrics
- [ ] Submit new sitemaps if needed
- [ ] Monitor keyword rankings
- [ ] Check mobile usability issues
- [ ] Review Core Web Vitals
- [ ] Analyze top-performing pages
- [ ] Identify improvement opportunities

## 🚨 Important Notes

1. **Verification takes time**: It may take 1-2 days for verification to complete
2. **Data delay**: Search Console data has a 1-3 day delay
3. **Patience required**: SEO results take 3-6 months to show significant improvement
4. **Regular monitoring**: Check weekly for best results

## 📞 Support

If you need help with:
- Setting up verification
- Interpreting data
- Fixing technical issues
- Ongoing SEO optimization

Contact your SEO specialist or web developer for assistance.

---

**Next Steps After Setup:**
1. Set up Google Analytics integration
2. Create regular SEO reports
3. Monitor competitor performance
4. Implement ongoing optimizations
