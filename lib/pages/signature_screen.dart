import 'package:flutter/material.dart';
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
      final signature = await _controller.toPngBytes();
      if (signature != null) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PoC Assinatura'),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                content: Image.memory(signature),
              ),
        );
      }
    }
  }
}
