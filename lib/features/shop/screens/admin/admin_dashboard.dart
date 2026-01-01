import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/controllers/admin_dashboard_controller.dart';
import 'package:kkn_store/features/shop/screens/admin/admin_user_list_screen.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminDashboardController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const KknAppbar(
        showArrowBack: true,
        title: Text('Store Bank'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              Row(
                children: [
                   Expanded(     
                      child: _buildSummaryCard(
                        context, 
                        'Total Income', 
                        controller.totalIncome, 
                        Colors.green, 
                        Iconsax.arrow_up_3
                      )
                   ),
                   const SizedBox(width: TSizes.spaceBtwItems),
                   Expanded(     
                      child: _buildSummaryCard(
                        context, 
                        'Balance', 
                        controller.totalBalance, 
                        Colors.blue, 
                        Iconsax.wallet_3
                      )
                   ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwsections),

              // Actions
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                   onPressed: () => Get.to(() => const AdminUserListScreen()), 
                   child: const Text('View User Orders')
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwsections),
              
              // Transactions History Header
              Text('Recent Transactions', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              // Transactions List
              Obx(() {
                 if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
                 if (controller.transactions.isEmpty) return const Center(child: Text('No transactions yet.'));
                 
                 return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.transactions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                    itemBuilder: (context, index) {
                       final transaction = controller.transactions[index];
                       final isCredit = transaction.type == 'Credit';
                       
                       return Container(
                          padding: const EdgeInsets.all(TSizes.md),
                          decoration: BoxDecoration(
                             color: dark ? TColors.darkContainer : TColors.lightContainer,
                             borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                             border: Border.all(color: isCredit ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                               Icon(isCredit ? Iconsax.arrow_down_1 : Iconsax.arrow_up_1, color: isCredit ? Colors.green : Colors.red),
                               const SizedBox(width: TSizes.spaceBtwItems),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Text(transaction.description, style: Theme.of(context).textTheme.titleMedium),
                                      Text(transaction.date.toString().split(' ')[0], style: Theme.of(context).textTheme.labelMedium),
                                   ],
                                 ),
                               ),
                               Text(
                                 '₹${transaction.amount.toStringAsFixed(2)}',
                                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: isCredit ? Colors.green : Colors.red,
                                 ),
                               ),
                            ],
                          ),
                       );
                    },
                 );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, RxDouble value, Color color, IconData icon) {
     final dark = THelperFunctions.isDarkMode(context);
     return Container(
       padding: const EdgeInsets.all(TSizes.md),
       decoration: BoxDecoration(
          color: dark ? TColors.darkContainer : TColors.lightContainer,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: Border.all(color: color.withOpacity(0.5)),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Icon(icon, color: color, size: 24),
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                   decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                   ),
                   child: Text('+20%', style: TextStyle(color: color, fontSize: 10)), // Placeholder stats
                 ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(title, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Obx(() => Text('₹${value.value.toStringAsFixed(1)}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color))),
         ],
       ),
     );
  }
}
