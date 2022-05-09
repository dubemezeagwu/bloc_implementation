part of 'counter_cubit.dart';

class CounterState extends Equatable {
  int counterValue;
  bool? wasIncremented;

  CounterState({required this.counterValue, this.wasIncremented});

  @override
  // TODO: implement props
  List<Object?> get props => [wasIncremented, counterValue];

  Map<String, dynamic> toMap () {
    return {
      "counterValue": counterValue,
      "wasIncremented": wasIncremented,
    };
  }

  factory CounterState.fromMap (Map<String, dynamic> map) {
    return CounterState(
      counterValue: map["counterValue"],
      wasIncremented: map["wasIncremented"],
    );
  }

  String toJson() => json.encode(toMap());

  // This decodes the jsonData and uses the CounterState.fromMap function to
  // create a map of the class instance
  factory CounterState.fromJson (String jsonData){
    return CounterState.fromMap(json.decode(jsonData));
  }
}
