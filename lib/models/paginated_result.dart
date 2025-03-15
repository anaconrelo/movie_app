

import 'package:movieapp/utils/typedefs.dart';

class PaginatedResult {
  final int count;
  final String? previous;
  final String? next;
  final List<JsonMap> results;

  const PaginatedResult({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'previous': previous,
      'next': next,
      'results': results,
    };
  }

  factory PaginatedResult.fromMap(Map<String, dynamic> map) {
    return PaginatedResult(
      count: map['count'] as int,
      previous: map['previous'] as String?,
      next: map['next'] as String?,
      results: (map['results'] as List).cast<JsonMap>(),
    );
  }

  factory PaginatedResult.fromList(List<JsonMap> list) {
    return PaginatedResult(
      count: list.length,
      previous: null,
      next: null,
      results: list,
    );
  }
}
