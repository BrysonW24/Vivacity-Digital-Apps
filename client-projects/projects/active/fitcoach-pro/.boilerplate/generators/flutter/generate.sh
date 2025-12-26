#!/bin/bash

###############################################################################
# Flutter Boilerplate Code Generator
#
# This script automates the creation of Flutter files following established
# patterns and architecture guidelines. It scaffolds screens, providers,
# services, repositories, models, and widgets while maintaining consistency
# with the boilerplate structure.
#
# Usage:
#   ./generate.sh screen <ScreenName>
#   ./generate.sh provider <ProviderName>
#   ./generate.sh service <ServiceName>
#   ./generate.sh repository <RepositoryName>
#   ./generate.sh model <ModelName>
#   ./generate.sh widget <WidgetName>
#
# Examples:
#   ./generate.sh screen HomeScreen
#   ./generate.sh provider UserProvider
#   ./generate.sh service AnalyticsService
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Utility functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Convert PascalCase to snake_case
to_snake_case() {
    echo "$1" | sed 's/\([A-Z]\)/_\1/g' | sed 's/^_//' | tr '[:upper:]' '[:lower:]'
}

# Get the lib directory
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../lib" && pwd)"

if [ ! -d "$LIB_DIR" ]; then
    print_error "Could not find lib directory at $LIB_DIR"
    exit 1
fi

###############################################################################
# Screen Generator
###############################################################################
generate_screen() {
    local screen_name=$1
    local snake_name=$(to_snake_case "$screen_name")
    local screen_dir="${LIB_DIR}/screens/${snake_name}"
    local file_path="${screen_dir}/${snake_name}.dart"

    if [ -d "$screen_dir" ]; then
        print_error "Screen directory already exists: $screen_dir"
        return 1
    fi

    mkdir -p "$screen_dir"

    # Create main screen file
    cat > "$file_path" << 'EOF'
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../config/app_sizes.dart';

/// [SCREEN_NAME_PLACEHOLDER] Screen
///
/// Displays [description].
///
/// State Management: Uses Provider for state management
/// Related Providers: [RELATED_PROVIDERS_PLACEHOLDER]
class [SCREEN_NAME_PLACEHOLDER] extends StatefulWidget {
  const [SCREEN_NAME_PLACEHOLDER]({Key? key}) : super(key: key);

  @override
  State<[SCREEN_NAME_PLACEHOLDER]> createState() => _[SCREEN_NAME_PLACEHOLDER]State();
}

class _[SCREEN_NAME_PLACEHOLDER]State extends State<[SCREEN_NAME_PLACEHOLDER]> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Initialize screen data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('[SCREEN_NAME_PLACEHOLDER]'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spacing16),
          child: Consumer<AppStateProvider>(
            builder: (context, appState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: Add screen content here
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
EOF

    # Replace placeholder
    sed -i "s/\[SCREEN_NAME_PLACEHOLDER\]/${screen_name}/g" "$file_path"

    print_success "Screen created: $file_path"
    print_info "Next steps:"
    print_info "1. Update the screen description in the class docstring"
    print_info "2. Add related providers to the docstring"
    print_info "3. Implement screen content in the build method"
    print_info "4. Add route in lib/config/routes.dart"
}

###############################################################################
# Provider Generator
###############################################################################
generate_provider() {
    local provider_name=$1
    local snake_name=$(to_snake_case "$provider_name")
    local file_path="${LIB_DIR}/providers/${snake_name}.dart"

    if [ -f "$file_path" ]; then
        print_error "Provider file already exists: $file_path"
        return 1
    fi

    cat > "$file_path" << 'EOF'
import 'package:flutter/foundation.dart';
import '../services/logger_service.dart';

/// [PROVIDER_NAME_PLACEHOLDER] Provider
///
/// Manages [description].
///
/// State: [STATE_DESCRIPTION_PLACEHOLDER]
///
/// Usage:
/// ```dart
/// final provider = context.read<[PROVIDER_NAME_PLACEHOLDER]>();
/// final state = context.watch<[PROVIDER_NAME_PLACEHOLDER]>();
/// ```
class [PROVIDER_NAME_PLACEHOLDER] extends ChangeNotifier {
  // State variables
  // TODO: Define state variables here

  // Getters
  // TODO: Add state getters here

  // Methods

  /// Initialize provider state
  Future<void> initialize() async {
    try {
      LoggerService.info('[PROVIDER_NAME_PLACEHOLDER]: Initializing');
      // TODO: Add initialization logic
      notifyListeners();
    } catch (e) {
      LoggerService.error('[PROVIDER_NAME_PLACEHOLDER]: Initialization failed', error: e);
      rethrow;
    }
  }

  /// Reset provider state
  void reset() {
    // TODO: Reset state variables
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: Clean up resources
    super.dispose();
  }
}
EOF

    # Replace placeholder
    sed -i "s/\[PROVIDER_NAME_PLACEHOLDER\]/${provider_name}/g" "$file_path"

    print_success "Provider created: $file_path"
    print_info "Next steps:"
    print_info "1. Define state variables in the class"
    print_info "2. Add getters for state access"
    print_info "3. Implement provider logic methods"
    print_info "4. Register provider in lib/app.dart MultiProvider list"
}

###############################################################################
# Service Generator
###############################################################################
generate_service() {
    local service_name=$1
    local snake_name=$(to_snake_case "$service_name")
    local file_path="${LIB_DIR}/services/${snake_name}.dart"

    if [ -f "$file_path" ]; then
        print_error "Service file already exists: $file_path"
        return 1
    fi

    cat > "$file_path" << 'EOF'
import '../services/logger_service.dart';

/// [SERVICE_NAME_PLACEHOLDER] Service
///
/// Handles [description].
///
/// Responsibilities:
/// - TODO: Add responsibility 1
/// - TODO: Add responsibility 2
///
/// Dependencies: None (unless specified)
///
/// Usage:
/// ```dart
/// final service = getIt<[SERVICE_NAME_PLACEHOLDER]>();
/// ```
class [SERVICE_NAME_PLACEHOLDER] {
  // TODO: Add private fields for dependencies if needed

  // Constructor
  [SERVICE_NAME_PLACEHOLDER]();

  /// Initialize service
  Future<void> initialize() async {
    try {
      LoggerService.info('[SERVICE_NAME_PLACEHOLDER]: Initializing');
      // TODO: Add initialization logic
    } catch (e) {
      LoggerService.error('[SERVICE_NAME_PLACEHOLDER]: Initialization failed', error: e);
      rethrow;
    }
  }

  /// Dispose service resources
  Future<void> dispose() async {
    try {
      LoggerService.info('[SERVICE_NAME_PLACEHOLDER]: Disposing');
      // TODO: Add cleanup logic
    } catch (e) {
      LoggerService.error('[SERVICE_NAME_PLACEHOLDER]: Dispose failed', error: e);
    }
  }

  // TODO: Add service methods here
}
EOF

    # Replace placeholder
    sed -i "s/\[SERVICE_NAME_PLACEHOLDER\]/${service_name}/g" "$file_path"

    print_success "Service created: $file_path"
    print_info "Next steps:"
    print_info "1. Add service responsibilities in docstring"
    print_info "2. Implement initialization logic"
    print_info "3. Add service methods"
    print_info "4. Register in lib/injection.dart if it's a singleton"
}

###############################################################################
# Repository Generator
###############################################################################
generate_repository() {
    local repo_name=$1
    local snake_name=$(to_snake_case "$repo_name")
    local file_path="${LIB_DIR}/repositories/${snake_name}.dart"

    if [ -f "$file_path" ]; then
        print_error "Repository file already exists: $file_path"
        return 1
    fi

    cat > "$file_path" << 'EOF'
import '../services/api/api_client.dart';
import '../services/logger_service.dart';

/// [REPO_NAME_PLACEHOLDER] Repository
///
/// Handles data operations for [description].
/// Abstracts API and local storage operations.
///
/// Dependencies:
/// - ApiClient: For API communication
///
/// Usage:
/// ```dart
/// final repo = getIt<[REPO_NAME_PLACEHOLDER]>();
/// ```
class [REPO_NAME_PLACEHOLDER] {
  final ApiClient _apiClient;

  [REPO_NAME_PLACEHOLDER]({required ApiClient apiClient})
      : _apiClient = apiClient;

  // TODO: Add repository methods here
  // Example pattern:
  //
  // Future<List<Item>> fetchItems() async {
  //   try {
  //     final response = await _apiClient.get('/endpoint');
  //     final items = (response.data as List)
  //         .map((item) => Item.fromJson(item))
  //         .toList();
  //     LoggerService.info('[REPO_NAME_PLACEHOLDER]: Fetched ${items.length} items');
  //     return items;
  //   } catch (e) {
  //     LoggerService.error('[REPO_NAME_PLACEHOLDER]: Fetch failed', error: e);
  //     rethrow;
  //   }
  // }
}
EOF

    # Replace placeholder
    sed -i "s/\[REPO_NAME_PLACEHOLDER\]/${repo_name}/g" "$file_path"

    print_success "Repository created: $file_path"
    print_info "Next steps:"
    print_info "1. Add repository methods following the example pattern"
    print_info "2. Create corresponding Model file if needed"
    print_info "3. Register in lib/injection.dart"
    print_info "4. Use in providers or services"
}

###############################################################################
# Model Generator
###############################################################################
generate_model() {
    local model_name=$1
    local snake_name=$(to_snake_case "$model_name")
    local file_path="${LIB_DIR}/models/${snake_name}.dart"

    if [ -f "$file_path" ]; then
        print_error "Model file already exists: $file_path"
        return 1
    fi

    cat > "$file_path" << 'EOF'
import 'package:freezed_annotation/freezed_annotation.dart';

part '[SNAKE_NAME_PLACEHOLDER].freezed.dart';
part '[SNAKE_NAME_PLACEHOLDER].g.dart';

/// [MODEL_NAME_PLACEHOLDER] Model
///
/// Represents [description].
///
/// Generated using freezed for immutability and JSON serialization.
/// Run: flutter pub run build_runner build
@freezed
class [MODEL_NAME_PLACEHOLDER] with _\$[MODEL_NAME_PLACEHOLDER] {
  const factory [MODEL_NAME_PLACEHOLDER]({
    // TODO: Add fields here
    // Example: @JsonKey(name: 'id') required String id,
  }) = _[MODEL_NAME_PLACEHOLDER];

  factory [MODEL_NAME_PLACEHOLDER].fromJson(Map<String, dynamic> json) =>
      _\$[MODEL_NAME_PLACEHOLDER]FromJson(json);
}
EOF

    # Replace placeholders
    sed -i "s/\[MODEL_NAME_PLACEHOLDER\]/${model_name}/g" "$file_path"
    sed -i "s/\[SNAKE_NAME_PLACEHOLDER\]/${snake_name}/g" "$file_path"

    print_success "Model created: $file_path"
    print_warning "Model uses freezed - you must run: flutter pub run build_runner build"
    print_info "Next steps:"
    print_info "1. Add model fields in the factory constructor"
    print_info "2. Add @JsonKey annotations if field names differ from JSON"
    print_info "3. Run: flutter pub run build_runner build"
}

###############################################################################
# Widget Generator
###############################################################################
generate_widget() {
    local widget_name=$1
    local snake_name=$(to_snake_case "$widget_name")
    local file_path="${LIB_DIR}/widgets/${snake_name}.dart"

    if [ -f "$file_path" ]; then
        print_error "Widget file already exists: $file_path"
        return 1
    fi

    cat > "$file_path" << 'EOF'
import 'package:flutter/material.dart';

/// [WIDGET_NAME_PLACEHOLDER] Widget
///
/// A [description].
///
/// Parameters:
/// - TODO: Add parameter descriptions
///
/// Usage:
/// ```dart
/// [WIDGET_NAME_PLACEHOLDER](
///   // TODO: Add parameters
/// )
/// ```
class [WIDGET_NAME_PLACEHOLDER] extends StatelessWidget {
  // TODO: Add widget parameters here
  // Example: final String title;

  const [WIDGET_NAME_PLACEHOLDER]({
    Key? key,
    // TODO: Add required parameters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: Add widget implementation
      child: const Center(
        child: Text('[WIDGET_NAME_PLACEHOLDER]'),
      ),
    );
  }
}
EOF

    # Replace placeholder
    sed -i "s/\[WIDGET_NAME_PLACEHOLDER\]/${widget_name}/g" "$file_path"

    print_success "Widget created: $file_path"
    print_info "Next steps:"
    print_info "1. Add widget parameters as class fields"
    print_info "2. Add parameters to constructor"
    print_info "3. Implement widget UI in build method"
}

###############################################################################
# Main Command Handler
###############################################################################
main() {
    if [ $# -lt 2 ]; then
        print_error "Invalid arguments"
        echo ""
        echo "Usage: ./generate.sh <type> <name>"
        echo ""
        echo "Types:"
        echo "  screen      - Generate a new screen"
        echo "  provider    - Generate a new provider"
        echo "  service     - Generate a new service"
        echo "  repository  - Generate a new repository"
        echo "  model       - Generate a new model"
        echo "  widget      - Generate a new widget"
        echo ""
        echo "Examples:"
        echo "  ./generate.sh screen HomeScreen"
        echo "  ./generate.sh provider UserProvider"
        echo "  ./generate.sh service AnalyticsService"
        echo "  ./generate.sh repository UserRepository"
        echo "  ./generate.sh model User"
        echo "  ./generate.sh widget CustomButton"
        exit 1
    fi

    local type=$1
    local name=$2

    print_info "Generating ${type} '${name}'..."

    case $type in
        screen)
            generate_screen "$name"
            ;;
        provider)
            generate_provider "$name"
            ;;
        service)
            generate_service "$name"
            ;;
        repository)
            generate_repository "$name"
            ;;
        model)
            generate_model "$name"
            ;;
        widget)
            generate_widget "$name"
            ;;
        *)
            print_error "Unknown type: $type"
            echo "Valid types: screen, provider, service, repository, model, widget"
            exit 1
            ;;
    esac
}

main "$@"
