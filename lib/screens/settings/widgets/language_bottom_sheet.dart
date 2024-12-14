import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/settings/widgets/language_option.dart';

import '../../../provider/my_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LanguageOption(
              title: 'English',
              isSelected: pro.currentLocal == 'en',
              onTap: () {
                pro.changeLanguage('en');
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 16),
            LanguageOption(
              title: 'العربية',
              isSelected: pro.currentLocal == 'ar',
              onTap: () {
                pro.changeLanguage('ar');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
