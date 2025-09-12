import 'package:go_router/go_router.dart';
import 'package:metreyar_flutter_web/features/auth/pages/login_page.dart';
import 'package:metreyar_flutter_web/features/dashboard/pages/dashboard_page.dart';
import 'package:metreyar_flutter_web/features/estimation/pages/estimation_list_page.dart';
import 'package:metreyar_flutter_web/features/estimation/pages/estimation_detail_page.dart';
import 'package:metreyar_flutter_web/features/estimation/pages/create_estimation_page.dart';
import 'package:metreyar_flutter_web/features/materials/pages/materials_page.dart';
import 'package:metreyar_flutter_web/features/projects/pages/projects_page.dart';
import 'package:metreyar_flutter_web/features/analysis/pages/analysis_page.dart';
import 'package:metreyar_flutter_web/features/settings/pages/settings_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    // 🔐 Authentication
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    // 🏠 Dashboard
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    // 📋 Estimation Routes
    GoRoute(
      path: '/estimations',
      name: 'estimations',
      builder: (context, state) => const EstimationListPage(),
      routes: [
        GoRoute(
          path: 'create',
          name: 'create_estimation',
          builder: (context, state) => const CreateEstimationPage(),
        ),
        GoRoute(
          path: ':id',
          name: 'estimation_detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EstimationDetailPage(estimationId: id);
          },
        ),
      ],
    ),

    // 📦 Materials
    GoRoute(
      path: '/materials',
      name: 'materials',
      builder: (context, state) {
        final query = state.uri.queryParameters['q'];
        final category = state.uri.queryParameters['category'];
        return MaterialsPage(
          searchQuery: query,
          categoryFilter: category,
        );
      },
    ),

    // 🏗️ Projects
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => const ProjectsPage(),
    ),

    // 📊 Analysis
    GoRoute(
      path: '/analysis',
      name: 'analysis',
      builder: (context, state) {
        final projectId = state.uri.queryParameters['projectId'];
        return AnalysisPage(projectId: projectId);
      },
    ),

    // ⚙️ Settings
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'profile',
          name: 'profile_settings',
          builder: (context, state) => const ProfileSettingsPage(),
        ),
        GoRoute(
          path: 'notifications',
          name: 'notification_settings',
          builder: (context, state) => const NotificationSettingsPage(),
        ),
      ],
    ),
  ],

  // 🔄 Error Handling
  errorBuilder: (context, state) => const ErrorPage(),
  redirect: (context, state) {
    // TODO: Add authentication redirect logic
    return null;
  },
);
