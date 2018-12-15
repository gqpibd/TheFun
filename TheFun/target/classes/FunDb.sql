﻿// update : 12/15 08:23 -- FUN_BUY 테이을 POINT칼럼 이름을 USEPOINT로 변경
// update : 12/12 21:15 -- FUN_BUY 테이블에 POINT 칼럼 추가, FUN_BUY_VIEW도 수정
// update : 12/12 18:57 -- FUN_BUY 테이블에 STATUS 칼럼 추가, FUN_BUY_VIEW STAUTS 계산법 변경
// update : 12/10 17:34 -- FUN_PROJECTALL 변경 -- 달성금액 다시 계산2 
// update : 12/07 08:41 -- FUN_PROJECTALL 변경 -- 달성금액 다시 계산 
// update : 12/06 02:33 -- FUN_PROJECTALL 변경 -- REVIEWCOUNT 추가
// update : 12/04 20:11 -- FUN_BUY에 PRICE추가(기부시 필요) FUN_BUY_VIEW 테이블 수정
﻿// update : 12/04 19:31 -- FUN_PROJECTALL 테이블에서 해당 펀딩 프로젝트의 총 리워드 갯수를 가져올 수 있는 OPTIONTOTAL 칼럼을 추가.
﻿// update : 12/04 16:42 -- FUN_BUY 테이블에 CARDNUMBER ,BANKNAME, PRICE 추가
// update : 12/03 20:58 -- FUN_BUY_VIEW 테이블에 PDATE, SHIPDATE 추가
﻿// update : 12/03 17:10 -- FUN_PROJECT 에서 CONTENT칼럼의 자료형을 VARCHAR2(4000)에서 CLOB칼럼으로 변경. 순서도 맨 마지막으로.
// update : 12/03 03:28 -- FUN_PROJECTALL 변경 -- STATUS에 REJECT, REVISE 추가됨
// update : 12/03 02:33 -- 프로젝트 승인, 거절 메시지 테이블( FUN_PROJECTMSG ) 생성
// update : 12/02 00:50 -- FUN_ALARM 테이블에 FROMNICKNAME(알람생성자), CONTENT 추가
// update : 11/30 21:23 -- FUN_PROJECTALL테이블 수정, status 가져올 때, WHEN EDATE-SYSDATE >= 0 THEN 'ongoing' 
// update : 11/30 01:30 -- FUN_QNA_VIEW TOWHOMNICKNAME 추가, TOWHOM 외래키 추가
// update : 11/29 01:43 -- FUN_BUY 테이블에서 PRICE 삭제, 대신 FUN_BUY_VIEW에서 가격을 가져오도록 변경, FUN_PROJECTALL도 이에 맞게 변경, 장바구니에서도 PRICE 삭제 및 VIEW 변경 
// update : 11/28 23:32 -- FUN_PROJECTALL 에서 BUYCOUNT 가져오는 방법 변경
// update : 11/28 20:35 -- FUN_BUY 테이블에 배송지정보(name, phone, postcode, roadaddress, detailaddress 칼럼 추가), FUN_BUY_VIEW도 이에 맞게 변경
// update : 11/27 19:29 -- FUN_PROJECTALL 에서 NICKNAME 가져올 수있게 수정
// update : 11/27 16:45 -- 닉네임과 프로필 가져올 수 있게 FUN_QNA_VIEW 생성
// update : 11/27 16:12 -- FUN_QNA 테이블에 TOWHOM 칼럼 추가
// update : 11/27 2:43  --  FUN_BUY_VIEW , FUN_BASKET_VIEW 변경. status를 project에서 가져오는 대신 변경된 projectall view 내용 가져오도록 함
// update : 11/26 19:22 -- projectall view 변경 -- status update

-- 멤버 테이블

DROP TABLE FUN_MEMBER
CASCADE CONSTRAINTS; -- S추가
 
CREATE TABLE FUN_MEMBER(
   ID VARCHAR2(50) PRIMARY KEY,
   PWD VARCHAR2(50),
   NICKNAME VARCHAR2(50) NOT NULL,
   PHONE VARCHAR2(50),
   EMAIL VARCHAR2(50),
   PROFILE VARCHAR2(100),
   INFO VARCHAR2(2000), -- 소개글 (NOT NULL 삭제)
   POINT NUMBER(15),
   AUTH NUMBER(1) NOT NULL, -- 1: 일반회원 3: 관리자
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100)
);


-- 프로젝트 테이블

DROP TABLE FUN_PROJECT
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PROJECT;

CREATE TABLE FUN_PROJECT(
   SEQ NUMBER(8) PRIMARY KEY,
   ID VARCHAR2(50) NOT NULL,
   
   FUNDTYPE VARCHAR2(50) NOT NULL, -- REWARD | DONATION
   CATEGORY VARCHAR2(50) NOT NULL, -- FOOD, ANIMAL, IT | ANIMAL, HUMAN
   TITLE VARCHAR2(200) NOT NULL,       
   SUMMARY VARCHAR2(1000) NOT NULL,
   TAGS VARCHAR2(400), -- 태그를 넣는거는 선택사항으로? NOT NULL 없앰.
   BANK VARCHAR2(200) NOT NULL,
   GOALFUND NUMBER(10) NOT NULL, -- GOAL 오타 GOALPRICE? GOALFUND? GOALFUNDAMOUNT?
   
   SDATE DATE NOT NULL, -- DATE로 변경
   EDATE DATE NOT NULL,-- DATE로 변경
   PDATE DATE NOT NULL, -- DATE로 변경 -- 결제일
   SHIPDATE DATE, -- DATE로 변경 -- 배송일 --> 기부인 경우 배송이 없으므로 NOT NULL 삭제
   REGDATE DATE NOT NULL,
   
   STATUS VARCHAR2(50) NOT NULL, -- 1: 준비중, 2: 승인대기, 3: 진행중, 4: 완료됨(성공), 5: 완료됨(실패), 6: 삭제
   
   CONTENT CLOB NOT NULL -- 사진 포함한 본문
);

CREATE SEQUENCE SEQ_PROJECT
START WITH 1 INCREMENT BY 1;

ALTER TABLE FUN_PROJECT ADD CONSTRAINT PROJECT_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제(참조하는 데이터가 삭제되면 함께 삭제)

-- FUN_PROJECT테이블 변경사항 쿼리
-- 새 CLOB 컬럼을 추가합니다
ALTER TABLE FUN_PROJECT ADD(TMP_CONTENT CLOB NOT NULL);
-- 데이터를 복사합니다
UPDATE FUN_PROJECT SET TMP_CONTENT = CONTENT;
COMMIT;
-- 기존 컬럼을 삭제합니다
ALTER TABLE FUN_PROJECT DROP COLUMN CONTENT;
-- 새로 추가한 임시 컬럼의 이름을 변경합니다
ALTER TABLE FUN_PROJECT RENAME COLUMN TMP_CONTENT TO CONTENT;
-- 이제 해당 칼럼에 NOT NULL 추가
ALTER TABLE FUN_PROJECT MODIFY (CONTENT NOT NULL);


-- 프로젝트 옵션 테이블

DROP TABLE FUN_OPTION
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_OPTION;

CREATE TABLE FUN_OPTION(
   SEQ NUMBER(8) PRIMARY KEY,
   PROJECTSEQ NUMBER(8) NOT NULL,
   
   TITLE VARCHAR2(200) NOT NULL,
   CONTENT VARCHAR2(400) NOT NULL,
   
   PRICE NUMBER(8) NOT NULL,
   STOCK NUMBER(8) -- 재고 제한이 없을 수 있음.. NOT NULL 삭제
);

CREATE SEQUENCE SEQ_OPTION
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_OPTION ADD CONSTRAINT OPTION_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제


-- 구매 테이블

DROP TABLE FUN_BUY
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_BUY;

CREATE TABLE FUN_BUY( -- 어차피 BUY 하나당 REVIEW하나니까.. 합치면
   SEQ NUMBER(8) PRIMARY KEY, -- 후기를 남기려면 구매 번호 필요
   ID VARCHAR2(50) NOT NULL,
   
   PROJECTSEQ NUMBER(8) NOT NULL,
   OPTIONSEQ NUMBER(8),  -- 기부인 경우는 OPTION이 없음
   
   COUNT NUMBER(8) NOT NULL,
   REGDATE DATE NOT NULL,
   
   -- 배송지 정보
   NAME VARCHAR2(50),
   PHONE VARCHAR2(50),
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100),   

   -- 후기 + 별점..
   SCORE NUMBER(2), -- 5점만점. 10점만점
   BCOMMENT VARCHAR2(1000), -- 후기
   
   --결제카드정보
   CARDNUMBER VARCHAR2(50),
   BANKNAME VARCHAR2(50),
   
   PRICE NUMBER,
   STATUS VARCHAR2(50)
);

--- SEQ 추가
CREATE SEQUENCE SEQ_BUY
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_OPTIONSEQ_FK
FOREIGN KEY(OPTIONSEQ)
REFERENCES FUN_OPTION(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE;

-- FUN_OPTION 테이블 변경사항 쿼리
-- 배송지 정보 추가
ALTER TABLE FUN_BUY
ADD(
   NAME VARCHAR2(50),
   PHONE VARCHAR2(50),
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100)
)
--결제카드정보 추가
ALTER TABLE FUN_BUY
ADD(
   CARDNUMBER VARCHAR2(50),
   BANKNAME VARCHAR2(50)
)
-- PRICE 칼럼 추가
ALTER TABLE FUN_BUY
ADD(
   PRICE NUMBER
)

-- status 칼럼 추가
ALTER TABLE FUN_BUY
ADD(
   status VARCHAR2(50)
)

-- 포인트 칼럼 추가
ALTER TABLE FUN_BUY
ADD(
   usepoint number
)


-- 장바구니 테이블

DROP TABLE FUN_BASKET
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_BASKET;

CREATE TABLE FUN_BASKET(
   SEQ NUMBER(8) PRIMARY KEY, -- SEQ 추가
   ID VARCHAR2(50) NOT NULL,
   
   PROJECTSEQ NUMBER(8) NOT NULL,
   OPTIONSEQ NUMBER(8), -- 기부인 경우는 OPTION이 없음
   
   COUNT NUMBER(8) NOT NULL,
   REGDATE DATE NOT NULL -- 필요할까?
);

-- BASKET SEQ 추가
CREATE SEQUENCE SEQ_BASKET
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_OPTIONSEQ_FK
FOREIGN KEY(OPTIONSEQ)
REFERENCES FUN_OPTION(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제

-- FUN_BASKET 테이블 변경사항 쿼리
-- PRICE 칼럼 삭제
ALTER TABLE FUN_BASKET
DROP COLUMN PRICE CASCADE CONSTRAINTS;


-- 공지사항 테이블

DROP TABLE FUN_NOTICE
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_NOTICE;

CREATE TABLE FUN_NOTICE(
   SEQ NUMBER(8) PRIMARY KEY,
   PROJECTSEQ NUMBER(8) NOT NULL,
   
   TITLE VARCHAR2(400) NOT NULL,
   CONTENT VARCHAR2(800) NOT NULL,
   
   REGDATE DATE NOT NULL
);

CREATE SEQUENCE SEQ_NOTICE
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_NOTICE ADD CONSTRAINT NOTICE_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제


-- 좋아요 테이블

DROP TABLE FUN_LIKE
CASCADE CONSTRAINTS;

CREATE TABLE FUN_LIKE(
   ID VARCHAR2(50) NOT NULL,
   PROJECTSEQ NUMBER(8) NOT NULL
);

ALTER TABLE FUN_LIKE ADD CONSTRAINT LIKE_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_LIKE ADD CONSTRAINT LIKE_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제


-- 알람 테이블

DROP TABLE FUN_ALARM
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_ALARM;

CREATE TABLE FUN_ALARM(
   SEQ NUMBER(8) NOT NULL,
   PROJECTSEQ NUMBER(8) NOT NULL,   
   ID VARCHAR2(50) NOT NULL, -- 받는사람
   
   ATYPE VARCHAR2(50) NOT NULL, -- 알람 종류. 1. 시작, 2. 종료, 3. 결제, 4. 배송, 5. 공지, 6. 댓글
   BUYTYPE VARCHAR2(50) NOT NULL, -- 찜, 장바구니, 구매, 내프로젝트, 기타(댓글만 다는 경우)
   REGDATE DATE NOT NULL,
   FROMNICKNAME VARCHAR2(50), -- 보내는사람
   ACONTENT VARCHAR2(2000)
);

CREATE SEQUENCE SEQ_ALARM
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제


-- Q&A 테이블

DROP TABLE FUN_QNA
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_QNA;

CREATE TABLE FUN_QNA(
   SEQ NUMBER(8) PRIMARY KEY,
   PROJECTSEQ NUMBER(8) NOT NULL,
   ID VARCHAR2(50) NOT NULL,
   
   REFSEQ NUMBER(8) NOT NULL, -- 대댓일 때 원래 댓글
   CONTENT VARCHAR2(1000) NOT NULL,
   STATUS VARCHAR2(50) NOT NULL, -- 1. 일반, 2. 비밀, 3 삭제
   
   REGDATE DATE NOT NULL,
   TOWHOM VARCHAR2(50)
);

CREATE SEQUENCE SEQ_QNA
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제

-- REFSEQ 왜래키 추가
ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_REFSEQ_FK
FOREIGN KEY(REFSEQ)
REFERENCES FUN_QNA(SEQ)
ON DELETE CASCADE; -- 종속 삭제

-- TOWHOM 왜래키 추가
ALTER TABLE FUN_QNA ADD CONSTRAINT ALARM_MEMBER_TOWHOM_FK
FOREIGN KEY(TOWHOM)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; 

-- FUN_QNA 테이블 변경사항 쿼리
ALTER TABLE FUN_QNA
ADD(towhom varchar2(50));


-----------------------프로젝트 승인, 거절 메시지 테이블

DROP TABLE FUN_PROJECTMSG CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_PROJECTMSG;

CREATE TABLE FUN_PROJECTMSG( 
    SEQ NUMBER(8) PRIMARY KEY, 
    PROJECTSEQ NUMBER(8) NOT NULL,
    STATUS VARCHAR2(50) NOT NULL, -- SUBMIT, APPROVE, REJECT, REVISE, RESUBMIT
    MESSAGE VARCHAR2(3000),
    REGDATE DATE,
    CONSTRAINT FK_PROJECTSEQ_PROJECTMSG FOREIGN KEY(PROJECTSEQ) REFERENCES FUN_PROJECT(SEQ)
);

CREATE SEQUENCE SEQ_PROJECTMSG
START WITH 1 INCREMENT BY 1;


-------------- VIEW : 프로젝트 전체 내용 

CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED, STATUS, NICKNAME, OPTIONTOTAL, REVIEWCOUNT)
AS
SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE,
   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(DISTINCT ID) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),      
   NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT SUM(NVL(B.PRICE,(SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)) * B.COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   (SELECT 
    CASE 
        WHEN LOWER(STATUS) = 'waiting' THEN 'waiting'
        WHEN LOWER(STATUS) = 'delete' THEN 'delete'
        WHEN LOWER(STATUS) = 'reject' THEN 'reject'
        WHEN LOWER(STATUS) = 'revise' THEN 'revise'
        WHEN SDATE >= SYSDATE THEN 'preparing' 
        WHEN EDATE-SYSDATE >= 0 THEN 'ongoing' 
        WHEN (SELECT SUM(NVL(B.PRICE,(SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)) * B.COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ) >=  GOALFUND THEN 'complete_success'         
        ELSE 'complete_fail'  
     END AS "status" 
     FROM FUN_PROJECT WHERE SEQ = P.SEQ),
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = P.ID),
    NVL((SELECT COUNT(*) FROM FUN_OPTION WHERE PROJECTSEQ = P.SEQ),0),
    (SELECT COUNT(*) FROM FUN_BUY WHERE PROJECTSEQ= P.SEQ AND NVL(SCORE,0)>0)
FROM FUN_PROJECT P;

-------------- VIEW : 구매
CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, SCORE, BCOMMENT, NAME, PHONE, POSTCODE, ROADADDRESS, DETAILADDRESS, CARDNUMBER, BANKNAME, USEPOINT, PTITLE, OTITLE, OCONTENT, STATUS, PRICE, PDATE, SHIPDATE)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE, B.SCORE, B.BCOMMENT, B.NAME, B.PHONE, B.POSTCODE, B.ROADADDRESS, B.DETAILADDRESS, B.CARDNUMBER, B.BANKNAME, B.USEPOINT,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),    
    (SELECT 
     CASE 
        WHEN LOWER(STATUS) = 'finish' THEN 'finish'        
        ELSE (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ = B.PROJECTSEQ)
     END AS "status" 
     FROM FUN_BUY
     WHERE SEQ=B.SEQ),
    NVL(B.PRICE,(SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)),
    (SELECT PDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ),
    (SELECT SHIPDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ)
FROM FUN_BUY B;

-------------- VIEW : 장바구니
CREATE OR REPLACE VIEW FUN_BASKET_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE, STOCK)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),
    (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ= B.PROJECTSEQ),
    (SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT STOCK FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)
FROM FUN_BASKET B;

-------------- VIEW : 옵션
CREATE OR REPLACE VIEW FUN_OPTION_VIEW (SEQ, PROJECTSEQ, TITLE, CONTENT, PRICE, STOCK, BUYCOUNT)
AS
SELECT O.SEQ, O.PROJECTSEQ, O.TITLE, O.CONTENT, O.PRICE, O.STOCK,
    NVL((SELECT SUM(COUNT) FROM FUN_BUY GROUP BY OPTIONSEQ HAVING OPTIONSEQ = O.SEQ),0)
FROM FUN_OPTION O;

-------------- VIEW : 알람
CREATE OR REPLACE VIEW FUN_ALARM_VIEW (SEQ, PROJECTSEQ, ID, FROMNICKNAME, ATYPE, BUYTYPE, REGDATE, ACONTENT, PTITLE)
AS
SELECT A.SEQ, A.PROJECTSEQ, A.ID, A.FROMNICKNAME, A.ATYPE, A.BUYTYPE, A.REGDATE, A.ACONTENT,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = A.PROJECTSEQ)
FROM FUN_ALARM A;

-------------- VIEW : 댓글
CREATE OR REPLACE VIEW FUN_QNA_VIEW (SEQ, PROJECTSEQ, ID, REFSEQ, CONTENT, STATUS, REGDATE, TOWHOM, NICKNAME, PROFILE, TOWHOMNICKNAME)
AS
SELECT Q.SEQ, Q.PROJECTSEQ, Q.ID, Q.REFSEQ, Q.CONTENT, Q.STATUS, Q.REGDATE, Q.TOWHOM, 
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = Q.ID),
    (SELECT PROFILE FROM FUN_MEMBER WHERE ID = Q.ID),
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = Q.TOWHOM)
FROM FUN_QNA Q;


--------------임시 insert 데이터
insert into FUN_MEMBER
values('admin', 'admin', '운영자', '01012345678', 'abc@gmail.com', 'profile',
        '안녕하세요 운영자입니다', 0, 3, '123', '테헤란로', 'kh빌딩 3층');