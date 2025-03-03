import 'package:flutter/material.dart';
import 'package:tst/data/controller/product_controller.dart';
import '../widgets/product_list_tile.dart';

class Crudapi extends StatefulWidget {
  const Crudapi({super.key});

  @override
  State<Crudapi> createState() => _CrudapiState();
}

class _CrudapiState extends State<Crudapi> {
  final ProductController productController = ProductController();

  void productDialog({
    String? id,
    String? name,
    int? qty,
    String? img,
    int? unitPrice,
    int? totalPrice,
  }) {
    final productNameController = TextEditingController(text: name ?? '');
    final productQtyController = TextEditingController(
      text: qty?.toString() ?? '0',
    );
    final productImageController = TextEditingController(text: img ?? '');
    final productUnitPriceController = TextEditingController(
      text: unitPrice?.toString() ?? '0',
    );
    final productTotalPriceController = TextEditingController(
      text: totalPrice?.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(id == null ? 'Add Product' : 'Update Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(productNameController, 'Product Name'),
                _buildTextField(productImageController, 'Product Image'),
                _buildTextField(productQtyController, 'Product Qty'),
                _buildTextField(
                  productUnitPriceController,
                  'Product Unit Price',
                ),
                _buildTextField(productTotalPriceController, 'Total Price'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          if (id == null) {
                            await productController.createProduct(
                              productNameController.text,
                              productImageController.text,
                              int.parse(productQtyController.text),
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text),
                            );
                          } else {
                            await productController.updateProduct(
                              id,
                              productNameController.text,
                              productImageController.text,
                              int.parse(productQtyController.text),
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text),
                            );
                          }
                          fetchData();
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error: $e"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        id == null ? 'Add Product' : 'Update Product',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Future<void> fetchData() async {
    await productController.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white)),
      ),
      body:
          productController.products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ProductListTile(
                    product: product,
                    onEdit:
                        () => productDialog(
                          id: product.sId,
                          name: product.productName,
                          img: product.img,
                          qty: product.qty,
                          unitPrice: product.unitPrice,
                          totalPrice: product.totalPrice,
                        ),
                    onDelete: () async {
                      final success = await productController.deleteProducts(
                        product.sId.toString(),
                      );
                      if (success) {
                        fetchData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Product deleted"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Something went wrong, please try again",
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
