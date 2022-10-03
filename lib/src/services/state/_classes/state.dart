abstract class ModelState<T, U extends Object> {
  /// Retrieve current state
  Future<Map<String, T>> getState();

  /// Replace current state with new state - will not send update to listeners
  Future<void> setState({required Map<String, T> newState});

  /// Update many entries with new values.  Returns the list of entries updated.
  Future<List<T>> update({required List<U> updates});

  /// Retrieve entries by key
  Future<List<T>> select({required List<String> keys});

  /// Add an entry, then notify listeners. Returns the entry
  /// Does nothing if an entry with a matching id exists
  Future<List<T>> insert({required List<T> values});

  // Delete values by key.  Returns a list of keys that were not successfully deleted
  Future<List<String>> delete({required List<String> keys});

  // Update if entries exist, otherwise create.  Returns the entries when done
  Future<List<T>> upsert({required List<T> values});
}
