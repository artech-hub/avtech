# 🔒 SSL Certificate Fix Guide for GitHub Pages

## Problem: "Not Secure" Warning on https://avtechcompany.in

Your GitHub Pages site is showing a "Not Secure" warning because the SSL certificate is not properly configured for your custom domain.

## 🚨 Immediate Solutions

### Method 1: Re-enable SSL in GitHub Pages Settings (Recommended)

1. **Go to your GitHub repository settings**
   - Navigate to `https://github.com/artech-hub/avtech/settings`
   - Click on **"Pages"** in the left sidebar

2. **Remove and re-add your custom domain**
   - In the "Custom domain" section, delete `avtechcompany.in`
   - Click **"Save"**
   - Wait 2-3 minutes
   - Re-enter `avtechcompany.in` and click **"Save"**

3. **Enable HTTPS enforcement**
   - After saving the domain, wait 5-10 minutes
   - The **"Enforce HTTPS"** checkbox should appear
   - Check the box to enable HTTPS enforcement

### Method 2: Update CNAME File

Update your CNAME file to ensure proper domain configuration:

```bash
# In your project root, update docs/CNAME
echo "avtechcompany.in" > docs/CNAME
```

### Method 3: DNS Configuration Check

Verify your DNS settings with your domain provider:

**A Records (if using apex domain):**
```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

**CNAME Record (if using www subdomain):**
```
artech-hub.github.io
```

## 🔧 Step-by-Step Fix Process

### Step 1: Update CNAME File
```powershell
# Navigate to your project
cd "C:\Users\averma148\OneDrive - MetLife\Documents\Angular_project\avtech"

# Create/update CNAME file
echo "avtechcompany.in" | Out-File -FilePath "docs\CNAME" -Encoding utf8 -NoNewline
```

### Step 2: Commit and Push Changes
```powershell
git add docs/CNAME
git commit -m "Update CNAME for SSL certificate fix"
git push origin main
```

### Step 3: GitHub Pages Configuration
1. Go to your repository: `https://github.com/artech-hub/avtech`
2. Settings → Pages
3. Ensure "Source" is set to "Deploy from a branch" 
4. Branch: `main`, Folder: `/docs`
5. Custom domain: `avtechcompany.in`
6. Wait 5-10 minutes for SSL certificate provisioning
7. Enable "Enforce HTTPS"

### Step 4: Clear DNS Cache (Optional)
```powershell
# Clear DNS cache on Windows
ipconfig /flushdns

# Clear browser cache
# Ctrl+Shift+Delete in most browsers
```

## 🕐 Timeline for SSL Certificate

- **Initial setup**: 10-15 minutes
- **DNS propagation**: 24-48 hours (maximum)
- **SSL certificate activation**: 5-10 minutes after DNS is resolved

## 🔍 Verification Steps

### Check SSL Status:
```powershell
# Test SSL certificate
curl -I https://avtechcompany.in
```

### Online SSL Checkers:
- https://www.ssllabs.com/ssltest/
- https://whynopadlock.com/
- https://www.digicert.com/help/

## 🚨 Common Issues and Solutions

### Issue 1: "Certificate mismatch" error
**Solution**: Remove and re-add custom domain in GitHub Pages settings

### Issue 2: "DNS_PROBE_FINISHED_NXDOMAIN" error
**Solution**: Check DNS configuration with your domain provider

### Issue 3: "ERR_SSL_PROTOCOL_ERROR"
**Solution**: Wait for SSL certificate provisioning (up to 24 hours)

### Issue 4: HTTPS not available
**Solution**: Ensure DNS is properly configured and wait for propagation

## 🎯 Expected Results

After following these steps:
- ✅ `https://avtechcompany.in` should load with a green padlock
- ✅ No "Not Secure" warning
- ✅ Automatic redirect from HTTP to HTTPS
- ✅ SSL certificate shows "Issued by: GitHub Pages"

## 📞 If Problems Persist

1. **Check GitHub Status**: https://www.githubstatus.com/
2. **Contact Domain Provider**: Verify DNS settings
3. **Wait 24-48 hours**: For complete DNS propagation
4. **Use GitHub Community**: https://github.community/

## 🔗 Useful Resources

- [GitHub Pages Custom Domain Documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [GitHub Pages HTTPS Documentation](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https)
- [DNS Configuration Guide](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)

---

## 🚀 Quick Fix Summary

1. Update CNAME file with your domain
2. Commit and push changes
3. Remove and re-add custom domain in GitHub Pages settings
4. Wait 10-15 minutes for SSL certificate
5. Enable HTTPS enforcement

Your site should be secure within 15-30 minutes! 🔒
