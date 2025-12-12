import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/onboarding_screen.dart';
import 'screens/today_screen.dart';
import 'screens/focus_session_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/ai_coach_screen.dart';

const String supabaseUrl = 'https://ulvycnyfxkwhwcpmllge.supabase.co';
const String supabaseAnonKey = 'YOUR_ANON_KEY_HERE'; // Get from Supabase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
  runApp(const FocusHabitCoachApp());
}

class FocusHabitCoachApp extends StatelessWidget {
  const FocusHabitCoachApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus & Habit Coach',
      theme: ThemeData(
        primaryColor: const Color(0xFF4F46E5),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        final session = snapshot.data?.session;
        if (session != null) return const HomeScreen();
        return const OnboardingScreen();
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = const [
    TodayScreen(),
    FocusSessionScreen(),
    ProgressScreen(),
    AiCoachScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    if (isMobile) {
      return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Focus'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Coach'),
          ],
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      );
    }
    
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Today')),
              NavigationRailDestination(icon: Icon(Icons.timer), label: Text('Focus')),
              NavigationRailDestination(icon: Icon(Icons.trending_up), label: Text('Progress')),
              NavigationRailDestination(icon: Icon(Icons.auto_awesome), label: Text('Coach')),
            ],
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
