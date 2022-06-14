import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/auth/auth_bloc.dart';
import 'package:six_am_mart/repositories/location/location_repository.dart';
import 'package:six_am_mart/screens/location/pick_map_screen.dart';
import 'package:six_am_mart/screens/location/widgets/search_location.dart';
import 'package:six_am_mart/screens/parcel/cubit/parcel_cubit.dart';
import 'package:six_am_mart/widgets/display_image.dart';
import 'package:six_am_mart/widgets/loading_indicator.dart';

import 'demo_map_screen.dart';
import 'pick_parsel_address.dart';

class ParcelScreen extends StatelessWidget {
  static const String routeName = '/parcel';
  const ParcelScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<ParcelCubit>(
        create: (context) => ParcelCubit(
          authBloc: context.read<AuthBloc>(),
          locationRepository: context.read<LocationRepository>(),
        ),
        child: const ParcelScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parcelCubit = context.read<ParcelCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Send Your Parcel',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ParcelCubit, ParcelState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == ParcelStatus.loading) {
            return const LoadingIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: DisplayImage(
                        height: 170.0,
                        width: size.width * 0.9,
                        imageUrl:
                            'https://img.freepik.com/free-vector/modern-website-banner-template-with-abstract-shapes_1361-3311.jpg?w=2000',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15.0,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.location_on),
                              DottedLine(),
                              Icon(Icons.location_on),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30.0),
                              DisplayAddress(
                                label: 'Current Address',
                                onTap: () async {
                                  final address =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const PickParcelAddress(),
                                    ),
                                  );
                                  print(
                                      'Address picked form maps screen $address');

                                  parcelCubit.addSenderAddress(address);
                                },
                                address: state.senderAddress,
                                phNo: '91 85409291922',
                              ),
                              const SizedBox(height: 65.0),
                              DisplayAddress(
                                label: 'Drop Off',
                                onTap: () async {
                                  final address =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const PickParcelAddress(),
                                    ),
                                  );
                                  print(
                                      'Address picked form maps screen $address');

                                  parcelCubit.addReceiverAddress(address);
                                },
                                address: state.receiverAddress,
                                phNo: '91 85409291922',
                              ),
                            ],
                          ),
                        ],
                      )

                      //AddBar(),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     //  AddBar(),
                      //     const DottedLine(),
                      //     // AddBar(),
                      //   ],
                      // ),
                      ),
                ),
                const SizedBox(height: 30.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Task Details',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            letterSpacing: 0.9,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {},
                          // icon: const Icon(
                          //   Icons.add,
                          //   size: 20.0,
                          // ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12.0),
                            child: Text(
                              'Add ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DisplayAddress extends StatelessWidget {
  final VoidCallback onTap;
  final String? address;
  final String? phNo;
  final String label;

  const DisplayAddress({
    super.key,
    required this.onTap,
    required this.address,
    required this.phNo,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,

      // MaterialPageRoute(
      //   builder: (_) => PickMapScreen(
      //     fromAddAddress: false,
      //     canRoute: true,
      //     fromSignUp: false,
      //     route: '/pick',
      //     onPicked: (_) {},
      //   ),
      // ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(address ?? ''),
                    const SizedBox(height: 5.0),
                    Text(phNo ?? '')
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              const CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.phone,
                  size: 16.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// class AddBar extends StatelessWidget {
//   const AddBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {},
//       child: Row(
//         children: [
//           const Icon(Icons.location_on),
//           const SizedBox(width: 10.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Drop Off',
//                 style: TextStyle(color: Colors.grey.shade500),
//               ),
//               const SizedBox(height: 5.0),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: size.width * 0.65,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text('E 46 Patel Nagar, Bhopal Madhya Pradesh'),
//                         SizedBox(height: 5.0),
//                         Text(
//                           '91 8540928489',
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10.0),
//                   const CircleAvatar(
//                     radius: 14.0,
//                     backgroundColor: Colors.green,
//                     child: Icon(
//                       Icons.phone,
//                       size: 16.0,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class DottedLine extends StatelessWidget {
  const DottedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < 8; i++)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 4.0,
              width: 2.0,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }
}
