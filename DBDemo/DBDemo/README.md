#  DBDemo

# Clean MVVM SwiftUI Offline App

## Features
- SwiftUI + Combine
- Clean Architecture
- Offline-first (SwiftData)
- Dependency Injection
- Unit & UI Testing

## Architecture
MVVM + UseCase + Repository

## Modules
- Presentation
- Domain
- Data

## Testing
- ViewModel Tests
- UseCase Tests
- Repository Tests
- UI Tests


📦 App
 ┣ 📂 Application
 ┃ ┣ App.swift
 ┃ ┣ DependencyContainer.swift
 ┃ ┗ SessionManager.swift
 ┣ 📂 Presentation
 ┃ ┣ 📂 Auth
 ┃ ┃ ┣ LoginView.swift
 ┃ ┃ ┣ SignupView.swift
 ┃ ┃ ┗ AuthViewModel.swift
 ┃ ┣ 📂 Home
 ┃ ┃ ┣ HomeView.swift
 ┃ ┃ ┗ HomeViewModel.swift
 ┃ ┣ 📂 Components
 ┃ ┃ ┗ CustomTextField.swift
 ┣ 📂 Domain
 ┃ ┣ 📂 Models
 ┃ ┃ ┣ User.swift
 ┃ ┃ ┗ Item.swift
 ┃ ┣ 📂 UseCases
 ┃ ┃ ┣ LoginUseCase.swift
 ┃ ┃ ┣ SignupUseCase.swift
 ┃ ┃ ┗ ItemUseCase.swift
 ┃ ┣ 📂 Repositories
 ┃ ┃ ┣ AuthRepositoryProtocol.swift
 ┃ ┃ ┗ ItemRepositoryProtocol.swift
 ┣ 📂 Data
 ┃ ┣ 📂 RepositoryImpl
 ┃ ┃ ┣ AuthRepository.swift
 ┃ ┃ ┗ ItemRepository.swift
 ┃ ┣ 📂 Local
 ┃ ┃ ┣ SwiftDataStack.swift
 ┃ ┃ ┣ UserEntity.swift
 ┃ ┃ ┗ ItemEntity.swift
 ┃ ┣ 📂 Remote (Optional)
 ┃ ┃ ┗ APIClient.swift
 ┣ 📂 Resources
 ┃ ┗ Assets.xcassets
 ┣ 📂 Tests
 ┃ ┣ 📂 UnitTests
 ┃ ┃ ┣ ViewModelTests
 ┃ ┃ ┣ UseCaseTests
 ┃ ┃ ┗ RepositoryTests
 ┃ ┗ 📂 UITests
 ┃   ┗ AppUITests.swift
