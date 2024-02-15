<?php
if(!isset($_SESSION)) {
	session_start();
}

/* // 에러를 찾고 싶다면 활성화 시켜서 확인할 수 있다.
ini_set("display_startup_errors", 1);
ini_set("display_errors", 1);
error_reporting(E_ALL);
// */

// 데이터가 제대로 넘어오는지 검증 목적
//echo '<pre>';print_r($_POST);echo '</pre>';
//echo '<pre>';print_r($_FILES);echo '</pre>';
//exit;

/*
if(!(isset($_SESSION['userID']) && !empty($_SESSION['userID']))){
	$result = array(
		'status' => "fail",
		'message' => "앱을 완전 종료후 다시 로그인하세요."
	);
	echo json_encode($result);
	exit;
}
// */

if(isset($_POST['code']) && !empty($_POST['code'])){
	@extract($_POST);
	@extract($HTTP_POST_VARS);
	@extract($HTTP_POST_FILES);

	require_once 'config/dbconnect.php';
	require_once 'phpclass/dbconnect.php';
	require_once 'phpclass/loginClass.php';
	$c = new LoginClass();

	header("Cache-Control: no-cache, must-revalidate");
	header("Content-type: application/json; charset=UTF-8");

	$json_object = array();

	$reg_date = date("Y-m-d H:i:s");
	$filename = NULL;
	if ($_FILES['file']['name']) { // 파일이 첨부되어 있으면
		$allowed_ext = array('jpg','bmp','png','gif');
		$tmpname = $_FILES['file']['tmp_name'];  // 임시파일명
		$realname  = $_FILES['file']['name'];  // 실제 파일명
		$filesize  = $_FILES['file']['size']; // 파일 크기
		$filetype  = $_FILES['file']['type']; // 파일 형태

		if (!$_FILES['file']['error']) { // 오류 없이 파일 업로드 성공
			$fileExt = getExt($realname);  // 파일 확장자 구하는 함수
			if(!in_array($fileExt, $allowed_ext)) {
					@unlink($tmpname);
					$image_url ="허용되지 않는 파일입니다.";
					$json_object = array('idx' => -1, 'code' => $code, 'result' => 'fail', 'message' => $image_url);
					echo json_encode($json_object);
					exit;
			} else {
				// 신규 파일 등록
				if (is_uploaded_file($tmpname)){  // 임시파일이 디렉토리에 존재하는 경우
					// filename 생성 규칙은 적당히 다른 것으로 대체하여 사용해도 된다.
					// 해킹 방어를 목적으로 작성한 코드이며, DB 테이블과 적정하게 사용하여 다운로드시 추정 어렵게 하는 목적
					$filename = date("Ymd").md5(uniqid($tmpname)) .round(microtime(true)).'.'.$fileExt;
					$uploadFile = "./upload/" . $filename; //change this directory
					if(move_uploaded_file($tmpname, $uploadFile)){ // 임시 디렉토리에 있던 파일을 실제 파일의 이름으로 전송
						@chmod($uploadFile,0606); // 리눅스에서 파일 권한 변경
						$sql = "insert into photo_data (code, realname, filename, userID, reg_date) VALUES ('$code', '$realname', '$filename', '$userID', '$reg_date')";
						$result = mysqli_query($db,$sql);
						if ($result) {
							$json_object = array('idx' => mysqli_insert_id($db), 'code' => $code, 'result' => 'success', 'message' => $filename);
						} else {
							$json_object = array('idx' => -1, 'code' => $code, 'result' => 'fail', 'message' => $filename);
						}
					} else {
						$image_url ="이미지를 업로드할 수 없습니다.";
						$json_object = array('idx' => -1, 'code' => $code, 'result' => 'fail', 'message' => $image_url);
					}
					echo json_encode($json_object);
				}

			} // 파일 확장자 성공시
		} // 오류없이 파일 전송 성공이면
	} // 파일이 첨부되어 있으면.

}


// 파일 확장자 추출
function getExt($filename){
	$ext = substr(strrchr($filename,"."),1); // 공격방어 감지를 위해 콤마의 취지를 뒤에서부터 검색
	// strrchr(문자열, 찾을 문자) : 찾을 문자가 마지막으로 나온 위치부터 끝까지 반환 
	// strstr(문자열, 찾을 문자) : 찾을 문자열이 나온 처음 위치부터 끝까지 반환.
	$ext = strtolower($ext); // 확장자 소문자로 변환
	return $ext;
}

/*
	FileName : photo_upload.php

	Input Variable : Post Method
		idx				(Int)			: 고유번호
		filename		(String)		: 사진파일이름
		reg_date		(String)		: 업로드일자
		userID			(String)		: 사용자 ID
		file			(Stream)		: 사진파일

	Output Value : 
		idx				(Int)			: 사진 고유번호
		code			(String)		: 코드
		result			(String)		: 로그인 결과			(Required)		=> success, fail
		message 		(String)		: 파일 URL

*/
?>
