import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://rpmsobnanioupvighzxv.supabase.co',      
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwbXNvYm5hbmlvdXB2aWdoenh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM1OTczMjQsImV4cCI6MjA4OTE3MzMyNH0.iNcikXVcjM0wNo1pXjXE-vNmyOB4bnQKnu4ZMmnHCYo',                     
  );
  
  runApp(const TurtleConservationApp());
}