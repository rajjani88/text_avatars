import 'package:flutter/material.dart';
import 'package:text_avatars/text_avatars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Avatars Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AvatarDemoPage(),
    );
  }
}

class AvatarDemoPage extends StatelessWidget {
  const AvatarDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Text Avatars Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Basic Initials',
              'Avatars with auto-generated initials from names',
              [
                _buildExample(
                  const UserAvatar(userName: 'John Doe'),
                  'John Doe',
                ),
                _buildExample(
                  const UserAvatar(userName: 'Jane Smith'),
                  'Jane Smith',
                ),
                _buildExample(
                  const UserAvatar(userName: 'Alice'),
                  'Alice (single name)',
                ),
                _buildExample(
                  const UserAvatar(userName: 'Bob Wilson'),
                  'Bob Wilson',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection('Custom Text', 'Avatars with custom initials text', [
              _buildExample(const UserAvatar(initialsText: 'AB'), 'Custom: AB'),
              _buildExample(const UserAvatar(initialsText: 'XY'), 'Custom: XY'),
              _buildExample(const UserAvatar(initialsText: '42'), 'Number: 42'),
            ]),
            const SizedBox(height: 32),
            _buildSection(
              'Custom Colors',
              'Avatars with custom background and text colors',
              [
                _buildExample(
                  const UserAvatar(
                    userName: 'Sarah Connor',
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                  ),
                  'Purple Background',
                ),
                _buildExample(
                  const UserAvatar(
                    userName: 'Tony Stark',
                    backgroundColor: Colors.red,
                    textColor: Colors.yellow,
                  ),
                  'Red & Yellow',
                ),
                _buildExample(
                  UserAvatar(
                    userName: 'Bruce Wayne',
                    backgroundColor: Colors.grey.shade900,
                    textColor: Colors.white,
                  ),
                  'Dark Theme',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection('Different Sizes', 'Avatars in various sizes', [
              _buildExample(
                const UserAvatar(userName: 'Small', size: 32),
                'Small (32)',
              ),
              _buildExample(
                const UserAvatar(userName: 'Medium', size: 56),
                'Medium (56)',
              ),
              _buildExample(
                const UserAvatar(userName: 'Large', size: 80),
                'Large (80)',
              ),
              _buildExample(
                const UserAvatar(userName: 'XL', size: 120),
                'Extra Large (120)',
              ),
            ]),
            const SizedBox(height: 32),
            _buildSection(
              'Network Images',
              'Avatars loading from network (with fallback)',
              [
                _buildExample(
                  const UserAvatar(
                    profileUrl: 'https://i.pravatar.cc/150?img=1',
                    userName: 'User One',
                    size: 64,
                  ),
                  'Valid Image URL',
                ),
                _buildExample(
                  const UserAvatar(
                    profileUrl: 'https://invalid-url-example.com/avatar.jpg',
                    userName: 'User Two',
                    size: 64,
                  ),
                  'Invalid URL (fallback)',
                ),
                _buildExample(
                  const UserAvatar(
                    profileUrl: 'https://i.pravatar.cc/150?img=3',
                    userName: 'User Three',
                    size: 64,
                  ),
                  'Valid Image URL',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Custom Text Styles',
              'Avatars with custom text styling',
              [
                _buildExample(
                  const UserAvatar(
                    userName: 'Bold Text',
                    textStyle: TextStyle(fontWeight: FontWeight.w900),
                    size: 64,
                  ),
                  'Bold Font',
                ),
                _buildExample(
                  const UserAvatar(
                    userName: 'Custom Size',
                    textStyle: TextStyle(fontSize: 32),
                    size: 80,
                  ),
                  'Large Text',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection('In a List', 'Avatars used in a typical user list', [
              _buildListExample('John Doe', 'john@example.com'),
              _buildListExample('Jane Smith', 'jane@example.com'),
              _buildListExample('Alice Johnson', 'alice@example.com'),
              _buildListExample('Bob Wilson', 'bob@example.com'),
              _buildListExample('Charlie Brown', 'charlie@example.com'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String description,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        Wrap(spacing: 24, runSpacing: 24, children: children),
      ],
    );
  }

  Widget _buildExample(Widget avatar, String label) {
    return Column(
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildListExample(String name, String email) {
    return Card(
      child: ListTile(
        leading: UserAvatar(userName: name, size: 40),
        title: Text(name),
        subtitle: Text(email),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
