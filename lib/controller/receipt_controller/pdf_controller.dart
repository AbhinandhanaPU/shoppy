import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/controller/receipt_controller/receipt_controller.dart';
import 'package:shoppy/model/cart_model.dart';

class ReceiptGenerator {
  final PaymentController paymentController = Get.put(PaymentController());
  final ReceiptController receiptController = Get.put(ReceiptController());

  Future<void> generateReceipt(List<CartItem> cartItems) async {
    receiptController.setGeneratingReceipt(true);

    final pdf = pw.Document();

    log("Cart Items: ${cartItems.length}");

    double totalAmount = cartItems.fold(0, (summ, item) {
      return summ + (item.product.price * item.quantity);
    });

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'SHOPPY',
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue),
              ),
              pw.Text(
                'Receipt',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Date: ${DateTime.now().toString()}'),
              pw.SizedBox(height: 20),
              pw.Text(
                'Products:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
                ),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'Product Name',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Quantity',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Price',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Total',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ...cartItems.map((item) {
                    return pw.TableRow(
                      children: [
                        pw.Text(
                          item.product.name,
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          'x${item.quantity}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Amount: ',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Thank you for your purchase!',
                textAlign: pw.TextAlign.center,
              ),
            ],
          ),
        );
      },
    ));

    final outputDir = await getExternalStorageDirectory();
    final outputFile = File(
        "${outputDir!.path}/receipt_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await outputFile.writeAsBytes(await pdf.save());

    receiptController.setGeneratingReceipt(false);
    receiptController.setReceiptPath(outputFile.path);

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "receipt.pdf",
    );

    Get.snackbar('Receipt', 'Receipt saved as PDF ');
  }
}
