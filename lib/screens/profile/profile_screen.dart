import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/user/user_repository.dart';
import '/screens/profile/cubit/profile_cubit.dart';
import 'widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(
          userRepository: context.read<UserRepository>(),
        )..loaduserProfile(),
        child: const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final authBloc = context.read<AuthBloc>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.chat_bubble_outline,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case ProfileStatus.loading:
                return const LoadingIndicator();

              case ProfileStatus.error:
                return const Center(
                  child: Text('Something went wrong'),
                );

              case ProfileStatus.succuss:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.person_outline_sharp,
                                      color: Colors.black,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: Text(
                                  '${state.user?.firstName ?? ' '}\n${state.user?.lastName ?? ''}',
                                  //'Rishu Kumar',
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Row(
                          children: [
                            ProfileTile(
                              label: 'Order history',
                              icon: Icons.description,
                              onTap: () {},
                            ),
                            const Spacer(),
                            const CircleAvatar(
                              radius: 13.0,
                              backgroundColor: Colors.amber,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        ProfileTile(
                          label: 'Liked products',
                          icon: Icons.favorite,
                          onTap: () {},
                        ),
                        const Divider(),
                        Row(
                          children: [
                            ProfileTile(
                              label: 'Profile Settings',
                              icon: Icons.person,
                              onTap: () {},
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Completed - '),
                                      TextSpan(
                                        text: '60%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        height: 7.0,
                                        width: 15.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                          color: Colors.black,
                                        ),
                                      ),
                                    for (int i = 0; i < 4; i++)
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        height: 7.0,
                                        width: 15.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const Divider(),
                        ProfileTile(
                          label: 'Settings',
                          icon: Icons.settings,
                          onTap: () {},
                        ),
                        const Divider(),
                        ProfileTile(
                          label: 'Exit',
                          icon: FontAwesomeIcons.arrowRightFromBracket,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );

              default:
                return const LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
