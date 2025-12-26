# LLM Embeddings & Local LLM Integration

This folder contains tools and libraries for integrating open-source LLMs (Large Language Models) into your Flutter applications.

## Overview

Local LLM integration enables your apps to:
- Run AI models on-device (no cloud dependency)
- Perform inference with privacy (data stays local)
- Support offline AI features
- Reduce latency and costs
- Comply with data residency requirements

## Directory Structure

```
llm_embeddings/
├── llama_cpp/                          # Llama.cpp integration (fastest)
├── ollama/                             # Ollama API client
├── mistral/                            # Mistral model integration
├── local_embeddings/                   # Embedding generation
├── vector_db/                          # Vector database integrations
├── rag_toolkit/                        # Retrieval Augmented Generation
├── quantization/                       # Model quantization tools
├── utils/                              # Common utilities
└── README.md                           # This file
```

## Supported Models

### Small Models (Mobile-Friendly)
| Model | Size | Quantization | Speed | Memory |
|-------|------|--------------|-------|--------|
| **TinyLlama** | 1.1B | 4-bit | Fastest | ~512MB |
| **Phi-2** | 2.7B | 4-bit | Very Fast | ~1.5GB |
| **Mistral-7B** | 7B | 4-bit | Fast | ~4GB |
| **Llama 2 7B** | 7B | 4-bit | Fast | ~4GB |

### Best Practices by Use Case
- **Chat/Conversational:** Mistral-7B, Llama 2 7B
- **Code Generation:** CodeLlama 7B
- **Text Summarization:** TinyLlama, Phi-2
- **Q&A (RAG):** Mistral-7B, Llama 2
- **Embeddings:** Sentence-Transformers (110M model)

## Quick Start

### 1. Using Ollama (Easiest - Server-Based)

**Setup Ollama on development machine:**
```bash
# Install Ollama from https://ollama.ai
ollama serve

# In another terminal, pull a model
ollama pull mistral:7b-instruct
```

**Use in Flutter:**
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class OllamaClient {
  static const String baseUrl = 'http://localhost:11434/api';

  static Future<String> generateText(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': 'mistral:7b-instruct',
        'prompt': prompt,
        'stream': false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'];
    }
    throw Exception('Failed to generate text');
  }
}

// Usage
final text = await OllamaClient.generateText('What is Flutter?');
print(text);
```

### 2. Using Llama.cpp (Fastest - On-Device)

**Add to pubspec.yaml:**
```yaml
dependencies:
  flutter_llama_cpp: ^0.1.0
  # or use plain Dart/native bindings
```

**Use in code:**
```dart
import 'package:flutter_llama_cpp/flutter_llama_cpp.dart';

class LocalLLM {
  late FlutterLlamaCpp llamaCpp;

  Future<void> initialize() async {
    llamaCpp = FlutterLlamaCpp();
    // Load model from assets or downloads
    await llamaCpp.loadModel(
      modelPath: 'assets/models/mistral-7b-q4_k_m.gguf',
      gpuLayers: 20, // Enable GPU acceleration if available
    );
  }

  Future<String> generate(String prompt) async {
    return await llamaCpp.generate(
      prompt: prompt,
      maxTokens: 256,
      temperature: 0.7,
    );
  }
}
```

### 3. Integration with Your Apps

**Example: Add AI chat to FitCoach Pro**
```dart
// lib/services/ai_coach_service.dart
class AiCoachService {
  late OllamaClient ollama;

  Future<String> getWorkoutAdvice(String userQuery) async {
    final prompt = '''You are a professional fitness coach.
User: $userQuery
Provide specific, actionable advice.''';

    return await ollama.generateText(prompt);
  }
}
```

## Model Download & Management

### Automated Model Download

```dart
class ModelManager {
  static const String modelsDir = 'models';

  // Download quantized model from HuggingFace
  static Future<void> downloadModel(String modelName) async {
    final url = 'https://huggingface.co/api/models/$modelName/resolve/main/model.gguf';
    // Download and save to app storage
  }

  // Check if model exists locally
  static Future<bool> isModelAvailable(String modelName) async {
    final file = File('$modelsDir/$modelName.gguf');
    return await file.exists();
  }
}
```

### Model Storage Optimization

```dart
// Small models (<2GB) can be included in app
// Large models should be downloaded on first run
class SmartModelLoader {
  Future<void> loadModel(String name) async {
    if (await ModelManager.isModelAvailable(name)) {
      // Load from local storage
      return;
    }

    // Download from internet
    await ModelManager.downloadModel(name);
  }
}
```

## Vector Embeddings & RAG

### Generate Embeddings

```dart
import '../../llm_embeddings/llm_embeddings/local_embeddings/embedding_service.dart';

class DocumentEmbedder {
  late EmbeddingService embedder;

  Future<void> initialize() async {
    embedder = EmbeddingService();
    // Using distilbert-base-uncased (110M - very small)
    await embedder.loadModel('sentence-transformers/distilbert-base-uncased');
  }

  Future<List<double>> embedText(String text) async {
    return await embedder.embed(text);
  }
}
```

### RAG (Retrieval Augmented Generation)

```dart
import '../../llm_embeddings/llm_embeddings/rag_toolkit/rag_engine.dart';

class SmartAssistant {
  late RAGEngine ragEngine;

  Future<void> setupRAG(List<String> documents) async {
    ragEngine = RAGEngine();

    // Add documents to vector database
    for (final doc in documents) {
      final embedding = await embedder.embedText(doc);
      await ragEngine.addDocument(doc, embedding);
    }
  }

  Future<String> answerQuestion(String question) async {
    // Find relevant documents
    final relevant = await ragEngine.retrieve(question, topK: 3);

    // Use LLM with relevant context
    final prompt = '''Context:
${relevant.join('\n')}

Question: $question

Answer:''';

    return await ollama.generateText(prompt);
  }
}
```

## Performance Optimization

### Memory Management

```dart
class OptimizedLLM {
  // Use 4-bit quantization for 75% smaller models
  static const String quantization = 'q4_k_m';

  // Reduce context window for faster inference
  static const int maxContextLength = 512;

  // Batch multiple prompts for efficiency
  static Future<List<String>> batchGenerate(List<String> prompts) async {
    return Future.wait([
      for (final prompt in prompts) generate(prompt)
    ]);
  }
}
```

### Caching & Optimization

```dart
class CachedLLM {
  final Map<String, String> responseCache = {};

  Future<String> generateCached(String prompt) async {
    if (responseCache.containsKey(prompt)) {
      return responseCache[prompt]!;
    }

    final response = await generate(prompt);
    responseCache[prompt] = response;
    return response;
  }

  // Clear cache when needed
  void clearCache() => responseCache.clear();
}
```

## Integration Examples

### FitCoach Pro: AI Personal Trainer

```dart
// Provide workout recommendations
final advice = await aiCoach.getWorkoutAdvice(
  'I want to build muscle in my arms'
);

// Generate meal plans
final mealPlan = await aiCoach.generateMealPlan(
  'Vegetarian, 2000 calories'
);
```

### TaskFlow: AI Project Assistant

```dart
// Auto-generate task descriptions
final taskDescription = await aiAssistant.generateTask(
  'Implement user authentication'
);

// Estimate effort
final effort = await aiAssistant.estimateEffort(taskDescription);
```

### RecipeBank: Smart Recipe Finder

```dart
// Find recipes from ingredients
final recipes = await recipeAI.findRecipes([
  'chicken', 'garlic', 'olive oil'
]);

// Generate shopping list
final list = await recipeAI.generateShoppingList(selectedRecipes);
```

## Troubleshooting

### Model Too Large

**Problem:** Model doesn't fit on device
**Solution:** Use quantization (4-bit instead of FP32)
```bash
# Using ollama
ollama pull mistral:7b  # Already quantized
```

### Slow Inference

**Problem:** Generation takes >5 seconds
**Solutions:**
1. Reduce `maxTokens` parameter
2. Increase `temperature` (0.3-0.5 for faster)
3. Use GPU acceleration
4. Switch to smaller model

### Memory Leaks

**Problem:** App crashes after multiple generations
**Solutions:**
```dart
// Properly cleanup resources
class SafeLLM {
  Future<void> dispose() async {
    await llamaCpp.unloadModel();
  }

  // Use try-finally
  Future<String> safeGenerate(String prompt) async {
    try {
      return await generate(prompt);
    } finally {
      // Clear intermediate buffers if needed
    }
  }
}
```

## Best Practices

✅ **Do:**
- Use quantized models (q4 or q5)
- Start with small models (7B or smaller)
- Test on actual device hardware
- Implement caching for common requests
- Handle offline scenarios gracefully
- Set reasonable token limits

❌ **Don't:**
- Use FP32 models on mobile (too large)
- Run inference on main thread
- Load multiple large models simultaneously
- Ignore memory constraints
- Skip error handling
- Hardcode model paths

## Resources

### Model Sources
- [Hugging Face](https://huggingface.co/models?sort=downloads) - 100K+ models
- [TheBloke](https://huggingface.co/TheBloke) - Optimized quantized models
- [Ollama Library](https://ollama.ai/library) - Pre-configured models

### Libraries & Tools
- [Ollama](https://ollama.ai) - Easy local LLM server
- [Llama.cpp](https://github.com/ggerganov/llama.cpp) - Fastest inference
- [Sentence-Transformers](https://www.sbert.net/) - Embeddings
- [Milvus](https://milvus.io/) - Vector database

### Documentation
- [LLM Documentation Index](./docs/index.md)
- [Ollama Integration Guide](./ollama/README.md)
- [Llama.cpp Setup](./llama_cpp/README.md)
- [RAG Implementation Guide](./rag_toolkit/README.md)

## Next Steps

1. **For Development:**
   - Install Ollama
   - Pull a test model
   - Try integration with test app

2. **For Production:**
   - Choose appropriate quantized model
   - Implement caching layer
   - Add error handling
   - Test on target devices
   - Set up monitoring

3. **For Your Projects:**
   - FitCoach Pro: AI workout & nutrition recommendations
   - TaskFlow: AI task generation & estimates
   - RecipeBank: Smart recipe search & meal planning

---

**Last Updated:** November 30, 2025
**Status:** Ready for Integration
