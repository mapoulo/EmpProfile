import 'dart:async';

import 'package:provider/provider.dart';
import 'package:user_crud/bloc/provider_bloc.dart';

class StateBloc {
  final StreamController<bool> controller = StreamController<bool>.broadcast();
  ProviderBloc provider = ProviderBloc();

  Stream get animationStatus => controller.stream;

  void toggleAnimationStatus() {
    provider.toggleAnimatingValue();
    controller.sink.add(provider.isAnimating);
    print("Method called");
  }

  void dispose() {
    controller.close();
  }
}

final stateBloc = StateBloc();
