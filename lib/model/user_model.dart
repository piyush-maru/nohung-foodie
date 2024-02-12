
class Foodie  {
    bool? status;
    String? message;
    Data? data;

    Foodie({this.status, this.message, this.data});

    Foodie.fromJson(Map<String, dynamic> json) {
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

class Data{
    String? kitchenName;
    String? email;
    String? address;
    String? stateId;
    String? cityId;
    String? pinCode;
    String? contactName;
    String? role;
    String? mobileNumber;
    String? kitchenContactNumber;
    String? fssaiLicenceNo;
    String? expiryDate;
    String? panNo;
    String? gstNo;
    int? userStatus;
    int? status;
    String? createdDate;
    String? modifiedDate;
    int? kitchenId;
    String? password;
    String? menuFile;
    String? documentFile;
    String? userId;

    Data(
        {this.kitchenName,
            this.email,
            this.address,
            this.stateId,
            this.cityId,
            this.pinCode,
            this.contactName,
            this.role,
            this.mobileNumber,
            this.kitchenContactNumber,
            this.fssaiLicenceNo,
            this.expiryDate,
            this.panNo,
            this.gstNo,
            this.userStatus,
            this.status,
            this.createdDate,
            this.modifiedDate,
            this.kitchenId,
            this.password,
            this.menuFile,
            this.documentFile,
            this.userId});

    Data.fromJson(Map<String, dynamic> json) {
        kitchenName = json['kitchenname'];
        email = json['email'];
        address = json['address'];
        stateId = json['stateid'];
        cityId = json['cityid'];
        pinCode = json['pincode'];
        contactName = json['contactname'];
        role = json['role'];
        mobileNumber = json['mobilenumber'];
        kitchenContactNumber = json['kitchencontactnumber'];
        fssaiLicenceNo = json['fssailicenceno'];
        expiryDate = json['expirydate'];
        panNo = json['panno'];
        gstNo = json['gstno'];
        userStatus = json['userstatus'];
        status = json['status'];
        createdDate = json['createddate'];
        modifiedDate = json['modifieddate'];
        kitchenId = json['kitchenid'];
        password = json['password'];
        menuFile = json['menu_file'];
        documentFile = json['document_file'];
        userId = json['user_id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['kitchenname'] = kitchenName;
        data['email'] = email;
        data['address'] = address;
        data['stateid'] = stateId;
        data['cityid'] = cityId;
        data['pincode'] = pinCode;
        data['contactname'] = contactName;
        data['role'] = role;
        data['mobilenumber'] = mobileNumber;
        data['kitchencontactnumber'] = kitchenContactNumber;
        data['fssailicenceno'] = fssaiLicenceNo;
        data['expirydate'] = expiryDate;
        data['panno'] = panNo;
        data['gstno'] = gstNo;
        data['userstatus'] = userStatus;
        data['status'] = status;
        data['createddate'] = createdDate;
        data['modifieddate'] = modifiedDate;
        data['kitchenid'] = kitchenId;
        data['password'] = password;
        data['menu_file'] = menuFile;
        data['document_file'] = documentFile;
        data['user_id'] = userId;
        return data;
    }
}