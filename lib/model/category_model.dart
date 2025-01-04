import 'package:shiksha/pages/home_page.dart';

class CategoryModel {
  final String name;
  bool isSelected;
  final List<SectionModel> sections; // A list of sections for each subject

  CategoryModel({
    required this.name,
    this.isSelected = false,
    required this.sections, // Now sections, not topics
  });
}
