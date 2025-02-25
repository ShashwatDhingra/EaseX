extension EaseXList<T> on List<T> {
  /// Returns the element at [index] or null if the index is out of range.
  T? safeGet(int index) => (index >= 0 && index < length) ? this[index] : null;
    



  /// Removes duplicate elements from the list.
  List<T> removeDuplicates() => toSet().toList();

  /// Splits the list into chunks of the given [size].
  List<List<T>> chunk(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Sorts a list based on a given property.
  List<T> sortBy<R extends Comparable<R>>(R Function(T item) selector, {bool ascending = true}) {
    List<T> sortedList = List<T>.from(this);
    sortedList.sort((a, b) => ascending 
        ? selector(a).compareTo(selector(b)) 
        : selector(b).compareTo(selector(a)));
    return sortedList;
  }

  /// Converts a list into a map using a key selector.
  Map<K, T> toMap<K>(K Function(T item) keySelector) => {for (var item in this) keySelector(item): item};
}

// /// use case

//   List<int> numbers = [1, 2, 3, 4, 5];

//   // Safe Access
//   print(numbers.safeGet(2));  // Output: 3
//   print(numbers.safeGet(10)); // Output: null

//   // Remove Duplicates
//   List<int> duplicateNumbers = [1, 2, 2, 3, 4, 4, 5];
//   print(duplicateNumbers.removeDuplicates()); // Output: [1, 2, 3, 4, 5]

//   // Chunk List
//   print(numbers.chunk(2));  // Output: [[1, 2], [3, 4], [5]]

//   // Sort By Property
//   List<Map<String, dynamic>> users = [
//     {'name': 'Alice', 'age': 30},
//     {'name': 'Bob', 'age': 25},
//     {'name': 'Charlie', 'age': 35}
//   ];
//   print(users.sortBy((user) => user['age'] as int)); 
//   // Output: [{'name': 'Bob', 'age': 25}, {'name': 'Alice', 'age': 30}, {'name': 'Charlie', 'age': 35}]

//   // Convert to Map
//   print(users.toMap((user) => user['name'] as String));
//   // Output: {'Alice': {'name': 'Alice', 'age': 30}, 'Bob': {'name': 'Bob', 'age': 25}, 'Charlie': {'name': 'Charlie', 'age': 35}}
