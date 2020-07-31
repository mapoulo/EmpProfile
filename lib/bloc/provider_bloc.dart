class ProviderBloc{

  bool isAnimating = true;

  void toggleAnimatingValue() => isAnimating = !isAnimating;

}

final theProvider = ProviderBloc();