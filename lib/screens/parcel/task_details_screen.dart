import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/urls.dart';
import '/constants/constants.dart';
import '/repositories/parcel/parcel_repository.dart';
import '/widgets/display_image.dart';
import '/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/location/location_repository.dart';
import '/screens/parcel/cubit/parcel_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  static const String routeName = '/taskDetails';
  const TaskDetailsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => ParcelCubit(
            authBloc: context.read<AuthBloc>(),
            locationRepository: context.read<LocationRepository>(),
            parcelRepository: context.read<ParcelRepository>())
          ..loadParcelCategories(),
        child: const TaskDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parcelCubit = context.read<ParcelCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ParcelCubit, ParcelState>(
        builder: (context, state) {
          if (state.status == ParcelStatus.loading) {
            return const LoadingIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //height: 200.0,
                color: green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Delivery of alcohol or any illegal items is prohibited by law',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Image.asset(
                        'assets/image/no-alcohol.png',
                        height: 55.0,
                        width: 55.0,
                        //fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Package Type',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side:
                            BorderSide(color: Colors.grey.shade300, width: 0.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: SizedBox(
                          height: size.height * 0.55,
                          child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              final category = state.categories[index];
                              bool isSelected =
                                  category == state.selectedCategory;

                              final iconUrl =
                                  '${Urls.parcelCategoryImg}${category?.image}';

                              return GestureDetector(
                                onTap: () {
                                  if (!isSelected) {
                                    parcelCubit.selectPackageType(category);
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 7.0),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 17.0,
                                    horizontal: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      width: isSelected ? 1.2 : 0.9,
                                      color: isSelected
                                          ? green
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                  // color: isSelected
                                  //     ? green.withOpacity(0.8)
                                  //     : Colors.white,
                                  child: Row(
                                    children: [
                                      DisplayImage(
                                        imageUrl: iconUrl,
                                        height: 32.0,
                                        width: 32.0,
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              category?.name ?? '',
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              category?.description ?? '',
                                              style: TextStyle(
                                                //fontSize: 15.0,
                                                // fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
