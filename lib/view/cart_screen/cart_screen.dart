import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/controller/cart_screen_controller.dart';
import 'package:folder_structure_sample_april/view/cart_screen/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CartScreenController>().getAllCartItems();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CartScreenController>(
              builder: (context, cartProvider, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final cartItem =
                          cartProvider.getCurrentItem(cartProvider.keys[index]);
                      return CartItemWidget(
                        title: cartItem?.title.toString() ?? "",
                        desc: cartItem?.des.toString() ?? "",
                        qty: cartItem?.qty.toString() ?? "",
                        image: cartItem?.image.toString() ?? "",
                        onIncrement: () {
                          context
                              .read<CartScreenController>()
                              .incrementQty(cartProvider.keys[index]);
                        },
                        onDecrement: () {
                          context
                              .read<CartScreenController>()
                              .decQty(cartProvider.keys[index]);
                        },
                        onRemove: () {
                          context
                              .read<CartScreenController>()
                              .removeItem(cartProvider.keys[index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: cartProvider.keys.length);
              },
            )),
      ),
    );
  }
}
