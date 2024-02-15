<?php
include_once 'dbinfo.php';
$db = isConnectDb($db);

function isConnectDb($db)
{
    $conn = mysqli_connect($db['host'],$db['user'],$db['pass'],$db['name'],$db['port']);
    mysqli_set_charset($conn, "utf8");  // DB설정이 잘못되어 euc-kr 로 되어 있으면 문제가 됨
    if (mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
        exit;
    } else {
        return $conn;
    }
}

/* 사용자 권한 등록
use mysql;
create user mfsigma@localhost identified by 'wonderfull!#%';
grant all privileges on android.* to mfsigma@localhost;
flush privileges;

*/

?>