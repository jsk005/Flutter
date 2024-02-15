-- 이미지를 지정한 폴더에 저장하고 관련 사항을 테이블에 저장하는 코드 목적

CREATE TABLE photo_data (
  idx int(11) NOT NULL,
  code varchar(20) NOT NULL COMMENT '코드',
  userID varchar(20) NOT NULL,
  realname varchar(100) NOT NULL DEFAULT '0' COMMENT '실업로드파일명',
  filename varchar(100) NOT NULL DEFAULT '0' COMMENT '변경저장파일명',
  reg_date timestamp NULL DEFAULT NULL COMMENT '업로드일자',
  removed int(1) NOT NULL DEFAULT -1,
  display tinyint(2) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE photo_data
  ADD PRIMARY KEY (idx),
  ADD KEY code (code);

ALTER TABLE photo_data
  MODIFY idx int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

