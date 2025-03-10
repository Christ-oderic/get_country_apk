import 'package:flutter/material.dart';
import 'package:get_country_apk/common/colors.dart';

class ButtonUtils extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const ButtonUtils({
    super.key,
    required this.buttonText,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(      
      onPressed: onPressed ?? () {}, 
      style: ElevatedButton.styleFrom(      
        backgroundColor: AppColors.primaryElement, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)), 
        ),
        shadowColor: Colors.grey, 
        elevation: 2, 
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}