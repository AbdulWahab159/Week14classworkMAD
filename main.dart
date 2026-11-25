import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const SignInPage(),
      );
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    if (email.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LayoutPage(
          userName: 'Abdul Wahab',
          userEmail: email.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.indigo.shade50,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.account_circle,
                      size: 85, color: Colors.indigo),
                  const Text('Sign In',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: const Text('LOGIN'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void register() {
    if (name.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful! Please sign in.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.indigo.shade50,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.person_add,
                      size: 80, color: Colors.indigo),
                  const Text('Create Account',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: register,
                      child: const Text('REGISTER'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Sign In'),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
}

class LayoutPage extends StatefulWidget {
  final String userName;
  final String userEmail;
  const LayoutPage({
    super.key,
    this.userName = 'Abdul Wahab',
    this.userEmail = 'student@gmail.com',
  });

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int selectedIndex = 0;

  void logout() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignInPage()),
        (_) => false,
      );

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homePage(),
      const FavoritesPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(['Home Dashboard', 'Favorites', 'Settings'][selectedIndex]),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            ),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.userName),
            accountEmail: Text(widget.userEmail),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
            decoration: const BoxDecoration(color: Colors.indigo),
          ),
          _drawerItem(Icons.home, 'Home', () => _select(0)),
          _drawerItem(Icons.person, 'Profile', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(
                  userName: widget.userName,
                  userEmail: widget.userEmail,
                ),
              ),
            );
          }),
          _drawerItem(Icons.favorite, 'Favorites', () => _select(1)),
          _drawerItem(Icons.settings, 'Settings', () => _select(2)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.pop(context);
              logout();
            },
          ),
        ]),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: (i) => setState(() => selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  void _select(int index) {
    Navigator.pop(context);
    setState(() => selectedIndex = index);
  }

  ListTile _drawerItem(IconData icon, String title, VoidCallback action) =>
      ListTile(leading: Icon(icon), title: Text(title), onTap: action);

  Widget _homePage() => ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Welcome back, ${widget.userName}!\nExplore your dashboard and quick actions below.',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: _action(Icons.person, 'Profile', Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(
                      userName: widget.userName,
                      userEmail: widget.userEmail,
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: _action(Icons.shopping_bag, 'Products', Colors.orange,
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProductsPage()))),
            ),
            Expanded(
              child: _action(Icons.favorite, 'Favorites', Colors.pink,
                  () => setState(() => selectedIndex = 1)),
            ),
          ]),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: const Text('My Profile'),
              subtitle: const Text('View profile details'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.message, color: Colors.indigo),
              title: const Text('Messages'),
              subtitle: const Text('Check messages'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MessagesPage())),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.indigo),
              title: const Text('Settings'),
              subtitle: const Text('Manage settings'),
              onTap: () => setState(() => selectedIndex = 2),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProductsPage())),
            icon: const Icon(Icons.explore),
            label: const Text('Explore More Products'),
          ),
        ],
      );

  Widget _action(
          IconData icon, String title, Color color, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(title),
            ]),
          ),
        ),
      );
}

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;
  const ProfilePage(
      {super.key, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(userName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(userEmail),
            const SizedBox(height: 30),
            Card(
              child: Column(children: const [
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                  subtitle: Text('+1 234 567 8900'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  subtitle: Text('New York, USA'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Member Since'),
                  subtitle: Text('January 2025'),
                ),
              ]),
            ),
            ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              ),
              child: const Text('Edit Profile'),
            ),
          ]),
        ),
      );
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Flutter Dev Course', 'price': '\$49.99', 'icon': Icons.code},
      {'name': 'Dart Masterclass', 'price': '\$39.99', 'icon': Icons.laptop},
      {
        'name': 'UI/UX Design Kit',
        'price': '\$29.99',
        'icon': Icons.design_services
      },
      {
        'name': 'Cloud Backend Setup',
        'price': '\$59.99',
        'icon': Icons.cloud
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products & Courses'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Icon(product['icon'] as IconData, color: Colors.indigo),
              ),
              title: Text(product['name'] as String),
              subtitle: Text('Price: ${product['price']}'),
              trailing: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Purchased ${product['name']}!')),
                ),
                child: const Text('Buy'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const favorites = ['Flutter Dev Course', 'UI/UX Design Kit'];
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text('Your Favorite Items',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ...favorites.map((item) => Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.pink),
                title: Text(item),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Removed $item from favorites')),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: const [
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('A')),
                title: Text('Admin'),
                subtitle: Text(
                    'Welcome to the Flutter App! Let us know if you need help.'),
                trailing: Text('10:42 AM'),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('S')),
                title: Text('Support Team'),
                subtitle: Text('Your ticket #1024 has been resolved.'),
                trailing: Text('Yesterday'),
              ),
            ),
          ],
        ),
      );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text('App Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Card(
            child: Column(children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Receive alerts and updates'),
                value: true,
                onChanged: (value) {},
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Use dark theme'),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.indigo),
                title: const Text('About App'),
                subtitle: const Text('Version 1.0.0'),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: 'Flutter App',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2025 Abdul Wahab',
                ),
              ),
            ]),
          ),
        ],
      );
}
