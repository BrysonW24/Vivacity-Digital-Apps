import 'package:flutter/material.dart';
import 'package:basic_flutter_app/models/product_model.dart';
import 'package:basic_flutter_app/utils/mock_data_loader.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<ProductModel>> _products;

  @override
  void initState() {
    super.initState();
    _products = MockDataLoader.loadMockProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<ProductModel>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load products'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(product.imageUrl, width: 50, height: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
