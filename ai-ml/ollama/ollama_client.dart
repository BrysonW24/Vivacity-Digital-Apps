/// Ollama API Client
/// Simple HTTP client for Ollama local LLM server
///
/// Setup: Run `ollama serve` to start server
/// Then pull a model: `ollama pull mistral:7b-instruct`

import 'package:http/http.dart' as http;
import 'dart:convert';

class OllamaClient {
  static const String defaultBaseUrl = 'http://localhost:11434/api';
  final String baseUrl;
  final String defaultModel;

  OllamaClient({
    this.baseUrl = defaultBaseUrl,
    this.defaultModel = 'mistral:7b-instruct',
  });

  /// Generate text using Ollama
  Future<String> generate(
    String prompt, {
    String? model,
    int maxTokens = 256,
    double temperature = 0.7,
  }) async {
    final modelToUse = model ?? defaultModel;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': modelToUse,
          'prompt': prompt,
          'stream': false,
          'temperature': temperature,
          'num_predict': maxTokens,
        }),
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () => throw TimeoutException('Ollama request timed out'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? '';
      } else {
        throw Exception(
          'Ollama error: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to generate text: $e');
    }
  }

  /// Stream text generation (for real-time output)
  Stream<String> generateStream(
    String prompt, {
    String? model,
    int maxTokens = 256,
    double temperature = 0.7,
  }) async* {
    final modelToUse = model ?? defaultModel;

    try {
      final request = http.Request(
        'POST',
        Uri.parse('$baseUrl/generate'),
      );

      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode({
        'model': modelToUse,
        'prompt': prompt,
        'stream': true,
        'temperature': temperature,
        'num_predict': maxTokens,
      });

      final response = await http.Client().send(request);

      if (response.statusCode == 200) {
        await for (final chunk in response.stream
            .transform(utf8.decoder)
            .transform(const LineSplitter())) {
          if (chunk.isEmpty) continue;

          try {
            final data = jsonDecode(chunk);
            if (data['response'] != null) {
              yield data['response'];
            }
          } catch (e) {
            // Skip malformed JSON lines
            continue;
          }
        }
      } else {
        throw Exception(
          'Ollama stream error: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to stream text: $e');
    }
  }

  /// List available models
  Future<List<String>> listModels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tags'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final models = data['models'] as List;
        return models.map((m) => m['name'] as String).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to list models: $e');
    }
  }

  /// Check if Ollama server is running
  Future<bool> isServerAvailable() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tags'),
      ).timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Generate embeddings for text
  Future<List<double>> embed(
    String text, {
    String? model,
  }) async {
    final modelToUse = model ?? 'nomic-embed-text:latest';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/embed'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': modelToUse,
          'input': text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final embeddings = data['embeddings'] as List;
        if (embeddings.isNotEmpty) {
          return List<double>.from(embeddings[0]);
        }
        return [];
      }
      throw Exception('Failed to embed text: ${response.statusCode}');
    } catch (e) {
      throw Exception('Embedding error: $e');
    }
  }
}

/// Example usage:
/// ```
/// final client = OllamaClient();
///
/// // Check if server is running
/// if (await client.isServerAvailable()) {
///   // Generate text
///   final response = await client.generate(
///     'What is Flutter?',
///     maxTokens: 150,
///   );
///   print(response);
/// } else {
///   print('Start Ollama server with: ollama serve');
/// }
/// ```
