import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/components/app_bar.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/components/rating_section.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/components/review_input_section.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  WriteReviewScreenState createState() => WriteReviewScreenState();
}

class WriteReviewScreenState extends State<WriteReviewScreen> {
  int _selectedRating = 0;
  final List<String> _selectedImprovements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle('Penilaian'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgPattern2),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Color.fromARGB(80, 255, 255, 255),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            RatingSection(
              selectedRating: _selectedRating,
              onRatingSelected: (rating) {
                setState(() {
                  _selectedRating = rating;
                });
              },
            ),
            SizedBox(height: 20.h),
            ReviewInputImprovementSection(
              selectedImprovements: _selectedImprovements,
              onImprovementSelected: (improvement) {
                setState(() {
                  if (_selectedImprovements.contains(improvement)) {
                    _selectedImprovements.remove(improvement);
                  } else {
                    _selectedImprovements.add(improvement);
                  }
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
