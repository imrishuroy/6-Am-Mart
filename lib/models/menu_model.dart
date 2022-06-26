import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String icon;
  final String title;
  final String route;

  const MenuModel({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  List<Object> get props => [icon, title, route];

  @override
  String toString() => 'MenuModel(icon: $icon, title: $title, route: $route)';
}
