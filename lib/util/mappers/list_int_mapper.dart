class ListIntMapper {
  static List<int> toList(dynamic json) {
    if (json is List) {
      // Convierte cada elemento de la lista a int
      final List<int> jsonInt =
          json.map((id) => int.parse(id.toString())).toList();
      return jsonInt;
    } else {
      // CHANGE 
      return [];
    }
  }
}
