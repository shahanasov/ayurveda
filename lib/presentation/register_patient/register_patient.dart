import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:ayurveda/presentation/home/home_screen.dart';
import 'package:ayurveda/presentation/pdf/pdf_generator.dart';
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
        actions: const [Icon(Icons.notifications_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            (h) => DropdownMenuItem(value: h, child: Text(h)),
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
                            (m) => DropdownMenuItem(value: m, child: Text(m)),
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
                    // Validate required fields before proceeding
                    if (provider.nameController.text.trim().isEmpty ||
                        provider.whatsappController.text.trim().isEmpty ||
                        provider.addressController.text.trim().isEmpty ||
                        provider.selectedLocation == null ||
                        provider.selectedBranch == null ||
                        provider.treatments.isEmpty ||
                        provider.dateController.text.trim().isEmpty ||
                        provider.selectedHour == null ||
                        provider.selectedMinute == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all required fields"),
                        ),
                      );
                      return;
                    }

                    // Save patient data after PDF is generated
                    final success = await provider.savePatientData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? "Patient Registered & PDF Generated"
                              : "Registration Failed",
                        ),
                      ),
                    );

                    // Calculate balance if needed (optional, but good practice)
                    double totalAmount =
                        provider.totalAmountController.text.trim().isEmpty
                        ? provider.treatments.fold(
                            0.0,
                            (sum, t) => sum + t.maleCount,
                          )
                        : double.parse(
                            provider.totalAmountController.text.trim(),
                          );

                    double discount =
                        provider.discountAmountController.text.trim().isEmpty
                        ? 0.0
                        : double.parse(
                            provider.discountAmountController.text.trim(),
                          );

                    double advance =
                        provider.advanceAmountController.text.trim().isEmpty
                        ? 0.0
                        : double.parse(
                            provider.advanceAmountController.text.trim(),
                          );

                    double balance = totalAmount - discount - advance;

                    // Format date and time
                    String bookedOn = DateTime.now().toString().split(
                      ' ',
                    )[0]; // or use provider.dateController.text
                    String treatmentDate = provider.dateController.text.trim();
                    String treatmentTime =
                        '${provider.selectedHour}:${provider.selectedMinute}';

                    // Convert treatment list to map format expected by PDF generator
                    List<Map<String, dynamic>> pdfTreatments = provider
                        .treatments
                        .map(
                          (t) => {
                            'name': t.name,
                            'price': provider.balanceAmountController.text
                                .trim(),
                            'male': t.maleCount,
                            'female': t.femaleCount,
                            'total': provider.advanceAmountController.text
                                .trim(),
                          },
                        )
                        .toList();

                    // Generate PDF
                    await showTreatmentInvoicePdf(
                      name: provider.nameController.text.trim(),
                      address: provider.addressController.text.trim(),
                      phone: provider.whatsappController.text.trim(),
                      bookedOn: bookedOn,
                      treatmentDate: treatmentDate,
                      treatmentTime: treatmentTime,
                      treatments: pdfTreatments,
                      totalAmount: totalAmount,
                      discount: discount,
                      advance: advance,
                      balance: balance,
                    );

                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
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

  Widget treatmentItem(Treatment treatment, VoidCallback onRemove) => Container(
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
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.primaryGreen,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onTap: () => provider.pickDate(ctx),
      );
}
