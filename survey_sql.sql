/* 구분자를 ";" 으(로) 변경 */
/* 127.0.0.1 에 MariaDB or MySQL (TCP/IP) 을(를) 통해 연결 중, 사용자 이름 "root", 암호 사용: Yes… */
CREATE TABLE `sv_admin` (
	`adm_id` VARCHAR(20) NOT NULL PRIMARY key,
	`adm_pwd` VARCHAR(20) NOT NULL,
	`adm_name` VARCHAR(30) NOT NULL,
	`adm_level` CHAR(1) NOT NULL DEFAULT 'C'
)
COLLATE='utf8_general_ci'
;
/* "Unnamed" 세션 시작 */
CREATE TABLE `sv_top` (
	`sv_no` INT NOT NULL AUTO_INCREMENT,
	`sv_subject` VARCHAR(255) NOT NULL,
	`sv_wdate` DATE NOT NULL,
	`sv_sdate` DATE NOT NULL,
	`sv_edate` DATE NOT NULL,
	`sv_writer` VARCHAR(30) NOT NULL,
	`sv_realname` CHAR(1) NOT NULL,
	`sv_ing` CHAR(1) NOT NULL,
	`sv_sysdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`sv_no`)
)
COLLATE='utf8_general_ci'
;

CREATE TABLE `sv_child` (
  `sv_no` int(11) NOT NULL,
  `sc_no` int(11) NOT NULL,
  `sc_subject` varchar(50) NOT NULL,
  `sc_type` varchar(10) NOT NULL,
  `sc_tcnt` int(11) NOT NULL DEFAULT 2,
  `sc_t1` varchar(20) NOT NULL,
  `sc_t2` varchar(20) NOT NULL,
  `sc_t3` varchar(20) DEFAULT NULL,
  `sc_t4` varchar(20) DEFAULT NULL,
  `sc_t5` varchar(20) DEFAULT NULL,
  `sc_sysdate` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sc_no`,`sv_no`)
)