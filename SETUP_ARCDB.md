# arcDB Setup Guide

This guide will walk you through setting up the arcDB repository and deploying to Firebase.

## Prerequisites
- Node.js installed (v18 or higher)
- Git installed
- Firebase account (createch51095@gmail.com)

---

## Step 1: Push to GitHub

Run these commands in your terminal from the project root (`C:\Projects\arcDB`):

```bash
# Check current git status
git status

# Add all changes
git add .

# Commit changes
git commit -m "Configure for arcDB and arcdb.web.app"

# Remove old remote (if exists - it's ok if this fails)
git remote remove origin

# Add new GitHub remote
git remote add origin https://github.com/CreaTech51095/arcDB.git

# Push to GitHub (you'll need to authenticate)
git push -u origin main
```

If `main` doesn't work, try:
```bash
git push -u origin master
```

---

## Step 2: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Sign in with: `createch51095@gmail.com`
3. Click **"Add project"** or **"Create a project"**
4. Enter project name: `arcdb`
5. Important: The project ID must be exactly `arcdb` (not arcdb-xxxxx)
6. Enable Google Analytics (optional but recommended)
7. Click **"Create project"**

---

## Step 3: Enable Firebase Services

### 3.1 Enable Authentication
1. In Firebase Console, go to **Build > Authentication**
2. Click **"Get started"**
3. Click on **"Email/Password"** under Sign-in providers
4. Toggle **"Enable"** to ON
5. Click **"Save"**

### 3.2 Create Firestore Database
1. Go to **Build > Firestore Database**
2. Click **"Create database"**
3. Select **"Start in production mode"** (we have rules configured)
4. Choose a location (preferably closest to your users)
5. Click **"Enable"**

### 3.3 Enable Storage
1. Go to **Build > Storage**
2. Click **"Get started"**
3. Select **"Start in production mode"** (we have rules configured)
4. Use the same location as Firestore
5. Click **"Done"**

---

## Step 4: Get Firebase Configuration

1. In Firebase Console, click the **gear icon** ⚙️ next to "Project Overview"
2. Select **"Project settings"**
3. Scroll down to **"Your apps"** section
4. Click the **web icon** `</>`  to add a web app
5. App nickname: `arcDB`
6. Check **"Also set up Firebase Hosting"**
7. Click **"Register app"**
8. Copy the `firebaseConfig` object values

---

## Step 5: Create Environment File

Create a file called `.env` in the `frontend/` directory:

```bash
# On Windows PowerShell
New-Item -Path "frontend\.env" -ItemType File

# Or manually create: frontend/.env
```

Add your Firebase configuration to `frontend/.env`:

```env
VITE_FIREBASE_API_KEY=your_api_key_here
VITE_FIREBASE_AUTH_DOMAIN=arcdb.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=arcdb
VITE_FIREBASE_STORAGE_BUCKET=arcdb.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id_here
VITE_FIREBASE_APP_ID=your_app_id_here
VITE_FIREBASE_MEASUREMENT_ID=your_measurement_id_here
```

Replace the values with the actual values from Step 4.

---

## Step 6: Install Dependencies

```bash
# Install Firebase Functions dependencies
cd firebase-functions
npm install
cd ..

# Install Frontend dependencies
cd frontend
npm install
cd ..
```

---

## Step 7: Firebase Login

```bash
firebase login
```

This will open a browser window. Sign in with `createch51095@gmail.com`.

---

## Step 8: Build Frontend

```bash
cd frontend
npm run build
cd ..
```

This will create the production build in `frontend/dist/`.

---

## Step 9: Deploy to Firebase

```bash
firebase deploy
```

This will deploy:
- ✅ Firestore rules
- ✅ Storage rules
- ✅ Firebase Functions
- ✅ Hosting

The deployment will take a few minutes.

---

## Step 10: Verify Deployment

1. Visit: `https://arcdb.web.app`
2. You should see the login page
3. Try creating a new account
4. Test the functionality

---

## Optional: Set Up Service Account (for admin scripts)

If you need to use `update-user-role.js`:

1. In Firebase Console > Project Settings > **Service Accounts** tab
2. Click **"Generate new private key"**
3. Download the JSON file
4. Rename it to: `arcdb-firebase-adminsdk.json`
5. Place it in the project root (same folder as `update-user-role.js`)
6. ⚠️ **IMPORTANT**: Add `arcdb-firebase-adminsdk.json` to `.gitignore`

Usage:
```bash
node update-user-role.js your-email@example.com admin
```

---

## Troubleshooting

### Error: "Project ID mismatch"
- Make sure `.firebaserc` has `"default": "arcdb"`
- Run: `firebase use arcdb`

### Error: "Permission denied"
- Make sure you're logged in: `firebase login --reauth`

### Build errors
- Delete `node_modules` and reinstall:
  ```bash
  cd frontend
  rm -rf node_modules
  npm install
  cd ..
  ```

### Deployment errors
- Check that you're in the project root directory
- Verify Firebase project is selected: `firebase projects:list`
- Try: `firebase use arcdb`

---

## Post-Deployment: Create Admin User

After deploying, you'll need to make your first user an admin:

1. Visit `https://arcdb.web.app` and register an account
2. Download the service account key (see Optional step above)
3. Run:
   ```bash
   node update-user-role.js createch51095@gmail.com admin
   ```

---

## Summary of Changes Made

✅ Updated `.firebaserc` - Changed project ID to `arcdb`
✅ Updated `frontend/env.example` - Changed to arcdb project
✅ Updated `frontend/package.json` - Changed name to `arcdb-frontend`
✅ Updated `firebase-functions/package.json` - Changed to `arcdb-functions`
✅ Updated `update-user-role.js` - Changed service account filename

---

## Next Steps

After successful deployment:

1. **Test the app thoroughly**
   - User registration
   - Login
   - Create artifacts
   - Scan QR codes
   - Upload photos
   - Test offline mode

2. **Set up CI/CD** (optional)
   - GitHub Actions for automatic deployment

3. **Monitor usage**
   - Firebase Console > Analytics
   - Check function logs
   - Monitor Firestore usage

---

## Support

If you encounter issues:
1. Check Firebase Console > Functions > Logs
2. Check browser console for errors
3. Verify all services are enabled in Firebase Console

---

**Project URLs:**
- **GitHub**: https://github.com/CreaTech51095/arcDB
- **Live App**: https://arcdb.web.app
- **Firebase Console**: https://console.firebase.google.com/project/arcdb

