import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:ayurveda/presentation/register_patient/widgets/reg.dart';
import 'package:ayurveda/presentation/register_patient/widgets/treatment_add.dart';
import 'package:ayurveda/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/dropdown.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterPatientProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [Icon(Icons.notifications_outlined,)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(height: 1, color: AppColors.lightGray),
                    const SizedBox(height: 24),

                    // ---------------- Name ----------------
                    RegisterTextField(
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      hint: 'Enter your full name',
                      controller: provider.nameController,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Whatsapp ----------------
                    RegisterTextField(
                      keyboardType: TextInputType.phone,
                      label: 'Whatsapp Number',
                      hint: 'Enter Whatsapp number',
                      controller: provider.whatsappController,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Address ----------------
                    RegisterTextField(
                      keyboardType: TextInputType.name,
                      label: 'Address',
                      hint: 'Enter your full address',
                      controller: provider.addressController,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Location ----------------
                    RegisterDropdownField(
                      label: 'Location',
                      hint: 'Choose location',
                      value: provider.selectedLocation,
                      onChanged: provider.setLocation,
                      items: provider.locations,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Branch ----------------
                    RegisterDropdownField(
                      label: 'Branch',
                      hint: 'Choose branch',
                      value: provider.selectedBranch?.name,
                      onChanged: (val) {
                        final branch = provider.branches.firstWhere(
                          (b) => b.name == val,
                        );
                        provider.setBranch(branch);
                      },
                      items: provider.branches.map((b) => b.name).toList(),
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Treatments ----------------
                    sectionTitle("Treatments"),
                 
                    const SizedBox(height: 12),

                    // Gender counters
                    const SizedBox(height: 20),

                    // Add treatment button
                    TreatmentWidget(),
                    const SizedBox(height: 24),

                    // ---------------- Payment ----------------
                    RegisterTextField(
                      keyboardType: TextInputType.number,
                      label: 'Total Amount',
                      hint: 'Enter total amount',
                      controller: provider.totalAmountController,
                    ),
                    const SizedBox(height: 24),
                    RegisterTextField(
                      keyboardType: TextInputType.number,
                      label: 'Discount Amount',
                      hint: 'Enter discount amount',
                      controller: provider.discountAmountController,
                    ),
                    sectionTitle("Payment Option"),
                    Row(
                      children: [
                        "Cash",
                        "Card",
                        "UPI",
                      ].map((e) => _radio(e, provider)).toList(),
                    ),
                    const SizedBox(height: 24),
                    RegisterTextField(
                      keyboardType: TextInputType.number,
                      label: 'Advance Amount',
                      hint: 'Enter advance amount',
                      controller: provider.advanceAmountController,
                    ),
                    const SizedBox(height: 24),
                    RegisterTextField(
                      keyboardType: TextInputType.number,
                      label: 'Balance Amount',
                      hint: 'Enter balance amount',
                      controller: provider.balanceAmountController,
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Date picker ----------------
                    datePicker(provider, context),
                    sectionTitle("Treatment Time"),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: provider.selectedHour,
                            items: provider.hours
                                .map(
                                  (h) => DropdownMenuItem(
                                    value: h,
                                    child: Text(h),
                                  ),
                                )
                                .toList(),
                            onChanged: provider.setHour,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Hour",
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: provider.selectedMinute,
                            items: provider.minutes
                                .map(
                                  (m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m),
                                  ),
                                )
                                .toList(),
                            onChanged: provider.setMinute,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Minute",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ---------------- Save Button ----------------
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final patient = await provider
                                .savePatientData(); // returns PatientRegister
                            final jsonData = patient.toJson();

                            // Here you can call API or PDF generator
                            bool success = await provider.service
                                .registerPatient(patient); // call API
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? "Patient Registered Successfully"
                                      : "Failed to Register Patient",
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget sectionTitle(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
  );

  Widget treatmentItem(Treatment treatment, VoidCallback onRemove) =>
      Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              '${treatment.id}.',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                treatment.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.close, color: AppColors.orangeAccent),
            ),
          ],
        ),
      );

  Widget _radio(String title, RegisterPatientProvider provider) => Row(
    children: [
      Radio(
        value: title,
        groupValue: provider.paymentOption,
        activeColor: AppColors.primaryGreen,
        onChanged: provider.setPaymentOption,
      ),
      Text(title),
    ],
  );

  Widget datePicker(RegisterPatientProvider provider, BuildContext ctx) =>
      TextFormField(
        controller: provider.dateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Treatment Date',
          suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryGreen),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onTap: () => provider.pickDate(ctx),
      );
}
