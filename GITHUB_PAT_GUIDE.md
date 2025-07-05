# GitHub Personal Access Token (PAT) Guide

## 🚨 URGENT: Fixing 403 Permission Denied Error

**If you're seeing this error:**
```
remote: Permission to artech-hub/avtech.git denied to artech-hub.
fatal: unable to access 'https://github.com/artech-hub/avtech.git/': The requested URL returned error: 403
```

### 🔧 **Immediate Solutions:**

#### Solution 1: Use Personal Access Token (Most Common Fix)
1. **Create PAT** (see instructions below)
2. **Use PAT instead of password** when prompted:
   ```bash
   Username: artech-hub
   Password: [PASTE YOUR PERSONAL ACCESS TOKEN HERE]
   ```

#### Solution 2: Update Git Credentials
```bash
# Clear stored credentials
git config --global --unset credential.helper
git config --unset credential.helper

# Or on Windows, clear Windows Credential Manager
cmdkey /delete:git:https://github.com
```

#### Solution 3: Update Remote URL with Token
```bash
# Remove existing remote
git remote remove origin

# Add remote with your Personal Access Token
git remote add origin https://YOUR_TOKEN@github.com/artech-hub/avtech.git

# Push again
git push -u origin main
```

#### Solution 4: Check Repository Access
- Verify you have **write access** to `artech-hub/avtech` repository
- If it's an organization repo, ensure you're a member with proper permissions

---

## 🔑 What is a Personal Access Token?

A Personal Access Token (PAT) is a secure way to authenticate with GitHub instead of using your password. It's required for:
- Git operations (clone, push, pull) from command line
- GitHub API access
- Third-party applications
- GitHub Actions workflows

## 🚀 How to Create a Personal Access Token

### Step 1: Access GitHub Settings
1. Go to [GitHub.com](https://github.com) and sign in
2. Click your profile picture (top-right corner)
3. Select **Settings** from the dropdown menu

### Step 2: Navigate to Developer Settings
1. Scroll down in the left sidebar
2. Click **Developer settings** (at the bottom)
3. Click **Personal access tokens**
4. Choose **Tokens (classic)** or **Fine-grained tokens**

### Step 3: Generate New Token
1. Click **Generate new token**
2. Select **Generate new token (classic)** for most use cases

### Step 4: Configure Token Settings
1. **Note**: Give your token a descriptive name (e.g., "AVtech Project Token")
2. **Expiration**: Choose expiration period (recommended: 90 days or custom)
3. **Scopes**: Select the permissions you need:

#### 📋 **Recommended Scopes for Your Project:**
- ✅ **repo** - Full control of private repositories
- ✅ **workflow** - Update GitHub Action workflows
- ✅ **write:packages** - Upload packages to GitHub Package Registry
- ✅ **delete:packages** - Delete packages from GitHub Package Registry
- ✅ **admin:repo_hook** - Full control of repository hooks
- ✅ **admin:org_hook** - Full control of organization hooks

#### 🔧 **For Basic Git Operations:**
- ✅ **repo** - Access to repositories
- ✅ **user** - Access to user profile information

### Step 5: Generate and Copy Token
1. Click **Generate token**
2. **⚠️ IMPORTANT**: Copy the token immediately - you won't see it again!
3. Store it securely (password manager, secure note, etc.)

## 💻 How to Use Personal Access Token

### Method 1: Git Command Line Authentication
When prompted for username and password:
- **Username**: Your GitHub username
- **Password**: Use your Personal Access Token (not your account password)

### Method 2: Clone with Token in URL
```bash
git clone https://TOKEN@github.com/username/repository.git
```

### Method 3: Configure Git Credentials
```bash
# Configure Git to store credentials
git config --global credential.helper store

# Or use credential manager (Windows)
git config --global credential.helper manager-core
```

### Method 4: Update Remote URL with Token
```bash
# Remove existing remote
git remote remove origin

# Add remote with token
git remote add origin https://TOKEN@github.com/username/repository.git
```

## 🔐 Security Best Practices

### ✅ **Do:**
- Use descriptive token names
- Set appropriate expiration dates
- Use minimal required scopes
- Store tokens securely
- Rotate tokens regularly
- Delete unused tokens

### ❌ **Don't:**
- Share tokens publicly
- Commit tokens to repositories
- Use tokens in public scripts
- Give unnecessary permissions
- Leave tokens without expiration

## 🛠️ For Your AVtech Project

### Step-by-Step Setup:

1. **Create Token**:
   - Go to GitHub.com → Settings → Developer settings → Personal access tokens
   - Generate new token with `repo` and `workflow` scopes

2. **Configure Your Project**:
   ```bash
   # Navigate to your project
   cd "C:\Users\averma148\OneDrive - MetLife\Documents\Angular_project\avtech"
   
   # Configure Git if not already done
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

3. **Initialize Git Repository** (if not already done):
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Angular AVtech project setup"
   ```

4. **Add Remote Repository**:
   ```bash
   # Replace USERNAME and REPOSITORY with your actual values
   git remote add origin https://github.com/USERNAME/REPOSITORY.git
   ```

5. **Push to GitHub**:
   ```bash
   git push -u origin main
   ```
   - When prompted, use your GitHub username and PAT as password

## 🌐 Alternative: GitHub CLI

You can also use GitHub CLI for easier authentication:

```bash
# Install GitHub CLI
winget install GitHub.cli

# Authenticate
gh auth login

# Clone repository
gh repo clone username/repository
```

## 🔧 Troubleshooting Common Issues

### Issue 1: "Authentication failed"
- Check if token is correct
- Verify token hasn't expired
- Ensure token has required scopes

### Issue 2: "Repository not found"
- Check repository URL
- Verify you have access to the repository
- Ensure token has `repo` scope

### Issue 3: "Permission denied"
- Check if token has write permissions
- Verify you're a collaborator on the repository

## 📱 Token Management

### View Your Tokens:
1. GitHub.com → Settings → Developer settings → Personal access tokens
2. See all active tokens, their scopes, and expiration dates

### Revoke Tokens:
1. Click on token name
2. Click **Delete** to revoke immediately

### Update Token Scopes:
1. Create new token with required scopes
2. Update applications/scripts with new token
3. Delete old token

## 🎯 Quick Reference

| Action | Command |
|--------|---------|
| Clone with token | `git clone https://TOKEN@github.com/user/repo.git` |
| Push with token | Use username + token as password |
| Store credentials | `git config --global credential.helper store` |
| Check remote | `git remote -v` |
| Update remote | `git remote set-url origin https://TOKEN@github.com/user/repo.git` |

## 🔗 Direct Links

- **Create Token**: https://github.com/settings/tokens
- **GitHub CLI**: https://cli.github.com/
- **Git Documentation**: https://git-scm.com/docs

Remember: Your Personal Access Token is like a password - keep it secure! 🔒
