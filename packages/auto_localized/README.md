# auto_localized

Flutter localization tool that moves all the translation files validation
from runtime to source generation step and generates easy to use fields. Usage example:
```dart
Text(
  context.translate(Strings.welcome),
)
```

Using code generation has many strong advantages such as runtime-safety and better performance.

## Getting Started

### Native setup

On **iOS** you need to add supported locales to `ios/Runner/Info.plist`

Example:
```xml
<key>CFBundleLocalizations</key>
<array>
  <string>pl</string>
  <string>en</string>
  <string>sk</string>
</array>
```
### Pubspec setup
Add dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  auto_localized: <latest_version>

dev_dependencies:
  build_runner: ^1.10.1 
  auto_localized_generator: <latest_version>
```

***Note:** no need for adding `flutter_localizations` dependency: `auto_localized` does it for you.*

If you store your translation json files outside of `lib` folder (which you should), example structure:
```
lang/
├── en.json
├── pl.json
└── sk.json
lib/
pubspec.yaml
```

you need to tell [build](https://github.com/dart-lang/build) about that. To include folders other than `lib` you need to add them 
to `sources`. Create `build.yaml` file in package directory. Example `build.yaml`:
```yaml
targets:
  $default:
    sources:
      - $package$
      - lib/**
      - lang/**
```

You can look-up a sample configuration in the [example](https://github.com/marcinsiedlik/auto_localized/tree/master/packages/example).

### Configuration

Create new dart file create a dummy class and annotate it with `AutoLocalized`. Example:
```dart
import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  convertToCamelCase: true,
  onBlankValueStrategy: OnBlankValueStrategy.error,
  locales: [
    AutoLocalizedLocale(
      languageCode: 'pl',
      jsonFilePath: 'lang/pl.json',
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      jsonFilePath: 'lang/en.json',
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      jsonFilePath: 'lang/sk.json',
    ),
  ],
)
class _$Strings {}
```
Class name have to start with: `_$`. It will be used in generated translations. For the example above it will be: `Strings`.
 
### Generation
 
Run the generator with command in terminal:
```
flutter pub run build_runner build --delete-conflicting-outputs
```
Build can run automatically after every file change with:
```
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Usage

Gp to app declaration and add generated config fields: `supportedLocales` and `localizationsDelegates`:

```dart
MaterialApp(
      title: 'Auto Localized Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationsDelegates,
      home: HomePage(),
    );
```
You can access these fields by `AutoLocalizedData` class or `AutoLocalizedContextExtension`.

Translations are ready to use by:
```dart
Text(
  context.translate(Strings.welcome),
)
```
or:
```dart
Text(
  Strings.welcome.get(context),
)
```

### Example

For typical complete setup checkout [example](https://github.com/marcinsiedlik/auto_localized/tree/master/packages/example).

