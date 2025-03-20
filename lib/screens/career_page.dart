import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class CareerPage extends StatefulWidget {
  @override
  _CareerPageState createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  List<dynamic> careerList = [
    {
        "_id": "67d2806ee125d6617da1cb1f",
        "id": 1,
        "company": "CSL",
        "title": "DEVELOPER",
        "description": "WE ARE HIRING DEV",
        "deadline": "28.11.2024 - 27.02.2025",
        "category": "DEVSD"
    },
    {
        "_id": "67d2806ee125d6617da1cb20",
        "id": 2,
        "company": "CSL",
        "title": "TESTER",
        "description": "QA",
        "deadline": "02.12.2024 - 21.03.2025",
        "category": "QA"
    },
    {
        "_id": "67d2806ee125d6617da1cb21",
        "id": 3,
        "company": "ARVERSE",
        "title": "CONTENT CREATOR",
        "description": "We are seeking a talented content creator who is passionate about storytelling...",
        "deadline": "N/A",
        "category": "CREATOR"
    }
  ];
  bool isLoading = false;
  bool hasError = false;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCareerData();
  // }

  // Future<void> fetchCareerData() async {
  //   final url = Uri.parse("http://localhost:8000/careerss");

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         careerList = json.decode(response.body);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //         hasError = true;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       hasError = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CAREER",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text("Failed to load data"))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: careerList.length,
                  itemBuilder: (context, index) {
                    final job = careerList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job["company"] ?? "Unknown",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 4),
                            Text(
                              job["title"] ?? "N/A",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              job["description"] ?? "No description available",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "DEADLINE  ${job["deadline"] ?? "N/A"}",
                                  style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    job["category"] ?? "N/A",
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                // Implement navigation to job details page if needed
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "More Details",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
