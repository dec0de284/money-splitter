# Money Splitter

Money Splitter is a Flutter application for saving percentage profiles and
splitting a capital amount among them. Profile data is stored locally with
Drift.

## Requirements

- Flutter stable with Dart 3.12 or later
- A browser supported by Flutter for the web build

## Development

Install the locked dependencies and run the app:

```sh
flutter pub get
flutter run -d chrome
```

Run the same checks used by continuous integration:

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
dart run build_runner build
flutter build web
```

`lib/data/app_database.g.dart` is generated from
`lib/data/app_database.dart` and is committed so a checkout can compile
without running the generator. Regenerate it after changing the Drift schema
and commit the result.

The checked-in `web/drift_worker.js` and `web/sqlite3.wasm` files are required
inputs for Drift on the web. They are copied from the locked Drift package;
`flutter build web` consumes them but does not create them. Build output is
written under `build/` and is intentionally ignored.

## Automation

Pull requests and pushes to `main` run formatting, analysis, tests, generated
database verification, and a release web build. Dependabot checks Dart/pub and
GitHub Actions dependencies weekly.

## Licensing

Original material authored for this repository is dedicated under CC0 1.0
Universal. Dependencies, retained runtime files, toolchain components, and
compiled distributions remain under their respective upstream terms. See
[LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

The licensing inventory is provided for project maintenance and is not legal
advice.
