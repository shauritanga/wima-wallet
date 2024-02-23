import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wima_wallet/provider/data.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  String? selectedEducationLevel;
  String? selectedBusinessRegistration;
  String? likeHavingBankAccountResponse;
  String? haveBankAcountResponse;
  String? selecteAccountResponse;
  String? selectedMoneyEducationResponse;
  String? selectedBankProfitResponse;
  String? selectedGroupResponse;
  String? selectedLoanResponse;
  String? selecteBankName;
  String? selectedGroupLoanResponse;
  String? selectedGender;
  String? likeToUseBank;
  String? selectedActivity;
  String? selectedService;
  String? selectedEmployer;
  String? selectedRegion;
  String? selectedRegionId;
  String? selectedDistrict;
  String? selectedDistrictId;
  String? dOfBirth;

  String region = "";
  String district = "";
  String ward = "";
  String village = "";
  String name = "";
  String dob = "";
  String phone = "";
  String imageUrl = "";
  String? email;
  String? nida;
  String? kura;
  String activity = "";
  String? employer;
  String? office;
  String? farmType;
  String? businessType;
  String? location;
  String? businessLicense;
  double? midYearSales;
  double? yearlySales;
  String bankName = "";
  String challengeToOpenAccount = "";
  String haveAgroup = "";
  String groupName = "";
  int totalNumberOfMembers = 0;
  bool isLoading = false;
  UploadTask? uploadTask;

  Future uploadProfileImage(File file, XFile? pickedImage) async {
    final path = "images/${pickedImage!.name}";
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      ref.putFile(file);
    } catch (e) {
      throw Exception("File upload failed");
    }

    setState(() {
      uploadTask = ref.putFile(file);
    });
    try {
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = urlDownload;
      });
    } catch (e) {
      throw Exception("Fail to upload to firebase storage");
    }
  }

  Stream<QuerySnapshot> getRegions() {
    return _firestore.collection('regions').snapshots();
  }

  Stream<QuerySnapshot> getDistricts(String regionId) {
    return _firestore
        .collection('districts')
        .where('regionId', isEqualTo: regionId)
        .snapshots();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 12,
                      color: const Color(0xff102d61),
                    ),
                    const SizedBox(width: 8),
                    const Text("Taarifa za mtu binafsi"),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Jina kamili",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jaza jina tafadhali";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                const Text("Jinsia"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua'),
                        value: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        items: [
                          "Mme",
                          "Mke",
                        ].map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Tarehe ya kuzaliwa",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? doBirth = await showDatePicker(
                          currentDate: DateTime.now(),
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(DateTime.now().year - 10),
                        );
                        final dobText =
                            doBirth!.toIso8601String().split("T")[0];
                        _dobController.text = dobText;
                        setState(() {
                          dob = doBirth.toIso8601String();
                        });
                      },
                      icon: const Icon(EvaIcons.calendarOutline),
                    ),
                  ),
                  controller: _dobController,
                  onSaved: (value) => dOfBirth = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jaza tarehe ya kuzaliwa";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),
                const Text("Mahali unapoishi"),
                const SizedBox(height: 8),
                StreamBuilder<QuerySnapshot>(
                  stream: getRegions(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> regions = snapshot.data!.docs;

                    List<Map> mikoa = regions.map((mkoa) {
                      return {"id": mkoa.id, "name": mkoa.data() as Map};
                    }).toList();

                    return Container(
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Chagua Mkoa'),
                            value: selectedRegion,
                            onChanged: (String? value) {
                              setState(() {
                                selectedRegionId = mikoa
                                    .where((element) =>
                                        element['name']['name'] == value)
                                    .first['id']
                                    .toString();
                                selectedRegion = value;
                                selectedDistrict = null;
                              });
                            },
                            items: mikoa.map((region) {
                              return DropdownMenuItem<String>(
                                value: region['name']['name'],
                                child: Text("${region['name']['name']}"),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: selectedRegion != null
                      ? getDistricts(selectedRegionId!)
                      : null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || selectedRegion == null) {
                      return Container();
                    }

                    List<QueryDocumentSnapshot> districts = snapshot.data!.docs;

                    List<Map> wilayas = districts.map((mkoa) {
                      return {"id": mkoa.id, "name": mkoa.data() as Map};
                    }).toList();

                    return Container(
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Chagua Wilaya'),
                            value: selectedDistrict,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDistrictId = wilayas
                                    .where((element) =>
                                        element['name']['name'] == value)
                                    .first['id']
                                    .toString();
                                selectedDistrict = value;
                              });
                            },
                            items: wilayas.map((district) {
                              return DropdownMenuItem<String>(
                                value: district['name']['name'],
                                child: Text("${district['name']['name']}"),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Kata",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => ward = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jaza kata anakotoka";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Kijiji au Mtaa",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => village = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Jaza kijiji au mtaa anaoishi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Namba ya simu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => phone = value!,
                  validator: (value) {
                    String pattern = r'^[+255|0]+[6|7]\d{8}$';
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return "Jaza namba ya simu";
                    } else if (!regExp.hasMatch(value)) {
                      return "Jaza namba ya simu sahihi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Barua pepe(sio lazima)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => email = value,
                  validator: (value) {
                    String pattern =
                        r'^[a-z]+([a-z0-9.-]+)?\@[a-z]+\.[a-z]{2,3}$';
                    RegExp regExp = RegExp(pattern);
                    if (!regExp.hasMatch(value!)) {
                      return "Jaza barua pepe iliyosahihi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Namba ya NIDA",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => nida = value,
                  validator: (value) {
                    if (value!.length < 20 || value.length > 20) {
                      "Andika NIDA namba sahihi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                const Text("Elimu"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua kiwango cha elimu'),
                        value: selectedEducationLevel,
                        onChanged: (String? value) {
                          setState(() {
                            selectedEducationLevel = value;
                          });
                        },
                        items: [
                          "Dalasa la saba",
                          "Kitado cha nne",
                          "Kidato cha sita",
                          "Certificate",
                          "Diploma",
                          "Degree",
                          "Masters",
                          "PHD"
                        ].map((elimu) {
                          return DropdownMenuItem<String>(
                            value: elimu,
                            child: Text(elimu),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 12,
                      color: const Color(0xff102d61),
                    ),
                    const SizedBox(width: 8),
                    const Text("Taarifa za kazi"),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Je unajishughulisha na nini?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua'),
                        value: selectedActivity,
                        onChanged: (String? value) {
                          setState(() {
                            selectedActivity = value;
                            activity = value!;
                            selectedEmployer = null;
                            businessType = null;
                            farmType = null;
                            location = null;
                            employer = null;
                            office = null;
                          });
                        },
                        items: [
                          "Nimeajiriwa",
                          "Kilimo",
                          "Biashara",
                        ].map((kazi) {
                          return DropdownMenuItem<String>(
                            value: kazi,
                            child: Text(kazi),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                if (selectedActivity == "Nimeajiriwa")
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Chagua Mwajiri'),
                              value: selectedEmployer,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedEmployer = value;
                                  employer = value;
                                  selectedBusinessRegistration = null;
                                });
                              },
                              items: [
                                "Serikali",
                                "Kampuni binafsi",
                              ].map((kazi) {
                                return DropdownMenuItem<String>(
                                  value: kazi,
                                  child: Text(kazi),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Jina la ofisi",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => office = value!,
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                if (selectedActivity?.toLowerCase() == "kilimo")
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Aina ya kilimo(Mkulima au Mfugaji)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => farmType = value,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Eneo lilipo shamba",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => location = value,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if (selectedActivity?.toLowerCase() == "biashara")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Aina ya biashara",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => businessType = value,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Eneo ilipo biashara",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => location = value,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      const Text("Je biashara imesajiriwa?"),
                      const SizedBox(height: 8),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Chagua jibu'),
                              value: selectedBusinessRegistration,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedBusinessRegistration = value;
                                });
                              },
                              items: [
                                "Ndiyo",
                                "Hapana",
                              ].map((kazi) {
                                return DropdownMenuItem<String>(
                                  value: kazi,
                                  child: Text(kazi),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      selectedBusinessRegistration?.toLowerCase() == "ndiyo"
                          ? Column(
                              children: [
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Namba ya usajiri wa biashara",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onSaved: (value) => businessLicense = value,
                                  keyboardType: TextInputType.text,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Mauzo kwa miezi sita",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => midYearSales = double.parse(value!),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Mauzo kwa mwaka",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onSaved: (value) => yearlySales = double.parse(value!),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 12,
                      color: const Color(0xff102d61),
                    ),
                    const SizedBox(width: 8),
                    const Text("Taarifa zaidi"),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Je Unapenda kutumia benki?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: likeToUseBank,
                        onChanged: (String? value) {
                          setState(() {
                            likeToUseBank = value;
                          });
                        },
                        items: [
                          "Ndiyo",
                          "Hapana",
                        ].map((pref) {
                          return DropdownMenuItem<String>(
                            value: pref,
                            child: Text(pref),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Je, una Akaunti ya Benki?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: haveBankAcountResponse,
                        onChanged: (String? value) {
                          setState(() {
                            haveBankAcountResponse = value;
                            likeHavingBankAccountResponse = null;
                          });
                        },
                        items: [
                          "Ndiyo",
                          "Hapana",
                        ].map((acount) {
                          return DropdownMenuItem<String>(
                            value: acount,
                            child: Text(acount),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                haveBankAcountResponse?.toLowerCase() == "hapana"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text("Je ungependa kuwa na akaunti ya benki?"),
                          const SizedBox(height: 8),
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Chagua jibu'),
                                  value: likeHavingBankAccountResponse,
                                  onChanged: (String? value) {
                                    setState(() {
                                      likeHavingBankAccountResponse = value;
                                    });
                                  },
                                  items: [
                                    "Ndiyo",
                                    "Hapana",
                                  ].map((account) {
                                    return DropdownMenuItem<String>(
                                      value: account,
                                      child: Text(account),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
                const Text("Je Kuna benki gani mitaa hii?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: selecteBankName,
                        onChanged: (String? value) {
                          setState(() {
                            selecteBankName = value;
                          });
                        },
                        items: [
                          "Hakuna",
                          "CRDB",
                          "NMB",
                          "NBC",
                          "BOA",
                          "FNB",
                          "International Commercial Bank",
                          "TADB",
                          "NIC",
                          "PBZ",
                          "Stanbic Bank",
                          "Standard Chartered",
                          "United Bank for Africa",
                          "UBL",
                          "ZBC",
                          "DCB",
                          "MWANGA",
                          "Baroda",
                          "Bank of India",
                          "EXIM",
                          "Access",
                          "Advans",
                          "Akiba",
                          "Amana",
                          "Barclays",
                          "Citi",
                          "CBA",
                          "Eco",
                          "Equity",
                          "FBME",
                          "Azania",
                          "Mkombozi",
                          "DTB",
                          "KCB"
                        ].map((bank) {
                          return DropdownMenuItem<String>(
                            value: bank,
                            child: Text(bank),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                    "Je umewahi kukutana na changamoto kufungua akaunti ya benki?"),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Ipi? Iandike hapa",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onSaved: (value) => challengeToOpenAccount = value!,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),
                const Text("Je unajua faida za kuwa na akaunti ya benki?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: selectedBankProfitResponse,
                        onChanged: (String? value) {
                          setState(() {
                            selectedBankProfitResponse = value;
                          });
                        },
                        items: [
                          "Ndiyo",
                          "Hapana",
                        ].map((faida) {
                          return DropdownMenuItem<String>(
                            value: faida,
                            child: Text(faida),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Je ungependa kupata mikopo?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: selectedLoanResponse,
                        onChanged: (String? value) {
                          setState(() {
                            selectedLoanResponse = value;
                          });
                        },
                        items: [
                          "Ndiyo",
                          "Hapana",
                        ].map((loan) {
                          return DropdownMenuItem<String>(
                            value: loan,
                            child: Text(loan),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Je umesajiriwa katika vikundi?"),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Chagua jibu'),
                        value: selectedGroupResponse,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGroupResponse = value;
                          });
                        },
                        items: [
                          "Ndiyo",
                          "Hapana",
                        ].map((vikundi) {
                          return DropdownMenuItem<String>(
                            value: vikundi,
                            child: Text(vikundi),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                selectedGroupResponse?.toLowerCase() == "ndiyo"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text("Jina la kikunndi"),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Andika jina la kikundi",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onSaved: (value) => groupName = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Jaza jina la kikundi";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 16),
                          const Text("Idadi ya wanachama"),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Andika jumla ya wanakikundi",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onSaved: (value) =>
                                totalNumberOfMembers = int.parse(value!),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Jaza idadi ya wanachama";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                              "Je vikundi vyenu viko tayari kukopesheka?"),
                          const SizedBox(height: 8),
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Chagua jibu'),
                                  value: selectedGroupLoanResponse,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedGroupLoanResponse = value;
                                    });
                                  },
                                  items: [
                                    "Ndiyo",
                                    "Hapana",
                                  ].map((vikundi) {
                                    return DropdownMenuItem<String>(
                                      value: vikundi,
                                      child: Text(vikundi),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                              "Je, Mnatumia huduma gani kuendesha kazi zenu"),
                          const SizedBox(height: 8),
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Chagua jibu'),
                                  value: selectedService,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedService = value;
                                    });
                                  },
                                  items: [
                                    "Banki",
                                    "Pesa Taslimu",
                                    "Mitandao ya simu"
                                  ].map((service) {
                                    return DropdownMenuItem<String>(
                                      value: service,
                                      child: Text(service),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                              "Je mnahitaji kufundishwa juu ya umuhimu wa kutunza pesa na kuendesha miradi midogo?"),
                          const SizedBox(height: 8),
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Chagua jibu'),
                                  value: selectedMoneyEducationResponse,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedMoneyEducationResponse = value;
                                    });
                                  },
                                  items: [
                                    "Ndiyo",
                                    "Hapana",
                                  ].map((vikundi) {
                                    return DropdownMenuItem<String>(
                                      value: vikundi,
                                      child: Text(vikundi),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
                const Text("Picha"),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      final pickedImage =
                          await picker.pickImage(source: ImageSource.camera);

                      final file = File(pickedImage!.path);
                      setState(() {
                        isLoading = true;
                      });
                      await uploadProfileImage(file, pickedImage);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 35,
                                width: 35,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Image.network(
                              imageUrl == ""
                                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQofHJFmvUkoZgk9cHJsB5XrkMGy2W-qIiCqkIhXWv3e1GkxA_N2mfS&usqp=CAE&s"
                                  : imageUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            // final url = Uri.https(
                            //     'ors.brela.go.tz', '/um/load/load_nida');

                            // final response =
                            //     await http.post(url, body: {'NIN': nida});
                            // print("NIDA RESPONSE $response");
                            Map<String, dynamic> data = {
                              "userId": FirebaseAuth.instance.currentUser?.uid,
                              "name": name,
                              "gender": selectedGender!,
                              "dob": dob,
                              "region": selectedRegion,
                              "district": selectedDistrict,
                              "ward": ward,
                              "village": village,
                              "phone": phone,
                              "email": email ?? "",
                              "NIDA": nida ?? "",
                              "education": selectedEducationLevel!,
                              "activity": activity,
                              "like_to_use_bank": likeToUseBank!,
                              "have_account": haveBankAcountResponse,
                              "like_loan": selectedLoanResponse,
                              "bank_near": selecteBankName,
                              "response_profit_bank":
                                  selectedBankProfitResponse,
                              "open_accunt_challenge": challengeToOpenAccount,
                              "has_a_group": selectedGroupResponse,
                              "imageUrl": imageUrl,
                            };
                            if (activity.toLowerCase() == "biashara") {
                              Map<String, dynamic> biasharaObj = {
                                "business_type": businessType!,
                                "location": location!,
                                "is_business_registered":
                                    selectedBusinessRegistration!,
                                "half_sales": midYearSales!,
                                "yearl_sales": yearlySales!,
                              };

                              if (selectedBusinessRegistration?.toLowerCase() ==
                                  "ndiyo") {
                                biasharaObj
                                    .addAll({"license": businessLicense!});
                              }
                              data.addAll(biasharaObj);
                            } else if (activity.toLowerCase() == "kilimo") {
                              Map<String, dynamic> kilimoObj = {
                                "farm_type": farmType!,
                                "farm_location": location,
                              };

                              data.addAll(kilimoObj);
                            } else {
                              Map<String, dynamic> employerObj = {
                                "employer": employer!,
                                "office": office!,
                              };

                              data.addAll(employerObj);
                            }

                            if (haveBankAcountResponse?.toLowerCase() ==
                                "hapana") {
                              Map<String, dynamic> wantAccountObj = {
                                "like_to_have_bank_account":
                                    likeHavingBankAccountResponse,
                              };
                              data.addAll(wantAccountObj);
                            }

                            if (selectedGroupResponse?.toLowerCase() ==
                                "ndiyo") {
                              Map<String, dynamic> groupObj = {
                                "group_name": groupName,
                                "group_like_loan": selectedGroupLoanResponse,
                                "total_members": totalNumberOfMembers,
                                "service_used": selectedService,
                                "like_money_education":
                                    selectedMoneyEducationResponse,
                              };
                              data.addAll(groupObj);
                            }

                            final result = await showDialog(
                              context: context,
                              builder: (context) => FutureProgressDialog(
                                ref.read(dataProvider).addData(data),
                                message: const Text("Inapakia..."),
                              ),
                            );
                            if (result) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Usajiri umekamilika"),
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              return Navigator.of(context).pop();
                            }
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Usajiri umeshindikana, angalia kama una mtandao"),
                              ),
                            );
                          }
                        },
                  disabledColor: Colors.grey,
                  height: 56,
                  color: const Color(0xff102d61),
                  minWidth: size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text(
                    "Sajiri",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
