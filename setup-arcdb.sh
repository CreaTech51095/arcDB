#!/bin/bash
# arcDB Setup Script for Mac/Linux/Git Bash
# This script automates the setup process

echo ""
echo "=================================="
echo "   arcDB Setup Script"
echo "=================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

if ! command_exists node; then
    echo -e "${RED}❌ Node.js is not installed. Please install Node.js v18 or higher.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js found: $(node --version)${NC}"

if ! command_exists npm; then
    echo -e "${RED}❌ npm is not installed.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ npm found: $(npm --version)${NC}"

if ! command_exists git; then
    echo -e "${RED}❌ Git is not installed. Please install Git.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Git found: $(git --version)${NC}"

if ! command_exists firebase; then
    echo -e "${YELLOW}❌ Firebase CLI is not installed.${NC}"
    echo -e "${YELLOW}Installing Firebase CLI...${NC}"
    npm install -g firebase-tools
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to install Firebase CLI${NC}"
        exit 1
    fi
fi
echo -e "${GREEN}✅ Firebase CLI found${NC}"

# Step 1: Git Setup
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 1: Git Repository Setup${NC}"
echo -e "${CYAN}==================================${NC}"

read -p $'\nDo you want to push to GitHub now? (y/n) ' response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}Adding and committing changes...${NC}"
    git add .
    git commit -m "Configure for arcDB and arcdb.web.app"
    
    echo -e "\n${YELLOW}Updating Git remote...${NC}"
    git remote remove origin 2>/dev/null
    git remote add origin https://github.com/CreaTech51095/arcDB.git
    
    echo -e "\n${YELLOW}Pushing to GitHub...${NC}"
    echo -e "${YELLOW}You may need to authenticate with GitHub...${NC}"
    
    # Try main first, then master
    git push -u origin main 2>/dev/null
    if [ $? -ne 0 ]; then
        git push -u origin master
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    else
        echo -e "${RED}❌ Failed to push to GitHub. Please check your credentials.${NC}"
    fi
else
    echo -e "${YELLOW}⏭️  Skipping GitHub push. You can do this manually later.${NC}"
fi

# Step 2: Environment File
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 2: Firebase Configuration${NC}"
echo -e "${CYAN}==================================${NC}"

if [ ! -f "frontend/.env" ]; then
    echo -e "\n${YELLOW}⚠️  No .env file found in frontend directory${NC}"
    echo -e "${YELLOW}You need to create frontend/.env with your Firebase config${NC}"
    echo -e "${YELLOW}See frontend/env.example for the template${NC}"
    echo ""
    echo -e "${CYAN}Steps to get Firebase config:${NC}"
    echo "1. Go to https://console.firebase.google.com"
    echo "2. Create project with ID: arcdb"
    echo "3. Enable Authentication (Email/Password)"
    echo "4. Create Firestore Database"
    echo "5. Enable Storage"
    echo "6. Go to Project Settings > Your apps"
    echo "7. Add web app and copy the config"
    echo ""
    read -p $'Have you created frontend/.env? (y/n) ' response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "\n${YELLOW}⏭️  Please create frontend/.env and run this script again${NC}"
        echo -e "${YELLOW}Or continue manually following SETUP_ARCDB.md${NC}"
        exit 0
    fi
else
    echo -e "${GREEN}✅ Found frontend/.env file${NC}"
fi

# Step 3: Install Dependencies
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 3: Installing Dependencies${NC}"
echo -e "${CYAN}==================================${NC}"

echo -e "\n${YELLOW}Installing Firebase Functions dependencies...${NC}"
cd firebase-functions
npm install
cd ..
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Firebase Functions dependencies installed${NC}"
else
    echo -e "${RED}❌ Failed to install Firebase Functions dependencies${NC}"
    exit 1
fi

echo -e "\n${YELLOW}Installing Frontend dependencies...${NC}"
cd frontend
npm install
cd ..
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Frontend dependencies installed${NC}"
else
    echo -e "${RED}❌ Failed to install Frontend dependencies${NC}"
    exit 1
fi

# Step 4: Firebase Login
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 4: Firebase Login${NC}"
echo -e "${CYAN}==================================${NC}"

read -p $'\nDo you want to login to Firebase now? (y/n) ' response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}Opening Firebase login...${NC}"
    echo -e "${CYAN}Please sign in with: createch51095@gmail.com${NC}"
    firebase login
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Successfully logged in to Firebase!${NC}"
    else
        echo -e "${RED}❌ Failed to login to Firebase${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⏭️  Skipping Firebase login${NC}"
fi

# Step 5: Build Frontend
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 5: Building Frontend${NC}"
echo -e "${CYAN}==================================${NC}"

read -p $'\nDo you want to build the frontend now? (y/n) ' response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}Building frontend...${NC}"
    cd frontend
    npm run build
    cd ..
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Frontend built successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to build frontend${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⏭️  Skipping frontend build${NC}"
fi

# Step 6: Deploy
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}Step 6: Deploy to Firebase${NC}"
echo -e "${CYAN}==================================${NC}"

read -p $'\nDo you want to deploy to Firebase now? (y/n) ' response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}Deploying to Firebase...${NC}"
    echo -e "${YELLOW}This may take several minutes...${NC}"
    firebase deploy
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✅ Successfully deployed to Firebase!${NC}"
        echo -e "\n${CYAN}🎉 Your app is now live at: https://arcdb.web.app${NC}"
    else
        echo -e "${RED}❌ Failed to deploy to Firebase${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⏭️  Skipping Firebase deployment${NC}"
fi

# Summary
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}   Setup Complete!${NC}"
echo -e "${CYAN}==================================${NC}"
echo -e "\n${YELLOW}📚 For detailed instructions, see: SETUP_ARCDB.md${NC}"
echo -e "${CYAN}🌐 Live App: https://arcdb.web.app${NC}"
echo -e "${CYAN}💻 GitHub: https://github.com/CreaTech51095/arcDB${NC}"
echo -e "${CYAN}🔥 Firebase Console: https://console.firebase.google.com/project/arcdb${NC}"
echo ""

