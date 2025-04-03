import 'package:flutter/material.dart';
import 'package:wendys_challenge/features/home/domain/entities/menu_entity.dart';

class ProductScreenParams {
  const ProductScreenParams({required this.product});

  final MenuEntity product;
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({required this.params, super.key});

  final ProductScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(params.product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 32,
          children: [
            Text(
              params.product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Calories: ${params.product.calorieRange ?? 'Not available'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Price: ${params.product.priceRange ?? 'Not available'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
