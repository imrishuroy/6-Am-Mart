import 'package:connectivity/connectivity.dart';
import '/helpers/dimensions.dart';
import '/utils/images.dart';
import '/utils/styles.dart';
import '/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget child;

  const NoInternetScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noInternet, width: 150, height: 150),
            // Text(
            //   'oops'.tr,
            //   style: robotoBold.copyWith(
            //     fontSize: 30,
            //     color: Theme.of(context).textTheme.bodyText1.color,
            //   ),
            // ),
            Text(
              'oops',
              style: robotoBold.copyWith(
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            ElevatedButton(
                onPressed: () {
                  // Get.offAllNamed('/');
                },
                child: const Text('Go to Home')),
            const Text(
              // 'no_internet_connection'.tr,
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: robotoRegular,
            ),
            const SizedBox(height: 40),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                onPressed: () async {
                  if (await Connectivity().checkConnectivity() !=
                      ConnectivityResult.none) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => child));
                  }
                },
                // buttonText: 'retry'.tr,
                buttonText: 'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
