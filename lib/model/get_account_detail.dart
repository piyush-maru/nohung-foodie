class GetAccountDetails {
    bool? status;
    String? message;
    Data? data;

    GetAccountDetails({this.status, this.message, this.data});

    GetAccountDetails.fromJson(Map<String, dynamic> json) {
        status = json['status'];
        message = json['message'];
        data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['status'] = status;
        data['message'] = message;
        if (this.data != null) {
            data['data'] = this.data!.toJson();
        }
        return data;
    }
}

class Data {
    String? userId;
    String? kitchenName;
    String? address;
    String? email;
    String? mobileNumber;
    String? password;
    String? typeOfFirm;
    String? typeOfFood;
    String? fromTime;
    String? toTime;
    String? openDays;
    String? typeOfMeals;
    String? totalRating;
    String? menuFile;
    String? documentFile;

    Data(
        {this.userId,
            this.kitchenName,
            this.address,
            this.email,
            this.mobileNumber,
            this.password,
            this.typeOfFirm,
            this.typeOfFood,
            this.fromTime,
            this.toTime,
            this.openDays,
            this.typeOfMeals,
            this.totalRating,
            this.menuFile,
            this.documentFile});

    Data.fromJson(Map<String, dynamic> json) {
        userId = json['user_id'];
        kitchenName = json['kitchen_name'];
        address = json['address'];
        email = json['email'];
        mobileNumber = json['mobile_number'];
        password = json['password'];
        typeOfFirm = json['type_of_firm'];
        typeOfFood = json['type_of_food'];
        fromTime = json['from_time'];
        toTime = json['to_time'];
        openDays = json['open_days'];
        typeOfMeals = json['type_of_meals'];
        totalRating = json['totalrating'];
        menuFile = json['menufile'];
        documentFile = json['documentfile'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['user_id'] = userId;
        data['kitchen_name'] = kitchenName;
        data['address'] = address;
        data['email'] = email;
        data['mobile_number'] = mobileNumber;
        data['password'] = password;
        data['type_of_firm'] = typeOfFirm;
        data['type_of_food'] = typeOfFood;
        data['from_time'] = fromTime;
        data['to_time'] = toTime;
        data['open_days'] = openDays;
        data['type_of_meals'] = typeOfMeals;
        data['totalrating'] = totalRating;
        data['menufile'] = menuFile;
        data['documentfile'] = documentFile;
        return data;
    }
}
