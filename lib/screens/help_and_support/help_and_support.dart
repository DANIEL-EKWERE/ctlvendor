import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/widgets/custom_text_field.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.chevron_left_rounded),
        ),
        title: Text('Help and Support'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Call or Chat with us and we will answer your questions',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          SvgPicture.asset('assets/phone.svg'),
                          const Text(
                            'www.ctl.elianaeliohotels.com',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          SvgPicture.asset('assets/phone.svg'),
                          const Text(
                            '+2347123456789',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          SvgPicture.asset('assets/help_support.svg'),
                          Text(
                            'hello@ctl.elianaeliohotels.com',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          SvgPicture.asset('assets/office.svg'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Corporate Office',
                                style: TextStyle(
                                  color: Color(0xff3D3D3D),
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '#12 Your address, LGA\nState, Nigeria',
                                style: TextStyle(
                                  color: Color(0xff3D3D3D),
                                  fontFamily: 'Roboto',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          // RichText(
                          //   text: TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: '#12 Your address, LGA\nState, Nigeria',

                          //         style: TextStyle(
                          //           color: Color(0xff3D3D3D),
                          //           fontFamily: 'Roboto',
                          //           fontSize: 10,
                          //           fontWeight: FontWeight.w600
                          //           //decoration: TextDecoration.underline,
                          //         ),
                          //       ),
                          //     ],
                          //     text: '\nCorporate Office',
                          //     //style: DefaultTextStyle.of(context).style,
                          //     style: TextStyle(color: Color(0xff3D3D3D),
                          //           fontFamily: 'Roboto',
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.w600)
                          //   ),
                          // ),
                        ],
                      ),
                      // Spacer(),
                      SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 25),
                          SizedBox(
                            width: 77.65,
                            height: 20,
                            child:
                                //CustomButton(text: 'Get Direcition', onPressed: (){})
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Get Direction',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffFECC2B),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                          ),
                        ],
                      ),
                      // Spacer(),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/map.png'),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            //topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            //bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get In Touch.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Color(0xffF24A00),
                      ),
                    ),
                    const Text(
                      'Chat with our customer care representative',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Color(0xff3D3D3D),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CustomTextField(hint: 'Name'),
                    const SizedBox(height: 10),
                    const Row(
                      spacing: 10,
                      children: [
                        Expanded(child: CustomTextField(hint: 'Number')),
                        Expanded(child: CustomTextField(hint: 'Email')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Your Message',
                          hintStyle: const TextStyle(color: Colors.black12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black12,
                            ),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 77.65,
                        height: 30,
                        child:
                            //CustomButton(text: 'Get Direcition', onPressed: (){})
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFECC2B),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/faq.svg'),
                          const Text('FAQ'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/facebook.svg'),
                        SvgPicture.asset('assets/instagram.svg'),
                        SvgPicture.asset('assets/x.svg'),
                        SvgPicture.asset('assets/telegram.svg'),
                        SvgPicture.asset('assets/linkedin.svg'),
                        SvgPicture.asset('assets/whatsApp.svg'),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
