abstract class IBillingRepository {
  Future<void> requestSubscription(String userId, String planId);
  Future<void> cancelSubscription(String userId);
}
