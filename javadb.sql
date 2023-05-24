-- javadb

-- user TBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthyear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
CREATE TABLE usertbl (
    no        NUMBER(4)
        CONSTRAINT pk_usertbl PRIMARY KEY,
    username  NVARCHAR2(10) NOT NULL,    -- varchar2(20) 가능
    birthyear NUMBER(4) NOT NULL,
    addr      NVARCHAR2(50) NOT NULL,        -- varchar2(50) 가능
    mobile    NVARCHAR2(20)
);              -- varchar2(20) 가능

DROP TABLE usertbl;

-- select(+서브쿼리,조인) + DML(insert, delete, update) 구문이 엄청 중요하다
-- 전체조회
SELECT
    *
FROM
    usertbl;
--개별조회(특정번호, 특정이름...)
--여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?(where 절과 관련) pk가 아닌 이상 여러개가 나올수있음
SELECT
    *
FROM
    usertbl
WHERE
    no = 1; --pk로 만들면 결과 하나로 나온다!!
SELECT
    *
FROM
    usertbl
WHERE
    username = '홍길동'; --동명이인이 있어서 중복이 가능..

-- like : _ or % 여러행이 결과로 나올때 사용
SELECT
    *
FROM
    usertbl
WHERE
    username LIKE '_길동%'; -- 앞에 한자리 뒤에 상관없음

--insert into 테이블명(필드명1, 필드명2...)
--values();

--update 테이블명
--set 업데이트할 필드명=값, 업데이트할 필드명=값,....
--where 조건;

--delete 테이블명 where 조건

--delete from 테이블명 where 조건



-- 시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE user_seq;

-- insert
-- no : user_seq 값 넣기
INSERT INTO usertbl (
    no,
    username,
    birthyear,
    addr,
    mobile
) VALUES (
    user_seq.NEXTVAL,
    '홍길동',
    2010,
    '서울시 종로구 123',
    '010-1234-5678'
);

SELECT
    *
FROM
    usertbl;

COMMIT;

-- 모든 컬럼 not null

-- paytype : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성
CREATE TABLE paytype (
    pay_no NUMBER(1) PRIMARY KEY,
    info   VARCHAR2(10) NOT NULL
);

CREATE SEQUENCE paytype_seq;

INSERT INTO paytype VALUES (
    paytype_seq.NEXTVAL,
    'card'
); -- 부모에 해당하는 테이블이어서 데이터를 먼저 넣어줌
INSERT INTO paytype VALUES (
    paytype_seq.NEXTVAL,
    'cash'
);

SELECT
    *
FROM
    paytype; -- 1 : card, 2 : cash

-- suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1: paytype 테이블에 있는 pay-no 참조 해서 사용)

CREATE TABLE suser (
    user_id NUMBER(4) PRIMARY KEY,
    name    VARCHAR2(20) NOT NULL,
    pay_no  NUMBER(1) NOT NULL
        REFERENCES paytype ( pay_no )
);

DROP TABLE suers;
-- product
-- product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
_
create table product(
            product_id number(8) primary key,
            pname varchar2(30) not null,
            price number(8) not null,
            content varchar2(50)not null);
            
drop table product;
create sequence product_seq;

-- sorder
-- order_id(숫자-8 pk), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
-- order_seq 생성

create table sorder(
            order_id number(8) primary key,
            user_id number(4) not null REFERENCES suser(user_id),
            product_id number(8)  not null REFERENCES product(product_id)
            );

ALTER TABLE sorder ADD order_date DATE;     -- 구매날짜

create sequence order_seq;

--insert into order values(order_seq.nextval,물건을 구매한 id, 상품 id, sysdate); -- 장바구니로 이용

select * from sorder;

-- user_id, name, pay_no, info
-- suser와 paytype join
select u.user_id, u.name, u.pay_no, p.info
from suser u, paytype p
where u.pay_no = p.pay_no AND u.user_id=1000;

-- 주문정보 전체 조회
select * from sorder;

-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content

-- 기준 : sorder
-- suser 테이블 : name,
-- paytype 테이블 : card/cash
-- product 테이블 : product_id, pname, price, content

-- 전체 주문목록
select s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, suser u, paytype t, product p
where s.user_id = u.user_id AND u.pay_no = t.pay_no AND s.product_id = p.product_id;

-- 홍길동 주문목록 조회
select s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, suser u, paytype t, product p
where s.user_id = u.user_id AND u.pay_no = t.pay_no AND s.product_id = p.product_id AND s.user_id = 1000;

--select s.user_id, s.name, t.pay_no, p.product_id, p.price, p.content
--from sorder s, suser u, paytype t, product p
--where u.paytype = t.paytype and s.product_id = p.product_id and 


-- 도서 테이블
-- code, title, writer, price
-- code : 1001(pk)
-- title : ‘자바의 신’ (varchar2 or nvarchar2 ==> 한글일때 varchar2:한글 3byte 처리, nvarchar2:한글 문자 갯수만큼 1byte)
-- writer : ‘홍길동’
-- price : 25000

-- bookTBL 테이블 생성

create table booktbl(
    code number(4) primary key, -- not null+unique
    title nvarchar2(50) not null,
    writer nvarchar2(20) not null,
    price number(8) not null);

drop table booktbl;

insert into booktbl(code, title,writer, price) values(1001, '이것이 자바다', '신용균', 25000);
insert into booktbl(code, title,writer, price) values(1002, '자바의 신', '강신용', 28000);
insert into booktbl(code, title,writer, price) values(1003, '오라클로 배우는 데이터베이스', '이지훈', 28000);
insert into booktbl(code, title,writer, price) values(1004, '자바 1000제', '김용만', 29000);
insert into booktbl(code, title,writer, price) values(1005, '자바 프로그래밍 입문', '박은종', 30000);

commit;

alter table booktbl add description nvarchar2(100);

-- member 테이블 not null
-- userid( 영어,숫자,특수문자) 최대 12 허용, pk
-- password(영어,숫자,특수문자) 최대 15 허용
-- name(한글)
-- gender(한글-남 or )여
-- email 적절한 크기

create table membertbl(
    userid varchar2(15)  primary key,
    password varchar2(20) not null,
    name nvarchar2(10) not null,
    gender nvarchar2(2) not null,
    email varchar2(50) not null
);

insert into membertbl values('hong123', 'hong123@', '홍길동', '남', 'hong123@gmail.com');
commit;

-- 카운트 함수로 불러옴 결과값은 정수
select count(*) from membertbl where userid='hok11@';

-- 게시판 board
-- 글번호(bno, 숫자, 시퀀스 삽입, pk(pk_board 제약조건명), 작성자(name,한글), 비밀번호(passowrd,숫자,영문자), 제목(title,한글), 내용(content,한글), 파일첨부(attach,파일명), 
-- 답변글 작성시 참조되는 글 번호(re_ref,숫자), 답변글 레벨(re_lev,숫자), 답변글 순서(re_seq,숫자)
-- 조회수(cnt,숫자,default 0 지정), 작성날짜(redate, default 로 sysdate 지정) - 숫자8자리


create table board(
    bno number(8) constraint pk_board primary key,
    name nvarchar2(10) not null,
    password nvarchar2(20) not null,
    title nvarchar2(50) not null,
    content nvarchar2(1000) not null,
    attach nvarchar2(100),
    re_ref number(8) not null,
    re_lev number(8) not null,
    re_seq number(8) not null,
    cnt number(8) default 0,
    regdate date default sysdate
);
    
-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

UPDATE board
SET
    title = '',
    content = ''
WHERE
        bno = 3
    AND password = '12345';

UPDATE board
SET
    title = '',
    content = '',
    attach = ''
WHERE
        bno = 3
    AND password = '12345';

-- 서브쿼리(쿼리 안에 쿼리 포함)

INSERT INTO board (
    bno,
    name,
    password,
    title,
    content,
    re_ref,
    re_lev,
    re_seq
)
    (
        SELECT
            board_seq.NEXTVAL,
            name,
            password,
            title,
            content,
            board_seq.CURRVAL,
            re_lev,
            re_seq
        FROM
            board
    );

COMMIT;



-- 댓글(계층형)
-- re_ref, re_lev, re_seq 

-- 원본글 작성 re_ref : bno 값과 동일
--          re_lev : 0, re_seq : 0

-- 원본글
select bno, title, re_ref, re_lev, re_seq from board where bno = 2563;

-- re_ref : 그룹번호, re_seq : 그룹 내에서 댓글의 순서(댓글도 최신순으로 보여줘야 함 - 순서가 필요함 그 작업을 위해 필요), 
-- re_lev : 그룹 내에서 댓글의 깊이(원본글의 댓글인지? 댓글의 댓글인지?...대대댓글인지..?) 

-- 댓글도 새글임 => insert 작업
--              bno : board_seq.nextval (시퀀스 번호 발급 받아서 처리)
--              re_ref : 원본글의 re_ref 값과 동일하게 삽입 (그룹잡기)
--              re_seq : 원본글의 re_seq + 1
--              re_lev : 원본글의 re_lev + 1


-- 첫번재 댓글 작성
insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글','게시글 댓글',null,2563,1,1);

commit;

-- 가장 최신글과 댓글 가지고 오기(+ re_seq asc : 댓글의 최신) - 그룹으로 가져오기
select bno, title, re_ref, re_lev, re_seq from board where re_ref=2563 order by re_seq;

-- 두번째 댓글 작성
-- re_seq 가 값이 작을수록 최신글임

-- 기존 댓글이 있는가? 기존 댓글의 re_seq 변경을 한 후 insert 작업 해야 함

-- update 구문에서 where 절은 re_ref 는 원본글(부모글)의 re_ref 값, re_seq 비교구문은 원본글의 re_seq 값과 비교 (부모글의 re_seq 보다 커야 함)

update board set re_seq = re_seq + 1 where re_ref=2563 and re_seq > 0;

commit;

insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글2','게시글 댓글2',null,2563,1,1);

-- 댓글의 댓글 작성(대댓글)
-- update -> insert 

update board set re_seq = re_seq + 1 where re_ref=2563 and re_seq > 2;


insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','ReRe : 게시글','댓글의 댓글',null,2563,2,3);


-- 페이지 나누기
-- rownum : 조회된 결과에 번호를 매겨줌
--             order by 구문에 index 가 들어가지 않는다면 제대로 된 결과를 보장하지 않음 (index:색인) : 계층형에서는 rownum을 일반적으로 사용할 수 없다
--              pk 가 index로 사용됨


select rownum, bno, title from board order by bno desc;

-- 이렇게하면 원하는 결과 안나옴
select rownum, bno, title, re_ref, re_lev, re_seq 
from board order by re_ref desc, re_seq asc;

-- 해결
-- order by 구문을 먼저 실행한 후 rownum 붙여야 함

select rownum, bno, title, re_ref, re_lev, re_seq
from (select bno, title, re_ref, re_lev, re_seq 
      from board order by re_ref desc, re_seq asc)
where rownum <= 30;

-- 이렇게는 못함..
select rownum, bno, title, re_ref, re_lev, re_seq
from (select bno, title, re_ref, re_lev, re_seq 
      from board order by re_ref desc, re_seq asc)
where rownum >=31 and rownum <= 60;

-- 한 페이지에 30개의 목록을 보여준다 할 때
-- 1 2 3 4 5 6 ....
-- 1page 요청 (1~30)
-- 2page 요청 (31~60)
-- 3page 요청 (61~90)

select *
from(select rownum rnum, bno, title, re_ref, re_lev, re_seq
    from (select bno, title, re_ref, re_lev, re_seq 
         from board order by re_ref desc, re_seq asc)
    where rownum <= 90)
where rnum > 60;
-- 안쪽 부터 뽑아나오니 원래는 90개인데 보여주는게 30개임
-- rownum 이름 rnum 으로 이름 붙임


select *
from(select rownum rnum, bno, title, re_ref, re_lev, re_seq
    from (select bno, title, re_ref, re_lev, re_seq 
         from board order by re_ref desc, re_seq asc)
    where rownum <= ?)
where rnum > ?;
-- 1 page : rnum > 0, rownum <= 30
-- 2 page : rnum > 30, rownum <= 60
-- 3 page : rnum > 60, rownum <= 90

-- 1,2,3 이용
-- rownum 값 : 페이지 번호 * 한 페이지에 보여줄 목록 개수
-- rnum 값 : (페이지번호-1) * 한 페이지에 보여줄 목록 개수


select rownum, bno, title from board order by bno desc;
-- 위에 구문이 안돼서 밑에 썜이 주신 코드임
select /*+INDEX_DESC(board pk_board)*/ rownum, bno, title from board;


-- book_mvc 연습 테이블 생성
-- 도서 테이블
-- code, title, writer, price
-- code : 1001(pk)
-- title : ‘자바의 신’ (varchar2 or nvarchar2 ==> 한글일때 varchar2:한글 3byte 처리, nvarchar2:한글 문자 갯수만큼 1byte)
-- writer : ‘홍길동’
-- price : 25000

-- bookTBL 테이블 생성

create table booktblys(
    code number(4) primary key, -- not null+unique
    title nvarchar2(50) not null,
    writer nvarchar2(20) not null,
    price number(8) not null);

drop table booktblys;

insert into booktblys(code, title,writer, price) values(1001, '이것이 자바다', '신용균', 25000);
insert into booktblys(code, title,writer, price) values(1002, '자바의 신', '강신용', 28000);
insert into booktblys(code, title,writer, price) values(1003, '오라클로 배우는 데이터베이스', '이지훈', 28000);
insert into booktblys(code, title,writer, price) values(1004, '자바 1000제', '김용만', 29000);
insert into booktblys(code, title,writer, price) values(1005, '자바 프로그래밍 입문', '박은종', 30000);

commit;

alter table booktblys add description nvarchar2(100);

-- member_mvc 연습 테이블 생성
-- member 테이블 not null
-- userid( 영어,숫자,특수문자) 최대 12 허용, pk
-- password(영어,숫자,특수문자) 최대 15 허용
-- name(한글)
-- gender(한글-남 or )여
-- email 적절한 크기

create table membertblys(
    userid varchar2(15)  primary key,
    password varchar2(20) not null,
    name nvarchar2(10) not null,
    gender nvarchar2(2) not null,
    email varchar2(50) not null
);

insert into membertblys values('hong123', 'hong123@', '홍길동', '남', 'hong123@gmail.com');
commit;



select count(*) from board;

select count(*) from board where title like '%게시글%';



----------------- spring_board
-- bno 숫자(10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date default 로 현재시스템날짜
-- updatedate date default 로 현재시스템날짜
create table spring_board(
    bno number(10) constraint pk_spring_board primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default  sysdate);

-- 시퀀스 seq_board
create sequence seq_board;




-- my baits 연습용 테이블
create table person(
id varchar2(20) primary key,
name varchar2(30) not null);

select * from person;

insert into person values('kang123', '강길동');
insert into person values('kim123', '김길동');
insert into person values('ko123', '고길동');
insert into person values('choi123', '최길동');
commit;


-- 트랜잭션 테스트 테이블
-- 트랜잭션 : 하나의 업무에 여러개의 작은 업무들이 같이 묶여 있음 / 하나의 단위로 처리
-- 계좌이체 : 계좌 출금 => 타 계좌 입금
create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col1 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;

delete tbl_sample1;
commit;


-- membertbl password ==> 100 byte 로 변경 20230516
alter table membertbl modify password varchar2(100);


-- 페이지 나누기(GET 방식)
-- rownum : 조회된 결과에 번호를 매겨줌
-- spring_board : bno 가 pk 상황 (order by 기준도 bno)
-- 1 page : 가장 최신글 20개
-- 2 page : 그 다음 최신글 20개

insert into spring_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from spring_board);

commit;

select count(*) from spring_board;

-- 페이지 나누기를 할 때 필요한 sql 코드
-- 로우넘을 붙이고 오더바이 작업을 할 수 있어서 그 부분을 주의해야함 (오더바이를 먼저하고 로우넘을 이용해서 번호를 매기고 필요한 부분을 가지고 나오는 코드)
select *
from(select rownum rn, bno,title,writer
        from (select bno,title,writer from spring_board order by bno desc)
        where rownum <= 20)
where rn>0;


-- 오라클 힌트 사용
select bno,title,writer,regdate,updatedate
from (select /*+INDEX_DESC(spring_board pk_spring_board)*/ rownum rn, bno,title,writer,regdate,updatedate
        from spring_board
        where rownum <= 40)
where rn > 20;
-- bno 가 pk 인 상황이라 마침 index 개념도 있어서 oracle hint 를 사용해서 간단하게 사용 가능

select count (*) from spring_board;


-- 댓글 테이블
create table spring_reply(
    rno number(10,0) constraint pk_reply primary key, -- 댓글 글번호
    bno number(10,0) not null,                        -- 원본글 글번호
    reply varchar2(1000) not null,                    -- 댓글 내용
    replyer varchar2(50) not null,                    -- 댓글 작성자
    replydate date default sysdate,                   -- 댓글 작성날짜
    constraint fk_reply_board foreign key(bno) references spring_board(bno) -- 외래키 제약조건
);

-- 댓글 테이블 수정(컬럼추가) updatedate
alter table spring_reply add updatedate date default sysdate; 

create sequence seq_reply;

-- 1066 글에 댓글달기
insert into spring_reply(rno,bno,reply,replyer) 
values(seq_reply.nextval, 1066, '게시판 댓달기', '댓1');
commit;


-- spring_reply 인덱스 추가 설정
create index idx_reply on spring_reply(bno desc, rno asc);


select rno, bno, reply, replyer, replydate, updatedate
from (select /*+INDEX(spring_reply idx_reply)*/ rownum rn, rno, bno, reply, replyer, replydate, updatedate
        from spring_reply
        where bno=1066 and rownum <= 10)
where rn > 0;




