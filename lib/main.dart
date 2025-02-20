import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(TibajiApp());
}

class TibajiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riacho Tibaji Sustentável',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  void _playAudio() async {
    try {
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.setSource(AssetSource('audio/river_sound.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.resume();
    } catch (e) {
      print("Erro ao tocar áudio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/default_river.jpg',
              width: double.infinity, height: double.infinity, fit: BoxFit.cover),
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
              'assets/images/MPL.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Text("Logo não encontrada", style: TextStyle(color: Colors.white));
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Preservação do Riacho Tibaji',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _audioPlayer.stop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
                  },
                  child: Text('Começar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escolha uma opção')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen()));
              },
              child: Text('Conhecer a história do rio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
              },
              child: Text('Quiz sobre Sustentabilidade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                launch("https://wa.me/5589994526491?text=Gostaria%20de%20fazer%20uma%20denúncia%20ambiental.");
              },
              child: Text('Denúncia via WhatsApp'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('História do Rio Tibaji')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'O Rio Tibaji tem uma grande importância histórica e ambiental para a região. Sua preservação é fundamental para a biodiversidade local.',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QRScannerScreen()));
            },
            child: Text('Ler QR Code'),
          ),
        ],
      ),
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leitor de QR Code')),
      body: QRView(
        key: GlobalKey(debugLabel: 'QR'),
        onQRViewCreated: (controller) {},
      ),
    );
  }
}
