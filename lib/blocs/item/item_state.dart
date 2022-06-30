part of 'item_cubit.dart';

enum ItemStatus { initial, loading, succuss, error }

class ItemState extends Equatable {
  final List<Item> popularItemList;
  final List<Item> reviewedItemList;
  final bool isLoading;
  final List<int> variationIndex;
  final int quantity;
  final List<bool> addOnActiveList;
  final List<int> addOnQtyList;
  final String popularType;
  final String reviewedType;
  final ItemStatus status;
  final Failure failure;
  final List<String> itemTypeList;
  final int imageIndex;
  final int cartIndex;
  final Item? item;
  final int productSelect;
  final int imageSliderIndex;

  const ItemState({
    required this.popularItemList,
    required this.reviewedItemList,
    required this.isLoading,
    required this.variationIndex,
    required this.quantity,
    required this.addOnActiveList,
    required this.addOnQtyList,
    required this.popularType,
    required this.reviewedType,
    required this.status,
    required this.failure,
    required this.itemTypeList,
    required this.imageIndex,
    required this.cartIndex,
    required this.item,
    required this.productSelect,
    required this.imageSliderIndex,
  });

  factory ItemState.initial() => const ItemState(
        popularItemList: [],
        reviewedItemList: [],
        isLoading: false,
        variationIndex: [],
        quantity: 1,
        addOnActiveList: [],
        addOnQtyList: [],
        popularType: 'all',
        reviewedType: 'all',
        status: ItemStatus.initial,
        failure: Failure(),
        itemTypeList: [],
        imageIndex: 0,
        cartIndex: -1,
        item: null,
        productSelect: 0,
        imageSliderIndex: 0,
      );

  @override
  List<Object?> get props {
    return [
      popularItemList,
      reviewedItemList,
      isLoading,
      variationIndex,
      quantity,
      addOnActiveList,
      addOnQtyList,
      popularType,
      reviewedType,
      status,
      failure,
      itemTypeList,
      imageIndex,
      cartIndex,
      item,
      productSelect,
      imageSliderIndex,
    ];
  }

  ItemState copyWith({
    List<Item>? popularItemList,
    List<Item>? reviewedItemList,
    bool? isLoading,
    List<int>? variationIndex,
    int? quantity,
    List<bool>? addOnActiveList,
    List<int>? addOnQtyList,
    String? popularType,
    String? reviewedType,
    ItemStatus? status,
    Failure? failure,
    List<String>? itemTypeList,
    int? imageIndex,
    int? cartIndex,
    Item? item,
    int? productSelect,
    int? imageSliderIndex,
  }) {
    return ItemState(
      popularItemList: popularItemList ?? this.popularItemList,
      reviewedItemList: reviewedItemList ?? this.reviewedItemList,
      isLoading: isLoading ?? this.isLoading,
      variationIndex: variationIndex ?? this.variationIndex,
      quantity: quantity ?? this.quantity,
      addOnActiveList: addOnActiveList ?? this.addOnActiveList,
      addOnQtyList: addOnQtyList ?? this.addOnQtyList,
      popularType: popularType ?? this.popularType,
      reviewedType: reviewedType ?? this.reviewedType,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      itemTypeList: itemTypeList ?? this.itemTypeList,
      imageIndex: imageIndex ?? this.imageIndex,
      cartIndex: cartIndex ?? this.cartIndex,
      item: item ?? this.item,
      productSelect: productSelect ?? this.productSelect,
      imageSliderIndex: imageSliderIndex ?? this.imageSliderIndex,
    );
  }

  @override
  bool get stringify => true;
}
