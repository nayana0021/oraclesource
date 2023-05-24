-- 대소문자 구별 하지 않음(단 비밀번호는 구별함)
-- CREATE : 생성 / ALTER : 수정 / DROP : 삭제, DELETE : 삭제

-- 오라클 버전이 변경되면서 사용자 생성 시 요구하는 접두사 생략을 위해 : C## 문자를 넣어서 만들도록 변경 됨
-- JAVADB => C##JAVADB 이런 방식을 C## 사용하지 않겠음
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 사용자 : scott, hr => 데이터베이스 접속하여 데이터를 관리하는 계정
--          테이블, 인덱스, 뷰 등 여러 객체가 사용자별로 생성됨
--          업무에 따라 사용자들을 나눠서 관리

-- 스키마 : 데이터간 관계, 데이터 구조, 제약조건 등 데이터를 관리 저장하기 위해 정의한 데이터베이스 구조의 범위
-- 스키마 == 사용자(오라클 데이터베이스 경우)

-- 사용자 생성 : 사용자 생성 권한이 필요함 ==> sys, system

-- 사용자 생성 구문
-- 비밀번호는 대소문자 구별함

-- user 생성은 sys, system 만 가능
-- user 생성( 공간 할당 )
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
CREATE USER JAVADB IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
ALTER USER javadb QUOTA 2M ON USERS; -- 메모리부여

-- GRANT : 사용자 권한 부여(사용자 생성만 해서는 아무것도 할 수 없음) 반드시!
GRANT CONNECT, RESOURCE TO JAVADB;

CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP; 

-- SCOTT 에게 부여된 권한 : 권한 주는 건 system 만 가능
GRANT CONNECT, RESOURCE TO SCOTT;
-- 뷰 생성 권한 부여
GRANT CREATE VIEW TO SCOTT;
-- SYNONYM 생성 권한 부여
GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

select * from all_users;

GRANT UNLIMITED TABLESPACE TO SCOTT;


ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;

-- 사용자 삭제는 drop user

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- test 사용자 생성 / 비번 12345
CREATE USER test1 IDENTIFIED BY 12345; -- 사용자명 'TEST'(이)가 다른 사용자나 롤 이름과 상충됩니다

-- 접속권한 부여하지 않으면 안됨

-- 권한 관리
-- 1) 시스템 권한
--      사용자 생성(CREATE USER) / 수정(ALTER USER) / 삭제(DROP USER)
--      데이터베이스 접근(CREATE SESSION) / 수정 (ALTER SESSION)  
--      여러 객체 생성(view, synonym) 및 관리 권한

-- 2) 객체 권한
--      테이블 수정, 삭제, 인덱스 생성, 삽입, 참조, 조회, 수정
--      뷰 삭제, 삽입, 생성, 조회, 수정
--      시퀀스 수정, 조회
--      프로시저, 함수, 패키지 권한


--  권한 부여
-- create session을 test에게 부여
GRANT CREATE SESSION TO test1;


GRANT RESOURCE, CREATE TABLE TO test1;

-- 테이블 스테이스 users 에 권한이 없습니다. - 해결
ALTER USER test1 DEFAULT TABLESPACE USERS;  --no privileges on tablespace 'USERS' 해결
ALTER USER test1 TEMPORARY TABLESPACE TEMP;
ALTER USER test1 QUOTA 2M ON USERS;  -- users 에 공간 설정

-- scott 에게 test1가 생성한 member 테이블 조회 권한 부여
GRANT SELECT ON member TO scott; -- 특정 테이블에 대한 권한을 부여하는것

-- 권한 취소
REVOKE SELECT, INSERT ON member FROM scott; --멤버(테이블)에게 준 셀렉트 인서트 권한을 취소한다는 뜻

-- 사용자 삭제
DROP USER test1;
DROP USER test1 CASCADE; -- test1와 관련된 모든 객체 같이 삭제

drop user test1;

select sid, serial#, username,status from v$session where username ='test1';
alter system kill SESSION 'test1';


-- 롤 : 여러 권한들의 모임
-- CONNECT 롤 : CREATE SESSION
-- RESOURCE 롤 : CREATE TRIGGER, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TABLE...

-- 사용자 생성 + 테이블 스페이스 권한 부여
CREATE USER test2 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- 권한부여(뷰나 시노님은 따로)
GRANT CONNECT,RESOURCE TO test2;

--명령의 568 행에서 시작하는 중 오류 발생 -
--insert into spring_reply(rno,bno,reply,replyer) 
--values(seq_reply.nextval, 1066, '게시판 댓글달기', '댓글작성자1')
--오류 보고 -
--ORA-01536: 'USERS' 테이블스페이스에 영역 할당량이 초과됐습니다
alter user javadb quota unlimited on users;



