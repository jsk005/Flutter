<?php
class LoginClass extends DBController {
	// class 자식클래스 extends 부모클래스
	// override : 부모 클래스와 자식 클래스가 같은 메소드를 정의했을 경우 자식 클래스가 우선시된다.

    //////////// SHA256 비밀번호 암호화 
	public function hashSSHA($password) {
        $salt = sha1(rand());
        $salt = substr($salt, 0, 20);
		$encrypted = base64_encode(hash('sha256', $salt.$password, true) . $salt);
        $hash = array("salt" => $salt, "encrypted" => $encrypted);
        return $hash;
    }

    public function checkhashSSHA($salt, $password) {
		$hash = base64_encode(hash('sha256', $salt.$password, true) . $salt);
        return $hash;
    }

    // 회원 정보 신규 입력
    public function storeUser($userID, $name, $password, $telNO, $mobileNO,$email) {
        $hash = $this->hashSSHA($password);
        $encrypted_passwd = $hash['encrypted']; // encrypted password
        $salt = $hash['salt']; // salt

        $stmt = $this->db->prepare("INSERT INTO members(userID, userNM, passwd, salt, telNO,mobileNO,email, reg_date) VALUES(?, ?, ?, ?, ?, ?, ?, NOW())");
        $stmt->bind_param("sssssss", $userID, $name, $encrypted_passwd, $salt, $telNO, $mobileNO,$email);
        $result = $stmt->execute();
        $stmt->close();

        // check for successful store
        if ($result) {
            $stmt = $this->db->prepare("SELECT * FROM members WHERE userID = ?");
            $stmt->bind_param("s", $userID);
            $stmt->execute();
            $user = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            return $user;
        } else {
            return false;
        }
    }

    // 로그인 체크
    public function getUser($userID, $password) {
		$sql = "SELECT * FROM members WHERE userID = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("s", $userID);
        if ($stmt->execute()) {
            $user = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            // verifying user password
            $salt = $user['salt'];
            $encrypted_passwd = $user['passwd'];
            $hash = $this->checkhashSSHA($salt, $password);

            // check for password equality
            if ($encrypted_passwd == $hash) {
                // user authentication details are correct
                return $user;
            } else {
				$user['idx']= 0;
				return $user;
			}
        } else {
            return NULL;
        }
    }

	function getPassword($userID,$password){ 
        $sql = "select * from members where userID=?";
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("s", $userID);

        if ($stmt->execute()) {
            $user = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            // 비밀번호 검증
            $salt = $user['salt'];
            $encrypted_passwd = $user['passwd'];
            $hash = $this->checkhashSSHA($salt, $password);
            if ($encrypted_passwd == $hash) {
                return 1; // 일치
            } else {
				return 0; // 불일치
			}
        } else {
            return -1;
        }
	}

	// 비밀번호 수정
	function setPassword($newpw,$salt,$userID){ 
        $sql = "UPDATE members SET passwd=?, salt=? where userID=?";
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("sss", $newpw, $salt, $userID);
        $result = $stmt->execute();
        $stmt->close();

        if ($result) {
			return 1; // 일치
        } else {
            return 0;
        }
	}

	// 안드로이드/아이폰 로그인 체크
	public function LoginUserChk($userID,$password,$deviceID){
		if(empty($userID) || empty($password)){
			return 0;
		} else {
			$user = $this->getUser($userID, $password);
			if($user['idx']>0){ // 가입자 정보가 있다면
				// 장치 일련번호 체크
				if($user['phoneSE'] == NULL){
					// 신규 장비번호 입력(최초 로그인)
					$this->LoginUserEquipInput($userID,$deviceID);
					//return $user['idx']; // 결과가 1일 수도 있는데 관리자가 먼저 가입하면 회원은 1일 수는 없음.
					return 1; // 일련번호 일치
				} else {
					if($user['phoneSE'] === $deviceID){
						return 1; // 일련번호 일치
					} else {
						return -1; //일련번호 불일치
					}
				}
			} else {
				return 0; // 로그인 실패
			}
		}

	}

	// 장치번호 업데이트
	public function LoginUserEquipInput($userID,$deviceID){
        if(strlen($deviceID)>0 && strlen($deviceID)<40){ // 안드로이드폰
            $ostype = 2;
        } else if(strlen($deviceID)>39){ // 아이폰
            $ostype = 1;
        } else { // 기타
            $ostype = 0;
        }

		$sql='UPDATE members SET phoneSE=?, OStype=? where userID=?';
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("sss", $deviceID, $ostype, $userID);
		$status = $stmt->execute();
		if($status == true){
			return 1;
		} else {
			return 0;
		}
	}//end

	// 장치번호 초기화 (관리자용)
	public function EquipReset($userID){
		$ostype = 0;
		$sql='UPDATE members SET phoneSE=NULL, OStype=? where userID=?';
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("ss", $ostype, $userID);
		$status = $stmt->execute();
		if($status == true){
			return 1;
		} else {
			return 0;
		}
	}//end

	function regUserPhone($userID,$phoneNO){
		if($this->EquipSameChk($userID,$phoneNO) == 1) return 0;
		$sql='UPDATE members SET mobileNO=? WHERE userID=?';
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("ss", $phoneNO, $userID);
		$status = $stmt->execute();
		if($status == true){
			return 1;
		} else {
			return 0;
		}		
	}

	function LoginUserPhoneChk($userID,$password,$deviceID,$phoneNO){
		$user = $this->getUser($userID, $password);
		if($user['idx']>0){ // 가입자 정보가 있다면
			if($this->EquipSameChk($userID,$phoneNO) == 1) {
				$rs = $this->LoginUserEquipInput($userID,$deviceID);
				return $rs;
			} else {
				return 0;
			}
		}
	}

	function EquipSameChk($userID,$phoneNO){
		$sql = "SELECT count(*) FROM members WHERE userID=? and mobileNO=?";
		$stmt = $this->db->prepare($sql);
		$stmt->bind_param("ss", $userID, $phoneNO);
		if ($stmt->execute()) {
			$result = $stmt->get_result();
            $row = $result->fetch_row();
            $stmt->close();
			return $row[0];
        } else {
            return 0;
        }
	}

    // 회원 가입 여부 체크
    public function isUserExisted($userID) {
        $stmt = $this->db->prepare("SELECT userID from members WHERE userID = ?");

        $stmt->bind_param("s", $userID);
        $stmt->execute();
        //$stmt->store_result();
		$result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // user existed
			$stmt->free_result();
            $stmt->close();
            return true;
        } else {
            // user not existed
			$stmt->free_result();
            $stmt->close();
            return false;
        }
    }

	// 회원 정보 삭제
	public function deleteUser($userID){
        $stmt = $this->db->prepare("delete FROM members WHERE userID = ?");
        $stmt->bind_param("s", $userID);
		$stmt->execute();
		$stmt->close();
	}

}
?>
