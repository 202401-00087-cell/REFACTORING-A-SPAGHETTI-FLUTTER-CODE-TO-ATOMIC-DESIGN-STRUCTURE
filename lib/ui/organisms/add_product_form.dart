import 'package:flutter/material.dart';
import '../../utils/validators.dart';
import '../atoms/app_text_form_field.dart';
import '../atoms/category_dropdown_field.dart';
import '../atoms/filled_action_button.dart';

const _kCategories = ['Electronics', 'Home', 'Office', 'Accessories'];

class AddProductForm extends StatefulWidget {
  final void Function({
    required String name,
    required double price,
    required String category,
    required String description,
  }) onSubmit;

  const AddProductForm({super.key, required this.onSubmit});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Electronics';

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        category: _selectedCategory,
        description: _descriptionController.text,
      );

      setState(() {
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _selectedCategory = 'Electronics';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            controller: _nameController,
            label: 'Product Name',
            validator: ProductFormValidators.validateName,
          ),
          const SizedBox(height: 12),
          AppTextFormField(
            controller: _priceController,
            label: 'Price',
            keyboardType: TextInputType.number,
            validator: ProductFormValidators.validatePrice,
          ),
          const SizedBox(height: 12),
          CategoryDropdownField(
            value: _selectedCategory,
            categories: _kCategories,
            label: 'Category',
            onChanged: (value) {
              setState(() => _selectedCategory = value ?? 'Electronics');
            },
          ),
          const SizedBox(height: 12),
          AppTextFormField(
            controller: _descriptionController,
            label: 'Description',
            maxLines: 3,
            alignLabelWithHint: true,
            // No validator — matches the starter, where the description
            // TextFormField had no `validator:` argument at all.
          ),
          const SizedBox(height: 16),
          FilledActionButton(
            label: 'Submit Product',
            onPressed: _handleSubmit,
            fullWidth: true,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
