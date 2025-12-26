import 'package:flutter/material.dart';
import '../../config/app_sizes.dart';
import '../../services/logger_service.dart';

/// Search Screen
///
/// Allows users to search content in the app.
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    LoggerService.info('SearchScreen: Initialized');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    LoggerService.info('SearchScreen: Searching for "$query"');
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        // TODO: Implement actual search logic
        _searchResults = ['Result 1', 'Result 2', 'Result 3'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.spacing16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _handleSearch('');
                  },
                )
                    : null,
              ),
              onChanged: _handleSearch,
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
              child: Text(
                'No results',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(_searchResults[index]),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
