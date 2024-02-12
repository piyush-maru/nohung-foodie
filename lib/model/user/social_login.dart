class SocialLogin {
  bool? status;
  String? message;
  Data? data;

  SocialLogin({this.status, this.message, this.data});

  SocialLogin.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userType;
  String? kitchenName;
  String? email;
  String? mobileNumber;
  String? kitchenId;
  String? riderId;
  String? password;
  String? address;
  String? stateId;
  String? cityId;
  String? pinCode;
  String? contactName;
  String? role;
  String? kitchenContactNumber;
  String? fssaiLicenceNo;
  String? expiryDate;
  String? panNo;
  String? gstNo;
  String? menuFile;
  String? firmType;
  String? foodType;
  String? fromTime;
  String? toTime;
  String? openDays;
  String? mealType;
  String? otpCode;
  String? isVerifiedOtp;
  String? otpDate;
  String? isAgreeForPolicy;
  String? city;
  String? bikeType;
  String? youHaveLicense;
  String? licenceFile;
  String? rcBookFile;
  String? passportFile;
  String? idProofFile;
  String? wallet;
  String? pointsGained;
  String? latitude;
  String? longitude;
  String? userStatus;
  String? status;
  String? createdDate;
  String? modifiedDate;

  Data(
      {this.id,
        this.userType,
        this.kitchenName,
        this.email,
        this.mobileNumber,
        this.kitchenId,
        this.riderId,
        this.password,
        this.address,
        this.stateId,
        this.cityId,
        this.pinCode,
        this.contactName,
        this.role,
        this.kitchenContactNumber,
        this.fssaiLicenceNo,
        this.expiryDate,
        this.panNo,
        this.gstNo,
        this.menuFile,
        this.firmType,
        this.foodType,
        this.fromTime,
        this.toTime,
        this.openDays,
        this.mealType,
        this.otpCode,
        this.isVerifiedOtp,
        this.otpDate,
        this.isAgreeForPolicy,
        this.city,
        this.bikeType,
        this.youHaveLicense,
        this.licenceFile,
        this.rcBookFile,
        this.passportFile,
        this.idProofFile,
        this.wallet,
        this.pointsGained,
        this.latitude,
        this.longitude,
        this.userStatus,
        this.status,
        this.createdDate,
        this.modifiedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['usertype'];
    kitchenName = json['kitchenname'];
    email = json['email'];
    mobileNumber = json['mobilenumber'];
    kitchenId = json['kitchenid'];
    riderId = json['riderid'];
    password = json['password'];
    address = json['address'];
    stateId = json['stateid'];
    cityId = json['cityid'];
    pinCode = json['pincode'];
    contactName = json['contactname'];
    role = json['role'];
    kitchenContactNumber = json['kitchencontactnumber'];
    fssaiLicenceNo = json['fssailicenceno'];
    expiryDate = json['expirydate'];
    panNo = json['panno'];
    gstNo = json['gstno'];
    menuFile = json['menufile'];
    firmType = json['firmtype'];
    foodType = json['foodtype'];
    fromTime = json['fromtime'];
    toTime = json['totime'];
    openDays = json['opendays'];
    mealType = json['mealtype'];
    otpCode = json['otpcode'];
    isVerifiedOtp = json['isverifiedotp'];
    otpDate = json['otpdate'];
    isAgreeForPolicy = json['isagreeforpolicy'];
    city = json['city'];
    bikeType = json['biketype'];
    youHaveLicense = json['youhavelicense'];
    licenceFile = json['licencefile'];
    rcBookFile = json['rcbookfile'];
    passportFile = json['passportfile'];
    idProofFile = json['idprooffile'];
    wallet = json['wallet'];
    pointsGained = json['points_gained'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userStatus = json['userstatus'];
    status = json['status'];
    createdDate = json['createddate'];
    modifiedDate = json['modifieddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['usertype'] = userType;
    data['kitchenname'] = kitchenName;
    data['email'] = email;
    data['mobilenumber'] = mobileNumber;
    data['kitchenid'] = kitchenId;
    data['riderid'] = riderId;
    data['password'] = password;
    data['address'] = address;
    data['stateid'] = stateId;
    data['cityid'] = cityId;
    data['pincode'] = pinCode;
    data['contactname'] = contactName;
    data['role'] = role;
    data['kitchencontactnumber'] = kitchenContactNumber;
    data['fssailicenceno'] = fssaiLicenceNo;
    data['expirydate'] = expiryDate;
    data['panno'] = panNo;
    data['gstno'] = gstNo;
    data['menufile'] = menuFile;
    data['firmtype'] = firmType;
    data['foodtype'] = foodType;
    data['fromtime'] = fromTime;
    data['totime'] = toTime;
    data['opendays'] = openDays;
    data['mealtype'] = mealType;
    data['otpcode'] = otpCode;
    data['isverifiedotp'] = isVerifiedOtp;
    data['otpdate'] = otpDate;
    data['isagreeforpolicy'] = isAgreeForPolicy;
    data['city'] = city;
    data['biketype'] = bikeType;
    data['youhavelicense'] = youHaveLicense;
    data['licencefile'] = licenceFile;
    data['rcbookfile'] = rcBookFile;
    data['passportfile'] = passportFile;
    data['idprooffile'] = idProofFile;
    data['wallet'] = wallet;
    data['points_gained'] = pointsGained;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['userstatus'] = userStatus;
    data['status'] = status;
    data['createddate'] = createdDate;
    data['modifieddate'] = modifiedDate;
    return data;
  }
}