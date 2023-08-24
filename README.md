![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

<p align="center">
<a href="https://pub.dev/packages/flutter_pdf_kit"><img src="https://img.shields.io/pub/v/flutter_pdf_kit" alt="Pub"></a>
<a href="https://github.com/nikolaydymura/flutter_pdf_kit/actions"><img src="https://github.com/nikolaydymura/flutter_pdf_kit/actions/workflows/flutter_pdf_kit.yaml/badge.svg" alt="build"></a>
<a href="https://github.com/nikolaydymura/flutter_pdf_kit"><img src="https://img.shields.io/github/stars/nikolaydymura/flutter_pdf_kit.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

A flutter package for iOS and MacOS for applying CoreImage filters to image.

## Usage

### Display PDF document

```dart
import 'package:flutter_pdf_kit/flutter_pdf_kit.dart';

class PdfViewDemo extends StatelessWidget {
  const PdfViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPdfView.asset('assets/dummy.pdf');
  }
}

```