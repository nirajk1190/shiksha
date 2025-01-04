import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  final String assetPath; // Path to the asset file

  PdfViewer({required this.assetPath});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String? _tempPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
  }

  Future<void> _loadPdfFromAssets() async {
    try {
      // Copy the PDF file from assets to a temporary directory
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_pdf.pdf');
      final assetData = await DefaultAssetBundle.of(context).load(widget.assetPath);
      await tempFile.writeAsBytes(assetData.buffer.asUint8List());
      setState(() {
        _tempPath = tempFile.path;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _tempPath == null
          ? Center(child: Text('Failed to load PDF'))
          : PDFView(
        filePath: _tempPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        defaultPage: 0,
      ),
    );
  }
}
