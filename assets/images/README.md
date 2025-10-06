# Images

This directory contains image assets used in the application.

## Structure

- `logo/` - App logos and branding
- `icons/` - App icons and UI icons
- `backgrounds/` - Background images
- `placeholders/` - Placeholder images

## Formats

Supported formats:
- PNG (recommended for icons and logos)
- JPG (recommended for photos)
- SVG (recommended for scalable graphics)
- WebP (recommended for web optimization)

## Optimization

- Compress images before adding to the project
- Use appropriate sizes for different screen densities
- Consider using vector graphics (SVG) when possible

## Usage

Images are referenced in the `pubspec.yaml` file and can be used in the app with:

```dart
Image.asset('assets/images/logo/app_logo.png')
```
