import 'dart:async';

import 'package:provider/provider.dart';
import 'package:user_crud/bloc/provider_bloc.dart';

class StateBloc{

  StreamController controller = StreamController();
  ProviderBloc provider = ProviderBloc();

  Stream get animationStatus => controller.stream;

  void toggleAnimationStatus(){
    provider.toggleAnimatingValue();
    controller.sink.add(provider.isAnimating);
    print("Method called");
  }

  void dispose(){
    controller.close();
  }

}

final stateBloc = StateBloc();