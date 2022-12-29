/// List of names recently searched
/// for in places search page.
class SearchHistory extends Iterable<String> {
  final List<String> _history;

  @override
  Iterator<String> get iterator => _history.iterator;

  /// Constructor for [SearchHistory].
  /// Giving preliminary history is optional.
  SearchHistory([List<String>? history]) : _history = history ?? [];

  /// Adds new search query (at the top of the list).
  void add(String searchString) => _history.insert(0, searchString);

  /// Removes search query at given index.
  void remove(int index) => _history.removeAt(index);
}
