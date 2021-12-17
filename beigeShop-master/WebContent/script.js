function register_check(){
    if (document.frm.userId.value.length == 0){
        alert("아이디를 입력해주세요.")
        document.frm.userId.focus();
        return;
    }
    if (document.frm.userPassword.value.length == 0){
        alert("비밀번호를 입력해주세요.")
        document.frm.userPassword.focus();
        return;
    }
    if (document.frm.userName.value.length == 0){
        alert("이름을 입력해주세요.")
        document.frm.userName.focus();
        return;
    }
    if (document.frm.postcode.value.length == 0){
        alert("주소를 입력해주세요.")
        document.frm.postcode.focus();
        return;
    }
    if (document.frm.mobileNumber1.value.length == 0){
        alert("휴대전화를 입력해주세요.")
        document.frm.mobileNumber1.focus();
        return;
    }
    if (document.frm.userEmail.value.length == 0){
        alert("이메일를 입력해주세요.")
        document.frm.userEmail.focus();
        return;
    }

    // // if (document.frm.inputCertificateNumber.value.disabled = false){
    // if ($('#result').text() != '인증완료'){
    //     alert("휴대전화 인증을 해주세요.")
    //     document.frm.inputCertificateNumber.focus();
    //     return;
    // }

    if ($('#checkId').text() == '중복된 아이디입니다.'){
        alert("중복된 아이디입니다.");
        return;
    }


    var f = document.frm;
    if (f.userPassword.value == f.userPasswordCheck.value) {

        f.phoneNumber.value = f.phoneNumber1.value + "-" + f.phoneNumber2.value + "-" + f.phoneNumber3.value;
        f.mobileNumber.value = f.mobileNumber1.value + "-" + f.mobileNumber2.value + "-" + f.mobileNumber3.value;
        f.userAddress.value = f.postcode.value + "/" + f.address.value + "/" + f.extraAddress.value + "/" + f.detailAddress.value;
        alert("회원가입이 완료됐습니다.");
        f.submit();

    } else {
        alert("비밀번호를 확인해주세요.");
        f.userPasswordCheck.focus();
        return false;

    }
}

$( document ).ready( function() {
    $( '#checkDefaultAll' ).click( function() {
        $( '.check' ).prop( 'checked', this.checked );
    } );
} );


function update_check(){
    if (document.frm.userId.value.length == 0){
        alert("아이디를 입력해주세요.")
        document.frm.userId.focus();
        return;
    }
    if (document.frm.userPassword.value.length == 0){
        alert("비밀번호를 입력해주세요.")
        document.frm.userPassword.focus();
        return;
    }
    if (document.frm.userName.value.length == 0){
        alert("이름을 입력해주세요.")
        document.frm.userName.focus();
        return;
    }
    if (document.frm.postcode.value.length == 0){
        alert("주소를 입력해주세요.")
        document.frm.postcode.focus();
        return;
    }
    if (document.frm.mobileNumber1.value.length == 0){
        alert("휴대전화를 입력해주세요.")
        document.frm.mobileNumber1.focus();
        return;
    }
    if (document.frm.userEmail.value.length == 0){
        alert("이메일를 입력해주세요.")
        document.frm.userEmail.focus();
        return;
    }

    var f = document.frm;
    if (f.userPassword.value == f.userPasswordCheck.value) {

        f.phoneNumber.value = f.phoneNumber1.value + "-" + f.phoneNumber2.value + "-" + f.phoneNumber3.value;
        f.mobileNumber.value = f.mobileNumber1.value + "-" + f.mobileNumber2.value + "-" + f.mobileNumber3.value;
        f.userAddress.value = f.postcode.value + "/" + f.address.value + "/" + f.extraAddress.value + "/" + f.detailAddress.value;
        alert("정상");
        f.submit();

    } else {
        alert("비밀번호를 확인해주세요.");
        f.userPasswordCheck.focus();
    }
}

function delete_check() {
	if(confirm("정말 탈퇴하시겠습니까?")) {
		document.deleteForm.submit();
	} else {
		location.href = "updateUser.jsp";
	}
}

function delete_check_admin(qID) {
	if(confirm("정말 탈퇴 처리하시겠습니까?")) {
		location.href = "deleteMember.jsp?delete_mID=" + qID;
	} else {
		location.reload();
	}
}



$(document).ready(function (){

    var f = document.frm;

    $('#sendPhoneNumber').click(function (){
        var phone = f.mobileNumber1.value + "-" + f.mobileNumber2.value + "-" + f.mobileNumber3.value;

        if (phone == 0){
            $('#result').text('전화번호를 입력하세요');
            return;
        }
        // ajax 사용
        $.ajax({
            type : 'GET',
            url:'phoneCertificationAction.jsp',
            dataType : 'text',
            data: {phoneNumber : phone},
            success: function(data){
                cerNum = data.trim();
                $('#result').text('발송완료');

                $('#checkBtn').click(function () {
                    console.log(cerNum);
                    console.log($('#inputCertificateNumber').val())
                    if ($('#inputCertificateNumber').val() == cerNum) {
                        $('#result').text("인증완료");
                        document.getElementById("mobile1").disabled=true;
                        document.getElementById("mobile2").disabled=true;
                        document.getElementById("mobile3").disabled=true;
                        document.getElementById("inputCertificateNumber").disabled=true;

                    } else{
                        $('#result').text("인증완료실패");
                    }
                });
            },
            error: function(){
                $('#result').text('실패')
            }
        });
    });
});


