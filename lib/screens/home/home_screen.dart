import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/widgets/show_snakbar.dart';
import '/screens/home/cubit/home_cubit.dart';
import '/screens/home/widgets/banner_view.dart';

import 'widgets/feature_store_tile.dart';
import 'widgets/modules_view.dart';
import 'widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStatus.error) {
              ShowSnackBar.showSnackBar(context, title: state.failure.message);
            }
          },
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == HomeStatus.succuss) {
              return RefreshIndicator(
                onRefresh: () async => context.read<HomeCubit>().load(),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.35,
                        width: size.width,
                        child: Image.asset('assets/image/rectangle.png',
                            fit: BoxFit.fill),
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 14),
                                child: Text(
                                  'MY APP',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, top: 14),
                                child: SizedBox(
                                  height: size.height * 0.034,
                                  width: size.width * 0.034,
                                  child:
                                      Image.asset('assets/image/dots-icon.png'),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: size.height * 0.02,
                                ),
                                Text(
                                  'Xyz Road, Near abc, Vishakapatnam',
                                  style:
                                      TextStyle(fontSize: size.height * 0.014),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          const SearchBar(),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: size.height * 0.20,
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BannerView(banners: state.banners),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Essentials delivered to your doorstep',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.018),
                          ),
                          const SizedBox(height: 22),
                          ModuleView(modules: state.modules),
                          //CategoryView(categories: state.categories),
                          SizedBox(height: size.height * 0.04),
                          SizedBox(
                            //  height: 220,
                            width: size.width * 0.8,
                            child: Image.asset(
                              'assets/image/send-packages.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Featured Stores',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.018),
                          ),
                          // const SizedBox(height: 16),
                          SizedBox(
                            height: size.height * 0.35,
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                      height: size.height * 0.30,
                                      // autoPlay: true,
                                      // autoPlayInterval: Duration(seconds: 3),
                                      // autoPlayAnimationDuration:
                                      //     Duration(milliseconds: 1000),
                                      onPageChanged: (index, reason) {
                                        // setState(() {
                                        //   topCarouselActiveIndex = index;
                                        // });
                                      }),
                                  itemCount: state.featuredStores.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return FeatureStoreTile(
                                      store: state.featuredStores[index],
                                    );
                                  },
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
