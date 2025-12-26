/// Local Embedding Service
/// Generate vector embeddings for text using lightweight models
/// Useful for semantic search, similarity matching, and RAG

class EmbeddingService {
  /// Initialize embedding service
  /// Models should be lightweight (< 500MB) for mobile
  Future<void> initialize({
    String modelName = 'sentence-transformers/distilbert-base-uncased',
  }) async {
    // TODO: Initialize embedding model
    // Example: Use TensorFlow Lite for on-device embeddings
    // For now, use Ollama server for embeddings
  }

  /// Generate embedding for text
  /// Returns vector of dimension 384 (for distilbert)
  Future<List<double>> embed(String text) async {
    if (text.isEmpty) return [];

    try {
      // TODO: Implement embedding generation
      // Option 1: Use Ollama (requires server running)
      // Option 2: Use TensorFlow Lite model
      // Option 3: Use pre-computed embeddings cache

      return List.filled(384, 0.0); // Placeholder
    } catch (e) {
      throw Exception('Embedding error: $e');
    }
  }

  /// Batch embed multiple texts
  Future<List<List<double>>> embedBatch(List<String> texts) async {
    return Future.wait([
      for (final text in texts) embed(text),
    ]);
  }

  /// Calculate cosine similarity between two embeddings
  static double cosineSimilarity(
    List<double> vec1,
    List<double> vec2,
  ) {
    if (vec1.length != vec2.length) {
      throw ArgumentError('Vectors must have same dimension');
    }

    double dotProduct = 0;
    double norm1 = 0;
    double norm2 = 0;

    for (int i = 0; i < vec1.length; i++) {
      dotProduct += vec1[i] * vec2[i];
      norm1 += vec1[i] * vec1[i];
      norm2 += vec2[i] * vec2[i];
    }

    norm1 = norm1.sqrt();
    norm2 = norm2.sqrt();

    if (norm1 == 0 || norm2 == 0) return 0;
    return dotProduct / (norm1 * norm2);
  }

  /// Find most similar text from list
  Future<String> findMostSimilar(
    String query,
    List<String> candidates,
  ) async {
    final queryEmbedding = await embed(query);
    final candidateEmbeddings = await embedBatch(candidates);

    double maxSimilarity = -1;
    int bestIndex = 0;

    for (int i = 0; i < candidateEmbeddings.length; i++) {
      final similarity = cosineSimilarity(
        queryEmbedding,
        candidateEmbeddings[i],
      );

      if (similarity > maxSimilarity) {
        maxSimilarity = similarity;
        bestIndex = i;
      }
    }

    return candidates[bestIndex];
  }

  /// Find top-k most similar texts
  Future<List<(String, double)>> findTopKSimilar(
    String query,
    List<String> candidates, {
    int k = 5,
  }) async {
    final queryEmbedding = await embed(query);
    final candidateEmbeddings = await embedBatch(candidates);

    final scores = <(String, double)>[];

    for (int i = 0; i < candidateEmbeddings.length; i++) {
      final similarity = cosineSimilarity(
        queryEmbedding,
        candidateEmbeddings[i],
      );
      scores.add((candidates[i], similarity));
    }

    // Sort by similarity (descending)
    scores.sort((a, b) => b.$2.compareTo(a.$2));

    return scores.take(k).toList();
  }

  /// Dispose resources
  Future<void> dispose() async {
    // Cleanup model resources
  }
}

/// Example Usage:
/// ```
/// final embedder = EmbeddingService();
/// await embedder.initialize();
///
/// // Find most similar recipe
/// final similar = await embedder.findMostSimilar(
///   'vegetarian protein bowl',
///   [
///     'Tofu stir fry with vegetables',
///     'Chicken breast with rice',
///     'Lentil and quinoa salad',
///   ],
/// );
/// print(similar); // 'Lentil and quinoa salad'
/// ```
