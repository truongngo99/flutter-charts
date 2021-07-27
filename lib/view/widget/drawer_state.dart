import 'package:teq_flutter_core/teq_flutter_core.dart';

class DrawerState extends BaseState {
  final int index;
  DrawerState({this.index = 0});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
  DrawerState copyWith({int? index}) => DrawerState(index: index ?? this.index);
}
