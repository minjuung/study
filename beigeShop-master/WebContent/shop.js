function check_ok(){
	
	if(document.form.s_name.value.length ==0){
		alert("이름을 입력하세요.");
		form.s_name.focus();//유효성 체크라고 함.
		return;
	}
	if(document.form.s_price.value.length == 0){
		alert("판매가를 입력하세요.");
		form.s_price.focus();
		return;
	}
	if(document.form.s_stock.value.length == 0){
		alert("재고량을 입력하세요.");
		form.s_stock.focus();
		return;
	}

	document.form.submit();

}

function check_edit() {
	if(document.shopEditForm.s_name.value.length ==0){
		alert("이름을 입력하세요.");
		form.s_name.focus();//유효성 체크라고 함.
		return;
	}
	if(document.shopEditForm.s_price.value.length == 0){
		alert("판매가를 입력하세요.");
		form.s_price.focus();
		return;
	}
	if(document.shopEditForm.s_stock.value.length == 0){
		alert("재고량을 입력하세요.");
		form.s_stock.focus();
		return;
	}

	document.shopEditForm.submit();
}

function search_ok(){
	if(document.form.search.value.length == 0){
		alert("검색어를 입력하세요.");
		form.search.focus();
		return;
	}
	document.form.submit();
}

function delete_ok(sID) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		location.href="deleteShop.jsp?s_id=" + sID;  
	} else {
		location.reload();
	}
}