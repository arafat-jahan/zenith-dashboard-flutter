// lib/core/providers/app_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Navigation
final selectedNavIndexProvider = StateProvider<int>((ref) => 0);

// ── Pricing UI
final selectedBillingCycleProvider = StateProvider<String>((ref) => 'annual');
final selectedPlanProvider = StateProvider<String>((ref) => 'pro');

// ──────────────────────────────────────────────
// DASHBOARD
// ──────────────────────────────────────────────
class DashboardStats {
  final double totalRevenue;
  final int activeUsers;
  final int apiCalls;
  final double successRate;
  final bool isLoading;

  const DashboardStats({
    this.totalRevenue = 0,
    this.activeUsers = 0,
    this.apiCalls = 0,
    this.successRate = 0,
    this.isLoading = true,
  });

  DashboardStats copyWith({
    double? totalRevenue,
    int? activeUsers,
    int? apiCalls,
    double? successRate,
    bool? isLoading,
  }) =>
      DashboardStats(
        totalRevenue: totalRevenue ?? this.totalRevenue,
        activeUsers: activeUsers ?? this.activeUsers,
        apiCalls: apiCalls ?? this.apiCalls,
        successRate: successRate ?? this.successRate,
        isLoading: isLoading ?? this.isLoading,
      );
}

class DashboardNotifier extends StateNotifier<DashboardStats> {
  DashboardNotifier() : super(const DashboardStats()) {
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(
      totalRevenue: 128450.50,
      activeUsers: 24891,
      apiCalls: 3847200,
      successRate: 99.7,
      isLoading: false,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await _loadData();
  }
}

final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardStats>(
      (ref) => DashboardNotifier(),
);

// ──────────────────────────────────────────────
// CHAT
// ──────────────────────────────────────────────
class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final String selectedModel;

  const ChatState({
    this.messages = const [],
    this.isTyping = false,
    this.selectedModel = 'zenith-ultra',
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    String? selectedModel,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        isTyping: isTyping ?? this.isTyping,
        selectedModel: selectedModel ?? this.selectedModel,
      );
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());

  int _responseIndex = 0;

  static const List<String> _mockResponses = [
    "I've analyzed your request. The dataset shows a 23% improvement in model accuracy after fine-tuning with domain-specific data. Latency dropped from 340ms to 187ms.",
    "Based on current metrics, I recommend scaling the inference cluster to handle peak loads. Projected cost increase is minimal compared to performance gains.",
    "API response rate is 99.7% as of today. Minor anomalies detected in West-2 region — nothing critical but worth monitoring over the next 24 hours.",
    "Your subscription includes unlimited API calls on the Ultra plan. You've used 3.8M tokens this month, well within the 10B token limit.",
    "I can generate, analyze, summarize, code, and reason across complex domains. What would you like to explore next?",
  ];

  Future<void> sendMessage(String content) async {
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
    );

    await Future.delayed(const Duration(milliseconds: 1400));

    final aiMsg = ChatMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_ai',
      content: _mockResponses[_responseIndex % _mockResponses.length],
      isUser: false,
      timestamp: DateTime.now(),
    );
    _responseIndex++;

    state = state.copyWith(
      messages: [...state.messages, aiMsg],
      isTyping: false,
    );
  }

  void changeModel(String model) => state = state.copyWith(selectedModel: model);
  void clearChat() => state = state.copyWith(messages: [], isTyping: false);
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>(
      (ref) => ChatNotifier(),
);