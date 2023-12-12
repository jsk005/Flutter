import 'package:flutter/material.dart';
import 'package:state_ex/state/provider/provider_cart.dart';

class ProviderBadge with ChangeNotifier {
  final ProviderCart providerCart;

  ProviderBadge({
    required this.providerCart,
  }) {
    providerCart.addListener(providerCartListener);
  }

  int counter = 0;

  void providerCartListener() {
    counter = providerCart.cartProductList.length;
    notifyListeners();
  }

  @override
  void dispose() {
    providerCart.removeListener(providerCartListener);
    super.dispose();
  }
}