import '../../models/pricing_plan.dart';
import '../../theme/app_colors.dart';
import '../interfaces/i_pricing_repository.dart';

class StaticPricingRepository implements IPricingRepository {
  @override
  Future<List<PricingPlan>> getPricingPlans() async {
    // Simulate network delay for Apple-grade smooth loading
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      const PricingPlan(
        id: 'starter',
        name: 'Starter',
        tagline: 'Perfect for side projects',
        monthlyPrice: 0,
        annualPrice: 0,
        cta: 'Get Started',
        features: ['1,000 API calls/mo', 'Standard support', 'Community access', 'Basic analytics'],
        limits: [],
        gradientColors: [AppColors.accentBlue, AppColors.accentViolet],
        glowColor: AppColors.glowBlue,
      ),
      const PricingPlan(
        id: 'pro',
        name: 'Pro',
        tagline: 'For scaling applications',
        monthlyPrice: 49,
        annualPrice: 39,
        cta: 'Start Pro Trial',
        features: ['100,000 API calls/mo', 'Priority 24/7 support', 'Custom models', 'Advanced analytics', 'Team collaboration'],
        limits: [],
        gradientColors: [AppColors.accentViolet, AppColors.accentRose],
        glowColor: AppColors.glowViolet,
        isPopular: true,
      ),
      const PricingPlan(
        id: 'enterprise',
        name: 'Enterprise',
        tagline: 'Custom solutions for teams',
        monthlyPrice: 199,
        annualPrice: 159,
        cta: 'Contact Sales',
        features: ['Unlimited API calls', 'Dedicated account manager', 'SLA guarantee', 'Custom integrations', 'On-premise deployment'],
        limits: [],
        gradientColors: [AppColors.accentGreen, AppColors.accentBlue],
        glowColor: AppColors.glowGreen,
      ),
    ];
  }
}
