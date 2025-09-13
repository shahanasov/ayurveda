import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

Future<void> showTreatmentInvoicePdf({
  required String name,
  required String address,
  required String phone,
  required String bookedOn,
  required String treatmentDate,
  required String treatmentTime,
  required List<Map<String, dynamic>> treatments,
  required double totalAmount,
  required double discount,
  required double advance,
  required double balance,
}) async {
  final pdf = pw.Document();

  // Load logo for watermark and header
  final Uint8List logoBytes = await rootBundle
      .load('assets/images/logo.png')
      .then((data) => data.buffer.asUint8List());
  final pw.MemoryImage logoImage = pw.MemoryImage(logoBytes);

  final Uint8List signature = await rootBundle
      .load('assets/images/signature.png')
      .then((data) => data.buffer.asUint8List());
  final pw.MemoryImage signatureImage = pw.MemoryImage(signature);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Stack(
          children: [
            // BACKGROUND WATERMARK — Semi-transparent logo
            pw.Positioned.fill(
              child: pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Opacity(
                  opacity: 0.2,
                  child: pw.Image(logoImage, width: 300, height: 300),
                ),
              ),
            ),

            // MAIN CONTENT — Everything else goes on top
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Clinic Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Image(logoImage, width: 60, height: 60),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'KUMARAKOM',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'Cheepunkal P.O. Kumarakom, Kottayam, Kerala - 686563',
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text('e-mail: unknown@gmail.com'),
                        pw.SizedBox(height: 2),
                        pw.Text('Mob: +91 9876543210 | +91 9786543210'),
                        pw.SizedBox(height: 2),
                        pw.Text('GST No: 32AABCU9603R1ZW'),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 20),

                // Patient Details Heading
                pw.Container(
                  margin: pw.EdgeInsets.only(bottom: 10),
                  child: pw.Text(
                    'Patient Details',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                // Patient Info (Clean Row Layout)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Address',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'WhatsApp Number',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 10),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(name),
                        pw.SizedBox(height: 10),
                        pw.Text(address),
                        pw.SizedBox(height: 10),
                        pw.Text(phone),
                      ],
                    ),
                    pw.SizedBox(width: 40),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Booked On',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Treatment Date',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Treatment Time',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 10),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(bookedOn),
                        pw.SizedBox(height: 10),
                        pw.Text(treatmentDate),
                        pw.SizedBox(height: 10),
                        pw.Text(treatmentTime),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 15),

                // Dashed Line Separator
                pw.Container(
                  width: double.infinity,
                  height: 1,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.grey,
                        width: 0.5,
                        style: pw.BorderStyle.dashed, // Dashed line
                      ),
                    ),
                  ),
                ),

                // Treatments Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Text(
                        'Treatment',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        'Price',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        'Male',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        'Female',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        'Total',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(height: 5),
                ...treatments.map(
                  (t) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(width: 150, child: pw.Text(t['name'])),
                      pw.Container(width: 60, child: pw.Text('${t['price']}')),
                      pw.Container(width: 60, child: pw.Text('${t['male']}')),
                      pw.Container(width: 60, child: pw.Text('${t['female']}')),
                      pw.Container(width: 60, child: pw.Text('${t['total']}')),
                    ],
                  ),
                ),

                pw.SizedBox(height: 15),

                //  divider
                pw.Container(
                  width: double.infinity,
                  height: 1,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.grey,
                        width: 0.5,
                        style: pw.BorderStyle.dashed, // Dashed line
                      ),
                    ),
                  ),
                ),
                 pw. SizedBox(height: 10),
                // Summary
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Text(
                        'Total Amount',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        '$totalAmount',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Text(
                        'Discount',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        '$discount',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Text(
                        'Advance',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        '$advance',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Text(
                        'Balance',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),

                    pw.Container(
                      width: 60,
                      child: pw.Text(
                        '$balance',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
               pw. SizedBox(height: 10),

                pw.Container(
                  width: 50,
                  height: 1,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.grey,
                        width: 0.5,
                        style: pw.BorderStyle.dashed, // Dashed line
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: double.infinity, // Make container take full page width
                  padding: const pw.EdgeInsets.all(20), // Optional padding
                  child: pw.Column(
                    crossAxisAlignment:
                        pw.CrossAxisAlignment.end, // Right-align horizontally
                    mainAxisSize: pw
                        .MainAxisSize
                        .min, // Column only takes required height
                    children: [
                      // Thank You Message
                      pw.Text(
                        'Thank you for choosing us',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Your well-being is our commitment, and we’re honored\nyou’ve entrusted us with your health journey',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey,
                        ),
                      ),

                      // Signature
                      pw.SizedBox(height: 10),
                      pw.Image(signatureImage, width: 120, height: 40),
                    ],
                  ),
                ),

                // Footer Note
                pw.Spacer(),
                pw.Container(
                  child: pw.Center(
                    child: pw.Text(
                      '"Booking amount is non-refundable, and it’s important to arrive on the allotted time for your treatment"',
                      style: pw.TextStyle(fontSize: 9, color: PdfColors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  // Display or save PDF
  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}
