part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListEvent {}

class CategoryListInitialEvent extends CategoryListEvent {}

class CategoryListLoadEvent extends CategoryListEvent {}

class AddCategoryEvent extends CategoryListEvent {
  final CategoryModel category;
  AddCategoryEvent({required this.category});
}

class RemoveCategoryEvent extends CategoryListEvent {
  final CategoryModel category;
  RemoveCategoryEvent({required this.category});
}

class EditCategoryEvent extends CategoryListEvent {
  final int index;
  final Color color;
  final String title;

  EditCategoryEvent(
      {required this.index, required this.color, required this.title});
}
