extension StringExtension on String {
  String capitalizeFirstSymbol() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}