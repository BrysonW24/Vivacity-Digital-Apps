# Ollama Integration Guide

## What is Ollama?

Ollama is the easiest way to run LLMs locally. It's a simple command-line tool that runs LLM models on your development machine or server.

## Installation

### macOS
```bash
# Download from https://ollama.ai
# Or use Homebrew
brew install ollama
```

### Linux
```bash
curl https://ollama.ai/install.sh | sh
```

### Windows
Download from https://ollama.ai/download

## Quick Start

### 1. Start Ollama Server
```bash
ollama serve
# Server runs on http://localhost:11434
```

### 2. Pull a Model (in another terminal)
```bash
# Small, fast model (good for development)
ollama pull mistral:7b-instruct

# Or other popular models
ollama pull llama2:7b
ollama pull neural-chat:7b
ollama pull nomic-embed-text:latest  # For embeddings
```

### 3. Use in Flutter

Add to `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
  uuid: ^4.1.0
```

Copy `ollama_client.dart` to your project and use:

```dart
import '../../../llm_embeddings/ollama/services/llm/ollama_client.dart';

// Initialize
final ollama = OllamaClient(
  baseUrl: 'http://localhost:11434/api',
  defaultModel: 'mistral:7b-instruct',
);

// Generate text
final response = await ollama.generate(
  'What is Flutter?',
  maxTokens: 200,
);
print(response);

// Stream response (real-time)
ollama.generateStream('What is AI?').listen((chunk) {
  print(chunk); // Print as it arrives
});

// Generate embeddings
final embedding = await ollama.embed('Some text');
```

## Available Models

### Recommended Models

| Model | Size | Speed | Quality | Use Case |
|-------|------|-------|---------|----------|
| mistral:7b-instruct | 4.1GB | Fast | Good | General purpose chat |
| neural-chat:7b | 4.7GB | Fast | Good | Friendly, conversational |
| llama2:7b | 3.8GB | Fast | Good | Code, Q&A |
| orca-mini:3b | 1.9GB | Very Fast | Fair | Quick responses |
| nomic-embed-text | 274MB | Very Fast | Good | Embeddings |

### Pull Models
```bash
ollama pull mistral:7b-instruct
ollama pull neural-chat:7b
ollama pull llama2:7b
ollama pull orca-mini:3b
ollama pull nomic-embed-text:latest
```

### List Available Models
```bash
ollama list
```

### Remove Model
```bash
ollama rm mistral:7b-instruct
```

## Usage Examples

### Basic Text Generation
```dart
final client = OllamaClient();

final text = await client.generate(
  'Explain quantum computing in simple terms',
  maxTokens: 300,
  temperature: 0.7,
);
print(text);
```

### Streaming (Real-time Output)
```dart
// Show response as it's generated
client.generateStream(
  'Write a short story about a robot',
  maxTokens: 500,
).listen(
  (chunk) => print(chunk), // Print chunks as received
  onError: (error) => print('Error: $error'),
  onDone: () => print('Done'),
);
```

### Code Generation
```dart
final code = await client.generate(
  '''Generate a Dart function that:
- Takes two numbers as parameters
- Returns their greatest common divisor
- Includes comments explaining the algorithm''',
  model: 'llama2:7b',
  maxTokens: 300,
);
print(code);
```

### Question Answering with Context
```dart
final prompt = '''Context: Flutter is an open-source mobile application framework
created by Google. It uses Dart programming language.

Question: What language does Flutter use?
Answer:''';

final answer = await client.generate(prompt);
print(answer);
```

### Embeddings (Vector Representation)
```dart
// Generate embeddings for semantic search
final embedding1 = await client.embed('The cat sat on the mat');
final embedding2 = await client.embed('A feline was resting');

// Calculate similarity (cosine distance)
double similarity = calculateCosineSimilarity(embedding1, embedding2);
print('Similarity: $similarity'); // High score = similar meaning
```

## Integration with Flutter Apps

### FitCoach Pro Example
```dart
class AiCoachService {
  late OllamaClient ollama;

  Future<void> initialize() async {
    ollama = OllamaClient(
      defaultModel: 'neural-chat:7b', // Friendly model
    );

    if (!await ollama.isServerAvailable()) {
      throw Exception('Start Ollama server: ollama serve');
    }
  }

  Future<String> getWorkoutAdvice(String goal) async {
    return await ollama.generate(
      'As a fitness coach, provide a personalized workout recommendation for: $goal',
      maxTokens: 300,
      temperature: 0.8, // More creative
    );
  }

  Future<String> generateMealPlan(String preferences) async {
    return await ollama.generate(
      'Create a healthy meal plan for: $preferences',
      maxTokens: 400,
    );
  }
}
```

### TaskFlow Example
```dart
class TaskAssistant {
  late OllamaClient ollama;

  Future<String> generateTaskDescription(String shortDescription) async {
    return await ollama.generate(
      'Expand this task description with specific requirements and acceptance criteria: $shortDescription',
      maxTokens: 200,
    );
  }

  Future<String> estimateTaskEffort(String description) async {
    return await ollama.generate(
      'Estimate effort level (1-5 days) for: $description. Be concise.',
      maxTokens: 50,
    );
  }
}
```

## Performance Tuning

### Temperature (Creativity)
```dart
// Lower = more focused, deterministic
await client.generate(prompt, temperature: 0.1); // Very focused

// Higher = more creative, diverse
await client.generate(prompt, temperature: 1.0); // Very creative
```

### Token Limit
```dart
// Fewer tokens = faster response
await client.generate(prompt, maxTokens: 100); // Quick answer

// More tokens = detailed response
await client.generate(prompt, maxTokens: 1000); // Detailed answer
```

### Model Selection
```dart
// Fast responses
await client.generate(prompt, model: 'orca-mini:3b');

// Better quality
await client.generate(prompt, model: 'mistral:7b-instruct');
```

## Troubleshooting

### "Connection refused" Error
```
Error: Failed to generate text: Connection refused
```
**Solution:** Start Ollama server
```bash
ollama serve
```

### "Model not found" Error
```
Error: Ollama error: 404 - model not found
```
**Solution:** Pull the model first
```bash
ollama pull mistral:7b-instruct
```

### Slow Response Time
**Solutions:**
1. Use smaller model: `orca-mini:3b`
2. Reduce maxTokens
3. Increase temperature (faster but less focused)
4. Check if other processes are using CPU

### High Memory Usage
**Solutions:**
1. Use quantized models (default in ollama)
2. Switch to smaller model
3. Increase system swap space

### Model Takes Too Long to Load
**Solution:** Keep model in memory
```bash
# Ollama automatically manages model loading
# Models stay loaded for 5 minutes of inactivity
# Force unload with: ollama rm model-name
```

## Best Practices

✅ **Do:**
- Handle errors gracefully (server might not be running)
- Set reasonable timeouts
- Cache embeddings for repeated text
- Use streaming for long responses
- Test models on target device

❌ **Don't:**
- Call generate on main thread (use async)
- Keep multiple large models loaded
- Expose API keys in code
- Ignore error responses
- Hardcode model names (use constants)

## Advanced: Running Ollama on Server

### Docker Setup (for production)
```dockerfile
FROM ollama/ollama:latest

RUN ollama pull mistral:7b-instruct
RUN ollama pull nomic-embed-text:latest

EXPOSE 11434
CMD ["ollama", "serve"]
```

### Run Container
```bash
docker run -d \
  --name ollama-server \
  -p 11434:11434 \
  ollama/ollama:latest

# Pull models
docker exec ollama-server ollama pull mistral:7b-instruct
```

## Resources

- [Ollama Official Site](https://ollama.ai)
- [Ollama GitHub](https://github.com/jmorganca/ollama)
- [Available Models](https://ollama.ai/library)
- [API Documentation](https://github.com/jmorganca/ollama/blob/main/docs/api.md)
