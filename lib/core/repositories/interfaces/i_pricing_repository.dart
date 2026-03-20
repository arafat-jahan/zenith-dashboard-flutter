import '../../models/pricing_plan.dart';

abstract class IPricingRepository {
  Future<List<PricingPlan>> getPricingPlans();
}
