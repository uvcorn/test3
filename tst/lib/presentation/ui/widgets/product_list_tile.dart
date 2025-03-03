import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';

class ProductListTile extends StatelessWidget {
  final Data product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductListTile({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 12,
      child: ListTile(
        leading:
            product.img != null && product.img!.isNotEmpty
                ? CircleAvatar(
                  backgroundImage: NetworkImage(product.img!),
                  backgroundColor: Colors.grey.shade200,
                )
                : const CircleAvatar(child: Icon(Icons.image)),
        title: Text(
          product.productName ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Price: ${product.unitPrice} | Qty: ${product.qty}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
