<img src="http://159.65.210.101/php-actions.png" align="right" alt="PHP Actions for Github" />

Run PHP Code Sniffer tests in Github Actions.
=============================================

PHP_CodeSniffer is a script that tokenizes PHP, JavaScript and CSS files to detect violations of a defined coding standard - an essential development tool that ensures your code remains clean and consistent.

Common standards that can be checked include:

+ Use of camel case in variable, function, class names
+ Indentation rules, such as using tabs vs. spaces
+ Forbidden functions, such as `die()`
+ Checking that PHP files are side-effect-free

Usage
-----

```yaml
name: CI

on: [push]

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Composer install
        uses: php-actions/composer@v6

      - name: PHP Code Sniffer
        uses: php-actions/phpcs@v1
        with:
          php_version: 8.1
          path: src/
          standard: phpcs.xml
```

Version numbers
---------------

This action is released with semantic version numbers, but also tagged so the latest major release's tag always points to the latest release within the matching major version.

Please feel free to use uses: php-actions/phpcs@v1 to always run the latest version of v1, or uses: php-actions/phpcs@v1.0.0 to specify the exact release.

Inputs
------

The following configuration options are available:

+ `version` - What version of PHPCS to use
+ `php_version` - What version of PHP to use
+ `vendored_phpcs_path` - Path to a vendored phpcs binary
+ `path` - One or more files and/or directories to check
+ `standard` - The name or path of the coding standard to use
+ `sniffs` - A comma separated list of sniff codes to include checking (all sniffs must be part of the specified standard)
+ `exclude` - A comma separated list of sniff codes to exclude from checking (all sniffs must be part of the specified standard)
+ `ignore` - A comma separated list of patterns to ignore files and directories
+ `tab_width` - The number of spaces each tab represents
+ `report` - Print either the "full", "xml", "checkstyle", "csv", "json", "junit", "emacs", "source", "summary", "diff", "svnblame", "gitblame", "hgblame" or "notifysend" report, or specify the path to a custom report class, (the "full" report is printed by default)
+ `report_file` - Write the report to the specified file path
+ `report_width` - How many columns wide screen reports should be printed or set to "auto" to use current screen width, where supported
+ `basepath` - A path to strip from the front of file paths inside reports
+ `bootstrap` - A comma separated list of files to run before processing begins
+ `encoding` - The encoding of the files being checked (default is utf-8)
+ `extensions` - "A comma separated list of file extensions to check. The type of the file can be specified using: ext/type e.g., module/php,es/js"
+ `severity` - The minimum severity required to display an error or warning
+ `error_severity` - The minimum severity required to display an error
+ `warning_severity` - The minimum severity required to display a warning
+ `args` - Extra arguments to pass to the phpcs binary

If you require other configurations of PHPMD, please request them in the [Github issue tracker].

*****

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

[Github issue tracker]: https://github.com/php-actions/phpcs/issues
[sponsor]: https://github.com/sponsors/g105b
