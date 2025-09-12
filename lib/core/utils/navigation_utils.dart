import 'package:go_router/go_router.dart';

class NavigationUtils {
  static final GoRouter router = GoRouter.of(context);

  // 📊 Navigation to main pages
  static void goToDashboard() => router.go('/dashboard');
  static void goToEstimations() => router.go('/estimations');
  static void goToMaterials() => router.go('/materials');
  static void goToProjects() => router.go('/projects');
  static void goToAnalysis() => router.go('/analysis');
  static void goToSettings() => router.go('/settings');

  // 📋 Estimation navigation
  static void goToCreateEstimation() => router.go('/estimations/create');
  static void goToEstimationDetail(String id) => router.go('/estimations/$id');
  
  // 🔍 Materials with filters
  static void goToMaterialsWithSearch(String query) => 
      router.go('/materials?q=$query');
  
  static void goToMaterialsByCategory(String category) => 
      router.go('/materials?category=$category');

  // 📊 Analysis with project filter
  static void goToAnalysisWithProject(String projectId) => 
      router.go('/analysis?projectId=$projectId');

  // ⚙️ Settings sub-pages
  static void goToProfileSettings() => router.go('/settings/profile');
  static void goToNotificationSettings() => router.go('/settings/notifications');

  // 🔄 Back navigation
  static void goBack() => router.pop();
  
  // ❌ Clear all routes and go to root
  static void goToRoot() => router.go('/dashboard');

  // 📍 Get current route
  static String get currentRoute => router.routeInformationProvider.value.uri.toString();
}
