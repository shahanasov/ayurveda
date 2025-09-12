import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/presentation/register_patient/register_patient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import 'widgets/booking_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PatientProvider()..fetchPatients(),
      child: Consumer<PatientProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.black),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        size: 20,
                        Icons.notifications_outlined,
                        color: AppColors.black,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 0,
                      top: 15,
                      left: 8,
                      child: Container(
                        width: 20 * 0.35,
                        height: 20 * 0.35,
                        decoration: BoxDecoration(
                          color: AppColors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
                //  Search Section
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.hintGray),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for local trends',
                              hintStyle: TextStyle(
                                color: AppColors.hintGray,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.hintGray,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Sort Section
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Sort by :',
                        style: TextStyle(fontSize: 14, color: AppColors.black),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 15,
                          left: 15,
                          bottom: 10,
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderGray),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primaryGreen,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                //  Patient List
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          // refresh
                          onRefresh: provider.fetchPatients,
                          child: provider.patients.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/emptylist.png",
                                      ),
                                      const SizedBox(height: 10),
                                      const Text("No Patients Found"),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  itemCount: provider.patients.length,
                                  itemBuilder: (context, index) {
                                    return BookingCard(
                                      booking: provider.patients[index],
                                      index: index + 1,
                                    );
                                  },
                                ),
                        ),
                ),

                //  Register Button
                Container(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
