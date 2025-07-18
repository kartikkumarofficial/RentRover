import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rentrover/presentation/screens/auth/login_screen.dart';
import 'package:rentrover/presentation/screens/car_list_screen.dart';



class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C2B34),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/onboarding.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium cars. \nEnjoy the luxury',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Premium and prestige car daily rental. \nExperience the thrill at a lower price',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 320,
                    height: 54,
                    child: ElevatedButton(

                        onPressed: (){
                          Get.offAll(LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white
                        ),
                        child: Text(
                          'Let\'s Go',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
