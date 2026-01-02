import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/controllers/admin_orders_controller.dart';
import 'package:kkn_store/features/shop/screens/Order/order_details.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class AdminUserOrdersScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  const AdminUserOrdersScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminOrdersController>();
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: KknAppbar(
        showArrowBack: true,
        title: Text('${user['full_name']}\'s Orders'),
      ),
      body: Obx(() {
        if (controller.isLoading.value)
          return const Center(child: CircularProgressIndicator());
        if (controller.selectedUserOrders.isEmpty)
          return const Center(child: Text('No orders found for this user.'));

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// User Profile Header (Admin View)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(TSizes.md),
                  decoration: BoxDecoration(
                    color: TColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    border: Border.all(color: TColors.primaryColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Details',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      _buildDetailRow(
                        'Name:',
                        user['full_name'] ?? 'N/A',
                        context,
                      ),
                      _buildDetailRow(
                        'Email:',
                        user['email'] ?? 'N/A',
                        context,
                      ),
                      _buildDetailRow(
                        'Phone:',
                        user['phone_number'] ?? 'N/A',
                        context,
                      ),
                      // Note: Address is order-specific, but if profile has one, we could show it.
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwsections),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.selectedUserOrders.length,
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(height: TSizes.spaceBtwsections),

                  itemBuilder: (context, index) {
                    final order = controller.selectedUserOrders[index];
                    final dateStr = DateFormat(
                      'dd MMM yyyy',
                    ).format(order.orderDate);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Header
                        Text(
                          'Placed on $dateStr',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),

                        // Order Card
                        GestureDetector(
                          onTap:
                              () => Get.to(
                                () => OrderDetailsScreen(order: order),
                              ),
                          child: Container(
                            padding: const EdgeInsets.all(TSizes.md),
                            decoration: BoxDecoration(
                              color:
                                  dark
                                      ? TColors.darkContainer
                                      : TColors.lightContainer,
                              borderRadius: BorderRadius.circular(
                                TSizes.cardRadiusLg,
                              ),
                              border: Border.all(color: TColors.grey),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order #${order.id.substring(0, 5)}...',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                    Text(
                                      order.status,
                                      style: TextStyle(
                                        color:
                                            order.status == 'Pending'
                                                ? Colors.orange
                                                : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),

                                // Use order items if available (requires fetchOrderItems call ideally)
                                // For now, listing summary or just total
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Amount'),
                                    Text(
                                      '₹${order.totalAmount.toStringAsFixed(2)}',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Payment: ${order.paymentMethod}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
