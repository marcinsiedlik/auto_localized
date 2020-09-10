## [0.3.0] Breaking Change

* Add Safe Arguments supports.
* You can get translation without passing `BuildContext` in `get` method. (Wrapping `MaterialApp` with `AutoLocalizedApp` is required).
* The current locale is now accessible with `AutoLocalization.instance.locale`. 

## [0.2.0] Breaking Change

* Add YAML support.
* `AutoLocalizedLocale` field: `jsonFilePath` replaced with `translationsFilePath`.

## [0.1.0]

* Initial release.
