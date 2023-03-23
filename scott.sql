--# scott 

-- emp(employee) 테이블 구성 보기
-- 필드명(열 이름)     제약조건   데이터타입
-- EMPNO (사원번호)    NOT NULL  NUMBER(4)
-- ENAME(사원명), JOB(직책), MGR(직속상관 번호),HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능
-- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2) : 전체 자릿수는 8자리이고 소수점 2자리를 포함한다
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장 가능
-- DATE : 날짜 데이터

DESC emp;

-- DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC dept;

-- GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
DESC salgrade;

-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)
-- SELECT 열이름1,열이름2,.. (조회할 열이 전체라명 *로 처리)
-- FROM 테이블명;

-- 1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

-- 2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;
    
    
-- 3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;
-- 4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;    
    
-- 5. EMP 테이블 안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
    
-- 6. EMP 테이블 안에 부서번호 조회(단, 중복된 부서 번호는 제거)
-- DISTINCT : 중복 제거
SELECT DISTINCT
    deptno
FROM
    emp;
    
 -- 열이 여러 개인 경우(묶어서 중복이냐 아니냐를 판단) - 밑에 매니저 데이터는 넘버가 다 다르다 - 모두 다른 데이터 
SELECT DISTINCT
    job,
    deptno
FROM
    emp;
  
  
-- 7. 연산
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM)
-- 별칭 : 필드에 별칭을 임의로 부여( as 별칭, 혹은 한칸 띄고 별칭, 별칭에 공백이 있다면 "" 로 묶어주기)
-- 연산시 필드명 지정을 해주지 않으면 식이 필드명이 되어버림
-- as 필드명 으로 지정 (as 가 없어도 됨. 한칸 띄고)
-- 공백을 줘야한다면 단어를 큰따옴표로 묶는다("")
SELECT
    empno,
    ename,
    sal,
    comm,
    sal * 12 + comm AS annsal --NULL은 연산이 안됨 값이 NULL 이 되어버림
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp; 
    
    
    
    
-- 8. 정렬 : ORDER BY
--          내림차순 => DESC , 오름차순 => ASC

-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬(DESC 은 생략 불가 꼭 써야함)
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;
    
    
-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬(ASC 는 생략가능)
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal; --ASC 생략 가능
    
-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno;
    
-- 전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;

-- order by 는 자원을 많이 잡아먹는다 데이터가 많으면 많을수록 시간이 많이 걸린다

-- [실습] emp 테이블의 모든 열 출력
-- empno => employee_no
-- ename => employee_name
-- mgr => manager
-- sal => salary
--comm => commissionn
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면
-- 사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  AS employee_no,
    ename  employee_name,
    mgr    AS manager,
    sal    AS salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename ASC; -- asc 생략가능
    
-- WHERE : 특정 조건을 기준으로 원하는 행을 조회

-- 부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30; -- = : 같다

-- 사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
-- 부서번호가 30이고, 사원직책이 SALESMAN인 정보 조회 ( AND 사용)
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';  -- 대소문자 구별 하지 않는 것은 sql 의 특징이지만 내용이 대소문자 입력되어있으면 조회시 대소문자 구별해줘야 한다.
    
    
-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;
    
--  부서번호가 30이거나, 사원직책이 CLERK인 행 조회 ( OR 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';
    
    
-- 산술연산자 : +, -, *, /, mod(나머지-표준은 아님:오라클에서만 제공)
-- 비교연산자 : >, >=, <, <=
-- 등가비교연산자 : =, !=, <>, ^= (!=, <>, ^= : A값과 B값이 다를 경우 true, 같은 경우 false)
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자
-- LIKE 연산자와 와일드 카드(_, %)
-- IS NULL 연산자
-- 집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

-- 연산자 우선순위
-- 1) 산술연산자 *,/
-- 2) 산술연산자 +,-
-- 3) 비교연산자 
-- 4) IS NULL, IS NOT NULL, LIKE, IN 
-- 5) BETWEEN A AND B
-- 6) NOT
-- 7) AND
-- 8) OR
-- 우선순위를 줘야 한다면 소괄호 사용 추천

-- EMP 테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;

-- ename 이 F 이후의 문자로 시작하는 사원 조회
-- 문자 표현시 '' 만 사용 쌍따옴표 안됨!
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

SELECT
    *
FROM
    emp
WHERE
    ename <= 'FORZ'; --첫 글자 기준으로만

-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회 (OR로 조회)
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK'; --(여러개 조회 가능)

-- sal 이 3000 이 아닌 사원 조회 -- !=, <>, ^= 모두 사용가능
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;

SELECT
    *
FROM
    emp
WHERE
    sal <> 3000;

SELECT
    *
FROM
    emp
WHERE
    sal^= 3000;
    
-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회 => IN 연산자
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
-- JOB이 MANAGER, SALESMAN, CLERK 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';
-- JOB이 MANAGER, SALESMAN, CLERK 아닌 사원 조회 -- NOT IN 사용
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
-- sal 이 3000이 아닌 (NOT을 앞에 붙여 부정의 의미로 사용)
SELECT
    *
FROM
    emp
WHERE
    NOT sal = 3000;
    
-- 부서번호가 10,20 사원조회(in 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );
    
-- 급여가 2000 이상 3000 이하인 사원 조회

SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;
    
-- BETWEEN 최소값 AND 최대값; (BETWEEN A AND B)
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;
    
-- LIKE 연산자와 와일드카드(_, %) => 검색 작업에 많이 쓴다
-- _ : 어떤 값이든 상관없이 한 개의 문자 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

SELECT
    *
FROM
    emp
WHERE
    ename = 's'; -- => 이름이 s인 사원..

-- 사원 이름이 S로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%'; -- %는 여러개의 문자를 대치

-- 사원 이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%'; 

-- 사원 이름에 AM이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%'; 

-- 사원 이름에 AM이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%'; 

-- NULL : 데이터 값이 완전히 비어 있는 상태
-- = 을 사용할 수 없음

SELECT
    *
FROM
    emp
WHERE
    comm = NULL; -- 데이터 못 가져옴!! 널은 =으로 사용 못함

-- COMM 이 NULL인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;
    
-- MGR 이 NULL 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

-- MGR 이 NULL 이 아닌 사원 조회    
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;
    
-- 집합연산자

-- union(동일한 결과값인 경우 중복 제거), union all(중복 제거 안함) : 합집합

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10; -- 결과는 한 번 나온다

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10; -- 결과는 두 번 나온다

-- MINUS(차집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10; -- 전체를 구해서 10만 제외
   

-- INTERSECT(교집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10; -- 전체를 구해서 10만 제외

-- EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';
-- EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의
-- 사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;

-- EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
-- 집합 연산자를 사용하는 방식과 사용하지 않는 방식 두 가지를 사용한다

-- 집합연산자 사용하지 않는 경우
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

-- 집합연산자 사용하는 경우
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;

    
 -- 사원 이름에 E가 포함되어 있는 30 번 부서 사원 중 급여가 1000~2000 사이가 아닌 사원의 이름
 -- 사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND ( sal < 1000
          OR sal > 2000 ); -- 내가한거

SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 1000 AND 2000; -- 샘이 한거

 -- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원 이름의
 -- 두번째 글자가 L 이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';
    
    
-- 오라클 함수
-- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

-- 1. 문자열 함수
-- 1) UPPER, LOWER, INITCAP
-- UPPER : 모두 대문자, LOWER: 모두 소문자, INITCAP: 첫 글자만 대문자
-- LIKE '%ORACLE%' OR LIKE '%oracle%' OR LIKE '%Oracle%' ==> 검색 시 사용
SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';

SELECT
    *
FROM
    emp
WHERE
    upper(ename) LIKE upper('%ford%');
    
-- 2) LENGTH : 문자열 길이
SELECT
    ename,
    length(ename)
FROM
    emp;
    
-- 사원 이름의 길이가 5 이상인 사원 조회
SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;

-- 한글일 때
-- dual : sys가 소요하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1byte, 한글 : 문자1 => 3 byte
SELECT
    length('한글'),
    lengthb('한글'), -- 실제 사용하는 byte 수
    lengthb('ab')
FROM
    dual;
    
    
-- 3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략 가능 -- 추출길이 생략하면 시작위치부터 끝까지 다 나온다
-- 문자열 일부 추출

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5),
    substr(job, - 3)
FROM
    emp;

-- ENAME, 세번째 글자부터 출력
SELECT
    ename,
    substr(ename, 3)
FROM
    emp;
    
-- 3) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
-- INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택사항), 시작위치에서 찾으려는 문자가 몇 번째인지 지정(선택사항))

-- HELLO, ORACLE! 문자열에서 L문자열 찾기
SELECT
    instr('HELLO, ORACLE!', 'L')       AS instr_1,
    instr('HELLO, ORACLE!', 'L', 5)    AS instr_2,
    instr('HELLO, ORACLE!', 'L', 2, 2) AS instr_3
FROM
    dual;
    
-- 4) replace : 특정 문자를 다른 문자로 변경
-- replace(문자열데이터, 찾는문자, 변경문자)

-- 010-1234-5678    - 를 빈 문자열로 변경 / -를 없애기
SELECT
    '010-1234-5678'                    AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace_1,
    replace('010-1234-5678', '-')      AS replace_2
FROM
    dual;

-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT
    '이것이 Oracle 이다'                            AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is') AS replace_1
FROM
    dual;

-- 5) concat : 두 문자열 데이터 합치기
SELECT
    concat(empno,
           concat(':', ename))
FROM
    emp;

-- || : 문자열 연결 연산자

SELECT
    empno || ename,
    empno
    || ':'
    || ename
FROM
    emp;

-- 6) TRIM(양), LTRIM(왼), RTRIM(오) : 공백 포함 특정 문제 제거
-- ' ORACLE' = 'ORACLE' ==> FALSE
SELECT
    '     이것이     ',
    TRIM('     이것이     ')
FROM
    dual;

-- 2. 숫자함수
-- 1) ROUND, TRUNC,CEIL, FLOOR, MOD

-- round : 반올림
-- round(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,       -- 소수점 첫째 자리에서 반올림
    round(1234.5678, 0)   AS round0,      -- 소수점 첫째 자리에서 반올림
    round(1234.5678, 1)   AS round1,      -- 소수점 둘째 자리에서 반올림
    round(1234.5678, 2)   AS round2,      -- 소수점 세번째 자리에서 반올림
    round(1234.5678, - 1) AS round_minus1,-- 자연수 첫째 자리에서 반올림
    round(1234.5678, - 2) AS round_minus2 -- 자연수 둘째 자리에서 반올림
FROM
    dual;

-- trunc : 특정 위치에서 버리는 함수
-- trunc(숫자, 버림위치(선택))
SELECT
    trunc(1234.5678)      AS trunc,       -- 소수점 첫째 자리에서 버림
    trunc(1234.5678, 0)   AS trunc0,      -- 소수점 첫째 자리에서 버림
    trunc(1234.5678, 1)   AS trunc1,      -- 소수점 둘째 자리에서 버림
    trunc(1234.5678, 2)   AS trunc2,      -- 소수점 세번째 자리에서 버림
    trunc(1234.5678, - 1) AS trunc_minus1,-- 자연수 첫째 자리에서 버림
    trunc(1234.5678, - 2) AS trunc_minus2 -- 자연수 둘째 자리에서 버림
FROM
    dual;

-- ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수 -양수일때와 음수일때가 다름

SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;
    
-- mod(숫자, 나눌수) : 나머지 값 
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;
    
    
-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이

-- 날짜 데이터 + 날짜데이터 : 연산불가 (빼는건 되는데 더하는건 안됨)

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
-- 2) add_months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;
    
-- 입사 50주년이 되는 날짜 구하기
-- empno, ename, hiredate, 입사50주년날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;
    
-- 3) MONTHS_BETWEEN(첫번째날짜, 두번째날짜) : 두 날짜 데이터 간의 날짜 차이를 개월수로 계산하여 출력

-- 입사 45년 미만인 사원 데이터 조회
-- empno, ename, hiredate

SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1, -- 마이너스 나옴
    months_between(sysdate, hiredate)        AS months2, -- 앞 날짜가 현재날짜여야 양수값이 나옴
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
-- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--    last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

-- 날짜의 반올림, 버림 : ROUND, TRUNC
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용
--      

SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;

-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';
        
--ORA-01722: 수치가 부적합합니다 -> 형변환 가능한 상태가 아님
--01722. 00000 -  "invalid number"    
--select empno, ename, 'abcd'+empno
--from emp
--where ename = 'FORD';

-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력 형태로 날짜 출력하기 to_char 주로 사용됨
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;

-- MON, MONTH : 월 이름
-- DDD : 365일 중에서 며칠
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')    AS 현재날짜,
    to_char(sysdate, 'YYYY')          AS 현재연도,
    to_char(sysdate, 'MM')            AS 현재월,
    to_char(sysdate, 'MON')           AS 현재월1,
    to_char(sysdate, 'DD')            AS 현재일자,
    to_char(sysdate, 'DDD')           AS 현재일자2,
    to_char(sysdate, 'HH12:MI:SS AM') AS 현재날짜시간
FROM
    dual;
    
-- sal 필드에 ,(콤마)나 $(통화)표시를 하고 싶다면?
-- L(local) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l -- 세 자리 마다 콤마 찍어줭
FROM
    emp;
    
    
-- to_number(문자열데이터, 인식될 숫자형태)
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

-- 자동형변환안되는 상황 (콤마가 들어가면 문자임 -> 연산이 안됨)
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

SELECT
    1300 - '1,500', -- 숫자로 바로 변경되는 형태가 아니라 수치가 부적합하다는 오류가 남
    '1300' + 1500
FROM
    dual;
    
    
-- to_date(문자열데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20230320', 'YYYY-MM-DD')   AS todate2
FROM
    dual;
    
--ORA-01722: 수치가 부적합합니다
--select  '2023-03-21' - '2023-02-01'  문자빼기문자로 오류남
--from dual;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;

-- 널처리 함수
-- NULL + 300 => NULL

-- NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

-- NVL2(데이터, 널이 아닐경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    nvl2(comm, '0', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
-- DECODE함수 / CASE문

-- DECODE(검사 대상이 될 데이터,
--        조건1, 조건1이 일치할 때 실행할 구문
--        조건2, 조건2이 일치할 때 실행할 구문)

-- emp 테이블에 직책이 MANAGER 인 사람은 급여의 10% 인상,
-- SALESMAN 인 사람은 5%, ANALYST 인 사람은 그대로, 나머지는 3% 인상

SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;
    
-- 실습1 : EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다.
-- 하루 근무 시간을 8시간으로 보았을 때 사원들의
-- 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여
--결과를 출력한다. 단, 하루 급여는 소수점 셋째 자리에서
-- 버리고, 시급은 두 번재 소수점에서 반올림하시오.
SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)     AS pay_day,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;
    
-- 실습2 : EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오.
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하시오.

SELECT
    comm,
    nvl(to_char(comm),
        'N/A') --ORA-01722: 수치가 부적합합니다 => 숫자를 문자열로 출력해줘 해버린 상황 to_char로 형변환을 해주는 개념이 필요함
FROM
    emp;

-- 풀이
SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;

--select --> 내가 시도한거
--    empno, ename, hiredate, next_day(add_months(hiredate,3)),'월요일') as R_JOB , nvl2(comm,to_char(comm), 'N/A') as comm
--from emp;

-- 실습3 : EMP 테이블의 모든 사원을 대상으로 직속 사오간의 사원번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오.
-- 직속상관의 사원번호가  존재하지 않을 경우 : 0000
-- 직속상관의 사원번호 앞 두자리가 75일 경우 : 5555
-- 직속상관의 사원번호 앞 두자리가 76일 경우 : 6666
-- 직속상관의 사원번호 앞 두자리가 77일 경우 : 7777
-- 직속상관의 사원번호 앞 두자리가 78일 경우 : 8888
-- 그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원번호 그대로 출력

SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),
                  1,
                  2),
           NULL,
           '0000',
           '75',
           '5555',
           '76',
           '6666',
           '77',
           '7777',
           '78',
           '8888',
           substr(to_char(mgr),
                  1)) AS chg_mgr
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr),
                    1,
                    2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;

-- 다중행(집계) 함수 : sum, count, max, min, avg
--select 단일 함수의 그룹이 아닙니다 오류
--    ename, 
--    sum(sal)
--from emp;

SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

-- sum() : NULL은 제외하고 합계 구해줌
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*) -- emp 테이블의 행의 갯수가 몇개니 (특정 컬럼 지정시 그 행의 데이터의 갯수)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp;

-- 부서번호가 20인 사원의 입사일 중 제일 최근 입사일
SELECT
    MAX(hiredate) -- 가장 최신 날짜 출력됨
FROM
    emp
WHERE
    deptno = 20;

-- 부서번호가 20인 사원의 입사일 중 제일 오래된 입사일
SELECT
    MIN(hiredate)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30; -- 부서번호 30인 사원의 급여 평균
    
    
-- group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 10; -- 하나씩 밖에 못 봄
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;
    
-- 부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;

-- GROUP BY 표현식이 아닙니다.
--SELECT
--    AVG(sal),
--    deptno,
--    ename
--FROM
--    emp
--GROUP BY
--    deptno;
    
-- GROUP BY + HAVING : group by 절에 조건을 줄 때
-- HAVING : 그룹화된 대상을 출력 제한 걸때

-- 각 부서의 직책별 평균 급여 구하기( 단, 평균 급여가 2000 이상인 그룹만 출력)
-- deptno, job, 평균
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;
    
-- 그룹 함수는 허가되지 않습니다 그룹함수는 where 절에 못 들어와 못 쓴다!
-- SELECT
--    deptno,
--    job,
--    AVG(sal)
--FROM
--    emp
--where
--    AVG(sal) >= 2000
--GROUP BY
--    deptno,
--    job
--ORDER BY
--    deptno,
--    job;
   
-- select 실행 순서
-- 1) from 구문 실행, 2) where 실행 3) group by 4) having 5) select 6) order by
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

-- 실습1 :[실습1] EMP 테이블을 이용하여 부서번호(DEPTNO), 
--평균급여(AVG_SAL), 최고급여(MAX_SAL), 
--최저급여(MIN_SAL), 사원수(CNT)를 출력한다. 
--단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 SQL 문을 작성하시오.
SELECT
    deptno,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
    emp
GROUP BY
    deptno;

-- 실습2 :같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 SQL문을 작성하시오.
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;
    
-- 실습3 : 사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력하는 SQL문 작성하시오.
SELECT
    to_char(hiredate, 'YYYY') AS hire_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;

-- 조인 : 여러 테이블을 하나의 테이블처럼 사용
-- 1. 내부조인(inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--      1) 등가조인 : 두 개의 열이 일치할 때 값 추출
--      2) 비등가조인 : 범위에 해당할 때 값 추출
-- 2. 외부조인(outer join)
--      1) left outer join
--      2) right outer join
--      3) full outer join

-- dept :4행, emp :12행 ==> 4*12 = 48행 (조건이 없으면 이렇게 나오고 이것은 조인이 아님 이렇게 하는게 아니다)
-- 크로스 조인(나올 수 있는 모든 조합 추출)
SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;

-- ORA-00918: 열의 정의가 애매합니다(column ambiguously defined) -> 조인을 했을때 많이 나오는 에러

-- inner join
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc   -- 명확하게 해줘야 에러가 나지않음
FROM
    emp  e,
    dept d  --별칭을 줌
WHERE
    e.deptno = d.deptno;

-- SQL-99 표준
-- join ~ on
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno; -- om 에 기준을 넣는다

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal >= 3000;

-- SQL-99 표준
-- join ~ on
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    sal >= 3000;

-- emp, dept inner join, 급여가 2500 이하이고, 사원번호가 9999 이하인 사원 정보 조회
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal <= 2500
    AND e.empno <= 9999;

-- SQL-99 표준
-- join ~ on
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.sal <= 2500
    AND e.empno <= 9999;

-- emp 와 salgrade 조인
-- emp 테이블의 sal 이 salgrade 테이블의 losal 과 hisal 범위에 들어가는 형태로 조인
SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;

-- SQL-99 표준
-- join ~ on
SELECT
    *
FROM
         emp e
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- self join : 자기 자신 테이블과 조인

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;

-- outer join : 

-- 1) left outer join -> 오른쪽에 (+) 해준다
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno (+);

-- SQL-99 표준
-- join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

-- 2) right outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr (+) = e2.empno;

-- SQL-99 표준
-- join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

-- outer-join된 테이블은 1개만 지정할 수 있습니다
-- 01468. 00000 -  "a predicate may reference only one outer-joined table" 이렇게는 못함
--select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
--from emp e1, emp e2
--where e1.mgr(+) = e2.empno(+);

-- SQL-99 표준
-- join ~ on
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno;
    
-- 연결해야 할 테이블이 세 개일 때 (예시)
--select *
--from table1 t1, table2 t2, table3 t3
--where t1.empno = t2.empno and t2.deptno = t3.deptno;
--
--select *
--from table1 t1 join table2 t2 on t1.empno = t2.empno join table3 t3 on t2.deptno = t3.deptno;

-- 실습1 : 급여가 2000초과인 사원들의 부서 정보, 사원 정보를 아래와 같이 출력하는 SQL 문을 작성하시오.
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal > 2000;

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    e.sal > 2000;

-- 실습2 : 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하는 SQL문을 작성하시오.
SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno
GROUP BY
    d.deptno,
    d.dname;
-- join on
SELECT
    d.deptno,
    d.dname,
    floor(AVG(sal)) AS avg_sal,
    MAX(sal)        AS max_sal,
    MIN(sal)        AS min_sal,
    COUNT(*)        AS cnt
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
GROUP BY
    d.deptno,
    d.dname;

--select d.deptno, d.dname, avg(e.sal) as AVG_SAL, max(e.sal) as MAX_SAL, min(e.sal) as MIN_SAL, count(*)
--from dept d, emp e
--group by d.deptno;

-- 실습3 : 모든 부서정보와 사원 정보를 아래와 같이 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문을 작성하시오.(조인 ppt 12pg)
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d,
    emp  e
WHERE
    d.deptno = e.deptno (+);

SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d
    LEFT OUTER JOIN emp  e ON d.deptno = e.deptno (+);

--select e.deptno, d.dname, e.empno, e.ename, e.job, e.sal
--from emp e, dept d
--where e.deptno = d.deptno
--order by deptno, ename;

-- 서브쿼리(단일행,다중행)
-- sql 문을 실행하는 데 필요한 데이터를 추가 조회하기 위해 sql 문 내부에서 사용하는 select 문
-- 1) 단일행 서브쿼리 2) 다중행 서브쿼리 3) 다중열 서브쿼리

--SELECT 조회할 열
--FROM 테이블명
--WHERE 조건식(SELECT 조회할 열 FROM 테이블 WHERE 조건식 )

-- 존스의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 / 알이낸 JONES 급여를 가지고 조건식
SELECT
    sal
FROM
    emp
WHERE
    ename = 'JONES';  --2975

SELECT
    *
FROM
    emp
WHERE
    sal > 2975;
    
    
-- 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 반환
-- =, >, <, >=, <=, <>, ^=, != 연산자 허용

-- 존스의 급여보다 높은 급여를 받는 사원 조회(서브쿼리)
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            sal
        FROM
            emp
        WHERE
            ename = 'JONES'
    );

-- 사원이름이 ALLEN 인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회

SELECT
    *
FROM
    emp
WHERE
    comm > (
        SELECT
            comm
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );
    
-- 사원이름이 WARD 인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT
    *
FROM
    emp
WHERE
    hiredate < (
        SELECT
            hiredate
        FROM
            emp
        WHERE
            ename = 'WARD'
    );

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및
-- 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역

SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    );

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및
-- 부서정보 조회
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal <= (
        SELECT
            AVG(sal)
        FROM
            emp
    );

-- 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
-- IN, ANY(SOME), ALL, EXISTS 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회

-- 각 부서별 최고 급여
SELECT
    MAX(sal)
FROM
    emp
GROUP BY
    deptno;

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--select * from emp where sal = ( select max(sal) from emp group by deptno);

-- IN: 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE (IN 은 = 와 같은 뜻)
SELECT
    *
FROM
    emp
WHERE
    sal IN (
        SELECT
            MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 조회

-- ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나 이상이면 TRUE 
SELECT
    *
FROM
    emp
WHERE
    sal < ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

SELECT
    *
FROM
    emp
WHERE
    sal < SOME (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임
SELECT
    *
FROM
    emp
WHERE
    sal < (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );

-- 30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회

-- 1) 단일행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            MIN(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );
-- 2) 다중행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- ALL : 서브쿼리 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리 조건식이 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- EXISTS : 서브 쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );

SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 50
    );

-- 실습1 : 전체 사원 중 ALLEN 과 같은 직책인 사원들의 사원정보, 부서 정보를 다음과 같이 출력(쿼리 ppt 19pg)
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

--select job, empno, ename, sal, deptno, dname
--from emp e, dept d,
--where job = (select job from emp where ename = 'ALLEN');

-- 실습2 : 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문을 작성하시오
--(단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하기)

SELECT
    e.empno,
    e.ename,
    d.dname,
    e.hiredate,
    d.loc,
    e.sal,
    s.grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal -- e와 d연결, e와 s 연결
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    e.sal DESC,
    e.empno ASC;

-- 3) 다중열 서브쿼리 : 서브쿼리의 select 절에 비교할 데이터를 여러 개 지정

SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)    --맞춰서 써준다 웨어절 셀렉절
        FROM
            emp
        GROUP BY
            deptno
    );

-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
-- FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;

-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- SELECT 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야 함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;

-- 실습1 : 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
-- ppt 23pg
SELECT
    e.empno,
    e.ename,
    e.job,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    )
    AND e.deptno = 10;

-- 실습2 : 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력하는 SQL문을 작성하시오
--(단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원번호를 기준으로 오름차순 정렬하여 출력하시오.)

-- 단일행 서브쿼리
SELECT
    e.empno,
    e.ename,
    e.sal,
    s.grade
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

-- 다중행을 안 쓰려면 max 쓰면된다

SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

-- 다중행 함수 사용시(IN, ANY, SOME, ALL, EXISTS)
SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

-- DML( Date Manipulation Language ) : 데이터 추가(INSERT), 수정(UPDATE), 삭제(DELETE)하는 데이터 조작어
-- COMMIT : DML 작업을 데이터베이스에 최종 반영
-- ROLLBACK :DML 작업을 취소
-- select + DML ==> 자주 사용하는 sql 임


-- 연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp
    AS
        SELECT
            *
        FROM
            dept;

DROP TABLE dept_temp;

-- 열이름은 선택사항임
-- insert into 테이블이름(열이름1, 열이름2......)
-- values(데이터1, 데이터2......);

-- dept_temp 새로운 부서 추가하기
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

-- 열 이름 제거할 때(사용안할때)
INSERT INTO dept_temp VALUES (
    60,
    'NETWORK',
    'BUSAN'
); -- 열 순서대로 넣어야함. 생략할거면 세개 다 넣어야 함

-- INSERT 시 오류

-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--INSERT INTO dept_temp
--VALUES(600, 'NETWORK', 'BUSAN'); -- 데이터 타입이 NUMBER(2,0) 이다

--INSERT INTO dept_temp
--VALUES('60', 'NETWORK', 'BUSAN'); -- 자동 형변환 시켜버림 (문자에서 숫자로)

--INSERT INTO dept_temp
--VALUES('NO', 'NETWORK', 'BUSAN'); -- 문자라 자동형변환이 안된다 : 수치가 부적합합니다

-- 값의 수가 충분하지 않습니다
--INSERT INTO dept_temp(deptno, dname, loc)
--VALUES(70, 'DATABASE'); -- 2개만 넣었기 때문에 오류남

-- NULL 삽입
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    80,
    'WEB',
    NULL
); -- null이 들어간다 '명시' 하는 방법

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    90,
    'MOBILE',
    ''
);  -- 비어있는 형태로 해도 null이 들어간다

-- NULL 삽입할 컬럼명 지정하지 않았음
-- 삽입시 전체 컬럼을 삽입하지 않는다면 필드명 필수
INSERT INTO dept_temp (
    deptno,
    loc
) VALUES (
    91,
    'INCHEON'
);

SELECT
    *
FROM
    dept_temp;

-- emp_temp 생성( emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
-- 구조만 복사
CREATE TABLE emp_temp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 <> 1; -- 1하고 1은 같지 않다.. 결과값이 false이기 때문에 행이 만들어지지 않는다

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) --명확한 코드의 개념으로 열 이름을 명시해준다(갯수 맞춰서 넣기 편하자나)
 VALUES (
    9999,
    '홍길동',
    'PRESIDENT',
    NULL,
    '2001/01/01',
    5000,
    1000,
    10
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    1111,
    '성춘향',
    'MANAGER',
    9999,
    '2002-01-05',
    4000,
    NULL,
    20
);

-- 날짜 입력 시 년/월/일 순서 => 일/월/년 삽입
--날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
--INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) 
--VALUES(2222,'이순신', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20); -- 형식이 안 맞음 에러

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    2222,
    '이순신',
    'MANAGER',
    9999,
    TO_DATE('07/01/2001', 'DD/MM/YYYY'),
    4000,
    NULL,
    20
); -- 형식을 맞춰주면 됨

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    3333,
    '심봉사',
    'MANAGER',
    9999,
    sysdate,
    4000,
    NULL,
    30
);

-- 서브쿼리로 INSERT 구현
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp 에 추가
INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) --INSERT 시 컬림의 열 맞춰야 함 (select에 * 입력하면 에러남)
    SELECT
        e.empno,
        e.ename,
        e.job,
        e.mgr,
        e.hiredate,
        e.sal,
        e.comm,
        e.deptno
    FROM
        emp      e,
        salgrade s
    WHERE
        e.sal BETWEEN s.losal AND s.hisal
        AND s.grade = '1';

SELECT
    *
FROM
    emp_temp;
    
COMMIT;

-- 테이블을 처음 만들 때 null 값이 들어갈수있게 만들면 insert 시 null 을 읿력할수있다

-- UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--SET 변경할열이름=데이터, 변경할열이름=데이터....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건



-- dept_temp loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL';

ROLLBACK;   --커밋한 지점 기준으로 롤백임

-- 데이터 일부분 수정 : where 사용
-- dept_temp 부서번호가 40 번인 loc 열의 모든 값을 seoul 로 변경
UPDATE dept_temp
SET loc = 'SEOUL'
WHERE deptno = 40;

-- dept_name 부서번호가 80번인 dname은 SALES, LOC는 CHICAGO
UPDATE dept_temp
SET dname='SALES', loc = 'CHICAGO'
WHERE deptno = 80;



SELECT * FROM dept_temp;

-- emp_temp 사원들 중에서 급여가 2500 이하인 사원만 추가수당을 50으로 수정
UPDATE  emp_temp
SET    comm = 50 
WHERE   sal <= 2500;

-- 서브쿼리를 사용하여 데이터 수정
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트

update dept_temp
set (dname, loc) = (select dname, loc
                    from dept
                    where deptno = 40)
where deptno = 40;
    
COMMIT;

-- DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM (선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE emp_temp2 as select * from emp;

-- job이 MANAGER 인 사원 삭제

DELETE FROM emp_temp2
WHERE job='MANAGER';

-- job이 SALESMAN 인 사원 삭제
DELETE emp_temp2
WHERE job='SALESMAN';

-- 전체 데이터 삭제
DELETE emp_temp2;

ROLLBACK;

-- 서브쿼리를 사용하여 삭제
-- 급여 등급이 3등급이고, 30번 부서의 사원 삭제

delete from emp_temp2
where empno in (select e.empno
                from emp_temp2 e, salgrade s
                where e.sal between s.losal and s.hisal and s.grade=3 and e.deptno=30);


COMMIT;
-- 커밋 전까지는 최종반영이 아님
select * from emp_temp2;


-- 실습1 :실습을 위하여 기존 테이블을 이용하여 테이블을 생성한다.

--① EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
create table EXAM_EMP as select * from emp;
--② DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
create table EXAM_DEPT as select * from dept;
--③ SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성
create table EXAM_SALGRADE as select * from salgrade;



-- insert into 테이블이름(열이름1, 열이름2......)
-- values(데이터1, 데이터2......);

-- 실습2 : 다음의 정보를 EXAM_EMP 테이블에 입력하시오.
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02',4500,null,50);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21',1800,null,50);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7203, 'TEST_USER3', 'ANALYST', 7201, '2016-04-11',3400,null,60);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31',2700,300,60);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20',2600,null,70);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08',2600,null,70);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7207, 'TEST_USER7', 'LECTURE', 7201, '2016-10-28',2300,null,80);
insert into exam_emp( empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7208, 'TEST_USER8', 'STUDENT', 7201, '2018-03-09',1200,null,80);

-- 실습3 : EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
update exam_emp
set deptno=70
where sal > (select avg(sal) from exam_emp where deptno=50);

-- 실습4 : EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
-- 서브쿼리 사용
update exam_emp
set sal=sal*1.1 , deptno=80 
where hiredate > (select min(hiredate) from exam_emp where deptno=60);
-- 실습5 : EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
delete from exam_emp
where empno in (select empno
                from exam_emp, salgrade
                where sal between losal and hisal and grade=5);

--UPDATE 테이블명
--SET 변경할열이름=데이터, 변경할열이름=데이터....
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

select * from exam_emp;

COMMIT;

-- 트랜잭션(transaction) : 최소 수행 단위 - 여러개의 작업이 하나의 트랜잭션으로 묶일수있다
-- 트랜잭션을 제어하는 구문 TCL(Transaction Control Language) : commit, rollback 

CREATE TABLE dept_tcl AS SELECT * FROM dept;

INSERT INTO dept_tcl VALUES(50, 'DATABASE','SEOUL');

UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno=40;

DELETE FROM dept_tcl WHERE dname = 'RESEARCH';

SELECT * FROM dept_tcl;

-- 트랜잭션 취소
ROLLBACK; -- 롤백과 커밋만 해당

-- 트랜잭션 최종 반영 --> 커밋 이후 DML 작업은 하나의 트랜잭션으로 잡힌다
COMMIT;

-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
-- LOCK : 잠금(수정 중인 데이터 접근 막기) - 데이터의 일관성을 위해서 -> sql plus와 sql developer에서 동시에 접근하면 락이 걸려 디벨롭퍼에서 커밋하니까 풀림
DELETE FROM dept_tcl WHERE deptno=50;

UPDATE dept_tcl SET loc = 'SEOUL' WHERE deptno=30;

select * from dept_temp;














