// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

List<Job> jobFromJson(String str) => List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobToJson(List<Job> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
    int? id;
    String? title;
    String? department;
    String? location;
    String? salary;

    Job({
        this.id,
        this.title,
        this.department,
        this.location,
        this.salary,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        title: json["title"],
        department: json["department"],
        location: json["location"],
        salary: json["salary"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "department": department,
        "location": location,
        "salary": salary,
    };
}
