import 'package:flutter/material.dart';
import 'package:food_app/model/searchData/home_screen_search_model.dart';
import 'package:food_app/network/home_screen_repo/home_screen_search.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../customWidgets/image_error.dart';
import '../../widgets/jumping_dots/dancing_dots.dart';
import '../kitchen_details/kitchen_details_screen.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({Key? key, this.searchText = ''}) : super(key: key);
  final String searchText;
  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final TextEditingController _searchController = TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final searchTextController = TextEditingController();
  bool canPop = true;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchText;
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _searchController.text = _lastWords;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchModel =
        Provider.of<SearchHomeScreenModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 116,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset("assets/images/backyellowbutton.png",
                      height: 28)),
            ),
            poppinsText(
                txt: "Search",
                maxLines: 3,
                fontSize: 18,
                textAlign: TextAlign.center,
                weight: FontWeight.w600),
          ],
        ),
      ),
      body: FutureBuilder<HomeScreenSearch>(
          future: searchModel.getSearchData(_searchController.text),
          builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 2,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchModel
                                    .getSearchData(_searchController.text);
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "  Search",
                              //"Search North Indian, South Indian, Jain, Diet meals",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 2),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_speechToText.isNotListening) {
                              showModalBottomSheet(
                                enableDrag: true,
                                isScrollControlled: true,
                                isDismissible: false,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25))),
                                context: context,
                                builder: (context) => WillPopScope(
                                  onWillPop: () async {
                                    return false;
                                  },
                                  child: SingleChildScrollView(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: SingleChildScrollView(
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 30),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Hi, I'm listening.\nWhat do you like to eat ?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyles
                                                          .semiBoldText,
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            kYellowColor,
                                                        child: Icon(
                                                          Icons.mic,
                                                          color: Colors.white,
                                                          size: 35,
                                                        )),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    JumpingDots(
                                                      color: kYellowColor,
                                                    )
                                                  ],
                                                ),
                                              )),
                                        )),
                                  ),
                                ),
                              );
                            }
                            Future.delayed(const Duration(seconds: 5), () {
                              if (canPop) {
                                Navigator.pop(context);
                                _stopListening();
                              }
                            });
                            _speechToText.isNotListening
                                ? _startListening()
                                : _stopListening();
                          },
                          child: _speechToText.isNotListening
                              ? const Icon(
                                  Icons.mic,
                                  color: Color(0xb5232323),
                                )
                              : const JumpingDots(
                                  height: 3,
                                  width: 2,
                                  color: kYellowColor,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null
                    ? Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 30, bottom: 20),
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              print(
                                  "snapshot.data!.data[index].image${snapshot.data!.data[index].image}");
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => KitchenDetailsScreen(
                                            snapshot
                                                .data!.data[index].kitchenId,
                                            OrderCategory.Subscription
                                                .toJsonKey(),
                                            initialIndex: (snapshot.data!
                                                        .data[index].type ==
                                                    Type.KITCHEN)
                                                ? 0
                                                : 1),
                                      ),
                                    );
                                  },
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              8), // Adjust the radius as needed
                                          child: Image.network(
                                            snapshot.data!.data[index].image,
                                            errorBuilder: (BuildContext, Object,
                                                StackTrace) {
                                              return const ImageErrorWidget();
                                            },
                                            width: 60,
                                            height: 65,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: 230,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              poppinsText(
                                                  txt: snapshot
                                                      .data!.data[index].name,
                                                  maxLines: 3,
                                                  fontSize: 11,
                                                  textAlign: TextAlign.start,
                                                  weight: FontWeight.w600),
                                              poppinsText(
                                                  txt: snapshot.data!
                                                      .data[index].description,
                                                  maxLines: 6,
                                                  fontSize: 10,
                                                  textAlign: TextAlign.start,
                                                  weight: FontWeight.w500),
                                              /* Text(
                                                snapshot.data!.data[index].name,
                                                style: const TextStyle(
                                                    fontFamily: AppConstant.fontBold),
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.data[index].description,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        AppConstant.fontRegular),
                                              ),*/
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            }),
                      )
                    : const SizedBox(
                        height: 250,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppConstant.appColor,
                          ),
                        ),
                      ),
              ],
            );
          }),
    );
  }
}
