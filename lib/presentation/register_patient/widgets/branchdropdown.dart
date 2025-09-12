import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ayurveda/providers/register_provider.dart';
import 'package:ayurveda/data/models/branch_model.dart';

class BranchDropdownField extends StatelessWidget {
  const BranchDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterPatientProvider>(
      builder: (context, provider, child) {
        Widget field;

        if (provider.isLoading && provider.branches.isEmpty) {
       
          field = const Center(child: CircularProgressIndicator());
        } else if (provider.branches.isEmpty) {
         
          field = TextFormField(
            controller: provider.nameController, 
            decoration: InputDecoration(
              hintText: "Enter branch",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (val) {
              provider.selectedBranch = Branch(id: 0, name: val);
              provider.notifyListeners();
            },
          );
        } else {
          
          field = DropdownButtonFormField<Branch>(
            value: provider.selectedBranch,
            decoration: const InputDecoration(
              hintText: "Select branch",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(16),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGreen),
            onChanged: provider.setBranch,
            items: provider.branches
                .map(
                  (branch) => DropdownMenuItem<Branch>(
                    value: branch,
                    child: Text(branch.name),
                  ),
                )
                .toList(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Branch",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            field,
          ],
        );
      },
    );
  }
}
