# Third-Party Notices

The CC0 dedication in [LICENSE](LICENSE) does not apply to the components
listed here. Each component remains under its upstream license.

## Checked-In Runtime Files

The following files byte-match artifacts distributed in the locked
`drift 2.34.3` package:

| Repository file | SHA-256 | Origin |
| --- | --- | --- |
| `web/drift_worker.js` | `4DB0469DE8CEABAD8D5CD3D920614486BA587E100E39523F36F704A3AEC5F26C` | Drift web worker, MIT |
| `web/sqlite3.wasm` | `41CF968998241465D8B1DFFFB1EB60DD10C35DE5022A3647E14174EA3AF84143` | SQLite WebAssembly runtime shipped by Drift |

Drift is Copyright (c) 2021 Simon Binder and is distributed under the MIT
License. The MIT notice that applies to the retained Drift artifact follows:

> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.

SQLite states that its source code is in the public domain. The compiled WASM
file is retained as an upstream runtime artifact and is not included in this
repository's CC0 dedication.

## Direct Dependencies and Tools

Versions are resolved by `pubspec.lock`.

| Component | Role | Upstream license |
| --- | --- | --- |
| Flutter and Dart SDKs | Application framework and toolchain | BSD-style licenses |
| `drift` | Database runtime and web assets | MIT |
| `drift_flutter` | Flutter database integration | MIT |
| `intl` | Internationalization | BSD-3-Clause |
| `drift_dev` | Database code generation | MIT |
| `build_runner` | Build-time code generation | BSD-3-Clause |
| `flutter_lints` | Development lint rules | BSD-3-Clause |

These packages have transitive dependencies under additional permissive
licenses. Flutter generates the complete license inventory for a compiled app
in its `NOTICES` asset. Distributors must retain that generated inventory and
comply with all applicable upstream license terms. This summary does not
replace those license texts.

## Generated Source

`lib/data/app_database.g.dart` is generated from the repository's Drift schema
by `drift_dev`. It contains no upstream license header. The repository does not
assert that generation alone transfers or replaces any upstream rights; the
CC0 dedication applies only to rights held by the repository authors.