# Quick Start Guide for arcDB

## 🚀 Automated Setup (Recommended)

### For Windows PowerShell:
```powershell
.\setup-arcdb.ps1
```

### For Mac/Linux/Git Bash:
```bash
chmod +x setup-arcdb.sh
./setup-arcdb.sh
```

The script will guide you through:
1. ✅ Pushing to GitHub
2. ✅ Installing dependencies
3. ✅ Firebase login
4. ✅ Building the frontend
5. ✅ Deploying to Firebase

---

## 📝 Manual Setup

If you prefer manual setup, follow `SETUP_ARCDB.md` for detailed step-by-step instructions.

---

## ⚡ Quick Commands

### Push to GitHub
```bash
git add .
git commit -m "Configure for arcDB and arcdb.web.app"
git remote add origin https://github.com/CreaTech51095/arcDB.git
git push -u origin main
```

### Install & Build
```bash
cd firebase-functions && npm install && cd ..
cd frontend && npm install && npm run build && cd ..
```

### Deploy to Firebase
```bash
firebase login
firebase deploy
```

---

## 🔗 Important Links

- **Live App**: https://arcdb.web.app
- **GitHub**: https://github.com/CreaTech51095/arcDB
- **Firebase Console**: https://console.firebase.google.com/project/arcdb

---

## ⚠️ Before You Start

1. Create Firebase project with ID: `arcdb`
2. Enable Authentication (Email/Password)
3. Create Firestore Database
4. Enable Storage
5. Get Firebase config and create `frontend/.env`

See `SETUP_ARCDB.md` for detailed instructions.

---

## 🆘 Need Help?

See `SETUP_ARCDB.md` for:
- Detailed setup instructions
- Troubleshooting guide
- Firebase configuration steps
- Post-deployment tasks

