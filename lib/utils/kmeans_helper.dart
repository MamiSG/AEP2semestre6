import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class KMeansHelper {
  late List<List<double>> clusters;
  late List<double> mean;
  late List<double> scale;

  Future<void> loadModel() async {
    final String kmeansData =
        await rootBundle.loadString('assets/models/kmeans.json');
    final String scalerDataString =
        await rootBundle.loadString('assets/models/scaler.json');

    // Decodificar kmeans.json e acessar a chave "centroids"
    final kmeansJson = json.decode(kmeansData) as Map<String, dynamic>;
    clusters = (kmeansJson['centroids'] as List<dynamic>)
        .map<List<double>>((e) => (e as List<dynamic>)
            .map<double>((item) => item.toDouble())
            .toList())
        .toList();

    // Decodificar scaler.json e acessar as chaves "mean" e "scale"
    final scalerJson = json.decode(scalerDataString) as Map<String, dynamic>;
    mean = (scalerJson['mean'] as List<dynamic>)
        .map<double>((e) => e.toDouble())
        .toList();
    scale = (scalerJson['scale'] as List<dynamic>)
        .map<double>((e) => e.toDouble())
        .toList();
  }

  List<double> scaleFeatures(List<double> inputFeatures) {
    // Escalonar as características de entrada usando mean e scale
    List<double> scaledFeatures = [];
    for (int i = 0; i < inputFeatures.length; i++) {
      double scaledValue = (inputFeatures[i] - mean[i]) / scale[i];
      scaledFeatures.add(scaledValue);
    }
    return scaledFeatures;
  }

  int predictCluster(List<double> inputFeatures) {
    List<double> scaledFeatures = scaleFeatures(inputFeatures);

    double minDistance = double.infinity;
    int closestClusterIndex = -1;

    for (int i = 0; i < clusters.length; i++) {
      double distance =
          _calculateEuclideanDistance(scaledFeatures, clusters[i]);
      if (distance < minDistance) {
        minDistance = distance;
        closestClusterIndex = i;
      }
    }

    return closestClusterIndex;
  }

  double _calculateEuclideanDistance(List<double> point1, List<double> point2) {
    double sum = 0.0;
    for (int i = 0; i < point1.length; i++) {
      sum += pow((point1[i] - point2[i]), 2);
    }
    return sqrt(sum);
  }
}
