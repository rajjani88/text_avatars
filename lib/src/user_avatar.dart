import 'package:flutter/material.dart';

/// A customizable circular avatar widget that displays either a profile image
/// or user initials with automatic color generation.
///
/// This widget intelligently handles three display modes:
/// 1. Network image from [profileUrl]
/// 2. Initials generated from [userName]
/// 3. Direct text display from [initialsText]
///
/// Features:
/// - Automatic fallback to initials if image fails to load
/// - Consistent color generation based on initials
/// - Loading indicator for network images
/// - Customizable size, colors, and text styles
/// - Adaptive text color based on background brightness
///
/// Example:
/// ```dart
/// // Display profile image with fallback to initials
/// UserAvatar(
///   profileUrl: 'https://example.com/avatar.jpg',
///   userName: 'John Doe',
///   size: 64.0,
/// )
///
/// // Display initials with custom colors
/// UserAvatar(
///   userName: 'Jane Smith',
///   backgroundColor: Colors.purple,
///   textColor: Colors.white,
///   size: 48.0,
/// )
///
/// // Display custom text
/// UserAvatar(
///   initialsText: 'AB',
///   size: 56.0,
/// )
/// ```
class UserAvatar extends StatefulWidget {
  /// The network URL of the user's profile image. Optional.
  ///
  /// If the image fails to load, the widget will automatically fall back
  /// to displaying initials.
  final String? profileUrl;

  /// The full name of the user (e.g., "John Wick"). Used to generate initials. Optional.
  ///
  /// Initials are generated as follows:
  /// - Single name: First letter (e.g., "John" → "J")
  /// - Multiple names: First letter of first and last name (e.g., "John Wick" → "JW")
  final String? userName;

  /// Optional text to display directly, overriding the userName/profileUrl logic.
  ///
  /// When provided, this text is displayed as-is (converted to uppercase).
  final String? initialsText;

  /// The diameter of the avatar circle.
  ///
  /// Defaults to 56.0.
  final double size;

  /// The background color of the avatar when initials are displayed.
  ///
  /// If null, a random color will be generated based on the initials.
  /// The same initials will always produce the same color for consistency.
  final Color? backgroundColor;

  /// The color of the initials text.
  ///
  /// If null, the color will be automatically determined based on the
  /// background color's brightness to ensure good contrast.
  final Color? textColor;

  /// Custom text style for the initials.
  ///
  /// The color property of this style is overridden by [textColor].
  /// The default font size is calculated as `size / 2.5`.
  final TextStyle? textStyle;

  const UserAvatar({
    super.key,
    this.profileUrl,
    this.userName,
    this.initialsText,
    this.size = 56.0,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  // Flag to track if the network image has failed to load.
  bool _imageLoadFailed = false;

  // The initials (or direct text) to display as fallback.
  String _initials = '';

  @override
  void initState() {
    super.initState();
    _setInitials();
    // Reset image load state on initialization
    _imageLoadFailed = false;
  }

  @override
  void didUpdateWidget(covariant UserAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Recalculate initials if name or direct text changes
    if (oldWidget.userName != widget.userName ||
        oldWidget.initialsText != widget.initialsText) {
      _setInitials();
    }
    // Reset error state if the profile URL changes
    if (oldWidget.profileUrl != widget.profileUrl) {
      _imageLoadFailed = false;
    }
  }

  /// Calculates the initials from the user name or uses the provided initialsText.
  void _setInitials() {
    // 1. If initialsText is provided, use it directly.
    if (widget.initialsText != null && widget.initialsText!.isNotEmpty) {
      _initials = widget.initialsText!.toUpperCase();
      return;
    }

    // 2. Otherwise, generate from userName.
    if (widget.userName != null && widget.userName!.isNotEmpty) {
      // Split the name, filter out empty strings, and convert to a list
      final nameParts = widget.userName!
          .trim()
          .split(RegExp(r'\s+'))
          .where((s) => s.isNotEmpty)
          .toList();

      if (nameParts.isEmpty) {
        _initials = '';
      } else if (nameParts.length == 1) {
        // Single word name: use the first letter
        _initials = nameParts.first[0].toUpperCase();
      } else {
        // Multiple words: use the first letter of the first and last word
        final firstInitial = nameParts.first[0];
        final lastInitial = nameParts.last[0];
        _initials = '${firstInitial.toUpperCase()}${lastInitial.toUpperCase()}';
      }
    } else {
      _initials = '?'; // Default fallback if no name or text is provided
    }
  }

  /// Generates a consistent random color based on the initials.
  ///
  /// This ensures that the same initials always get the same color
  /// across different instances of the widget (e.g., in a list).
  Color _getBackgroundColorForInitials() {
    // Use a list of predefined "material-like" background colors
    final List<Color> avatarColors = [
      Colors.blue.shade500,
      Colors.red.shade500,
      Colors.green.shade500,
      Colors.purple.shade500,
      Colors.orange.shade500,
      Colors.teal.shade500,
      Colors.indigo.shade500,
      Colors.pink.shade500,
    ];

    // If no initials, default to a light grey.
    if (_initials.isEmpty) {
      return Colors.grey.shade300;
    }

    // Generate a hash from the initials to pick a consistent color.
    final int hash = _initials.hashCode;
    final int index = hash.abs() % avatarColors.length;
    return avatarColors[index];
  }

  /// Builds the content (Image or Text) inside the circular avatar using the determined text color.
  Widget _buildAvatarContent(Color textColorOverride) {
    final bool useInitials =
        widget.initialsText != null ||
        widget.profileUrl == null ||
        widget.profileUrl!.isEmpty ||
        _imageLoadFailed;

    if (useInitials) {
      // Build the initials text
      final defaultStyle = TextStyle(fontSize: widget.size / 2.5);
      final textStyle = (widget.textStyle ?? defaultStyle).copyWith(
        color: textColorOverride,
        fontWeight: FontWeight.w600,
      );

      return Text(_initials, style: textStyle);
    }

    // Attempt to load the network image
    return ClipOval(
      child: Image.network(
        widget.profileUrl!,
        fit: BoxFit.cover,
        width: widget.size,
        height: widget.size,

        // --- Image Loading and Error Handling ---
        errorBuilder: (context, error, stackTrace) {
          // Schedule the state change for the next frame to prevent error.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_imageLoadFailed) {
              setState(() {
                _imageLoadFailed = true; // Forces a rebuild to use initials
              });
            }
          });
          // Return an empty container immediately while we wait for rebuild
          return const SizedBox.shrink();
        },

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            // Image loaded successfully
            return child;
          }
          // Show a progress indicator while loading
          return Center(
            child: SizedBox(
              width: widget.size * 0.35,
              height: widget.size * 0.35,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                // Use the calculated text color for the indicator
                valueColor: AlwaysStoppedAnimation<Color>(
                  textColorOverride.withAlpha(179),
                ),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Determine the background color: user-provided, or random if null
    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? _getBackgroundColorForInitials();

    // 2. Determine the final text color based on background luminance and user input
    final Color finalTextColor = widget.textColor == null
        ? effectiveBackgroundColor.withAlpha(255)
        : widget.textColor ?? Colors.white;

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      // Use CircleAvatar for standard styling and clipping
      child: CircleAvatar(
        backgroundColor: effectiveBackgroundColor.withAlpha(50),
        radius: widget.size / 2,
        // Pass the dynamically calculated text color to the content builder
        child: _buildAvatarContent(finalTextColor),
      ),
    );
  }
}
