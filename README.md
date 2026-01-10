# CA Blog App 📝

A modern blog application built with **Flutter** following **Clean Architecture** principles. This app allows users to create, read, and manage blog posts with a beautiful dark-themed UI.

---

## 📱 Features

- **User Authentication**

  - Sign Up with email, password, and name
  - Sign In with email and password
  - Sign Out functionality
  - Persistent user session

- **Blog Management**

  - Create new blog posts with images
  - View all blog posts
  - Category-based blog organization
  - Blog post details view

- **Offline Support**

  - Local caching of blogs using Hive
  - Automatic sync when online

- **Modern UI**
  - Dark theme with gradient accents
  - Responsive design
  - Loading indicators and error handling

---

## 🏗️ Clean Architecture

This project follows **Clean Architecture** principles, separating the codebase into distinct layers:

```
lib/
├── core/                          # Shared/Core functionality
│   ├── common/
│   │   ├── entities/              # Common entities (User)
│   │   └── widgets/               # Reusable widgets
│   ├── cubits/                    # App-level state management
│   ├── error/                     # Error handling (Failures, Exceptions)
│   ├── network/                   # Network connectivity checker
│   ├── secrets/                   # App secrets/configuration
│   ├── theme/                     # App theming (colors, styles)
│   ├── usecase/                   # Base UseCase interface
│   └── utils/                     # Utility functions
│
├── features/
│   ├── auth/                      # Authentication Feature
│   │   ├── data/
│   │   │   ├── datasource/        # Remote data sources (Supabase)
│   │   │   ├── models/            # Data models (UserModel)
│   │   │   └── repository/        # Repository implementations
│   │   ├── domain/
│   │   │   ├── repository/        # Repository interfaces
│   │   │   └── usecases/          # Business logic (SignUp, SignIn, etc.)
│   │   └── presentation/
│   │       ├── bloc/              # Auth BLoC (state management)
│   │       ├── pages/             # UI screens (SignIn, SignUp)
│   │       └── widgets/           # Auth-specific widgets
│   │
│   └── blog/                      # Blog Feature
│       ├── data/
│       │   ├── datasources/       # Remote & Local data sources
│       │   ├── models/            # Data models (BlogModel)
│       │   └── repositories/      # Repository implementations
│       ├── domain/
│       │   ├── entities/          # Blog entity
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Business logic (Upload, Fetch)
│       └── presentation/
│           ├── bloc/              # Blog BLoC (state management)
│           ├── pages/             # UI screens (BlogPage, AddBlog, BlogView)
│           └── widgets/           # Blog-specific widgets
│
├── home.dart                      # Root navigation widget
├── init_dependencies.dart         # Dependency injection setup
└── main.dart                      # App entry point
```

### Architecture Layers

| Layer            | Purpose                                                         |
| ---------------- | --------------------------------------------------------------- |
| **Presentation** | UI components, BLoC/Cubit state management, user interactions   |
| **Domain**       | Business logic, entities, use cases, repository interfaces      |
| **Data**         | Data sources (remote/local), models, repository implementations |
| **Core**         | Shared utilities, error handling, network, theming              |

---

## 📦 Packages Used

### Core Dependencies

| Package                                                       | Version | Purpose                                                  |
| ------------------------------------------------------------- | ------- | -------------------------------------------------------- |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)         | ^9.1.1  | State management using BLoC pattern                      |
| [get_it](https://pub.dev/packages/get_it)                     | ^9.2.0  | Dependency injection / Service locator                   |
| [fpdart](https://pub.dev/packages/fpdart)                     | ^1.2.0  | Functional programming (Either type for error handling)  |
| [supabase_flutter](https://pub.dev/packages/supabase_flutter) | ^2.12.0 | Backend as a Service (Authentication, Database, Storage) |

### Data & Storage

| Package                                                         | Version       | Purpose                                           |
| --------------------------------------------------------------- | ------------- | ------------------------------------------------- |
| [hive](https://pub.dev/packages/hive)                           | ^4.0.0-dev.2  | Local database for offline caching                |
| [isar_flutter_libs](https://pub.dev/packages/isar_flutter_libs) | ^4.0.0-dev.13 | Native libraries for Hive/Isar                    |
| [path_provider](https://pub.dev/packages/path_provider)         | ^2.1.0        | Finding commonly used locations on the filesystem |

### Networking

| Package                                                                             | Version | Purpose                            |
| ----------------------------------------------------------------------------------- | ------- | ---------------------------------- |
| [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) | ^3.0.1  | Check internet connectivity status |

### UI & Utilities

| Package                                                     | Version | Purpose                                  |
| ----------------------------------------------------------- | ------- | ---------------------------------------- |
| [cupertino_icons](https://pub.dev/packages/cupertino_icons) | ^1.0.8  | iOS-style icons                          |
| [dotted_border](https://pub.dev/packages/dotted_border)     | ^3.1.0  | Dotted border widgets (for image picker) |
| [image_picker](https://pub.dev/packages/image_picker)       | ^1.2.1  | Pick images from gallery/camera          |
| [intl](https://pub.dev/packages/intl)                       | ^0.20.2 | Date formatting and internationalization |
| [uuid](https://pub.dev/packages/uuid)                       | ^4.5.2  | Generate unique identifiers for blogs    |

### Configuration

| Package                                                   | Version | Purpose                         |
| --------------------------------------------------------- | ------- | ------------------------------- |
| [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) | ^6.0.0  | Environment variable management |

---

## 🔧 Key Implementation Details

### Dependency Injection

Using **GetIt** service locator for managing dependencies:

```dart
final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  // Initialize Supabase
  final supabase = await Supabase.initialize(...);

  // Register dependencies
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  // Initialize features
  _initAuth();
  _initBlog();
}
```

### Use Case Pattern

Base use case interface with functional error handling:

```dart
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}
```

### Error Handling

Using **fpdart**'s `Either` type for functional error handling:

```dart
Future<Either<Failures, User>> signIn({
  required String email,
  required String password,
});
```

### State Management

**BLoC pattern** with events and states:

- `AuthBloc` - Handles authentication (SignUp, SignIn, SignOut, GetCurrentUser)
- `BlogBloc` - Handles blog operations (Upload, Fetch)
- `AppUserCubit` - Manages global user state across the app

### Offline Support

Repository pattern with local and remote data sources:

```dart
Future<Either<Failures, List<Blog>>> fetchAllBlogsRepo() async {
  if (!await connectionChecker.isConnected) {
    // Fetch from local database
    final localBlogs = localDataSource.getLocalBlogs();
    return Right(localBlogs);
  }
  // Fetch from remote and cache locally
  return await remoteDataSource.fetchAllBlogsDb().then((blogModels) {
    localDataSource.uploadLocalBlogs(blogs: blogModels);
    return Right(blogModels);
  });
}
```

---

## 🎨 Theme

The app uses a custom **dark theme** with gradient accent colors:

| Color      | Value                | Usage           |
| ---------- | -------------------- | --------------- |
| Background | `RGB(24, 24, 32)`    | Main background |
| Gradient 1 | `RGB(187, 63, 221)`  | Purple accent   |
| Gradient 2 | `RGB(251, 109, 169)` | Pink accent     |
| Gradient 3 | `RGB(255, 159, 124)` | Orange accent   |
| Border     | `RGB(52, 51, 67)`    | Input borders   |

---

## 🗄️ Database Schema (Supabase)

### Tables

**profiles**
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | User ID (FK to auth.users) |
| name | TEXT | User's display name |

**blogs**
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Blog post ID |
| poster_id | UUID | Author's user ID |
| title | TEXT | Blog title |
| content | TEXT | Blog content |
| image_url | TEXT | Cover image URL |
| categories | TEXT[] | List of categories |
| updated_at | TIMESTAMP | Last update time |

### Storage Buckets

- `blogs_images` - Stores blog cover images

---

## 🚀 Getting Started

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd ca_blog_app
   ```

2. **Set up environment variables**

   Create a `.env` file in the root directory:

   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📋 Requirements

- Flutter SDK: ^3.10.0
- Dart SDK: ^3.10.0

---

## 📄 License

This project is for educational purposes, demonstrating Clean Architecture implementation in Flutter.

---

## 🙏 Acknowledgments

Built with ❤️ using Flutter and Clean Architecture principles.
