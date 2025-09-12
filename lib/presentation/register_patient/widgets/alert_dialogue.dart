import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:ayurveda/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreatmentAlertDialog extends StatefulWidget {
  final Treatment? initialTreatment;
  final int initialMale;
  final int initialFemale;

  const TreatmentAlertDialog({
    super.key,
    this.initialTreatment,
    this.initialMale = 0,
    this.initialFemale = 0,
  });

  @override
  State<TreatmentAlertDialog> createState() => _TreatmentAlertDialogState();
}

class _TreatmentAlertDialogState extends State<TreatmentAlertDialog> {
  Treatment? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    super.initState();
    selectedTreatment = widget.initialTreatment;
    maleCount = widget.initialMale;
    femaleCount = widget.initialFemale;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<RegisterPatientProvider>(
        context,
        listen: false,
      );
      provider.loadTreatments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterPatientProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Treatment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<Treatment>(
              value: selectedTreatment,
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: 'Choose preferred treatment',
                hintStyle: TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                ),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
              ),
              items: provider.treatments.isNotEmpty
                  ? provider.treatments.map((t) {
                      return DropdownMenuItem<Treatment>(
                        value: t,
                        child: Text(
                          t.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : [
                      const DropdownMenuItem(
                        value: null,
                        child: Text(
                          "No treatments available",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
              onChanged: (value) => setState(() => selectedTreatment = value),
            ),

            const SizedBox(height: 20),
            const Text(
              "Add Patients",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            _buildCounter(
              "Male",
              maleCount,
              (val) => setState(() => maleCount = val),
            ),
            const SizedBox(height: 16),

            _buildCounter(
              "Female",
              femaleCount,
              (val) => setState(() => femaleCount = val),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedTreatment == null
                    ? null
                    : () {
                        final newTreatment = Treatment(
                          id: selectedTreatment!.id,
                          name: selectedTreatment!.name,
                          maleCount: maleCount,
                          femaleCount: femaleCount,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pop(newTreatment);
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Row(
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
          ),
        ),
        const SizedBox(width: 12),
        _buildCounterButton(Icons.remove, () {
          if (value > 0) onChanged(value - 1);
        }),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Text(
            "$value",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 12),
        _buildCounterButton(Icons.add, () => onChanged(value + 1)),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
