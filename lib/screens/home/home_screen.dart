import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/home/cubit/home_cubit.dart';
import '/screens/home/widgets/banner_view.dart';

import 'widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                    width: size.width,
                    child: Image.asset('assets/image/rectangle.png',
                        fit: BoxFit.fill),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 14),
                            child: Text(
                              'MY APP',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 14),
                            child: SizedBox(
                              height: size.height * 0.034,
                              width: size.width * 0.034,
                              child: Image.asset('assets/image/dots-icon.png'),
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
                              style: TextStyle(fontSize: size.height * 0.014),
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
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
