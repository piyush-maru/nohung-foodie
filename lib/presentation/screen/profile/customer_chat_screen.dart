import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/customer_chat/receiver_messages.dart';
import '../../../network/chat_repo/customer_chat_repo.dart';

class CustomerChatScreen extends StatefulWidget {
  final Function refreshCallBack;

  const CustomerChatScreen({required this.refreshCallBack, Key? key})
      : super(key: key);

  @override
  _CustomerChatScreenState createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  var type = "";
  Future<ChatReceiverModel>? future;
  ScrollController scrollController = ScrollController();

  final messageController = TextEditingController();

  void clearText() {
    messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final chatModel = Provider.of<ChatModel>(context, listen: false);
    chatModel.receiveMessage().then((value) {
      setState(() {
        chats = value.data.reversed.toList();
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(
    //     scrollController.position.maxScrollExtent,
    //     curve: Curves.easeInOut,
    //     duration: const Duration(milliseconds: 500),
    //   );
    // });
    //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 20), curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (scrollController.hasClients) {
    //     scrollController.animateTo(scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 500),
    //         curve: Curves.fastOutSlowIn);
    //   }
    // });
  }

  List<Datum> chats = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final chatModel = Provider.of<ChatModel>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                      "assets/images/white_backButton.png",
                      height: 23)),
              const SizedBox(width: 8),
              poppinsText(
                  txt: "Chat with NOHUNG",
                  maxLines: 3,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500),
            ],
          ),
          backgroundColor: const Color(0xffffb300),
          elevation: 0,
        ),
        backgroundColor: const Color(0xffffb300),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                          height: 147,
                          child: Center(
                            child: Image.asset(
                              "assets/images/message_image.png",
                            ),
                          )),
                    ),

                    Expanded(
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        child: ListView.builder(
                            reverse: true,
                            //dragStartBehavior: DragStartBehavior.down,
                            shrinkWrap: true,
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              chats.sort(
                                  (a, b) => b.createdDate.compareTo(a.createdDate));
                              return Container(
                                // height: 50,
                                margin: const EdgeInsets.only(right: 10.0, bottom: 10),
                                //constraints: BoxConstraints(maxWidth: 150,maxHeight: 125),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 15),
                                decoration:  BoxDecoration(
                                  color: Color(0xffffb300).withOpacity(0.75),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8)
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: poppinsText(
                                txt: chats[index].message,
                                    maxLines: 3,
                                    fontSize: 13,
                                    textAlign: TextAlign.start,
                                    weight: FontWeight.w400),),

                                    /*Align(
                                        alignment: Alignment.bottomRight,
                                        child: poppinsText(
                                            txt: chats[index].time,
                                            maxLines: 3,
                                            fontSize: 12,
                                            textAlign: TextAlign.center,
                                            weight: FontWeight.w400),),*/
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(6.0),
                        ),
                        child: Container(
                         // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,//const Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      messageController.text.isEmpty
                                          ? ScaffoldMessenger.of(context).showSnackBar(
                                               SnackBar(
                                                content: poppinsText(
                                                    txt: "Write message",
                                                    maxLines: 3,
                                                    fontSize: 13,
                                                    textAlign: TextAlign.center,
                                                    weight: FontWeight.w400),
                                              ),
                                            )
                                          : chatModel
                                              .sendMessage(messageController.text)
                                              .then((value) {
                                              setState(() {
                                                chats.add(Datum(
                                                    createdDate: value.data.createddate,
                                                    time: value.data.createddate.toString(),
                                                    msgType: value.data.msgType,
                                                    message: value.data.message));
                                                messageController.clear();
                                              });
                                            });
                                    },
                                    child: Image.asset(
                                     "assets/images/wright_side_back.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                ),
                                hintText: "Write Message",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
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
