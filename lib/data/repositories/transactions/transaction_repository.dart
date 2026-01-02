import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kkn_store/features/shop/models/transaction_model.dart';

class TransactionRepository extends GetxController {
  static TransactionRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  // Fetch All Transactions
  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      final response = await _db.from('store_transactions').select().order('transaction_date', ascending: false);
      
      return (response as List<dynamic>).map((e) => TransactionModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Error fetching transactions: $e';
    }
  }

  // Calculate Totals (Could be done via RPC for perf, but Dart is fine for now)
  Future<Map<String, double>> fetchFinancialStats() async {
    try {
      final transactions = await fetchTransactions();
      
      double totalIncome = 0.0;
      double totalExpense = 0.0;
      
      for (var t in transactions) {
        if (t.type == 'Credit') {
          totalIncome += t.amount;
        } else {
          totalExpense += t.amount;
        }
      }
      
      return {
        'income': totalIncome,
        'expense': totalExpense,
        'balance': totalIncome - totalExpense,
      };
    } catch (e) {
      throw 'Error calculating stats: $e';
    }
  }
}
