import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final alturaAssinatura = alturaTela * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PoC Assinatura', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Signature(
              controller: _controller,
              height: alturaAssinatura,
              backgroundColor: Colors.grey[200]!,
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _controller.clear,
                  icon: Icon(Icons.clear),
                  label: Text('Limpar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    minimumSize: Size(150, 60),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _salvarAssinatura,
                  icon: Icon(Icons.save),
                  label: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    minimumSize: Size(150, 60),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _salvarAssinatura() async {
    if (_controller.isNotEmpty) {
      final Uint8List? signature = await _controller.toPngBytes();
      if (signature != null) {
        String? filePath;

        if (!kIsWeb) {
          final Directory directory = await getApplicationDocumentsDirectory();
          filePath =
              '${directory.path}/assinatura_${DateTime.now().millisecondsSinceEpoch}.png';
          final File imageFile = File(filePath);
          await imageFile.writeAsBytes(signature);
        }

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Assinatura'),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.memory(signature),
                    if (filePath != null) ...[
                      SizedBox(height: 8),
                      Text(
                        'Salvo em:\n$filePath',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ] else if (kIsWeb) ...[
                      SizedBox(height: 20),
                      Text(
                        'Visualização da assinatura no navegador.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
        );
      }
    }
  }
}
