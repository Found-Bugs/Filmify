// import 'package:flutter/material.dart';

// class ChangePassword extends StatelessWidget {
//   const ChangePassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Blue Rectangle
//             Container(
//               width: double.infinity,
//               height: 137,
//               color: const Color(0xFF111842),
//               child: Center(
//                 child: Text(
//                   'Change Password',
//                   style: const TextStyle(
//                     fontFamily: 'Mulish',
//                     fontWeight: FontWeight.w900,
//                     fontSize: 24,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Input Fields
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.1), // Padding responsif
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildInputField(context, 'Password', '**********'),
//                   const SizedBox(height: 20),
//                   _buildInputField(context, 'New Password', '**********'),
//                   const SizedBox(height: 20),
//                   _buildInputField(context, 'Confirm Password', '**********'),
//                   const SizedBox(height: 40),

//                   // Update Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add update logic here
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF171F1D),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                       ),
//                       child: const Text(
//                         'Update',
//                         style: TextStyle(
//                           fontFamily: 'Mulish',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 15,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(BuildContext context, String label, String hintText) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontFamily: 'DM Sans',
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           decoration: InputDecoration(
//             hintText: hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFFA9A9A9)),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           ),
//           obscureText: true, // For password fields
//         ),
//       ],
//     );
//   }
// }

import 'package:filmify/utils/colors.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Input Fields
            const CustomTextField(
              fieldName: 'Password',
              fieldNameColor: customTeksColorDark,
              hintText: 'Password',
              isPassword: true,
              suffixIcon: Icons.visibility_off,
              borderSide: BorderSide(),
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              fieldName: 'New Password',
              fieldNameColor: customTeksColorDark,
              hintText: 'New Password',
              isPassword: true,
              suffixIcon: Icons.visibility_off,
              borderSide: BorderSide(),
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              fieldName: 'Confirm Password',
              fieldNameColor: customTeksColorDark,
              hintText: 'Confirm Password',
              isPassword: true,
              suffixIcon: Icons.visibility_off,
              borderSide: BorderSide(),
            ),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: () {},
              text: 'Update',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
