class CounterModel {
  final int count;
  CounterModel(this.count);
  CounterModel copyWith({int count}) => CounterModel(count ?? this.count);
}
