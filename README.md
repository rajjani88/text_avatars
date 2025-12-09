# text_avatars

A customizable Flutter package for creating beautiful circular user avatars with automatic initials generation, smart fallback handling, and consistent color generation.
<table>
<tr>
<td>
  <img src="https://github.com/rajjani88/text_avatars/blob/main/example/screenshots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202025-12-05%20at%2015.38.17.png?raw=true" width="128"/>
</td>
<td>
  <img src="https://github.com/rajjani88/text_avatars/blob/main/example/screenshots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202025-12-05%20at%2015.38.17.png?raw=true" width="128"/>
</td>
  <td>
    <img src="https://github.com/rajjani88/text_avatars/blob/main/example/screenshots/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202025-12-05%20at%2015.38.23.png?raw=true" width="128"/>
  </td>
</tr>  
</table>

## Features

✨ **Smart Display Modes:**
- Display profile images from network URLs
- Automatically generate initials from user names
- Show custom text directly
- Seamless fallback to initials when images fail to load

🎨 **Customizable Styling:**
- Adjustable avatar size
- Custom background colors
- Custom text colors with automatic contrast
- Configurable text styles
- Consistent color generation based on initials

⚡ **Smart Features:**
- Loading indicators for network images
- Automatic error handling
- Consistent colors for same initials across app
- Responsive text sizing
- Material Design color palette

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  text_avatars: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:text_avatars/text_avatars.dart';

// Display initials from name
UserAvatar(
  userName: 'John Doe',
  size: 56.0,
)

// Display profile image with fallback
UserAvatar(
  profileUrl: 'https://example.com/avatar.jpg',
  userName: 'Jane Smith',
  size: 64.0,
)

// Display custom text
UserAvatar(
  initialsText: 'AB',
  size: 48.0,
)
```

### Advanced Customization

```dart
// Custom colors
UserAvatar(
  userName: 'Sarah Connor',
  backgroundColor: Colors.purple.shade700,
  textColor: Colors.white,
  size: 72.0,
)

// Custom text style
UserAvatar(
  userName: 'Tony Stark',
  textStyle: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  ),
  size: 80.0,
)

// Network image with custom fallback
UserAvatar(
  profileUrl: 'https://api.example.com/user/123/avatar',
  userName: 'Bruce Wayne',
  backgroundColor: Colors.black87,
  textColor: Colors.yellow,
  size: 100.0,
)
```

### In a List

```dart
ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) {
    final user = users[index];
    return ListTile(
      leading: UserAvatar(
        profileUrl: user.avatarUrl,
        userName: user.name,
        size: 40.0,
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  },
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `profileUrl` | `String?` | `null` | Network URL of the profile image |
| `userName` | `String?` | `null` | Full name used to generate initials |
| `initialsText` | `String?` | `null` | Direct text to display (overrides userName) |
| `size` | `double` | `56.0` | Diameter of the avatar circle |
| `backgroundColor` | `Color?` | `null` | Background color (auto-generated if null) |
| `textColor` | `Color?` | `null` | Text color (auto-contrasted if null) |
| `textStyle` | `TextStyle?` | `null` | Custom text style for initials |

## How It Works

### Initials Generation

- **Single name**: Uses first letter (e.g., "John" → "J")
- **Multiple names**: Uses first letter of first and last name (e.g., "John Doe" → "JD")
- **Empty/null**: Shows "?" as fallback

### Color Generation

When `backgroundColor` is not provided, the widget generates a consistent color based on the initials using a hash function. This ensures:
- Same initials always get the same color
- Visually distinct colors for different users
- Material Design color palette

### Image Loading

1. Attempts to load image from `profileUrl`
2. Shows loading indicator during load
3. Automatically falls back to initials if:
   - URL is empty/null
   - Network error occurs
   - Image fails to load

## Example

Check out the [example](example) directory for a complete sample app demonstrating all features.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Issues and Feedback

Please file issues, bugs, or feature requests in our [issue tracker](https://github.com/rajjani88/text_avatars/issues).

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

