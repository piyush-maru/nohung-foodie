import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/location_collections/widgets/address_list_card.dart';
import 'package:provider/provider.dart';

import '../../../model/user/user_address_list.dart';
import '../../../network/user/user_address_model.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final TextEditingController _searchLocation = TextEditingController();
  late Future<List<UserLocationTypes>> addressListFuture;

  @override
  void initState() {
    super.initState();
    final addressModel = Provider.of<UserAddressModel>(context, listen: false);

    addressListFuture = addressModel.searchAddress('');
  }

  @override
  void dispose() {
    _searchLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<UserAddressModel>(
      context,
    );
    final screenWidth = MediaQuery.sizeOf(context).width;

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
                  child:
                      Image.asset("assets/images/white_back.png", height: 28)),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Color(0x2F344333)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  color: Color(0xAB404240),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchLocation,
                    cursorColor: kYellowColor,
                    decoration: const InputDecoration(
                      hintText: "Search location, Area, Street name...",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xAB404240),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (_) {
                      setState(() {
                        addressModel.searchAddress(_searchLocation.text.trim());
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<List<UserLocationTypes>>(
                future: addressModel.searchAddress(_searchLocation.text.trim()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Column(
                        children: [
                          Image.asset(
                            'assets/icons/icon_no saved_addresses.png',
                            width: screenWidth * 0.7,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          poppinsText(
                              txt: 'No Address Found',
                              fontSize: 22,
                              weight: FontWeight.w500),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) {
                            return AddressListCard(
                              address: snapshot.data![index],
                            );
                          });
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppConstant.appColor,
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
