import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCategoryScroll extends StatelessWidget {
  const NewsCategoryScroll({
    super.key,
    required this.newsCateogryList,
    required this.newsCateogryNotifier,
    required this.height,
  });

  final List<String> newsCateogryList;
  final ValueNotifier<String> newsCateogryNotifier;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final currentNewsCategory = newsCateogryList[index];
          return GestureDetector(
            onTap: () {
              newsCateogryNotifier.value = currentNewsCategory;
            },
            child: Card(
              elevation: 2.0,
              color: (currentNewsCategory == newsCateogryNotifier.value)
                  ? Colors.blue
                  : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0)),
              child: Padding(
                padding: EdgeInsets.all(height * .01),
                child: Center(
                  child: Text(
                    newsCateogryList[index],
                    style: GoogleFonts.rubik(
                            fontSize: 15.0, fontWeight: FontWeight.bold)
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: newsCateogryList.length);
  }
}
