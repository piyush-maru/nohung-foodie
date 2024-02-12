import 'package:flutter/material.dart';

import '../utils/constants/app_constants.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var text1 = '''This Privacy Policy ("Policy") describes the policies and
procedures for the collection, use, disclosure and
protection of your information when you use our
website located at nohung.com, or the NOHUNG mobile
application (collectively, "NOHUNG Platform", "NOHUNG",
"Company", "we", "us" and "our"), a private company
established under the laws of India. The terms "you"
and "your" refer to the user of the NOHUNG Platform.
The term "Services" refers to any services offered by
NOHUNG whether on the NOHUNG Platform or otherwise.
Please read this Policy before using the NOHUNG
Platform or submitting any personal information to
NOHUNG. This Policy is a part of an incorporated within
and is to be read along with the Terms of Use.
''';
  var bold1 = 'YOUR CONSENT';
  var text2 = '''
  
By using the NOHUNG Platform and the Services, you
agree and consent to the collection, transfer, use,
storage, disclosure, and sharing of your information
as described and collected by us in accordance with
this Policy. If you do not agree with the Policy, please
do not use or access the NOHUNG Platform.
''';
  var bold2 = 'POLICY CHANGES';
  var text3 = '''
  
We may occasionally update this Policy and such
changes will be posted on this page. If we make any
significant changes to this Policy we will endeavor to
provide you with reasonable notice of such changes,
such as via prominent notice on the NOHUNG Platform
or to your email address on record, and where required
by applicable law, we will obtain your consent. To the
extent permitted under the applicable law, your
continued use of our Services after we publish or send
a notice about our changes to this Policy shall
constitute your consent to the updated Policy.
''';
  var bold3 = 'LINKS TO OTHER WEBSITES';
  var text4 = '''
  
The NOHUNG Platform may contain links to other
websites. Any personal information about you
collected while visiting such websites is not governed
by this Policy. NOHUNG shall not be responsible for
and has no control over the practices and content
of any website accessed using the links contained
on the NOHUNG Platform. This Policy shall not apply to
any information you may disclose to any of our service
providers/service personnel which we do not require
you to disclose to us or any of our service providers
under this Policy.
''';
  var bold4 = 'INFORMATION WE COLLECT FROM YOU';
  var text5 = '''
  
Device Information: To improve your app experience
and lend stability to our services to you, we may
collect information or employ third-party plugins that
collect information about the devices you use to
access our Services, including the hardware models,
operating systems, and versions, software, file names,
and versions, preferred languages, unique device
identifiers, advertising identifiers, serial numbers,
device motion information, mobile network information,
installed applications on device and phone state. The
information collected thus will be disclosed to or
collected directly by these plugins and may be used
to improve the content and/or functionality of the
services offered to you. Analytics companies may use
mobile device IDs to track your usage of the NOHUNG
Platform.
''';
  var bold5 = 'COOKIES';
  var text6 = '''
  
Our NOHUNG Platform and third parties with whom we
partner may use cookies, pixel tags, web beacons,
mobile device IDs, "flash cookies" and similar files or
technologies to collect and store information with
respect to your use of the Services and third-party
websites. Cookies are small files stored on your
browser or device by websites, apps, online media and
advertisements. We use cookies and similar
technologies for purposes such as: Authenticating
users; Remembering user preferences and settings;
Determining the popularity of content. Delivering and
measuring the effectiveness of advertising campaigns;
Analyzing site traffic and trends, and generally
understanding the online behaviors and interests of
people who interact with our services. A pixel tag (also
called a web beacon or clear GIF) is a tiny graphic with
a unique identifier, embedded invisibly on a webpage
(or an online ad or email), and is used to count or
track things like activity on a webpage or ad
impressions or clicks, as well as to access cookies
stored on the users’ computers. We use pixel tags to
measure the popularity of our various pages, features
and services. Further, we may include web beacons in
e-mail messages or newsletters to determine whether
the message has been opened and for other analytics.
To modify your cookie settings, please visit your
browser’s settings. By using our Services with your
browser settings to accept cookies, you are consenting
to our use of cookies in the manner described in this
section. We may also allow third parties to provide
audience measurement and analytics services for us,
to serve advertisements on our behalf across the
Internet and track and report on the performance of
those advertisements. These entities may use cookies,
web beacons, SDKs, and other technologies to identify
your device when you visit the NOHUNG Platform and
use our Services, as well as when you visit other online
sites and services. Please see our Cookie Policy for
more information regarding the use of cookies and
other technologies described in this section, including
your choices relating to such technologies.
''';
  var bold6 = 'USES OF YOUR INFORMATION:';
  var text7 = '''

We use the information we collect for the following
purposes, including: To provide, personalize, maintain
and improve our products and services, such as to
enable deliveries and other services, enable features to
personalise your NOHUNG account; To carry out our
obligations arising from any contracts entered into
between you and us and to provide you with the
relevant information and services; To administer and
enhance the security of our NOHUNG Platform and for
internal operations, including troubleshooting, data
analysis, testing, research, statistical and survey
purposes; To provide you with information about
services we consider similar to those that you are
already using, have enquired about, or may interest
you. If you are a registered user, we will contact you
by electronic means (e-mail or SMS or telephone or
other internet-based instant messaging systems) with
information about these services; To understand our
users (what they do on our Services, what features
they like, how they use them, etc.), improve the
content and features of our Services (such as by
personalising content to your interests), process and
complete your transactions, make special offers,
provide customer support, process and respond to
your queries; To generate and review reports and
data about, and to conduct research on, our user
base and Service usage patterns; To allow you to
participate in interactive features of our Services if
any; or To measure or understand the effectiveness
of advertising we serve to you and others, and to
deliver relevant advertising to you. If you are a partner
restaurant or merchant or delivery partner, to track
the progress of delivery or status of the order placed
by our customers. To carry out academic research
with academic partners. We may combine the
information that we receive from third parties with the
information you give to us and the information we
collect about you for the purposes set out above.
Further, we may anonymize and/or de-identify
information collected from you through the Services
or via other means, including via the use of third-party
web analytic tools. As a result, our use and disclosure
of aggregated and/or de-identified information are
not restricted by this Policy, and it may be used and
disclosed to others without limitation. We analyse the
log files of our NOHUNG Platform that may contain
Internet Protocol (IP) addresses, browser type and
language, Internet service provider (ISP), referring, app
crashes, page viewed and exit websites and
applications, operating system, date/time stamp and
clickstream data. This helps us to administer the
website, to learn about user behaviour on the site, to
improve our product and services, and gather
demographic information about our user base as a
whole.
''';
  var bold7 = 'DISCLOSURE AND DISTRIBUTION OF YOUR INFORMATION';
  var text8 = '''
  
We may share the information that we collect for the
following purposes: With Service Providers: We may
share your information with our vendors, consultants,
marketing partners, research firms, and other service
providers or business partners, such as payment
processing companies, to support our business. For
example, your information may be shared with
outside vendors to send you emails and messages
or push notifications to your devices in relation to our
Services, to help us analyze and improve the use of
our Services, to process and collect payments. We
also may use vendors for other projects, such as
conducting surveys or organizing sweepstakes for us.
With Partner Restaurants/Merchant: While you place a
request to order food through the NOHUNG Platform,
your information is provided to us and to the
restaurants/merchants with whom you may choose
to order. In order to facilitate your online food order
processing, we provide your information to that
restaurant/merchant in a similar manner as if you
had made a food order directly with the restaurant. If
you provide a mobile phone number, NOHUNG may
send you text messages regarding the order’s delivery
status. With Academic Partners: We may share your
information with our academic partners to carry out
academic research. With Other Users: If you are a
delivery partner, we may share your name, phone
number, and/or profile picture (if applicable), and
tracking details with other users to provide them with
the Services. For Crime Prevention or Investigation. We
may share this information with governmental
agencies or other companies assisting us when we
are: Obligated under the applicable laws or in good
faith to respond to court orders and processes or
Detecting and preventing against the actual or
potential occurrence of identity theft, fraud, abuse
of Services and other illegal acts; Responding to
claims that an advertisement, posting, or other
content violates the intellectual property rights of a
third party; Under a duty to disclose or share your
personal data to enforce our Terms of Use and other
agreements, policies or to protect the rights, property
or safety of the Company, our customers, others or in
the event of a claim or dispute relating to your use of
our Services. This includes exchanging information
with other companies and organizations for fraud
detection and credit risk reduction. For Internal Use:
We may share your information with any present or
future member of our "Group" (as defined below)or
affiliates for our internal business purposes The term
"Group" means, concerning any person, any entity
that is controlled by such person, or any entity that
controls such person, or any entity that is under
common control with such person, whether directly
or indirectly, or, in the case of a natural person, any
Relative (as such term is defined in the Companies
Act, 1956 and Companies Act, 2013 to the extent
applicable) of such person. With Advertisers and
advertising networks: We may work with third parties
such as network advertisers to serve advertisements
on the NOHUNG Platform and third-party websites or
other media (e.g., social networking platforms).
These third parties may use cookies, JavaScript,
web beacons (including clear GIFs), Flash LSOs and
other tracking technologies to measure the
effectiveness of their ads and to personalise
advertising content to you. While you cannot opt out
of advertising on the NOHUNG Platform, you may opt
out of much-interest-based advertising on third-party
sites and through third-party ad networks (including
DoubleClick Ad Exchange, Facebook Audience
Network, and Google AdSense). For more information,
visit www.aboutads.info/choices. Opting out means
that you will no longer receive personalised ads by
third parties ad networks from which you have opted
out, which is based on your browsing information
across multiple sites and online services. If you delete
cookies or change devices, your opt-out may no
longer be effective. To fulfil the purpose for which you
provide it. We may share your information other than
as described in this Policy if we notify you and you
consent to the sharing.
''';
  var bold8 = 'DATA SECURITY PRECAUTIONS';
  var text9 = '''
  
We have appropriate technical and security measures
in place to secure the information collected by us. We
use vault and tokenization services from third-party
service providers to protect the sensitive personal
information provided by you. The third-party service
providers for our vault and tokenization services and
our payment gateway and payment processing are
compliant with the payment card industry standard
(generally referred to as PCI compliant service
providers). You are advised not to send your full
credit/debit card details through unencrypted
electronic platforms. Where we have given you (or
where you have chosen) a username and password
which enables you to access certain parts of the
NOHUNG Platform, you are responsible for keeping
these details confidential. We ask you not to share
your password with anyone. Please be aware that
the transmission of information via the internet is not
completely secure. Although we will do our best to
protect your personal data, we cannot guarantee the
security of your data transmitted through the NOHUNG
Platform. Once we ave received your information, we
will use strict physical, electronic, and procedural
safeguards to try to prevent unauthorized access.
OPT-OUT When you sign up for an account, you opt-in
to receive emails from NOHUNG. You can log in to
manage your email preferences [here] or you can
follow the "unsubscribe" instructions in commercial
email messages, but note that you cannot opt-out
of receiving certain administrative notices, service
notices, or legal notices from NOHUNG. If you wish to
withdraw your consent for the use and disclosure of
your personal information in the manner provided in
this Policy or if you want your data to be deleted,
please write to us at contact@nohung.com. Please
note that we may take time to process such requests
and your request shall take effect no later than 5 (Five)
business days from the receipt of such request, after
which we will not use your personal data for any
processing unless required by us to comply with our
legal obligations. We may not be able to offer you any
or all Services upon such withdrawal of your consent.
''';
  var bold9 = 'GRIEVANCE OFFICER AND NOHUNG PLATFORM SECURITY';
  var text10 = '''

If you have any queries relating to the processing or
usage of information provided by you in connection
with this Policy, please email us at
contact@nohung.com or write to our Grievance
Officer at our address. If you come across any abuse
or violation of the Policy, please report it to
contact@nohung.com
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appColor,
      appBar: AppBar(
        leadingWidth: 150,
        leading: Row(
          children: [
            SizedBox(width: 8),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Image.asset("assets/images/white_backButton.png", height: 23),
            ),
            SizedBox(width: 8),
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 16,
                color: black1,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.appColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/privacy_policy.png'),
                      height: 176,
                      width: 166,
                    ),
                  ),
                  Text(
                    text1,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold1,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold2,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text3,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold3,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text4,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold4,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text5,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold5,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text6,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold6,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text7,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold7,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text8,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold8,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text9,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    bold9,
                    style: TextStyle(
                      fontSize: 14,
                      color: black1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    text10,
                    style: TextStyle(
                      fontSize: 13,
                      color: black1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
