import 'package:flutter/material.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Text('FAQ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(title: Text(
                  'what is Easy Home application ?',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                  ),
                ),
                  children: [
                    ListTile(title:
                    Text(
                      'Easy Home application provide you all services which you need from rent or buy or sell for any real estate in additional to home and law services',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                  ],
                  iconColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(title: Text(
                  'what is distinguishes easy home application about any other applications related to real estate ?',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                  ),
                ),
                  children: [
                    ListTile(title:
                    Text(
                      'we provide you in our application all services which probably need related to real estate',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                    ListTile(title:
                    Text(
                      '1) buy, sell, rent any real estate easily.',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                    ListTile(title:
                    Text(
                      '2) provide a filter which help you to reach to your desired house easily.',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                    ListTile(title:
                    Text(
                      '3) we make a partnership with two types of companies Home Sevices companies and law  Services companies',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                  ],
                  iconColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark? Colors.grey[300] : Colors.grey[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(title: Text(
                  'what is our objectives?',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark? Colors.black : Colors.white,
                  ),
                ),
                  children: [
                    ListTile(title:
                    Text(
                      'we looking forward to help you in providing all services related to real estate which you need in one application smoothly and easily way',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    ),
                  ],
                  iconColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}