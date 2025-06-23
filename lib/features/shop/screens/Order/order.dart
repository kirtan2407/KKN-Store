import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/screens/Order/widgets/order_list.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //appbar
      appBar: KknAppbar(title: Text('My Orders'), showArrowBack: true),
      body: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      /// orders
      child:OrderListItems(),
      ),
    );
  }
}
