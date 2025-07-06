# GitHub Pages Auto-Deploy Setup Guide

## 🚀 Automated GitHub Pages Deployment

### ✅ What's Already Setup:
- **GitHub Actions workflow** created in `.github/workflows/deploy-github-pages.yml`
- **Automatic builds** trigger on push to main/master branch
- **Custom domain** configured for `avtechcompany.in`
- **Build scripts** optimized for GitHub Pages

## 📋 Step-by-Step Setup

### 1. **GitHub Repository Setup**

1. **Create GitHub Repository**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit with GitHub Pages setup"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/avtech.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**:
   - Go to your repository on GitHub
   - Settings → Pages
   - Source: Deploy from a branch
   - Branch: `gh-pages`
   - Folder: `/ (root)`

### 2. **Domain Configuration**

1. **Add Custom Domain**:
   - In GitHub Pages settings
   - Custom domain: `avtechcompany.in`
   - Check "Enforce HTTPS"

2. **CNAME File** (automatically created by workflow):
   ```
   avtechcompany.in
   ```

### 3. **DNS Configuration for Domain Verification**

#### **A. GitHub Pages DNS Setup**

Add these DNS records to your domain registrar:

**For Root Domain (avtechcompany.in):**
```
Type: A
Host: @
Value: 185.199.108.153
TTL: 3600

Type: A
Host: @
Value: 185.199.109.153
TTL: 3600

Type: A
Host: @
Value: 185.199.110.153
TTL: 3600

Type: A
Host: @
Value: 185.199.111.153
TTL: 3600
```

**For WWW Subdomain:**
```
Type: CNAME
Host: www
Value: YOUR_USERNAME.github.io
TTL: 3600
```

#### **B. Google Search Console DNS Verification**

1. **Add TXT Record for Verification**:
   ```
   Type: TXT
   Host: @
   Value: google-site-verification=YOUR_VERIFICATION_CODE
   TTL: 3600
   ```

2. **Get Verification Code**:
   - Go to Google Search Console
   - Add Property → Domain
   - Enter `avtechcompany.in`
   - Choose DNS verification
   - Copy the TXT record value

### 4. **Domain Registrar Instructions**

#### **For Popular Registrars:**

**GoDaddy:**
1. Login to GoDaddy
2. My Products → DNS
3. Add Record → Type: A, Host: @, Points to: [IP addresses above]
4. Add Record → Type: TXT, Host: @, Value: [Google verification code]

**Namecheap:**
1. Login to Namecheap
2. Domain List → Manage
3. Advanced DNS → Add New Record
4. Type: A Record, Host: @, Value: [IP addresses]
5. Type: TXT Record, Host: @, Value: [Google verification code]

**Cloudflare:**
1. Login to Cloudflare
2. DNS → Records
3. Add Record → Type: A, Name: @, IPv4: [IP addresses]
4. Add Record → Type: TXT, Name: @, Content: [Google verification code]

## 🔄 Automated Workflow Process

### **What Happens on Each Push:**

1. **Trigger**: Push to main/master branch
2. **Install**: Node.js and dependencies
3. **Build**: Angular app with production settings
4. **Deploy**: Built files to `gh-pages` branch
5. **Domain**: CNAME file with `avtechcompany.in`
6. **Live**: Website automatically updates

### **Build Script Explanation:**
```bash
# Build for production
ng build --configuration=production --output-path=docs --base-href=/

# Copy browser files to docs root (for GitHub Pages)
cp -r docs/browser/* docs/

# Create 404.html (for Angular routing)
cp docs/index.html docs/404.html

# Prevent Jekyll processing
touch docs/.nojekyll
```

## 📊 Monitoring & Verification

### **Check Deployment Status:**
1. Go to your repository
2. Actions tab
3. See workflow runs and status

### **Verify DNS Propagation:**
```bash
# Check A records
nslookup avtechcompany.in

# Check TXT records (for Google verification)
nslookup -type=TXT avtechcompany.in
```

### **Online Tools:**
- **DNS Checker**: https://dnschecker.org/
- **What's My DNS**: https://www.whatsmydns.net/
- **DNS Propagation**: https://www.dnspropagation.net/

## 🚨 Common Issues & Solutions

### **1. Build Failures**
```yaml
# If build fails, check:
- Node.js version compatibility
- npm dependencies
- Angular version
- Build script syntax
```

### **2. Domain Not Working**
```bash
# Check DNS propagation (can take 24-48 hours)
# Verify A records point to GitHub Pages IPs
# Ensure CNAME file contains correct domain
```

### **3. SSL Certificate Issues**
```bash
# Wait 24 hours after DNS setup
# Check "Enforce HTTPS" in GitHub Pages settings
# Verify domain ownership
```

## 🔧 Advanced Configuration

### **Environment Variables** (if needed):
```yaml
# In .github/workflows/deploy-github-pages.yml
env:
  NODE_OPTIONS: "--max-old-space-size=4096"
  DOMAIN: "avtechcompany.in"
```

### **Custom Build Process**:
```yaml
# Add custom steps before build
- name: Setup Environment
  run: |
    echo "Building for production..."
    npm run prebuild
```

## 📈 SEO Benefits

### **Automatic Benefits:**
- ✅ **HTTPS enabled** (SSL certificate)
- ✅ **Custom domain** configured
- ✅ **404 handling** for Angular routing
- ✅ **Sitemap** accessible at `/sitemap.xml`
- ✅ **Robots.txt** accessible at `/robots.txt`

### **Google Search Console Setup:**
1. **Domain verified** via DNS TXT record
2. **Sitemap submitted** automatically
3. **Property configured** for `avtechcompany.in`

## 🎯 Next Steps After Setup

1. **Push your code** to trigger first deployment
2. **Wait for DNS propagation** (24-48 hours)
3. **Verify domain** in Google Search Console
4. **Submit sitemap** to Google
5. **Monitor** deployment status

## 📞 Troubleshooting

### **If deployment fails:**
1. Check GitHub Actions logs
2. Verify package.json scripts
3. Ensure all dependencies are installed
4. Check Angular build configuration

### **If domain doesn't work:**
1. Verify DNS records
2. Check DNS propagation
3. Ensure CNAME file is created
4. Wait for SSL certificate provisioning

---

## 🚀 **Ready to Deploy!**

Your setup is complete. Simply push your code to the main branch and watch your website automatically deploy to `https://avtechcompany.in`!

```bash
git add .
git commit -m "Setup GitHub Pages auto-deployment"
git push origin main
```
