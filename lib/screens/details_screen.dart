import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map person;
  const DetailsScreen({
    required this.person,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(" Taarifa za ${person['name']}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "${person['imageUrl']}",
              scale: 1,
              height: 290,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                      const Text("Taarifa binafsi"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DataTable(
                          headingRowHeight: 0,
                          border: TableBorder.all(color: Colors.grey),
                          dataRowMaxHeight: 45,
                          dataRowMinHeight: 25,
                          columns: const [
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                const DataCell(Text("Jina")),
                                DataCell(Text("${person['name']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Jinsia")),
                                DataCell(Text("${person['gender']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Umri")),
                                DataCell(Text(
                                    "${(today.year - DateTime.parse(person['dob']).year)} years")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Simu")),
                                DataCell(Text("${person['phone']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Barua pepe")),
                                DataCell(
                                  Text(
                                    person['email'] == ""
                                        ? "Hana"
                                        : "${person['email']}",
                                  ),
                                ),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Mahali anapoishi")),
                                DataCell(Text(
                                    "${person['ward']}, ${person['region']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Kiwango cha elimu")),
                                DataCell(Text("${person['education']}")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 12),
                  if (person['activity'].toString().toLowerCase() == "kilimo")
                    Row(
                      children: [
                        Expanded(
                          child: DataTable(
                            headingRowHeight: 0,
                            border: TableBorder.all(color: Colors.grey),
                            dataRowMaxHeight: 45,
                            dataRowMinHeight: 25,
                            columns: const [
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(Text("Shughuli yake")),
                                  DataCell(Text("${person['activity']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Aina ya kilimo")),
                                  DataCell(Text("${person['farm_type']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Mahali pa shughuli")),
                                  DataCell(Text("${person['farm_location']}")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (person['activity'].toString().toLowerCase() == "biashara")
                    Row(
                      children: [
                        Expanded(
                          child: DataTable(
                            headingRowHeight: 0,
                            border: TableBorder.all(color: Colors.grey),
                            dataRowMaxHeight: 45,
                            dataRowMinHeight: 25,
                            columns: const [
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(Text("Shughuli yake")),
                                  DataCell(Text("${person['activity']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Aina ya biashara")),
                                  DataCell(Text("${person['business_type']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Mahali biashara ilipo")),
                                  DataCell(Text("${person['location']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Biashara imesajiriwa")),
                                  DataCell(Text(
                                      "${person['is_business_registered']}")),
                                ],
                              ),
                              if (person['is_business_registered']
                                      .toString()
                                      .toLowerCase() ==
                                  "ndiyo")
                                DataRow(
                                  cells: [
                                    const DataCell(Text("Namba ya leseni")),
                                    DataCell(Text("${person['license']}")),
                                  ],
                                ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Mapato kwa miezi sita")),
                                  DataCell(Text("${person['half_sales']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Mapato kwa mwaka")),
                                  DataCell(Text("${person['yearl_sales']}")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (person['activity'].toString().toLowerCase() ==
                      "nimeajiriwa")
                    Row(
                      children: [
                        Expanded(
                          child: DataTable(
                            headingRowHeight: 0,
                            border: TableBorder.all(color: Colors.grey),
                            dataRowMaxHeight: 45,
                            dataRowMinHeight: 25,
                            columns: const [
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(Text("Shughuli yake")),
                                  DataCell(Text("${person['activity']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Mwajiri wake")),
                                  DataCell(Text("${person['employer']}")),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(Text("Ofisi gani")),
                                  DataCell(Text("${person['office']}")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DataTable(
                          headingRowHeight: 0,
                          border: TableBorder.all(color: Colors.grey),
                          dataRowMaxHeight: 45,
                          dataRowMinHeight: 25,
                          columns: const [
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                const DataCell(Text("Anapenda kutumia banki")),
                                DataCell(Text("${person['like_to_use_bank']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Ana akaunti ya benki")),
                                DataCell(Text("${person['have_account']}")),
                              ],
                            ),
                            if (person['have_account']
                                    .toString()
                                    .toLowerCase() ==
                                "hapana")
                              DataRow(
                                cells: [
                                  const DataCell(
                                      Text("Anapenda kuwa na akaunti")),
                                  DataCell(Text(
                                      "${person['like_to_have_bank_account']}")),
                                ],
                              ),
                            DataRow(
                              cells: [
                                const DataCell(
                                    Text("Kuna benki gani mtaani kwake")),
                                DataCell(Text("${person['bank_near']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(
                                    Text("Kuna changamoto kufungua akaunti")),
                                DataCell(
                                    Text("${person['open_accunt_challenge']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text(
                                    "Anajua faida y akuwa na akaunti banki")),
                                DataCell(
                                    Text("${person['response_profit_bank']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text("Angependa kupata mkopo")),
                                DataCell(Text("${person['like_loan']}")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(
                                    Text("Amesajiriwa kwenye vikundi")),
                                DataCell(Text("${person['has_a_group']}")),
                              ],
                            ),
                            if (person['has_a_group']
                                    .toString()
                                    .toLowerCase() ==
                                "ndiyo")
                              DataRow(
                                cells: [
                                  const DataCell(Text("Jina la kikundi")),
                                  DataCell(Text("${person['group_name']}")),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
