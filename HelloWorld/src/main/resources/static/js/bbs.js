$(document).ready(function dataSend() {
    $.ajax({
        url: "/bbsview",
        type: "GET",
        dataType: "json",
    }).done(function (data) {
        $("#resultDiv").text(JSON.stringify(data));
        console.log("성공");

    }).fail(function () {
        console.log("실패");
    })
});