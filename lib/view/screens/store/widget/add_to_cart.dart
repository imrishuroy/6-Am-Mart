import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/cart_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';

class AddToCard extends StatelessWidget {
  final Item item;
  const AddToCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final itemController = Get.find<ItemController>();
    final cartController = Get.find<CartController>();

    int _stock = 0;
    CartModel _cartModel;
    double _priceWithAddons = 0;

    // if (itemController.item != null && itemController.variationIndex != null) {
    //   List<String> _variationList = [];
    //   for (int index = 0;
    //       index < itemController.item.choiceOptions.length;
    //       index++) {
    //     _variationList.add(itemController.item.choiceOptions[index]
    //         .options[itemController.variationIndex[index]]
    //         .replaceAll(' ', ''));
    //   }
    //   String variationType = '';
    //   bool isFirst = true;
    //   _variationList.forEach((variation) {
    //     if (isFirst) {
    //       variationType = '$variationType$variation';
    //       isFirst = false;
    //     } else {
    //       variationType = '$variationType-$variation';
    //     }
    //   });

    //   double price = itemController.item.price;
    //   Variation _variation;
    //   _stock = itemController.item.stock;
    //   for (Variation variation in itemController.item.variations) {
    //     if (variation.type == variationType) {
    //       price = variation.price;
    //       _variation = variation;
    //       _stock = variation.stock;
    //       break;
    //     }
    //   }

    //   double _discount = (itemController.item.availableDateStarts != null ||
    //           itemController.item.storeDiscount == 0)
    //       ? itemController.item.discount
    //       : itemController.item.storeDiscount;
    //   String _discountType = (itemController.item.availableDateStarts != null ||
    //           itemController.item.storeDiscount == 0)
    //       ? itemController.item.discountType
    //       : 'percent';
    //   double priceWithDiscount =
    //       PriceConverter.convertWithDiscount(price, _discount, _discountType);
    //   double priceWithQuantity = priceWithDiscount * itemController.quantity;
    //   double addonsCost = 0;
    //   List<AddOn> _addOnIdList = [];
    //   List<AddOns> _addOnsList = [];
    //   for (int index = 0; index < itemController.item.addOns.length; index++) {
    //     if (itemController.addOnActiveList[index]) {
    //       addonsCost = addonsCost +
    //           (itemController.item.addOns[index].price *
    //               itemController.addOnQtyList[index]);
    //       _addOnIdList.add(AddOn(
    //           id: itemController.item.addOns[index].id,
    //           quantity: itemController.addOnQtyList[index]));
    //       _addOnsList.add(itemController.item.addOns[index]);
    //     }
    //   }

    //   _cartModel = CartModel(
    //     price,
    //     priceWithDiscount,
    //     _variation != null ? [_variation] : [],
    //     (price -
    //         PriceConverter.convertWithDiscount(
    //             price, _discount, _discountType)),
    //     itemController.quantity,
    //     _addOnIdList,
    //     _addOnsList,
    //     itemController.item.availableDateStarts != null,
    //     _stock,
    //     itemController.item,
    //   );
    //   _priceWithAddons = priceWithQuantity +
    //       (Get.find<SplashController>().configModel.moduleConfig.module.addOn
    //           ? addonsCost
    //           : 0);

    // }

    List<String> _variationList = [];
    for (int index = 0; index < item.choiceOptions.length; index++) {
      // _variationList.add(
      //   item.choiceOptions[index].options[variationIndex[index]]
      //       .replaceAll(' ', ''),
      // );
    }
    String variationType = '';
    bool isFirst = true;
    _variationList.forEach((variation) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    });

    double price = item.price;
    Variation _variation;
    _stock = item.stock;
    for (Variation variation in item.variations) {
      if (variation.type == variationType) {
        price = variation.price;
        _variation = variation;
        _stock = variation.stock;
        break;
      }
    }

    double _discount =
        (item.availableDateStarts != null || item.storeDiscount == 0)
            ? item.discount
            : item.storeDiscount;
    String _discountType =
        (item.availableDateStarts != null || item.storeDiscount == 0)
            ? item.discountType
            : 'percent';
    double priceWithDiscount =
        PriceConverter.convertWithDiscount(price, _discount, _discountType);
    double priceWithQuantity = priceWithDiscount * 1;
    double addonsCost = 0;
    List<AddOn> _addOnIdList = [];
    List<AddOns> _addOnsList = [];
    for (int index = 0; index < item.addOns.length; index++) {
      // if (itemController.addOnActiveList[index]) {
      //   addonsCost = addonsCost +
      //       (itemController.item.addOns[index].price *
      //           itemController.addOnQtyList[index]);
      //   _addOnIdList.add(AddOn(
      //       id: itemController.item.addOns[index].id,
      //       quantity: itemController.addOnQtyList[index]));
      //   _addOnsList.add(itemController.item.addOns[index]);
      // }
    }

    _cartModel = CartModel(
      price,
      priceWithDiscount,
      _variation != null ? [_variation] : [],
      (price -
          PriceConverter.convertWithDiscount(price, _discount, _discountType)),
      1,
      _addOnIdList,
      _addOnsList,
      item.availableDateStarts != null,
      _stock,
      item,
    );
    _priceWithAddons = priceWithQuantity +
        (Get.find<SplashController>().configModel.moduleConfig.module.addOn
            ? addonsCost
            : 0);

    return IconButton(
      onPressed: () {
        print('Cart model - ${_cartModel.toString()}');
        // print('Cart model index - ${itemController.cartIndex}');

        final check = Get.find<CartController>()
            .isExistInCart(item.id, variationType, false, -1);

        if (check == -1) {
          Get.find<CartController>().addToCart(_cartModel, -1);
        } else {
          // already exists in cart
          Get.find<CartController>().addToCart(_cartModel, 0);
        }

        print('Checking is exist in cart $check');
        //
      },
      icon: Icon(Icons.add),
    );
  }
}
