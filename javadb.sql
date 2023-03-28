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
            product_id number(8)  not null REFERENCES product(product_id));


create sequence order_seq;

