import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/config/urls.dart';
import '/models/item.dart';
import '/widgets/display_image.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class ChooseVarient extends StatefulWidget {
  final Item? item;
  const ChooseVarient({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ChooseVarient> createState() => _ChooseVarientState();
}

class _ChooseVarientState extends State<ChooseVarient> {
  BestTutorSite _site = BestTutorSite.javatpoint;

  @override
  Widget build(BuildContext context) {
    final itemImg = '${Urls.itemImage}${widget.item?.image}';
    // final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DisplayImage(
                    imageUrl: itemImg,
                    fit: BoxFit.cover,
                    height: 80.0,
                    width: 80.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available quantities',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.9,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: green,
                          radius: 3.5,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          widget.item?.name ?? 'N/A',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Choose Varient',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.grey),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          activeColor: green,
                          // fillColor:
                          //     MaterialStateColor.resolveWith((states) => green),
                          // fillColor: MaterialStateProperty.resolveWith<Color>(
                          //     (states) {
                          //   if (states.contains(MaterialState.disabled)) {
                          //     return Colors.orange.withOpacity(.32);
                          //   }
                          //   return green;
                          // }),
                          // fillColor:
                          //     MaterialStateColor.resolveWith((states) => green),
                          value: BestTutorSite.javatpoint,
                          groupValue: _site,
                          onChanged: (BestTutorSite? value) {
                            setState(() {
                              _site = value!;
                            });
                          },
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: '10 Kgs'),
                              TextSpan(
                                text: ' ₹ 580',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    // ListTile(
                    //   title:
                    //   leading:
                    // ),
                    Row(
                      children: [
                        Radio(
                          activeColor: green,
                          value: BestTutorSite.w3schools,
                          groupValue: _site,
                          onChanged: (BestTutorSite? value) {
                            setState(() {
                              _site = value!;
                            });
                          },
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: '1 Kg'),
                              TextSpan(
                                text: ' ₹ 58',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10 KGS',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 20.0,
                        ),
                        const SizedBox(width: 5.0),
                        const Text('Item total'),
                        const SizedBox(width: 20.0),
                        const Text(
                          '₹ 580',
                          style: TextStyle(color: green),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 44.0,
                          width: 100.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Add Item',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

 Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.45,
                            child: Text(
                              widget.item?.name ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 75.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Center(
                              child: Text(
                                widget.item?.veg == 1 ? 'Veg' : 'Non-Veg',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.item?.storeName ?? 'N/A',
                        style: const TextStyle(color: green),
                      ),
                      const SizedBox(height: 5.0),
                      RatingBar(
                        rating: widget.item?.avgRating ?? 0.0,
                        ratingCount: widget.item?.ratingCount ?? 0,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '₹ ${widget.item?.price.toString() ?? 'N/A'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.item?.description ?? 'N/A',
                style: const TextStyle(fontSize: 14.5),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.shade400,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.remove,
                            size: 18.0,
                          ),
                        ),
                        const Text('1'),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.add,
                            size: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Addons',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5.0),
              Stack(
                children: [
                  Container(
                    height: 82.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 10.0),
                        Text(
                          'Sause',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5.0),
                        Text('₹ 10.00 ', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 30.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.remove,
                              size: 18.0,
                            ),
                          ),
                          const Text('1'),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.add,
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: 'Total Amount: '),
                    TextSpan(
                      text: '₹ ${widget.item?.price}',
                      style: const TextStyle(color: green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

*/
