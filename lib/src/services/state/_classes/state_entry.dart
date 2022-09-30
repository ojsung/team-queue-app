abstract class StateEntry<T, U extends Object> {
  T get value;
  set value(T newValue);
  String get key;

  /// Get the entry
  StateEntry<T, U> select();

  /// Update the value of the entry
  StateEntry<T, U> update({required U value});
}
