#!/bin/bash

###############################################################################
# Flutter Boilerplate Health Check Script
#
# Validates the boilerplate structure, configuration, and dependencies.
# Ensures the project follows established patterns and best practices.
#
# Usage:
#   ./scripts/health-check.sh              # Run all checks
#   ./scripts/health-check.sh --quick      # Run quick checks only
#   ./scripts/health-check.sh --verbose    # Run with detailed output
#
# Exit Codes:
#   0 - All checks passed
#   1 - One or more checks failed
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
VERBOSE=false
QUICK_MODE=false
FAILED_CHECKS=0
PASSED_CHECKS=0
WARNINGS=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose)
            VERBOSE=true
            shift
            ;;
        --quick)
            QUICK_MODE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Utility functions
print_header() {
    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  $1${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════════${NC}"
}

print_check() {
    echo -e "${BLUE}▸ $1${NC}"
}

print_success() {
    ((PASSED_CHECKS++))
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    ((FAILED_CHECKS++))
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    ((WARNINGS++))
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Get project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

###############################################################################
# Core Structure Checks
###############################################################################
check_structure() {
    print_header "Checking Project Structure"

    local required_dirs=(
        "lib"
        "lib/config"
        "lib/enums"
        "lib/services"
        "lib/repositories"
        "lib/providers"
        "lib/widgets"
        "lib/screens"
        "lib/models"
        "lib/utilities"
        ".boilerplate"
        "scripts"
        "assets"
    )

    for dir in "${required_dirs[@]}"; do
        print_check "Directory: $dir"
        if [ -d "$dir" ]; then
            print_success "Directory exists: $dir"
        else
            print_error "Missing directory: $dir"
        fi
    done
}

###############################################################################
# File Presence Checks
###############################################################################
check_required_files() {
    print_header "Checking Required Files"

    # Core Dart files
    local required_files=(
        "lib/main.dart"
        "lib/app.dart"
        "lib/injection.dart"
        "pubspec.yaml"
        "analysis_options.yaml"
        "flutter_launcher_icons.yaml"
        ".env.development"
        ".env.production"
        ".boilerplate/VERSION"
        ".boilerplate/CHANGELOG.md"
        ".boilerplate/UPGRADE_GUIDE.md"
    )

    for file in "${required_files[@]}"; do
        print_check "File: $file"
        if [ -f "$file" ]; then
            print_success "File exists: $file"
        else
            print_warning "Missing file: $file"
        fi
    done
}

###############################################################################
# Dart File Validation
###############################################################################
check_dart_imports() {
    print_header "Validating Dart Imports"

    # Check main.dart has required imports
    print_check "Validating main.dart imports"
    if grep -q "import 'app.dart'" lib/main.dart && \
       grep -q "import 'injection.dart'" lib/main.dart; then
        print_success "main.dart has required imports"
    else
        print_error "main.dart missing required imports"
    fi

    # Check app.dart has provider imports
    print_check "Validating app.dart imports"
    if grep -q "import 'package:provider/provider.dart'" lib/app.dart; then
        print_success "app.dart has provider imports"
    else
        print_error "app.dart missing provider imports"
    fi

    # Check injection.dart has GetIt import
    print_check "Validating injection.dart imports"
    if grep -q "import 'package:get_it/get_it.dart'" lib/injection.dart; then
        print_success "injection.dart has GetIt imports"
    else
        print_error "injection.dart missing GetIt imports"
    fi
}

###############################################################################
# Config File Validation
###############################################################################
check_config_files() {
    print_header "Checking Configuration Files"

    # Check pubspec.yaml exists
    print_check "Validating pubspec.yaml"
    if [ -f "pubspec.yaml" ]; then
        print_success "pubspec.yaml exists"

        # Validate YAML structure
        if grep -q "^name:" pubspec.yaml && grep -q "^version:" pubspec.yaml; then
            print_success "pubspec.yaml has required fields"
        else
            print_error "pubspec.yaml missing required fields (name, version)"
        fi

        # Check for critical dependencies
        local critical_deps=("flutter" "provider" "get_it" "dio")
        for dep in "${critical_deps[@]}"; do
            if grep -q "  $dep:" pubspec.yaml; then
                print_success "Dependency found: $dep"
            else
                print_warning "Critical dependency missing: $dep"
            fi
        done
    else
        print_error "pubspec.yaml not found"
    fi

    # Check environment variables
    print_check "Validating .env files"
    if [ -f ".env.development" ]; then
        print_success ".env.development exists"
    else
        print_warning ".env.development not found"
    fi

    if [ -f ".env.production" ]; then
        print_success ".env.production exists"
    else
        print_warning ".env.production not found"
    fi

    # Check analysis_options.yaml
    print_check "Validating analysis_options.yaml"
    if [ -f "analysis_options.yaml" ]; then
        print_success "analysis_options.yaml exists"
    else
        print_warning "analysis_options.yaml not found"
    fi
}

###############################################################################
# Version Check
###############################################################################
check_version() {
    print_header "Checking Boilerplate Version"

    if [ -f ".boilerplate/VERSION" ]; then
        local version=$(cat .boilerplate/VERSION | tr -d ' ')
        print_success "Version file exists: $version"

        # Validate semantic versioning format
        if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            print_success "Version follows semantic versioning: $version"
        else
            print_error "Invalid version format: $version (expected: X.Y.Z)"
        fi
    else
        print_error ".boilerplate/VERSION not found"
    fi
}

###############################################################################
# Pattern Compliance Checks
###############################################################################
check_patterns() {
    print_header "Validating Architecture Patterns"

    # Check for ChangeNotifier providers
    print_check "Looking for ChangeNotifier providers"
    local provider_count=$(find lib/providers -name "*.dart" -type f 2>/dev/null | wc -l)
    if [ "$provider_count" -gt 0 ]; then
        print_success "Found $provider_count provider files"
    else
        print_warning "No provider files found in lib/providers"
    fi

    # Check for repositories
    print_check "Looking for repository files"
    local repo_count=$(find lib/repositories -name "*.dart" -type f 2>/dev/null | wc -l)
    if [ "$repo_count" -gt 0 ]; then
        print_success "Found $repo_count repository files"
    else
        print_warning "No repository files found in lib/repositories"
    fi

    # Check for services
    print_check "Looking for service files"
    local service_count=$(find lib/services -name "*.dart" -type f 2>/dev/null | wc -l)
    if [ "$service_count" -gt 0 ]; then
        print_success "Found $service_count service files"
    else
        print_warning "No service files found in lib/services"
    fi

    # Check for screens
    print_check "Looking for screen files"
    local screen_count=$(find lib/screens -name "*.dart" -type f 2>/dev/null | wc -l)
    if [ "$screen_count" -gt 0 ]; then
        print_success "Found $screen_count screen files"
    else
        print_warning "No screen files found in lib/screens"
    fi

    # Check for widgets
    print_check "Looking for widget files"
    local widget_count=$(find lib/widgets -name "*.dart" -type f 2>/dev/null | wc -l)
    if [ "$widget_count" -gt 0 ]; then
        print_success "Found $widget_count widget files"
    else
        print_warning "No widget files found in lib/widgets"
    fi
}

###############################################################################
# Asset Checks
###############################################################################
check_assets() {
    print_header "Checking Assets"

    if [ -d "assets" ]; then
        print_success "Assets directory exists"

        local asset_count=$(find assets -type f 2>/dev/null | wc -l)
        if [ "$asset_count" -gt 0 ]; then
            print_success "Found $asset_count asset files"
        else
            print_info "No asset files found (this is optional)"
        fi
    else
        print_warning "Assets directory not found"
    fi
}

###############################################################################
# Flutter Environment Checks
###############################################################################
check_flutter_env() {
    print_header "Checking Flutter Environment"

    # Check Flutter is installed
    print_check "Flutter installation"
    if command -v flutter &> /dev/null; then
        local flutter_version=$(flutter --version | head -1)
        print_success "Flutter is installed: $flutter_version"
    else
        print_error "Flutter is not installed or not in PATH"
        return 1
    fi

    # Check Flutter doctor
    print_check "Running flutter doctor"
    if SKIP_DEVICES=true flutter doctor -v &> /dev/null; then
        print_success "Flutter doctor passed"
    else
        print_warning "Flutter doctor found issues (check with: flutter doctor)"
    fi

    # Check Dart is installed
    print_check "Dart installation"
    if command -v dart &> /dev/null; then
        local dart_version=$(dart --version)
        print_success "Dart is installed: $dart_version"
    else
        print_error "Dart is not installed"
        return 1
    fi
}

###############################################################################
# Code Analysis (if not quick mode)
###############################################################################
check_code_analysis() {
    if [ "$QUICK_MODE" = true ]; then
        return
    fi

    print_header "Running Code Analysis"

    print_check "Analyzing Dart code"
    if command -v flutter &> /dev/null; then
        if flutter analyze --no-congratulate 2>&1 | tee /tmp/analyze.log | grep -q "^No issues found"; then
            print_success "Code analysis passed"
        else
            # Extract issue count
            local issue_count=$(grep -c "^  " /tmp/analyze.log || echo "0")
            if [ "$issue_count" -eq 0 ]; then
                print_success "Code analysis passed"
            else
                print_warning "Code analysis found $issue_count issues"
                if [ "$VERBOSE" = true ]; then
                    cat /tmp/analyze.log
                fi
            fi
        fi
    else
        print_warning "Flutter not available for code analysis"
    fi
}

###############################################################################
# Dependency Checks
###############################################################################
check_dependencies() {
    print_header "Checking Dependencies"

    if [ ! -f "pubspec.yaml" ]; then
        print_error "pubspec.yaml not found"
        return 1
    fi

    print_check "Dependencies"
    if [ -d ".dart_tool" ] || [ -d "pubspec.lock" ]; then
        print_success "Dependencies appear to be installed"
    else
        print_warning "Dependencies may not be installed (.dart_tool or pubspec.lock not found)"
        print_info "Run: flutter pub get"
    fi
}

###############################################################################
# Summary Report
###############################################################################
print_summary() {
    print_header "Health Check Summary"

    local total=$((PASSED_CHECKS + FAILED_CHECKS))
    echo ""
    echo "Passed Checks:  ${GREEN}$PASSED_CHECKS${NC}"
    echo "Failed Checks:  ${RED}$FAILED_CHECKS${NC}"
    echo "Warnings:       ${YELLOW}$WARNINGS${NC}"
    echo "Total Checks:   $total"
    echo ""

    if [ "$FAILED_CHECKS" -eq 0 ]; then
        print_success "All critical checks passed!"
        if [ "$WARNINGS" -gt 0 ]; then
            print_warning "Review $WARNINGS warnings above"
        fi
        return 0
    else
        print_error "$FAILED_CHECKS critical checks failed"
        return 1
    fi
}

###############################################################################
# Main Execution
###############################################################################
main() {
    echo ""
    echo -e "${MAGENTA}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║  Flutter Boilerplate Health Check                      ║${NC}"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Project Root: $PROJECT_ROOT"
    if [ "$QUICK_MODE" = true ]; then
        echo "Mode: Quick (skipping detailed analysis)"
    fi
    if [ "$VERBOSE" = true ]; then
        echo "Verbose: Enabled"
    fi
    echo ""

    # Run checks
    check_structure
    check_required_files
    check_dart_imports
    check_config_files
    check_version
    check_patterns
    check_assets
    check_flutter_env
    check_dependencies
    check_code_analysis

    # Print summary
    print_summary
    EXIT_CODE=$?

    echo ""
    echo "For detailed help:"
    echo "  - Architecture: See docs/DECISIONS.md"
    echo "  - Upgrading: See .boilerplate/UPGRADE_GUIDE.md"
    echo "  - Generators: See .boilerplate/generators/flutter/generate.sh"
    echo ""

    return $EXIT_CODE
}

# Run main function
main
exit $?
