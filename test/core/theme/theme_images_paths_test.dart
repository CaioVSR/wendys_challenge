import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/theme/theme_images_paths.dart';

void main() {
  group('ThemeImagesPaths', () {
    test('wendysLogo returns correct asset path', () {
      const expectedPath = 'assets/images/wendys_logo.png';

      const actualPath = ThemeImagesPaths.wendysLogo;

      expect(actualPath, expectedPath);
    });
  });
}
