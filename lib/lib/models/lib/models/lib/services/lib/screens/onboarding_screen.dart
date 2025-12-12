import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 0;
  final nameController = TextEditingController();
  String selectedLevel = 'School';
  int sessionMinutes = 25;
  List<String> subjects = [];
  final subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Focus Coach')),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: handleStepContinue,
        steps: [
          Step(
            title: const Text('Your Name'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter your name'),
            ),
          ),
          Step(
            title: const Text('Study Level'),
            content: DropdownButton<String>(
              value: selectedLevel,
              items: ['School', 'College', 'Other'].map((level) {
                return DropdownMenuItem(value: level, child: Text(level));
              }).toList(),
              onChanged: (value) => setState(() => selectedLevel = value ?? 'School'),
            ),
          ),
          Step(
            title: const Text('Focus Duration'),
            content: Slider(
              value: sessionMinutes.toDouble(),
              min: 15,
              max: 60,
              onChanged: (value) => setState(() => sessionMinutes = value.toInt()),
            ),
          ),
          Step(
            title: const Text('Your Subjects'),
            content: Column(
              children: [
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(hintText: 'Add subject'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      subjects.add(subjectController.text);
                      subjectController.clear();
                    });
                  },
                  child: const Text('Add Subject'),
                ),
                ...subjects.map((s) => Text(s)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleStepContinue() async {
    if (currentStep < 3) {
      setState(() => currentStep += 1);
    } else {
      // Save user to Supabase
      await Supabase.instance.client.from('users').insert({
        'name': nameController.text,
        'study_level': selectedLevel,
        'preferred_session_minutes': sessionMinutes,
      });
      
      // Navigate to home
      if (mounted) {
        Navigator.of(context).pushReplac
