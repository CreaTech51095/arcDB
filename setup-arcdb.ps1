# arcDB Setup Script for Windows PowerShell
# This script automates the setup process

Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "   arcDB Setup Script" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Check prerequisites
Write-Host "`nChecking prerequisites..." -ForegroundColor Yellow

if (-not (Test-CommandExists "node")) {
    Write-Host "❌ Node.js is not installed. Please install Node.js v18 or higher." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Node.js found: $(node --version)" -ForegroundColor Green

if (-not (Test-CommandExists "npm")) {
    Write-Host "❌ npm is not installed." -ForegroundColor Red
    exit 1
}
Write-Host "✅ npm found: $(npm --version)" -ForegroundColor Green

if (-not (Test-CommandExists "git")) {
    Write-Host "❌ Git is not installed. Please install Git." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Git found: $(git --version)" -ForegroundColor Green

if (-not (Test-CommandExists "firebase")) {
    Write-Host "❌ Firebase CLI is not installed." -ForegroundColor Yellow
    Write-Host "Installing Firebase CLI..." -ForegroundColor Yellow
    npm install -g firebase-tools
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install Firebase CLI" -ForegroundColor Red
        exit 1
    }
}
Write-Host "✅ Firebase CLI found" -ForegroundColor Green

# Step 1: Git Setup
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 1: Git Repository Setup" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$response = Read-Host "`nDo you want to push to GitHub now? (y/n)"
if ($response -eq 'y') {
    Write-Host "`nAdding and committing changes..." -ForegroundColor Yellow
    git add .
    git commit -m "Configure for arcDB and arcdb.web.app"
    
    Write-Host "`nUpdating Git remote..." -ForegroundColor Yellow
    git remote remove origin 2>$null
    git remote add origin https://github.com/CreaTech51095/arcDB.git
    
    Write-Host "`nPushing to GitHub..." -ForegroundColor Yellow
    Write-Host "You may need to authenticate with GitHub..." -ForegroundColor Yellow
    
    # Try main first, then master
    git push -u origin main 2>$null
    if ($LASTEXITCODE -ne 0) {
        git push -u origin master
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to push to GitHub. Please check your credentials." -ForegroundColor Red
    }
} else {
    Write-Host "⏭️  Skipping GitHub push. You can do this manually later." -ForegroundColor Yellow
}

# Step 2: Environment File
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 2: Firebase Configuration" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

if (-not (Test-Path "frontend\.env")) {
    Write-Host "`n⚠️  No .env file found in frontend directory" -ForegroundColor Yellow
    Write-Host "You need to create frontend\.env with your Firebase config" -ForegroundColor Yellow
    Write-Host "See frontend\env.example for the template" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Steps to get Firebase config:" -ForegroundColor Cyan
    Write-Host "1. Go to https://console.firebase.google.com" -ForegroundColor White
    Write-Host "2. Create project with ID: arcdb" -ForegroundColor White
    Write-Host "3. Enable Authentication (Email/Password)" -ForegroundColor White
    Write-Host "4. Create Firestore Database" -ForegroundColor White
    Write-Host "5. Enable Storage" -ForegroundColor White
    Write-Host "6. Go to Project Settings > Your apps" -ForegroundColor White
    Write-Host "7. Add web app and copy the config" -ForegroundColor White
    Write-Host ""
    $response = Read-Host "Have you created frontend\.env? (y/n)"
    if ($response -ne 'y') {
        Write-Host "`n⏭️  Please create frontend\.env and run this script again" -ForegroundColor Yellow
        Write-Host "Or continue manually following SETUP_ARCDB.md" -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "✅ Found frontend\.env file" -ForegroundColor Green
}

# Step 3: Install Dependencies
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 3: Installing Dependencies" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

Write-Host "`nInstalling Firebase Functions dependencies..." -ForegroundColor Yellow
Push-Location firebase-functions
npm install
Pop-Location
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Firebase Functions dependencies installed" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to install Firebase Functions dependencies" -ForegroundColor Red
    exit 1
}

Write-Host "`nInstalling Frontend dependencies..." -ForegroundColor Yellow
Push-Location frontend
npm install
Pop-Location
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Frontend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to install Frontend dependencies" -ForegroundColor Red
    exit 1
}

# Step 4: Firebase Login
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 4: Firebase Login" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$response = Read-Host "`nDo you want to login to Firebase now? (y/n)"
if ($response -eq 'y') {
    Write-Host "`nOpening Firebase login..." -ForegroundColor Yellow
    Write-Host "Please sign in with: createch51095@gmail.com" -ForegroundColor Cyan
    firebase login
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully logged in to Firebase!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to login to Firebase" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "⏭️  Skipping Firebase login" -ForegroundColor Yellow
}

# Step 5: Build Frontend
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 5: Building Frontend" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$response = Read-Host "`nDo you want to build the frontend now? (y/n)"
if ($response -eq 'y') {
    Write-Host "`nBuilding frontend..." -ForegroundColor Yellow
    Push-Location frontend
    npm run build
    Pop-Location
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Frontend built successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to build frontend" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "⏭️  Skipping frontend build" -ForegroundColor Yellow
}

# Step 6: Deploy
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "Step 6: Deploy to Firebase" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$response = Read-Host "`nDo you want to deploy to Firebase now? (y/n)"
if ($response -eq 'y') {
    Write-Host "`nDeploying to Firebase..." -ForegroundColor Yellow
    Write-Host "This may take several minutes..." -ForegroundColor Yellow
    firebase deploy
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✅ Successfully deployed to Firebase!" -ForegroundColor Green
        Write-Host "`n🎉 Your app is now live at: https://arcdb.web.app" -ForegroundColor Cyan
    } else {
        Write-Host "❌ Failed to deploy to Firebase" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "⏭️  Skipping Firebase deployment" -ForegroundColor Yellow
}

# Summary
Write-Host "`n==================================" -ForegroundColor Cyan
Write-Host "   Setup Complete!" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "`n📚 For detailed instructions, see: SETUP_ARCDB.md" -ForegroundColor Yellow
Write-Host "🌐 Live App: https://arcdb.web.app" -ForegroundColor Cyan
Write-Host "💻 GitHub: https://github.com/CreaTech51095/arcDB" -ForegroundColor Cyan
Write-Host "🔥 Firebase Console: https://console.firebase.google.com/project/arcdb" -ForegroundColor Cyan
Write-Host ""

