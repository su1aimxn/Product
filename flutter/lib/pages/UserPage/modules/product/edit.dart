import 'package:flutter/material.dart';
import 'package:flutter1/controllers/product_controller.dart';
import 'package:flutter1/models/product_model.dart';
import 'package:flutter1/pages/UserPage/view/UserPage.dart';
import 'package:flutter1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({required this.product, super.key});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.productName);
    _typeController = TextEditingController(text: widget.product.productType);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _unitController = TextEditingController(text: widget.product.unit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
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
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                labelStyle: TextStyle(color: Colors.orange), // Orange label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange), // Orange underline when focused
                ),
              ),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Product Type',
                labelStyle: TextStyle(color: Colors.orange), // Orange label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange), // Orange underline when focused
                ),
              ),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.orange), // Orange label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange), // Orange underline when focused
                ),
              ),
            ),
            TextField(
              controller: _unitController,
              decoration: const InputDecoration(
                labelText: 'Unit',
                labelStyle: TextStyle(color: Colors.orange), // Orange label text
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange), // Orange underline when focused
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      _editProduct(context);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Orange button
                minimumSize: const Size(120, 50), // Button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white), // White text on the button
                    ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Set background color to white
    );
  }

  void _editProduct(BuildContext context) {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product name cannot be empty.')),
      );
      return;
    }

    final updatedProduct = ProductModel(
      id: widget.product.id,
      productName: _nameController.text,
      productType: _typeController.text,
      price: (double.tryParse(_priceController.text) ?? widget.product.price)
          .toInt(), // Convert to int
      unit: _unitController.text,
    );

    final token = Provider.of<UserProvider>(context, listen: false).accessToken;

    setState(() {
      _isLoading = true; // Start loading
    });

    ProductController().updateProduct(token, updatedProduct).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserPage()),
        (route) => false, // Removes all previous routes
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false; // End loading
      });
    });
  }
}
