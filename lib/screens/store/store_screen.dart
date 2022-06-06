import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/store/widgets/all_stores.dart';
import '/config/urls.dart';
import '/helpers/dimensions.dart';
import '/screens/store/widgets/popular_stores.dart';
import '/widgets/display_image.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/store/store_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'cubit/store_cubit.dart';
import 'widgets/store_btn.dart';

class StoreScreenArgs {
  final String id;

  StoreScreenArgs({required this.id});
}

class StoreScreen extends StatefulWidget {
  static const String routeName = '/storePage';
  const StoreScreen({Key? key}) : super(key: key);

  static Route route({required StoreScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => StoreCubit(
          storeRepository: context.read<StoreRepository>(),
          moduleId: args.id,
        )..loadStore(),
        child: const StoreScreen(),
      ),
    );
  }

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with TickerProviderStateMixin {
  int activeTabIndex = 0;
  int carouselActiveIndex = 0;
  List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPXxtubdc9aLjJJV6p3XPAjWwiP7gI3MtM0Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPXxtubdc9aLjJJV6p3XPAjWwiP7gI3MtM0Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPXxtubdc9aLjJJV6p3XPAjWwiP7gI3MtM0Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPXxtubdc9aLjJJV6p3XPAjWwiP7gI3MtM0Q&usqp=CAU',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = AppBar().preferredSize.height;
    Size size = MediaQuery.of(context).size;

    /// TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color.fromRGBO(243, 243, 240, 1),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, statusBarHeight + appBarHeight),
        child: Container(
          width: double.infinity,
          height: statusBarHeight + appBarHeight,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.white,

                //  Color.fromRGBO(
                //   169,
                //   169,
                //   150,
                //   0.13,
                // ),
              )
            ],
            color: Colors.white,
            //Color.fromRGBO(255, 255, 255, 1),
          ),
          padding: EdgeInsets.only(left: 15, right: 15, top: statusBarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.chevron_left)),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.chevron_left,
              //   ),
              // ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: const Color.fromRGBO(69, 165, 36, 1)),
                child: Icon(
                  // const IconData(0xef09, fontFamily: 'MIcon'),
                  Icons.location_on,
                  size: size.height * 0.015,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Delivery address',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.height * 0.015,
                        letterSpacing: -0.5,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        'Vishakapatnam, street xyz, near public school',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: size.height * 0.014,
                            letterSpacing: -0.5,
                            color: const Color.fromRGBO(136, 136, 126, 1)),
                      ),
                    ),
                  ],
                ),
              ),
              StoreButton(
                title: 'Change',
                height: 30,
                width: size.width * 0.14,
                backColor: Colors.black,
                onPress: () => {},
              )
            ],
          ),
        ),
      ),
      body: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == StoreStatus.loading) {
            return const LoadingIndicator();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Container(
                    //   padding: const EdgeInsets.only(left: 14),
                    //  width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 202, 202, 202),
                            blurRadius: 1, // soften the shadow
                            spreadRadius: 1.4, //extend the shadow
                            offset: Offset(
                              1, // Move to right 10  horizontally
                              1.8, // Move to bottom 10 Vertically
                            ),
                          )
                        ]),
                    child: const TextField(
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        hintText: 'Search stores',
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),

                  // SearchInput(
                  //   title: "Search stores".tr,
                  //   hasSuffix: false,
                  // ),
                  // ShopListHorizontal(),

                  SizedBox(
                    height: size.height * 0.27,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state.banners.isEmpty
                            ? const SizedBox.shrink()
                            : CarouselSlider.builder(
                                options: CarouselOptions(
                                  // height: size.height * 0.18,
                                  height: size.height * 0.16,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      carouselActiveIndex = index;
                                    });
                                  },
                                ),
                                itemCount: state.banners.length,
                                itemBuilder: (context, index, realIndex) {
                                  final banner = state.banners[index];

                                  final imageUrl =
                                      '${Urls.bannerImg}${banner?.image}';

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3.5,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusSmall),
                                        child: DisplayImage(
                                          imageUrl: imageUrl,
                                          fit: BoxFit.cover,
                                        )

                                        //     Image.network(
                                        //   imageUrl,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        ),
                                  );
                                },
                              ),
                        const SizedBox(height: 20.0),
                        AnimatedSmoothIndicator(
                            activeIndex: carouselActiveIndex,
                            count: state.banners.length,
                            effect: ScrollingDotsEffect(
                              activeDotColor: Colors.green,
                              activeStrokeWidth: 9.0,
                              dotHeight: 6.0,
                              dotWidth: 6.0,
                              dotColor: Colors.green.shade200,
                            )

                            // SlideEffect(
                            //   dotHeight: 7,
                            //   dotWidth: 7,
                            //   dotColor: Colors.lightGreen.shade300,
                            //   activeDotColor: Colors.green,
                            // ),
                            )
                      ],
                    ),
                  ),

                  const Text(
                    'Popular Stores',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: -1,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  PopularStores(popularStores: state.popularStores),
                  const SizedBox(height: 20.0),
                  const Text(
                    'All Stores',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: -1,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  AllStores(allStores: state.allStores)

                  //  ShopListVertical()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
