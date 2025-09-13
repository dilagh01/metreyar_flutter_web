import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/welcome/pages/welcome_page.dart';
import '../features/estimation/pages/estimation_page.dart';
import '../features/materials/pages/materials_page.dart';
import '../features/projects/pages/projects_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/estimation',
      name: 'estimation',
      builder: (context, state) => const EstimationPage(),
    ),
    GoRoute(
      path: '/materials',
      name: 'materials',
      builder: (context, state) => const MaterialsPage(),
    ),
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => const ProjectsPage(),
    ),
  ],
);
