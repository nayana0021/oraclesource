-- javadb

-- user TBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthyear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
create table userTBL(
            no number(4) constraint pk_userTBL primary key,
            username nvarchar2(10) not null,    -- varchar2(20) 가능
            birthyear number(4) not null,
            addr nvarchar2(50) not null,        -- varchar2(50) 가능
            mobile nvarchar2(20));              -- varchar2(20) 가능

drop table userTBL;

-- select(+서브쿼리,조인) + DML(insert, delete, update) 구문이 엄청 중요하다
-- 전체조회
select * from usertbl;
--개별조회(특정번호, 특정이름...)
--여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?(where 절과 관련) pk가 아닌 이상 여러개가 나올수있음
select * from usertbl where no=1; --pk로 만들면 결과 하나로 나온다!!
select * from usertbl where username='홍길동'; --동명이인이 있어서 중복이 가능..

-- like : _ or % 여러행이 결과로 나올때 사용
select * from usertbl where username like '_길동%'; -- 앞에 한자리 뒤에 상관없음

--insert into 테이블명(필드명1, 필드명2...)
--values();

--update 테이블명
--set 업데이트할 필드명=값, 업데이트할 필드명=값,....
--where 조건;

--delete 테이블명 where 조건

--delete from 테이블명 where 조건





-- 시퀀스 생성
-- user_seq 생성(기본)
create sequence user_seq;

-- insert
-- no : user_seq 값 넣기
insert into userTBL(no, username, birthyear, addr, mobile)
values(user_seq.nextval ,'홍길동',2010,'서울시 종로구 123','010-1234-5678');

select * from userTBL;

commit;

-- 모든 컬럼 not null

-- paytype : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성
create table paytype(
            pay_no number(1) primary key,
            info varchar2(10) not null);

create sequence paytype_seq;

insert into paytype values(paytype_seq.nextval, 'card'); -- 부모에 해당하는 테이블이어서 데이터를 먼저 넣어줌
insert into paytype values(paytype_seq.nextval, 'cash');

select * from paytype; -- 1 : card, 2 : cash

-- suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1: paytype 테이블에 있는 pay-no 참조 해서 사용)

create table suser(
            user_id number(4) primary key,
            name varchar2(20) not null,
            pay_no number(1) not null REFERENCES paytype(pay_no));

drop table suers;
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




