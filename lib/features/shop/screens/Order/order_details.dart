import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/controllers/order_details_controller.dart';
import 'package:kkn_store/features/shop/models/order_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    controller.fetchOrderItems(order.id);
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: KknAppbar(
        title: Text('Order Details', style: Theme.of(context).textTheme.headlineSmall),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info Card
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.darkContainer : TColors.lightContainer,
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  children: [
                    _buildInfoRow('Order ID', '#${order.id.substring(0, 8)}...', context),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    _buildInfoRow('Date', DateFormat('dd MMM yyyy').format(order.orderDate), context),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    _buildInfoRow('Status', order.status, context, valueColor: _getStatusColor(order.status)),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    _buildInfoRow('Total', '₹${order.totalAmount}', context, isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwsections),

              // Products Header
              Text('Products', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Product List
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (controller.orderItems.isEmpty) {
                   return const Text('No items found for this order.');
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.orderItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    final item = controller.orderItems[index];
                    final itemTotal = item.price * item.quantity;
                    
                    return TRoundedContainer(
                      showBorder: true,
                      backgroundColor: dark ? TColors.darkContainer : TColors.white,
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Row(
                        children: [
                          /// Image
                          if (item.image != null)
                            Image.network(
                               item.image!,
                               width: 60, height: 60, fit: BoxFit.cover,
                               errorBuilder: (_,__,___) => const Icon(Icons.image_not_supported),
                            )
                          else
                            Container(width: 60, height: 60, color: Colors.grey[300]),
                          
                          const SizedBox(width: TSizes.spaceBtwItems),
                          
                          /// Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: Theme.of(context).textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 4),
                                Text('Qty: ${item.quantity}  x  ₹${item.price.toStringAsFixed(1)}', style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          
                          /// Total Price for Item
                          Text('₹${itemTotal.toStringAsFixed(1)}', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    );
                  },
                );
              }),
              
              const SizedBox(height: TSizes.spaceBtwsections),
              
              // Address Info (Optional, if we had it structure in OrderModel, currently simple map)
              Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: TSizes.spaceBtwItems),
              if (order.shippingAddress != null)
                 TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(order.shippingAddress!['name'] ?? '', style: Theme.of(context).textTheme.titleMedium),
                         const SizedBox(height: 4),
                         Text('${order.shippingAddress!['street']}, ${order.shippingAddress!['city']}', style: Theme.of(context).textTheme.bodyMedium),
                         Text('${order.shippingAddress!['state']}, ${order.shippingAddress!['postalCode']}', style: Theme.of(context).textTheme.bodyMedium),
                         const SizedBox(height: 4),
                         Text(order.shippingAddress!['phoneNumber'] ?? '', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                 )
              else
                 const Text('No shipping address info.'),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context, {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: valueColor, 
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal
        )),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processed': return Colors.blue;
      case 'shipped': return Colors.purple;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.orange;
    }
  }
}
