
class ProductFormValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Price must be a number';
    }
    if (parsed <= 0) {
      return 'Price must be greater than zero';
    }
    return null;
  }
}
