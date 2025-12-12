import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final _supabase = Supabase.instance.client;
  
  // User Operations
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await _supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  static Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _supabase
        .from('users')
        .update(data)
        .eq('id', userId);
  }

  // Subject Operations
  static Future<List<Map<String, dynamic>>> getSubjects(String userId) async {
    final response = await _supabase
        .from('subjects')
        .select()
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> addSubject(String userId, String name, String color) async {
    await _supabase
        .from('subjects')
        .insert({
          'user_id': userId,
          'name': name,
          'color_hex': color,
        });
  }

  // Daily Plan Operations
  static Future<List<Map<String, dynamic>>> getDailyPlans(String userId, DateTime date) async {
    final response = await _supabase
        .from('daily_plans')
        .select()
        .eq('user_id', userId)
        .eq('date', date.toIso8601String().split('T')[0]);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> saveDailyPlan(String userId, DateTime date, List<Map<String, dynamic>> tasks) async {
    await _supabase
        .from('daily_plans')
        .upsert({
          'user_id': userId,
          'date': date.toIso8601String().split('T')[0],
          'tasks_json': tasks,
          'target_sessions': tasks.fold(0, (sum, task) => sum + (task['sessions'] as int)),
        });
  }

  // Focus Session Operations
  static Future<void> logFocusSession(String userId, String subjectId, int actualMinutes) async {
    await _supabase
        .from('focus_sessions')
        .insert({
          'user_id': userId,
          'subject_id': subjectId,
          'date': DateTime.now().toIso8601String().split('T')[0],
          'actual_minutes': actualMinutes,
          'status': 'completed',
        });

    // Update habit stats
    await updateHabitStats(userId, actualMinutes);
  }

  // Habit Stats Operations
  static Future<void> updateHabitStats(String userId, int minutesAdded) async {
    final stats = await _supabase
        .from('habit_stats')
        .select()
        .eq('user_id', userId)
        .single();

    int newStreak = stats['current_streak'] ?? 0;
    final lastActiveDate = stats['last_active_date'];
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastActiveDate != today) {
      newStreak += 1;
    }

    await _supabase
        .from('habit_stats')
        .update({
          'total_minutes': (stats['total_minutes'] ?? 0) + minutesAdded,
          'current_streak': newStreak,
          'longest_streak': max(newStreak, stats['longest_streak'] ?? 0),
          'last_active_date': today,
        })
        .eq('user_id', userId);
  }

  static Future<Map<String, dynamic>> getHabitStats(String userId) async {
    final response = await _supabase
        .from('habit_stats')
        .select()
        .eq('user_id', userId)
        .single();
    return response;
  }
}
