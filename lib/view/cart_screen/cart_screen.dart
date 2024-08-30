import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/view/cart_screen/widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) => CartItemWidget(
                      title: "title",
                      desc: "desc",
                      qty: "1",
                      onIncrement: () {},
                      onDecrement: () {},
                      onRemove: () {},
                    ),
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemCount: 5)),
      ),
    );
  }
}
