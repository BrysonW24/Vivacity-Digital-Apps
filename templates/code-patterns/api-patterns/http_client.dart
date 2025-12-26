import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Basic HTTP Client Template for Flutter Apps
/// This template provides a simple HTTP client using Dart's built-in HttpClient
/// Suitable for basic REST API calls without external dependencies

class HttpClientService {
  static const String _baseUrl = 'https://api.example.com'; // Replace with your API base URL
  static const Duration _connectTimeout = Duration(seconds: 30);
  static const Duration _receiveTimeout = Duration(seconds: 30);

  final HttpClient _httpClient = HttpClient();

  HttpClientService() {
    _httpClient.connectionTimeout = _connectTimeout;
    _httpClient.idleTimeout = _receiveTimeout;
  }

  // Generic GET request
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    try {
