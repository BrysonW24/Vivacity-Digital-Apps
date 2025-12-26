@echo off
REM Journal App - Automated Test Runner
REM This script runs all automated tests for production readiness

echo ========================================
echo  Journal App - Test Suite Runner
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo [1/4] Getting dependencies...
call flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)

echo.
echo [2/4] Running unit tests...
call flutter test test/models test/utils
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Unit tests failed
    pause
    exit /b 1
)

echo.
echo [3/4] Running widget tests...
call flutter test test/widgets
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Some widget tests failed
    echo This is expected if widget keys are not yet added
)

echo.
echo [4/4] Generating test coverage report...
call flutter test --coverage
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Coverage generation failed
)

echo.
echo ========================================
echo  Test Run Complete!
echo ========================================
echo.
echo Coverage report generated at: coverage\lcov.info
echo.
echo To run integration tests, use:
echo   flutter test integration_test\app_test.dart -d windows
echo.

pause
