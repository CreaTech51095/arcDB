# arcDB - Archaeological Artifacts Database

A modern web and mobile application for managing archaeological artifacts with QR code scanning capabilities.

## 🌟 Features

- 📱 **QR Code Scanning**: Scan QR codes to instantly retrieve artifact information
- 🗄️ **Artifact Management**: Create, edit, and organize artifact records
- 📸 **Photo Management**: Upload and manage multiple photos per artifact
- 🔍 **Advanced Search**: Filter by name, date, location, type, and discovery site
- 📴 **Offline Mode**: Full functionality without internet connectivity
- 🔄 **Auto Sync**: Automatic data synchronization with conflict resolution
- 👥 **Role-Based Access**: Admin, Archaeologist, and Researcher roles
- 🔐 **Secure Authentication**: Email/password authentication
- 💾 **Data Persistence**: Cloud storage with Firebase

## 🚀 Quick Start

### Prerequisites

- Node.js v18 or higher
- npm or yarn
- Git
- Firebase account

### Automated Setup

#### Windows PowerShell:
```powershell
.\setup-arcdb.ps1
```

#### Mac/Linux/Git Bash:
```bash
chmod +x setup-arcdb.sh
./setup-arcdb.sh
```

The automated script will guide you through the entire setup process.

### Manual Setup

For detailed step-by-step instructions, see [SETUP_ARCDB.md](./SETUP_ARCDB.md)

## 📚 Documentation

- **[Quick Start Guide](./QUICK_START.md)** - Fast setup and common commands
- **[Setup Guide](./SETUP_ARCDB.md)** - Detailed installation instructions
- **[Migration Summary](./MIGRATION_SUMMARY.md)** - Configuration changes and migration notes

## 🏗️ Project Structure

```
arcDB/
├── frontend/                 # React frontend application
│   ├── src/
│   │   ├── components/      # React components
│   │   ├── pages/           # Page components
│   │   ├── services/        # API and Firebase services
│   │   ├── types/           # TypeScript type definitions
│   │   └── hooks/           # Custom React hooks
│   ├── public/              # Static assets
│   └── dist/                # Production build
├── firebase-functions/       # Firebase Cloud Functions
│   ├── src/
│   │   ├── auth/            # Authentication functions
│   │   ├── artifacts/       # Artifact management
│   │   ├── photos/          # Photo processing
│   │   └── sync/            # Data synchronization
│   └── lib/                 # Compiled functions
├── specs/                    # Project specifications
└── firebase.json            # Firebase configuration

```

## 🛠️ Technology Stack

### Frontend
- **React** - UI framework
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Tailwind CSS** - Styling
- **React Router** - Navigation
- **React Query** - Data fetching and caching
- **Firebase SDK** - Backend integration
- **Dexie.js** - Offline storage
- **html5-qrcode** - QR code scanning

### Backend
- **Firebase Authentication** - User management
- **Cloud Firestore** - NoSQL database
- **Firebase Storage** - File storage
- **Cloud Functions** - Serverless backend
- **Node.js** - Runtime environment

### Development Tools
- **ESLint** - Code linting
- **Jest** - Unit testing
- **Playwright** - E2E testing
- **TypeScript** - Type checking

## 🔧 Development

### Install Dependencies
```bash
# Frontend
cd frontend
npm install

# Functions
cd firebase-functions
npm install
```

### Run Development Server
```bash
# Frontend (with hot reload)
cd frontend
npm run dev
```

### Run Firebase Emulators
```bash
firebase emulators:start
```

### Build for Production
```bash
# Frontend
cd frontend
npm run build

# Functions
cd firebase-functions
npm run build
```

### Run Tests
```bash
# Frontend unit tests
cd frontend
npm test

# E2E tests
cd frontend
npm run test:e2e
```

## 🚀 Deployment

### Deploy to Firebase
```bash
# Login to Firebase
firebase login

# Deploy everything
firebase deploy

# Deploy specific services
firebase deploy --only hosting
firebase deploy --only functions
firebase deploy --only firestore
firebase deploy --only storage
```

## 👥 User Roles

### Admin
- Full access to all features
- User management
- Role assignment
- System configuration

### Archaeologist
- Create and edit artifacts
- Upload photos
- Scan QR codes
- Search and filter artifacts

### Researcher
- View-only access
- Search and filter artifacts
- View artifact details and photos

## 🔐 Security

- Email/password authentication
- Role-based access control
- Secure Firebase rules for Firestore and Storage
- Environment variables for sensitive data
- Service account keys protected by `.gitignore`

## 📱 Offline Functionality

The app supports full offline mode:
- Browse artifacts offline
- Create new artifacts offline
- Edit existing artifacts offline
- Scan QR codes offline
- Automatic sync when back online
- Conflict resolution for concurrent edits

## 🌐 Links

- **Live Application**: https://arcdb.web.app
- **GitHub Repository**: https://github.com/CreaTech51095/arcDB
- **Firebase Console**: https://console.firebase.google.com/project/arcdb

## 📋 Environment Variables

Create a `frontend/.env` file with the following variables:

```env
VITE_FIREBASE_API_KEY=your_api_key
VITE_FIREBASE_AUTH_DOMAIN=arcdb.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=arcdb
VITE_FIREBASE_STORAGE_BUCKET=arcdb.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
VITE_FIREBASE_APP_ID=your_app_id
VITE_FIREBASE_MEASUREMENT_ID=your_measurement_id
```

See `frontend/env.example` for template.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is private and proprietary.

## 🆘 Support

For issues and questions:
1. Check the [Setup Guide](./SETUP_ARCDB.md) troubleshooting section
2. Review [Migration Summary](./MIGRATION_SUMMARY.md)
3. Check Firebase Console logs
4. Review browser console for client-side errors

## 📝 Version History

### v1.0.0 (Current)
- Initial release with full artifact management
- QR code scanning functionality
- Offline mode support
- Role-based access control
- Photo upload and management
- Advanced search and filtering

## 🙏 Acknowledgments

- Built for archaeological research and artifact management
- Designed to work in remote locations with limited connectivity
- Focused on ease of use and reliability

---

**Project**: arcDB  
**Status**: Active Development  
**Last Updated**: 2025-10-19  
**Maintainer**: CreaTech51095

