# Publishing Guide for text_avatars Package

This guide will walk you through publishing the `text_avatars` package to pub.dev.

## Prerequisites

Before publishing, ensure you have:

1. **Pub.dev account**: Create one at [pub.dev](https://pub.dev)
2. **Google Account**: Required for pub.dev authentication
3. **Package verification**: All tests pass and package is validated

## Pre-Publishing Checklist

### ✅ Update Package Information

1. **Update `pubspec.yaml`**:
   - Replace `homepage`, `repository`, and `issue_tracker` URLs with your actual GitHub repository
   - Verify version number follows [semantic versioning](https://semver.org/)
   - Update description if needed

2. **Update `LICENSE`**:
   - Replace `[Your Name or Organization]` with your actual name or organization

3. **Review `README.md`**:
   - Add screenshots if available
   - Update any repository-specific links
   - Verify all code examples work

4. **Update `CHANGELOG.md`**:
   - Ensure current version changes are documented
   - Date the release

### ✅ Verify Package Quality

Run these commands to ensure quality:

```bash
# 1. Get dependencies
dart pub get

# 2. Analyze code for issues
dart analyze

# 3. Run all tests
flutter test

# 4. Format code
dart format .

# 5. Dry run publish
dart pub publish --dry-run
```

All commands should complete without errors or warnings.

## Publishing Steps

### Step 1: Verify Package

Run a dry-run to validate the package:

```bash
dart pub publish --dry-run
```

Expected output:
```
Package has 0 warnings.
```

### Step 2: Publish to pub.dev

```bash
dart pub publish
```

You will be prompted to:
1. Confirm the package files to be published
2. Authenticate with Google (opens browser)
3. Grant pub.dev access to your Google account
4. Confirm publication

### Step 3: Verify Publication

After successful publication:
1. Visit `https://pub.dev/packages/text_avatars`
2. Verify package information displays correctly
3. Check that example code and README render properly
4. Test installation in a new project

## Post-Publishing

### Tag the Release

Create a git tag for the release:

```bash
git tag -a v0.1.0 -m "Release version 0.1.0"
git push origin v0.1.0
```

### Monitor Package

- **Check pub.dev score**: View at `https://pub.dev/packages/text_avatars/score`
- **Respond to issues**: Monitor GitHub issues
- **Track downloads**: View analytics on pub.dev

## Updating the Package

For future updates:

1. Make your changes
2. Update version in `pubspec.yaml` following [semantic versioning](https://semver.org/):
   - **MAJOR** (1.0.0): Breaking changes
   - **MINOR** (0.1.0): New features, backwards compatible
   - **PATCH** (0.0.1): Bug fixes, backwards compatible
3. Update `CHANGELOG.md` with changes
4. Run tests and validation
5. Publish new version

Example version update:
```yaml
version: 0.1.1  # Bug fix
version: 0.2.0  # New feature
version: 1.0.0  # Breaking change or stable release
```

## Common Issues

### Authentication Issues

If authentication fails:
```bash
# Clear pub credentials
rm ~/.pub-cache/credentials.json
# Try publishing again
dart pub publish
```

### Package Name Taken

If the package name is already taken:
1. Choose a different name
2. Update `name` in `pubspec.yaml`
3. Update import statements in all files
4. Update README and documentation

### Validation Errors

If validation fails:
- Read error messages carefully
- Fix issues in the code
- Run `dart pub publish --dry-run` again
- Repeat until no errors

## Package Scoring

Pub.dev scores packages on:
- **Documentation** (20 points): Comprehensive README, API docs
- **Platforms** (20 points): Multi-platform support
- **Up-to-date dependencies** (10 points): Latest dependency versions
- **Static analysis** (30 points): No analysis warnings
- **Conventions** (20 points): Follows Dart/Flutter conventions

Aim for a score of 130+ for maximum visibility.

## Maintenance

Regular maintenance tasks:
- Update dependencies quarterly
- Respond to issues within 1 week
- Keep documentation current
- Test with latest Flutter/Dart versions
- Address security vulnerabilities promptly

## Resources

- [Publishing packages guide](https://dart.dev/tools/pub/publishing)
- [Package layout conventions](https://dart.dev/tools/pub/package-layout)
- [Writing package pages](https://dart.dev/tools/pub/writing-package-pages)
- [Verified publishers](https://dart.dev/tools/pub/verified-publishers)
- [Pub.dev help](https://pub.dev/help)

## Support

For help with publishing:
- [Dart Discord](https://discord.gg/Qt6DgfAWWx)
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/dart+flutter)
