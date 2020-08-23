# auto_localized

auto_localized is simplifying Flutter localization tool by using code generation.
Using code generation has many advantages such as runtime-safety and better performance. The generator checks translation files for missing keys, blank values etc. and generates easy to use dart fields. 

---

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
  build_runner: <latest_version>
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
build.yaml
pubspec.yaml
```

you need to tell [build_runner](https://pub.dev/packages/build_runner) about that, by overriding default `sources`
(by default you can reference a file only from `lib` directory). Create new (or update existing) `build.yaml` file on the root 
of the project and add following section: 
```yaml
targets:
  $default:
    sources:
      - $package$
      - lib/**
      - lang/**  # <-- your translations directory 
```

You can look-up a sample configuration in the [example](https://github.com/marcinsiedlik/auto_localized/tree/master/packages/example).

***Note:** Adding translations directory to `assets` section in `pubspec.yaml` is not required. Flutter don't need these files at runtime.*

### Configuration

Create new dart file with empty class and annotate it with `AutoLocalized`. 

Example:
```dart
import 'package:auto_localized/annotations.dart';

@AutoLocalized(
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

***Important:** path to translation file must be relative. Class have to start with `_$`. 
Name of that class will be used as name of translation container class - for the example above it will be: `Strings`.*

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

In app declaration add generated config fields: `supportedLocales` and `localizationsDelegates`:

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

### Done!

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

## Features

### Annotation configuration

auto_localized offers some configuration options for validation and code generation.

| Option                 | Default value | Description |
|------------------------|:-------------:|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `locales`              |       -       | list of `AutoLocalizedLocale` to associate `language code` (and optionally `country code`) with json file. List can't be null or empty.                                                                                                                                                                                                                          |
| `convertToCamelCase`   |     `true`    | If set to `true` then any key case will be converted to camel case in generated source. For example json key: `{ "test_message": "..." }` will be generated to source: `static const testMessage = LocalizedString(...);` If set to `false` the original key will be used.|
| `onBlankValueStrategy` |    `error`    | Defines the behaviour when the value for key is blank or consists of the characters of whites only. **Note:** This behaviour is will not be triggered if value is explicitly defined as `null`. In that case generator will always throw an Error. |

### Locale update callback

Often you would like to know when locale changes to perform different tasks: update network headers etc. 
You can do that with `AutoLocalization.addOnLocaleChangeCallback`.

Example:
```dart
AutoLocalization.addOnLocaleChangeCallback((locale) { 
      //do stuff
});
```

To stop listening for updates use `AutoLocalization.addOnLocaleChangeCallback`.

## Additional
Generate files have `.al.dart` extension, if You don't version controlling generated files don't forget to add it to `.gitigonre`

