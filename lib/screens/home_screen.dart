import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wima_wallet/models/dashboard.dart';
import 'package:wima_wallet/provider/summary.dart';
import 'package:wima_wallet/widgets/custom_card.dart';
import 'package:wima_wallet/widgets/custom_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Stream<Dashboard> getData() {
    final firestore = FirebaseFirestore.instance;
    final doc = firestore.collection("data").snapshots();
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
      final youth = snapshot.docs.where((doc) {
        return doc.data()['have_account'] == "Hapana" &&
            doc.data()['like_to_have_bank_account'] == "Ndiyo";
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
      );
      return dashboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double bottomBarHeight = MediaQuery.of(context).viewPadding.top;
    //final asyncValue = ref.watch(dataSummaryStreamProvider);

    // return asyncValue.when(
    //   loading: () => const Center(
    //     child: SizedBox(
    //       height: 48,
    //       width: 48,
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    //   error: (error, stackTrace) => Text("$error"),
    //   data: (data) => Scaffold(
    //     appBar: AppBar(
    //       title: const Text("WIMA"),
    //     ),
    //     drawer: CustomDrawer(
    //         statusBarHeight: statusBarHeight, bottomBarHeight: bottomBarHeight),
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 16),
    //           Container(
    //             margin: const EdgeInsets.symmetric(horizontal: 16),
    //             height: 250,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //               border: Border.all(width: 0.5, color: Colors.black26),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: const Text("Helooo"),
    //           ),
    //           const SizedBox(height: 16),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: CustomCard(
    //                     value: Row(
    //                       children: [
    //                         const SizedBox(width: 4),
    //                         Text(
    //                           "${data.total}",
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 18,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     onTap: () {},
    //                     title: "IDADI YA WALIOSAJIRIWA",
    //                     titleStyle: const TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 19,
    //                     ),
    //                     icon: EvaIcons.edit2Outline,
    //                     color: const Color(0xff102d61),
    //                     iconBackgroundColor: Colors.white,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Expanded(
    //                   child: CustomCard(
    //                     value: Row(
    //                       children: [
    //                         const SizedBox(width: 4),
    //                         Text(
    //                           "${data.women}",
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 20,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     onTap: () {},
    //                     icon: EvaIcons.personOutline,
    //                     iconBackgroundColor: Colors.cyanAccent,
    //                     color: const Color(0xff102d61).withAlpha(180),
    //                     title: "WANAWAKE",
    //                     titleStyle: const TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: CustomCard(
    //                     value: Row(
    //                       children: [
    //                         const SizedBox(width: 4),
    //                         Text(
    //                           "${data.group}",
    //                           style: const TextStyle(
    //                             fontSize: 20,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     topTitleStyle: const TextStyle(
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                     title: "WALIO KWENYE VIKUNDI",
    //                     titleStyle: const TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                     icon: EvaIcons.peopleOutline,
    //                     iconBackgroundColor: const Color(0xffefeaea),
    //                     iconColor: const Color(0xff151d26),
    //                     onTap: () {},
    //                   ),
    //                 ),
    //                 const SizedBox(width: 16),
    //                 const Expanded(
    //                   child: CustomCard(
    //                     icon: EvaIcons.bulbOutline,
    //                     iconBackgroundColor: Color(0xffefeaea),
    //                     iconColor: Color(0xff151d26),
    //                     title: "VIJANA",
    //                     titleStyle: TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                     value: Text(""),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: CustomCard(
    //                     value: Row(
    //                       children: [
    //                         const SizedBox(width: 4),
    //                         Text(
    //                           "${data.account}",
    //                           style: const TextStyle(
    //                             fontSize: 20,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     topTitleStyle: const TextStyle(
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                     title: "WANAHITAJI AKAUNTI",
    //                     titleStyle: const TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                     icon: Icons.home_work_outlined,
    //                     iconBackgroundColor: const Color(0xffefeaea),
    //                     iconColor: const Color(0xff151d26),
    //                     onTap: () {},
    //                   ),
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Expanded(
    //                   child: CustomCard(
    //                     icon: EvaIcons.creditCardOutline,
    //                     iconBackgroundColor: const Color(0xffefeaea),
    //                     iconColor: const Color(0xff151d26),
    //                     title: "WANAHITAJI MIKOPO",
    //                     titleStyle: const TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                     ),
    //                     value: Text("${data.loan}"),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 24),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

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
            title: const Text("WIMA"),
          ),
          drawer: CustomDrawer(
              statusBarHeight: statusBarHeight,
              bottomBarHeight: bottomBarHeight),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black26),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text("Helooo"),
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                          title: "IDADI YA WALIOSAJIRIWA",
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                          icon: EvaIcons.edit2Outline,
                          color: const Color(0xff102d61),
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
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                          icon: EvaIcons.personOutline,
                          iconBackgroundColor: Colors.cyanAccent,
                          color: const Color(0xff102d61).withAlpha(180),
                          title: "WANAWAKE",
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
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
                                "${data?.group}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          topTitleStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          title: "WALIO KWENYE VIKUNDI",
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          icon: EvaIcons.peopleOutline,
                          iconBackgroundColor: const Color(0xffefeaea),
                          iconColor: const Color(0xff151d26),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: CustomCard(
                          icon: EvaIcons.bulbOutline,
                          iconBackgroundColor: Color(0xffefeaea),
                          iconColor: Color(0xff151d26),
                          title: "VIJANA",
                          titleStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          value: Text(""),
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
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          topTitleStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          title: "WANAHITAJI AKAUNTI",
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
                          title: "WANAHITAJI MIKOPO",
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
