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
