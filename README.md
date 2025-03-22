<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=30&pause=1000&color=22C55E&center=true&vCenter=true&width=435&lines=%F0%9F%93%8C%EF%B8%8F+TaskFlow+%F0%9F%93%9D%EF%B8%8F;Offline-First+Productivity;Hive+%7C+BLoC+%7C+Firebase" alt="Animated Header">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.19.3-%2302569B?style=for-the-badge&logo=flutter">
  <img src="https://img.shields.io/badge/Null%20Safety-✅-%2300C853?style=for-the-badge">
  <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Desktop-%23007ACC?style=for-the-badge">
</p>

---

## ✨ Key Features
<p align="center">
  <img src="https://media.giphy.com/media/J3PFGI4iBqRy6QEMhq/giphy.gif" width="200" align="right">

- 📱 **Universal App** - Mobile & Desktop support
- 🌐 **Smart Sync** - Seamless offline-first architecture
- 🎮 **Real-time UI** - BLoC-powered state management
- 🔄 **CRUD Operations** - Intuitive task management
- 🛡️ **Data Safety** - Hive local storage + Firebase backup
- 🎨 **Pixel-Perfect UI** - Responsive & adaptive design
</p>

---

## 🛠️ Tech Stack
<div align="center">

| Category          | Technologies                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| **Core Framework**| <img src="https://img.shields.io/badge/Flutter-3.19.3-blue?logo=flutter">   |
| **State Mgmt**    | <img src="https://img.shields.io/badge/BLoC-8.1.3-%2300ACC1?logo=bloc">     |
| **Local DB**      | <img src="https://img.shields.io/badge/Hive-2.2.3-%23FF9A00?logo=hive">     |
| **Cloud Sync**    | <img src="https://img.shields.io/badge/Firebase-9.22.0-%23FFCA28?logo=firebase"> |
| **UI Toolkit**    | <img src="https://img.shields.io/badge/Slidable-3.0.0-%234285F4?logo=flutter"> |

</div>

---

## 🚀 Offline-First Architecture
```mermaid
graph LR
    A[User Interface] --> B[BLoC Layer]
    B --> C{"Internet?"}
    C -->|Yes| D[Firebase Cloud]
    C -->|No| E[Hive Local DB]
    D <--> F[Background Sync]
    E <--> F
    F --> G[Data Consistency]
```
📂 Project Structure
bash
Copy
lib/
├── config/                 # Routing & theme config
├── core/                   # Shared resources
│   ├── constants/          # App constants
│   ├── utils/              # Helper functions
│   └── widgets/            # Reusable components
├── features/               # Feature modules
│   └── tasks/              # Task management
│       ├── data/           # Data layer
│       │   ├── datasources # Local/remote sources
│       │   └── models      # Data models
│       ├── domain/         # Business logic
│       └── presentation/   # UI layer
│           ├── bloc/       # State management
│           └── views/      # Screens
└── injection.dart          # DI configuration