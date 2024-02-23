import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wima_wallet/models/dashboard.dart';
import 'package:wima_wallet/screens/complete.dart';
import 'package:wima_wallet/screens/registration.dart';
import 'package:wima_wallet/widgets/custom_card.dart';
import 'package:wima_wallet/widgets/custom_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  Stream<Dashboard> getData() {
    final firestore = FirebaseFirestore.instance;
    final doc = firestore
        .collection("data")
        .where("userId", isEqualTo: user?.uid)
        .snapshots();
    return doc.asyncMap((snapshot) {
      final women = snapshot.docs.where((doc) {
        return doc.data().containsValue("Mke");
      }).toList();
      final total = snapshot.docs.length;
      final group = snapshot.docs.where((doc) {
        return doc.data()['has_a_group'] == "Ndiyo";
      }).toList();
      final account = snapshot.docs.where((doc) {
        return doc.data()['have_account'] == "Hapana" &&
            doc.data()['like_to_have_bank_account'] == "Ndiyo";
      }).toList();

      DateTime today = DateTime.now();
      final youth = snapshot.docs.where((doc) {
        var userData = doc.data();

        String dob = userData['dob'];

        // // Calculate age based on date of birth
        DateTime dobirth = DateTime.parse(dob);

        var age = today.year - dobirth.year;

        if (today.month < dobirth.month ||
            (today.month == dobirth.month && today.day < dobirth.day)) {
          age--;
        }

        // // Check if age is between 18 and 40
        return age >= 18 && age <= 40;
        // Increment the user count
        //return true;
      }).toList();

      final loan = snapshot.docs.where((doc) {
        return doc.data()['like_loan'] == "Ndiyo";
      }).toList();

      Dashboard dashboard = Dashboard(
          women: women.length,
          total: total,
          group: group.length,
          account: account.length,
          loan: loan.length,
          youth: youth.length);
      return dashboard;
    });
  }

  List items = [
    "https://images.unsplash.com/photo-1573164574511-73c773193279?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzV8fGJ1c2luZXNzJTIwd29lbWFufGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1524508762098-fd966ffb6ef9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTJ8fGJ1c2luZXNzJTIwd29lbWFufGVufDB8fDB8fHww"
  ];

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double bottomBarHeight = MediaQuery.of(context).viewPadding.top;
    Size size = MediaQuery.of(context).size;
    //final asyncValue = ref.watch(dataSummaryStreamProvider);

    return StreamBuilder(
      stream: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final data = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
          ),
          drawer: CustomDrawer(
              statusBarHeight: statusBarHeight,
              bottomBarHeight: bottomBarHeight),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CarouselSlider(
                    items: items
                        .map(
                          (item) => Container(
                            height: 190,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: const Text(
                      "Anza usajiri",
                      style: TextStyle(color: Color(0xff102d61)),
                    ),
                    trailing: const Icon(
                      EvaIcons.arrowForwardOutline,
                      color: Color(0xff102d61),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CompletedRegistration()));
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xff102d61)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 12,
                        color: const Color(0xff102d61),
                      ),
                      const SizedBox(width: 8),
                      const Text("Takwimu fupi"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomCard(
                          value: Row(
                            children: [
                              const SizedBox(width: 4),
                              Text(
                                "${data?.total}",
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                          onTap: () {},
                          title: "Walio sajiriwa",
                          titleStyle: const TextStyle(),
                          icon: EvaIcons.edit2Outline,
                          iconBackgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomCard(
                          value: Row(
                            children: [
                              const SizedBox(width: 4),
                              Text(
                                "${data?.women}",
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                          onTap: () {},
                          icon: EvaIcons.personOutline,
                          iconBackgroundColor: Colors.cyanAccent,
                          title: "Wanawake",
                          titleStyle: const TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomCard(
                          value: Row(
                            children: [
                              const SizedBox(width: 4),
                              Text(
                                "${data?.group}",
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                          topTitleStyle: const TextStyle(),
                          title: "Wenye vikundi",
                          titleStyle: const TextStyle(),
                          icon: EvaIcons.peopleOutline,
                          iconBackgroundColor: const Color(0xffefeaea),
                          iconColor: const Color(0xff151d26),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomCard(
                          icon: EvaIcons.bulbOutline,
                          iconBackgroundColor: const Color(0xffefeaea),
                          iconColor: const Color(0xff151d26),
                          title: "Vijana",
                          titleStyle: const TextStyle(),
                          value: Text(
                            "${data?.youth}",
                            style: const TextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomCard(
                          value: Row(
                            children: [
                              const SizedBox(width: 4),
                              Text(
                                "${data?.account}",
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                          topTitleStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          title: "Wanaohitaji akaunti",
                          titleStyle: const TextStyle(),
                          icon: Icons.home_work_outlined,
                          iconBackgroundColor: const Color(0xffefeaea),
                          iconColor: const Color(0xff151d26),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomCard(
                          icon: EvaIcons.creditCardOutline,
                          iconBackgroundColor: const Color(0xffefeaea),
                          iconColor: const Color(0xff151d26),
                          title: "Wanaohitaji mikopo",
                          titleStyle: const TextStyle(),
                          value: Text("${data?.loan}"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
