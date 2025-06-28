import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DisplayDataScreen extends StatelessWidget {
  const DisplayDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    final CollectionReference myItems =
    FirebaseFirestore.instance.collection("Store Data");

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Stored Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: myItems
            .where('userEmail', isEqualTo: currentUserEmail)
            .limit(1) // ✅ Only one user's most recent data
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show fallback if no data or error
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          try {
            final doc = snapshot.data!.docs.first;
            final String name = doc['name'] ?? 'N/A';
            final String position = doc['position'] ?? 'N/A';
            final String profession = doc['proffesion'] ?? 'N/A';

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "User Info",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("👤 Name: $name",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("📍 Address: $position",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("💼 Profession: $profession",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            );
          } catch (e) {
            return Center(child: Text("Something went wrong: ${e.toString()}"));
          }
        },
      ),
    );
  }
}
