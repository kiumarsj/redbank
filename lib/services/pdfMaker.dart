import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateReport(String title, var dataList) async {
  const tableHeaders = ['Date', 'Amount', 'Destination Card'];
  const baseColor = PdfColors.red;
  // Create a PDF document.
  final document = pw.Document();

  // Data table
  final table = pw.Table.fromTextArray(
    border: null,
    headers: tableHeaders,
    data: List<List<dynamic>>.generate(
      dataList.length,
      (index) => <dynamic>[
        dataList[index]["date"],
        dataList[index]["amount"],
        dataList[index]["destCard"],
      ],
    ),
    headerStyle: pw.TextStyle(
      color: PdfColors.white,
      fontWeight: pw.FontWeight.bold,
    ),
    headerDecoration: const pw.BoxDecoration(
      color: baseColor,
    ),
    rowDecoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: baseColor,
          width: .5,
        ),
      ),
    ),
    cellAlignment: pw.Alignment.centerRight,
    cellAlignments: {0: pw.Alignment.centerLeft},
  );

  // Second page with a pie chart
  document.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      //theme: theme,
      build: (context) {
        return pw.Column(
          children: [
            pw.Text(
              title,
              style: const pw.TextStyle(
                color: baseColor,
                fontSize: 25,
              ),
            ),
            table,
          ],
        );
      },
    ),
  );

  // Return the PDF file content
  return document.save();
}
