// import 'package:flutter/material.dart';
// import 'package:herbalhub/frontend/config/routes.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to HerbalHub!',
//               //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               style:
//                   GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('lib/frontend/assets/images/home_page_logo.png',
//                 height: 150),
//             const SizedBox(height: 20),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.0),
//               child: Text(
//                 'Explore the world of herbal plants with us. Learn about their uses, benefits, and how to grow them. Start your journey to becoming a herbal expert today!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.roleSelection);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 65, 166, 68),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: const Text('Get Started',
//                   style: TextStyle(fontSize: 18, color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           'HerbalHub ©',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:herbalhub/frontend/config/routes.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome to HerbalHub!',
//               style: GoogleFonts.lexend(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Image.asset('lib/frontend/assets/images/home_page_logo.png',
//                 height: 150),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Text(
//                 'Explore the world of herbal plants with us. Learn about their uses, benefits, and how to grow them. Start your journey to becoming a herbal expert today!',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.lexend(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.roleSelection);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 65, 166, 68),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 'Get Started',
//                 style: GoogleFonts.lexend(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           'HerbalHub ©',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.lexend(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:herbalhub/frontend/config/routes.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome to HerbalHub!',
//               style: GoogleFonts.lexend(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Image.asset(
//               'lib/frontend/assets/images/home_page_logo.png',
//               height: 150,
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Text(
//                 'Explore the world of herbal plants with us. Learn about their uses, benefits, and how to grow them. Start your journey to becoming a herbal expert today!',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.lexend(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.roleSelection);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 65, 166, 68),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 elevation: 10, // Adds box shadow
//                 shadowColor: Colors.black.withOpacity(0.5), // Shadow color
//               ),
//               child: Text(
//                 'Get Started',
//                 style: GoogleFonts.lexend(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           'HerbalHub ©',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.lexend(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herbalhub/frontend/config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to HerbalHub!',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'lib/frontend/assets/images/ayushlogo.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Explore the world of herbal plants with us. Learn about their uses, benefits, and how to grow them. Start your journey to becoming a herbal expert today!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.roleSelection);
              },
              splashColor: Colors.greenAccent.withOpacity(0.5), // Ripple effect
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100), // Animation speed
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 65, 166, 68),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'HerbalHub ©',
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(color: Colors.grey),
        ),
      ),
    );
  }
}
