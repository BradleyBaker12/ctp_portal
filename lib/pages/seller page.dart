import 'package:ctp_portal/pages/add_seller_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ctp_portal/pages/login_page.dart';

class SellerPage extends StatelessWidget {
  final User? user;

  const SellerPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('sellers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<Map<String, dynamic>> sellersData =
                snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return {
                'name': data['name'] ?? 'N/A',
                'dealers': data['dealers'] ?? 0,
                'salesmen': data['salesmen'] ?? 0,
                'trucks': data['trucks'] ?? 0,
                'offers': data['offers'] ?? 0,
              };
            }).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Sellers')),
                  DataColumn(label: Text('Dealers')),
                  DataColumn(label: Text('Salesmen')),
                  DataColumn(label: Text('Trucks')),
                  DataColumn(label: Text('Offers')),
                ],
                rows: sellersData.map((seller) {
                  return DataRow(cells: [
                    DataCell(Text(seller['name'])),
                    DataCell(Text(seller['dealers'].toString())),
                    DataCell(Text(seller['salesmen'].toString())),
                    DataCell(Text(seller['trucks'].toString())),
                    DataCell(Text(seller['offers'].toString())),
                  ]);
                }).toList(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSellerScreen()),
            );
          },
          label: const Text('Add Seller'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
