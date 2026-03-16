import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/turtle_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // ==================== AUTH ====================
  
  static Future<bool> signUp(String email, String password) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static bool get isLoggedIn => _client.auth.currentUser != null;

  // ==================== CRUD ====================

  static Future<List<TurtleModel>> getTurtles() async {
    final response = await _client
        .from('turtles')
        .select()
        .order('created_at', ascending: false);
    
    return (response as List)
        .map((json) => TurtleModel.fromJson(json))
        .toList();
  }

  static Future<bool> insertTurtle(TurtleModel turtle) async {
    try {
      await _client.from('turtles').insert(turtle.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateTurtle(String id, TurtleModel turtle) async {
    try {
      await _client.from('turtles').update(turtle.toJson()).eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteTurtle(String id) async {
    try {
      await _client.from('turtles').delete().eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }
}