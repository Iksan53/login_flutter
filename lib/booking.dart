import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking Data',
      home: BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _propertyController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  final CollectionReference _bookingdata =
      FirebaseFirestore.instance.collection('bookingdata');

  // ignore: unused_element
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: _propertyController,
                  decoration: const InputDecoration(labelText: 'property'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'quantity',
                  ),
                ),
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'status'),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String property = _propertyController.text;
                    final double? quantity =
                        double.tryParse(_quantityController.text);
                    final String status = _statusController.text;
                    if (quantity != null) {
                      await _bookingdata.add({
                        "name": name,
                        "property": property,
                        "quantity": quantity,
                        "status": status
                      });

                      _nameController.text = '';
                      _propertyController.text = '';
                      _quantityController.text = '';
                      _statusController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _propertyController.text = documentSnapshot['property'].toString();
      _quantityController.text = documentSnapshot['quantity'].toString();
      _statusController.text = documentSnapshot['status'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: _propertyController,
                  decoration: const InputDecoration(labelText: 'property'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'quantity',
                  ),
                ),
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'status'),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String property = _propertyController.text;
                    final double? quantity =
                        double.tryParse(_quantityController.text);
                    final String status = _statusController.text;
                    if (quantity != null) {
                      await _bookingdata.add({
                        "name": name,
                        "property": property,
                        "quantity": quantity,
                        "status": status
                      });
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String bookingId) async {
    await _bookingdata.doc(bookingId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a data')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent.shade700,
          title: const Center(child: Text('Data Booking')),
        ),
        body: StreamBuilder(
          stream: _bookingdata.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['property']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// Add new product
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent.shade700,
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Image siteplan(String imageName) {
    return Image.asset(
      imageName,
      width: 400,
      height: 400,
    );
  }
}
