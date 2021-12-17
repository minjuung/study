package user;

public class UserDTO {
    private String userId;        //사용자 아이디
    private String userPassword;  //사용자 비밀번호
    private String userName;      //사용자 이름
    private String userAddress;   //사용자 주소
    private String mobileNumber;     //휴대전화
    private String phoneNumber;  //일반전화
    private String userEmail;
    private int userGrade;
    private String userSingUp;

    private String postcode;
    private String address;
    private String detailAddress;
    private String extraAddress;


    private String phoneNumber1;
    private String phoneNumber2;
    private String phoneNumber3;
    private String mobileNumber1;
    private String mobileNumber2;
    private String mobileNumber3;
    
    private int userPurchase;


    public UserDTO(String userId) {
        this.userId = userId;
    }

    public UserDTO(String phoneNumber1, String phoneNumber2, String phoneNumber3, String mobileNumber1, String mobileNumber2, String mobileNumber3) {
        this.phoneNumber1 = phoneNumber1;
        this.phoneNumber2 = phoneNumber2;
        this.phoneNumber3 = phoneNumber3;
        this.mobileNumber1 = mobileNumber1;
        this.mobileNumber2 = mobileNumber2;
        this.mobileNumber3 = mobileNumber3;
    }


    public UserDTO(String postCode, String address, String detailAddress, String extraAddress) {
        this.postcode = postCode;
        this.address = address;
        this.detailAddress = detailAddress;
        this.extraAddress = extraAddress;
    }


    public UserDTO() {

    }

//
//    public UserDTO(String userId, String userPassword, String userName, String userAddress, String mobileNumber, String phoneNumber, String userEmail) {
//        this.userId = userId;
//        this.userPassword = userPassword;
//        this.userName = userName;
//        this.userAddress = userAddress;
//        this.mobileNumber = mobileNumber;
//        this.phoneNumber = phoneNumber;
//        this.userEmail = userEmail;
//    }

    public UserDTO(String userId, String userPassword, String userName, String userAddress, String mobileNumber, String phoneNumber, String userEmail, int userGrade, String userSingUp) {
        this.userId = userId;
        this.userPassword = userPassword;
        this.userName = userName;
        this.userAddress = userAddress;
        this.mobileNumber = mobileNumber;
        this.phoneNumber = phoneNumber;
        this.userEmail = userEmail;
        this.userGrade = userGrade;
        this.userSingUp = userSingUp;
    }

    public String getPhoneNumber1() {
        return phoneNumber1;
    }

    public String getPhoneNumber2() {
        return phoneNumber2;
    }

    public String getPhoneNumber3() {
        return phoneNumber3;
    }

    public String getMobileNumber1() {
        return mobileNumber1;
    }

    public String getMobileNumber2() {
        return mobileNumber2;
    }

    public String getMobileNumber3() {
        return mobileNumber3;
    }


    public String getPostcode() {
        return postcode;
    }

    public String getAddress() {
        return address;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public String getExtraAddress() {
        return extraAddress;
    }


    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getUserGrade() {
        return userGrade;
    }

    public void setUserGrade(int userGrade) {
        this.userGrade = userGrade;
    }

    public String getUserSingUp() {
        return userSingUp;
    }

    public void setUserSingUp(String userSingUp) {
        this.userSingUp = userSingUp;
    }

	public int getUserPurchase() {
		return userPurchase;
	}

	public void setUserPurchase(int userPurchase) {
		this.userPurchase = userPurchase;
	}
}
