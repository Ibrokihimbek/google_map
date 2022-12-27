import 'package:flutter/material.dart';
import 'package:google_map/ui/map_screen/map_screen.dart';
import 'package:google_map/ui/splash_screen/app_colors.dart';
import 'package:google_map/ui/splash_screen/app_loties.dart';
import 'package:google_map/view_models/splash_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor:  AppColors.C_E1EEFB,
          body: Consumer<SplashViewModel>(
            builder: (context, viewModel, child) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  if (viewModel.latLong != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          latLong: viewModel.latLong!,
                        ),
                      ),
                    );
                  }
                },
              );
              return Center(
                child:  Lottie.asset(AppLoties.splashLotie),
              );
            },
          ),
        );
      },
    );
  }
}
