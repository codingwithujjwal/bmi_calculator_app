import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/gender_toggle.dart';
import '../widgets/input_field.dart';
import '../widgets/result_card.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  String category = "";
  String gender = "Male";

  void calculateBmi() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    setState(() {
      bmi = weight / (height * height);
      if (bmi! < 18.5) {
        category = "Underweight";
      } else if (bmi! < 24.9) {
        category = "Normal weight";
      } else if (bmi! < 29.9) {
        category = "Overweight";
      } else {
        category = "Obesity";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF690DAA), Color(0xFFA46ABB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GenderToggle(
              selectedGender: gender,
              onGenderSelected: (String selected) {
                setState(() => gender = selected);
              },
            ),
            const SizedBox(height: 20),
            InputField(
              controller: heightController,
              label: "Height (cm)",
              icon: Icons.height,
            ),
            const SizedBox(height: 20),
            InputField(
              controller: weightController,
              label: "Weight (kg)",
              icon: Icons.monitor_weight,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculateBmi,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xff8e44ad),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
              ),
              child: const Text(
                "Calculate BMI",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (bmi != null)
              ResultCard(bmi: bmi!, category: category, gender: gender),
          ],
        ),
      ),
    );
  }
}
