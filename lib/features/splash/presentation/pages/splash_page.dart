import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/config/app_config.dart';
import '../../../auth/data/repositories/auth_repository.dart';

/// Splash screen with beautiful animations
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      final authRepository = ref.read(authRepositoryProvider.notifier);
      if (authRepository.isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mobile_friendly,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
                  .animate()
                  .scale(
                    duration: AppConfig.mediumAnimation,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: AppConfig.shortAnimation),
              
              const SizedBox(height: 32),
              
              // App Name
              Text(
                AppConfig.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate(delay: 300.ms)
                  .slideY(begin: 0.3, end: 0)
                  .fadeIn(),
              
              const SizedBox(height: 8),
              
              // App Tagline
              Text(
                'Beautiful Mobile Experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              )
                  .animate(delay: 600.ms)
                  .slideY(begin: 0.3, end: 0)
                  .fadeIn(),
              
              const SizedBox(height: 60),
              
              // Loading Indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
                strokeWidth: 3,
              )
                  .animate(delay: 900.ms)
                  .fadeIn()
                  .scale(),
            ],
          ),
        ),
      ),
    );
  }
}
