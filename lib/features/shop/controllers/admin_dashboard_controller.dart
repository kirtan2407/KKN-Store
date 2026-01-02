import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/transactions/transaction_repository.dart';
import 'package:kkn_store/features/shop/models/transaction_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class AdminDashboardController extends GetxController {
  final transactionRepo = Get.put(TransactionRepository());

  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalBalance = 0.0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      
      // Fetch Stats
      final stats = await transactionRepo.fetchFinancialStats();
      totalIncome.value = stats['income'] ?? 0.0;
      totalBalance.value = stats['balance'] ?? 0.0;

      // Fetch List
      final list = await transactionRepo.fetchTransactions();
      transactions.assignAll(list);
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
