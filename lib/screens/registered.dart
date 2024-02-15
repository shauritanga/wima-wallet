import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wima_wallet/screens/complete.dart';
import 'package:wima_wallet/screens/details_screen.dart';
import 'package:wima_wallet/widgets/custom_drawer.dart';

class RegisteredScreen extends StatefulWidget {
  const RegisteredScreen({super.key});

  @override
  State<RegisteredScreen> createState() => _RegisteredScreenState();
}

class _RegisteredScreenState extends State<RegisteredScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();

  late Stream<List<DocumentSnapshot>> _stream;

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    return _firestore.collection("data").snapshots();
  }

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('data')
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _stream = FirebaseFirestore.instance
            .collection('data')
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots()
            .map((snapshot) => snapshot.docs
                .where(
                  (doc) => doc['name'].toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList());
      } else {
        // If query is empty, load all documents again
        _stream = FirebaseFirestore.instance
            .collection('data')
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots()
            .map((snapshot) => snapshot.docs);
      }
    });
  }

  String queryString = "";

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double bottomBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waliosajiriwa"),
      ),
      drawer: CustomDrawer(
          statusBarHeight: statusBarHeight, bottomBarHeight: bottomBarHeight),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      queryString = value;

                      _filterSearchResults(queryString);
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final documents = snapshot.data!;
                  if (documents.isEmpty) {
                    return const Center(
                      child: Text("Hujasajiri mtu yeyote"),
                    );
                  }
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> person =
                          documents[index].data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(person: person),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(220),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(1, 2),
                                color: Colors.grey,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${person['imageUrl']}"),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${person['name']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          "Gusa ili kuona wasifu wa wima",
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      EvaIcons.arrowForwardOutline,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CompletedRegistration(),
            ),
          );
        },
        backgroundColor: const Color(0xff102d61),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
