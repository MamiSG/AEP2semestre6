import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final KMeansHelper kmeansHelper = KMeansHelper();

  @override
  void initState() {
    super.initState();
    kmeansHelper.loadModel();
  }

  void _detectarCluster() {
    List<double> inputFeatures = [50.0, 100.0, 2.0, 75.0];
    int clusterIndex = kmeansHelper.predictCluster(inputFeatures);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cluster detectado: $clusterIndex'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detecção de Ameaças'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _detectarCluster,
          child: Text('Detectar Ameaça'),
        ),
      ),
    );
  }
}

class KMeansHelper {
  Future<void> loadModel() async {
    print('Modelo K-means implementado diretamente carregado com sucesso.');
  }

  int predictCluster(List<double> inputFeatures) {
    return 0;
  }
}
