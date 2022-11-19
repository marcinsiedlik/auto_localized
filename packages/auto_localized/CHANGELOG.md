## [1.3.2]

* Dependencies update

## [1.3.1]

* Dependencies update, code styling

## [1.3.0] Breaking Changes

* Updated dependencies
* Added support for multiple translation files for single locale ([github issue link](https://github.com/marcinsiedlik/auto_localized/issues/9)), now you can split your translations to multiple files for easier management. Field `translationsFilePath` has been replaced with `translationsFiles`. Example migration:
```dart
// old
AutoLocalizedLocale(
  languageCode: 'pl',
  translationsFilePath: 'lang/pl.json',
)

// new
AutoLocalizedLocale(
  languageCode: 'pl',
  translationsFiles: ['lang/pl.json'],
)
```

## [1.2.0]

* Added opt-in feature `generateOfKeyFactories` that allows you to obtain LocalizedString during runtime by generated methods `ofKey` and `maybeOfKey`

## [1.1.0]

* Dependencies upgrade

## [1.0.0]

* Null-safety migration
* Constructor of generated strings class is now private (IntelliSense improvement)

## [0.7.0]

* Add text getter method that wraps string with `Text` widget

## [0.6.0]

* Add fromJson/toJson methods (compatibility with [json_serializable](https://pub.dev/packages/json_serializable)
  , [freezed](https://pub.dev/packages/freezed) etc.)
* Fix README.md minor error

## [0.5.2]

* Fix minor `BuildContext` extension typo

## [0.5.1]

* Update example
* Minor documentation fix

## [0.5.0]

* Add option to get translations with getter methods - `generateGetterMethods` annotation config field

## [0.4.2]

* Fix forbidden dependency issue

## [0.4.0]

* Move `flutter_localizations` export to separate file (Documentation cleanup)
* Hide unnecessary api in generator

## [0.3.1] Breaking Change

* Class name now have to start with `$` instead of `_$` (fix analyzer issues)
* Fix generation error for empty JSON/YAML file
* Fix linter issues

## [0.3.0] Breaking Change

* Add Safe Arguments supports.
* You can get translation without passing `BuildContext` in `get` method. (Wrapping `MaterialApp` with `AutoLocalizedApp` is required).
* The current locale is now accessible with `AutoLocalization.instance.locale`.

## [0.2.0] Breaking Change

* Add YAML support.
* `AutoLocalizedLocale` field: `jsonFilePath` replaced with `translationsFilePath`.

## [0.1.0]

* Initial release.
