import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Last updated: September 20, 2021 \n '
                'Please read these terms and conditions carefully before using Our Service.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
              Text(
                'Termination',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We may terminate or suspend Your access immediately, without prior notice or liability, for any reason whatsoever, including without limitation if You breach these Terms and Conditions.\n Upon termination, Your right to use the Service will cease immediately.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
              Text(
                '"AS IS" and "AS AVAILABLE" Disclaimer',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The Service is provided to You "AS IS" and "AS AVAILABLE" and with all faults and defects without warranty of any kind. To the maximum extent permitted under applicable law, the Company, on its own behalf and on behalf of its Affiliates and its and their respective licensors and service providers, expressly disclaims all warranties, whether express, implied, statutory or otherwise, with respect to the Service, including all implied warranties of merchantability, fitness for a particular purpose, title and non-infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice. Without limitation to the foregoing, the Company provides no warranty or undertaking, and makes no representation of any kind that the Service will meet Your requirements, achieve any intended results, be compatible or work with any other software, applications, systems or services, operate without interruption, meet any performance or reliability standards or be error free or that any errors or defects can or will be corrected.\n Without limiting the foregoing, neither the Company nor any of the company\'s provider makes any representation or warranty of any kind, express or implied: (i) as to the operation or availability of the Service, or the information, content, and materials or products included thereon; (ii) that the Service will be uninterrupted or error-free; (iii) as to the accuracy, reliability, or currency of any information or content provided through the Service; or (iv) that the Service, its servers, the content, or e-mails sent from or on behalf of the Company are free of viruses, scripts, trojan horses, worms, malware, timebombs or other harmful components.\n Some jurisdictions do not allow the exclusion of certain types of warranties or limitations on applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to You. But in such a case the exclusions and limitations set forth in this section shall be applied to the greatest extent enforceable under applicable law.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
              Text(
                'Governing Law',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The laws of the Country, excluding its conflicts of law rules, shall govern this Terms and Your use of the Service. Your use of the Application may also be subject to other local, state, national, or international laws.',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
              Text(
                'Contact Us',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'If you have any questions about this Privacy Policy, You can contact us: \n By email: admin@gmail.com',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
