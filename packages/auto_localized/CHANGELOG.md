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
