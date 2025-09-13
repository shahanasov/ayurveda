import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:ayurveda/presentation/register_patient/widgets/treat_widget.dart';
import 'package:ayurveda/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_dialogue.dart';

class TreatmentWidget extends StatefulWidget {
  const TreatmentWidget({super.key});

  @override
  State<TreatmentWidget> createState() => _TreatmentWidgetState();
}

class _TreatmentWidgetState extends State<TreatmentWidget> {
  List<Treatment> treatments = [];

  void _addTreatment() async {
    final provider = Provider.of<RegisterPatientProvider>(
      context,
      listen: false,
    );

    await provider.loadTreatments();

    final result = await showDialog<Treatment>(
      context: context,
      builder: (_) => const TreatmentAlertDialog(),
    );

    if (result != null) {
      setState(() {
        treatments.add(result);
      });
    }
  }

  // Edit an existing treatment
  void _editTreatment(int index) async {
    final treatment = treatments[index];

    final result = await showDialog<Treatment>(
      context: context,
      builder: (_) => TreatmentAlertDialog(
        initialTreatment: treatment,
        initialMale: treatment.maleCount,
        initialFemale: treatment.femaleCount,
      ),
    );

    if (result != null) {
      setState(() {
        treatments[index] = result;
      });
    }
  }

  // Remove a treatment
  void _removeTreatment(int index) {
    setState(() {
      treatments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: treatments.asMap().entries.map((entry) {
            final index = entry.key;
            final treatment = entry.value;

            return TreatWidget(
              title: treatment.name,
              femaleCount: treatment.femaleCount,
              maleCount: treatment.maleCount,
              index: index + 1,
              onEdit: () => _editTreatment(index),
              onRemove: () => _removeTreatment(index),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _addTreatment,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: const Center(
              child: Text(
                "+ Add Treatment",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
