import 'package:flutter/material.dart';
import 'package:green_perk/constants/app_colors.dart';

class HomePageCustomCardWidget extends StatelessWidget {
  const HomePageCustomCardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.value,
  });

  final String title;
  final String imagePath;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .44,
      height: MediaQuery.of(context).size.width * .44,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: AppColors.primaryGreen,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    imagePath,
                    width: 65,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Google Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.textGreen,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Google Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: AppColors.textGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
