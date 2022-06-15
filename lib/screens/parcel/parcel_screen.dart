import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/screens/parcel/task_details_screen.dart';

import '/blocs/auth/auth_bloc.dart';
import '/repositories/location/location_repository.dart';
import '/screens/parcel/cubit/parcel_cubit.dart';
import '/widgets/display_image.dart';
import '/widgets/loading_indicator.dart';
import 'pick_parsel_address.dart';
import 'widgets/contact_form.dart';
import 'widgets/contact_section.dart';

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

  void showAddContactBottomSheet(
    BuildContext context, {
    required bool isSender,
  }) async {
    final parcelCubit = context.read<ParcelCubit>();
    final result = await showModalBottomSheet<Map<String, String?>?>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext _) {
        return BlocProvider<ParcelCubit>(
          create: (context) => ParcelCubit(
            authBloc: context.read<AuthBloc>(),
            locationRepository: context.read<LocationRepository>(),
          ),
          child: ContactForm(isSender: isSender),
        );
      },
    );
    final name = result?['name'];
    final phone = result?['phone'];
    print('Result from bottom sheet $result');

    parcelCubit.addContact(isSender: isSender, phNo: phone, name: name);
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
        listener: (_, state) {},
        builder: (_, state) {
          if (state.status == ParcelStatus.loading) {
            return const LoadingIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: SingleChildScrollView(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final address = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const PickParcelAddress(),
                                ),
                              );
                              print('Address picked form maps screen $address');

                              parcelCubit.addSenderAddress(address);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Current Address',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DottedLine(),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: AddressSection(
                                  address: state.senderAddress,
                                  phNo: state.senderPhNo,
                                  contactPersonName: state.senderName,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () => showAddContactBottomSheet(context,
                                    isSender: true),
                                child: const CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.phone,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              final address = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const PickParcelAddress(),
                                ),
                              );
                              print('Address picked form maps screen $address');

                              parcelCubit.addReceiverAddress(address);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5.0),
                                Text(
                                  'Drop Off',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: AddressSection(
                                    address: state.receiverAddress,
                                    phNo: state.receiverPhNo,
                                    contactPersonName: state.receiverName,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                GestureDetector(
                                  onTap: () => showAddContactBottomSheet(
                                      context,
                                      isSender: false),
                                  child: const CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.phone,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
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
                            onPressed: () => Navigator.of(context)
                                .pushNamed(TaskDetailsScreen.routeName),
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
            ),
          );
        },
      ),
    );
  }
}

class DisplayAddress extends StatelessWidget {
  final VoidCallback pickAddress;
  final String? address;
  final String? phNo;
  final String label;
  final VoidCallback pickContact;
  final String? contactPersonName;

  const DisplayAddress({
    super.key,
    required this.pickAddress,
    required this.address,
    required this.phNo,
    required this.label,
    required this.pickContact,
    required this.contactPersonName,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: pickAddress,

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
                    Text(contactPersonName ?? ''),
                    const SizedBox(height: 5.0),
                    Text(address ?? ''),
                    const SizedBox(height: 5.0),
                    Text(phNo ?? '')
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: pickContact,
                child: const CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.phone,
                    size: 16.0,
                    color: Colors.white,
                  ),
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
          for (int i = 0; i < 10; i++)
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
