# auto_localized

auto_localized is simplifying Flutter localization by using code generation.
This approach has many advantages such as runtime-safety and better performance. The generator checks translation files for 
missing keys, blank values etc. and outputs easy to use dart fields (or methods). 

Supported file types: JSON, YAML.
* Generation time validation
* Get translations without `BuildContext`
* Safe Arguments
* Supported file types: JSON, YAML

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

If you store your translations files outside of `lib` folder (which you should), example structure:
```
lang/
├── en.yaml
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

You can checkout sample configuration in the [example](https://github.com/marcinsiedlik/auto_localized/tree/master/packages/example).

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
      translationsFiles: ['lang/pl.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      translationsFiles: ['lang/en.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      translationsFiles: ['lang/sk.json'],
    ),
  ],
)
class $Strings {}
```

***Important:** path to translation file must be relative. Class name have to start with `$`. 
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

In app declaration add generated config fields: `supportedLocales` and `localizationsDelegates`\. 
Also, if you want to get translations without context you need to wrap `MaterialApp` with `AutoLocalizedApp`:

```dart
return AutoLocalizedApp(
  child: MaterialApp(
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationsDelegates,
  ),
);
```
You can access these fields by `AutoLocalizedData` class or `AutoLocalizedContextExtension`.

### Done!

Translations are ready to use by:
```dart
Text(
  Strings.welcome.get(context),
)
```
you can also get translations without context:
 ```dart
 Text(
   Strings.welcome.get(),
 )
 ```
`BuildContext` extension is also here:
```dart
Text(
  context.translate(Strings.welcome),
)
```
If you enable `generateGetterMethods` in annotation config you will get two additional ways:
```dart
//getter method
Text(
  Strings.getWelcome();
)

//BuildContext extension
Text(
  context.getWelcome();
)
```

### Example

For typical complete setup checkout [example](https://github.com/marcinsiedlik/auto_localized/tree/master/packages/example).

## Features

### Safe Arguments

You can define up to 5 arguments in for your translations, to define argument use syntax: `{(number from 1 to 5)}`
for example:
```json
{
  "welcome_message" : "Welcome {1}!, You have {2} points."
}
``` 
Result: 
```dart
Strings.welcomeMessage('Marcin', '3');
```
***Note:** These arguments are required - The compiler will force you to pass these arguments.*

You can also get args translation without applying them with `getRaw()` method.

Argument with given number can be used as much as you want, example:
```json
{
  "distance" : "Traveled: {2} {1} - Distance: {3} {1}"
}
``` 
You can get value for arg string with: 
```dart
Strings.distance.get('km', '12', '30');
```
If you enable `generateGetterMethods` in annotation config you will get two additional ways:
```dart
//getter method
Strings.getDistance('km', '12', '30');

//BuildContext extension
context.getDistance('km', '12', '30');
```

There is also regular translate `BuildContext` extension method:
```dart
Text(
  context.translate(Strings.welcomeMessage, 'Marcin', '3'),
)
```
This last method is unrecommended, because Dart [does not support method overloading](https://github.com/dart-lang/language/issues/1122).
Compiler can't force you to pass all required arguments, default value for missing argument is `""`.

### Annotation configuration

auto_localized offers some configuration options for validation and code generation.

| Option                   | Default value | Description                                                                                                                                                                                                                                                                                         |
|--------------------------|:-------------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `locales`                |       -       | List of `AutoLocalizedLocale` to associate language code (and optionally country code) with translations file. List can't be null or empty.                                                                                                                                                         |
| `generateGetterMethods`  |    `false`    | When set to true apart from fields creates additional getter methods for generated fields and extension methods on `BuildContext`. This gives you the additional ways of getting strings.                                                                                                           |
| `convertToCamelCase`     |    `true`     | If set to `true` then any key case will be converted to camel case in generated source. For example key: `{ "test_message": "..." }` will be generated to source: `static const testMessage = LocalizedString(...);` If set to `false` the original key will be used.                               |
| `onBlankValueStrategy`   |    `error`    | Defines the behaviour when the value for key is blank or contains only whitespaces. **Note:** This behaviour is will not be triggered if value is explicitly defined as `null`. In that case generator will always throw an Error.                                                                  |
| `generateOfKeyFactories` |    `false`    | When set to true you will gain access to additional methods `ofKey` and `maybeOfKey`. They will allow you to get `LocalizedString` at runtime with key from translation file. This feature is disabled by default because it introduces a point of possible runtime failure - use at your own risk. |

### Text getter

Translation can be also accessed with `text` method that wraps string with `Text` widget
```dart
Strings.welcomeMessage.text(
  arg: 'Marcin',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 17),
);
``` 

### Current locale

You can access the current locale with:
```dart
AutoLocalization.instance.locale;
```

### Locale update callback

Often you would like to know when locale changes to perform different tasks: update network headers etc. 
You can do that with `AutoLocalization.addOnLocaleChangeCallback`.

Example:
```dart
AutoLocalization.addOnLocaleChangeCallback((locale) { 
      //do stuff
});
```

To stop listening for updates use `AutoLocalization.removeOnLocaleChangeCallback`.

Example:
```dart

void onLocaleChange(Locale locale) {
  //do stuff
}

AutoLocalization.addOnLocaleChangeCallback(onLocaleChange);

AutoLocalization.removeOnLocaleChangeCallback(onLocaleChange);
```
## Additional
Generate files have `.al.dart` extension, if You don't version controlling generated files don't forget to add it to `.gitignore`

