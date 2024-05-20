import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSellerScreen extends StatefulWidget {
  const AddSellerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddSellerScreenState createState() => _AddSellerScreenState();
}

class _AddSellerScreenState extends State<AddSellerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dealersController = TextEditingController();
  final TextEditingController _salesmenController = TextEditingController();
  final TextEditingController _trucksController = TextEditingController();
  final TextEditingController _offersController = TextEditingController();

  Future<void> _addSeller() async {
    try {
      await FirebaseFirestore.instance.collection('sellers').add({
        'name': _nameController.text.trim(),
        'dealers': int.parse(_dealersController.text.trim()),
        'salesmen': int.parse(_salesmenController.text.trim()),
        'trucks': int.parse(_trucksController.text.trim()),
        'offers': int.parse(_offersController.text.trim()),
      });
      Navigator.pop(context);
    } catch (e) {
      print('Error adding seller: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding seller: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Seller'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Seller Name'),
            ),
            TextField(
              controller: _dealersController,
              decoration: const InputDecoration(labelText: 'Number of Dealers'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _salesmenController,
              decoration:
                  const InputDecoration(labelText: 'Number of Salesmen'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _trucksController,
              decoration: const InputDecoration(labelText: 'Number of Trucks'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _offersController,
              decoration: const InputDecoration(labelText: 'Number of Offers'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSeller,
              child: const Text('Add Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
