# SmartTask - Практикалық жұмыс №3

Мобильді қосымшаның құрылымы мен навигациясы (Flutter, Material 3, сыртқы пакетсіз).

## Іске қосу
```bash
# Архивті ашып, жоба папкасына кіріңіз
flutter create . --project-name smart_task --org kz.smarttask   # android/ios/web папкаларын жасайды (lib/ бұзылмайды)
flutter pub get
flutter run
flutter test
```
Flutter 3.27+ (Dart 3.5+) қажет. Демо аккаунт: **demo@mail.com / 123456**

## Құрылым (feature-based)
```
lib/
├─ main.dart, app.dart            # кіру нүктесі, MaterialApp, Theme, routes
├─ core/
│  ├─ theme/                      # app_colors.dart, app_theme.dart (түс, шрифт, стиль)
│  ├─ routes/app_routes.dart      # named routes
│  ├─ state/                      # AppState (ChangeNotifier) + AppScope (InheritedNotifier)
│  ├─ constants/categories.dart
│  ├─ utils/                      # validators, formatters, responsive
│  └─ widgets/                    # reusable: PrimaryButton, AppTextField, ItemCard,
│                                 #           SectionHeader, EmptyState, ItemsView
└─ features/
   ├─ splash/presentation/        # Splash
   ├─ auth/{data,presentation}/   # User, AuthService, Login, Register
   ├─ home/presentation/          # HomeShell (Bottom NavigationBar), HomeTab
   ├─ items/{data,presentation}/  # Item, ItemService, List, Detail, Create/Edit form
   ├─ search/presentation/        # Search
   ├─ favorites/presentation/     # Favorites
   └─ profile/presentation/       # Profile, Settings
```

## Тапсырмалар бойынша сәйкестік
| № | Орындалуы |
|---|-----------|
| 2-3 | feature-based папкалар: data / presentation, core/widgets, core/state (сервистер `*_service.dart`) |
| 4 | `core/theme` - ThemeData (light + dark), түстер, батырма/input/card стильдері |
| 5 | `core/widgets` - қайталанатын виджеттер |
| 6 | `SplashScreen` - градиент, логотип, 2.2 сек кейін Login-ге өтеді |
| 7 | `LoginScreen`, `RegisterScreen` |
| 8 | `HomeTab` - сәлемдесу, іздеу жолы, статистика, санаттар, соңғы тапсырмалар |
| 9 | `ItemsListScreen` (санат бойынша сүзгі), `ItemDetailScreen` |
| 10 | `ItemFormScreen` - бір форма жаңа қосу мен өңдеуге |
| 11 | `SearchTab`, `FavoritesTab`, `ProfileTab`, `SettingsScreen` (қараңғы тақырып жұмыс істейді) |
| 12 | `AppRoutes` - named routes (`pushNamed`, `pushReplacementNamed`, `pushNamedAndRemoveUntil`) |
| 13 | `HomeShell` - NavigationBar + IndexedStack (4 бөлім) |
| 14-15 | `Validators` - email, бос пароль, ең аз ұзындық, құпия сөз сәйкестігі, бос міндетті өрістер; қате хабарламалар қазақша |
| 16 | `ResponsiveCenter` (max width) + `ItemsView` (телефон: ListView, планшет: GridView 2-3 баған) |
| 17-19 | Төмендегі тексеру тізімі |

## Figma-мен салыстыру / тексеру тізімі
- [ ] Негізгі түс (#3F3DBF), бұрыштар радиусы (14), аралықтар (20/12) Figma-дағыдай
- [ ] Splash -> Login -> Home -> List -> Detail -> Edit -> артқа қайту
- [ ] Register -> Home; Logout -> Login (артқа қайтқанда Home ашылмайды)
- [ ] Bottom bar 4 бөлім арасында күй сақталады (IndexedStack)
- [ ] Бос email/пароль, қате email, 6 таңбадан қысқа пароль кезінде қате көрінеді
- [ ] Таңдаулыға қосу барлық экранда бірдей жаңарады (AppState)
- [ ] Шағын телефон, үлкен телефон, планшетте overflow жоқ

## Қорғау кезінде түсіндіру
- **Неге feature-based?** Әр функционал (auth, items...) өз папкасында, қосымша өскенде ұстау оңай.
- **Күй басқару:** `AppState extends ChangeNotifier` + `InheritedNotifier` - сыртқы пакетсіз; өзгеріс болғанда тек тәуелді виджеттер қайта салынады.
- **Навигация:** `onGenerateRoute` арқылы бір орталықтан басқарылады, аргументтер (`itemId`, `Item?`) беріледі.
- **Validation:** `Form` + `TextFormField.validator` + `GlobalKey<FormState>.validate()`.
