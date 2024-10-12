import 'package:flutter/material.dart';
import 'package:flutter1/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        backgroundColor: Colors.transparent, // Transparent background for AppBar
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFBD72B), // Start color (yellowish-orange)
                Color(0xFFF9484A), // End color (reddish-orange)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name: ${product.productName}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange, // Orange for product name
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Type: ${product.productType}',
              style: const TextStyle(fontSize: 20, color: Colors.black87), // Slightly muted text color
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: ${product.price} ${product.unit}',
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Unit: ${product.unit}',
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
            // Add more details if necessary
          ],
        ),
      ),
      backgroundColor: Colors.white, // Set the background color to white
    );
  }
}
