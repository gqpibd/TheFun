// update : 12/03 17:10 -- FUN_PROJECT 에서 CONTENT칼럼의 자료형을 VARCHAR2(4000)에서 CLOB칼럼으로 변경. 순서도 맨 마지막으로.
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
CASCADE CONSTRAINTS;
 
CREATE TABLE FUN_MEMBER(
   ID VARCHAR2(50) PRIMARY KEY,
   PWD VARCHAR2(50),
   NICKNAME VARCHAR2(50) NOT NULL,
   PHONE VARCHAR2(50),
   EMAIL VARCHAR2(50),
   PROFILE VARCHAR2(1000),
   INFO VARCHAR2(2000), -- 소개글 (NOT NULL 삭제)
   POINT NUMBER(15),
   AUTH NUMBER(1) NOT NULL, -- 1: 일반회원 3: 관리자
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100)
);

ALTER TABLE FUN_MEMBER
RENAME COLUMN ADDRESS TO PROFILE;

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
   
   STATUS VARCHAR2(50) NOT NULL -- 1: 준비중, 2: 승인대기, 3: 진행중, 4: 완료됨(성공), 5: 완료됨(실패), 6: 삭제
   
   CONTENT CLOB NOT NULL -- 사진 포함한 본문
);

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

ALTER TABLE FUN_PROJECT ADD CONSTRAINT PROJECT_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제(참조하는 데이터가 삭제되면 함께 삭제)



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
   BCOMMENT VARCHAR2(1000) -- 후기
);

-- 배송지 정보 추가
ALTER TABLE FUN_BUY
ADD(
   NAME VARCHAR2(50),
   PHONE VARCHAR2(50),
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100)
)

-- PRICE 칼럼 삭제
ALTER TABLE FUN_BUY
DROP COLUMN PRICE CASCADE CONSTRAINTS;

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
ON DELETE CASCADE; -- 종속 삭제


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

-- PRICE 칼럼 삭제
ALTER TABLE FUN_BASKET
DROP COLUMN PRICE CASCADE CONSTRAINTS;

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

CREATE TABLE FUN_ALARM(
   SEQ NUMBER(8) NOT NULL,
   PROJECTSEQ NUMBER(8) NOT NULL,
   ID VARCHAR2(50) NOT NULL,
   
   ATYPE VARCHAR2(50) NOT NULL, -- 알람 종류. 1. 시작, 2. 종료, 3. 결제, 4. 배송, 5. 공지, 6. 댓글
   BUYTYPE VARCHAR2(50) NOT NULL, -- 찜, 장바구니, 구매, 내프로젝트
   -- CONTENT VARCHAR2(2000) NOT NULL,
   REGDATE DATE NOT NULL
);

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

ALTER TABLE FUN_QNA
ADD(towhom varchar2(50));

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


-------------- VIEW : 프로젝트 전체 내용 
CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED, STATUS, NICKNAME)
AS
SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE,
   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(DISTINCT ID) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),      
   NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT SUM((SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ) * COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   (SELECT 
    CASE 
        WHEN LOWER(STATUS) = 'waiting' THEN 'waiting'
        WHEN LOWER(STATUS) = 'delete' THEN 'delete'
        WHEN SDATE >= SYSDATE THEN 'preparing' 
        WHEN EDATE >= SYSDATE THEN 'ongoing' 
        WHEN NVL((SELECT SUM((SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ) * COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0) >=  GOALFUND THEN 'complete_success'         
        ELSE 'complete_fail'  
     END AS "status" 
     FROM FUN_PROJECT WHERE SEQ = P.SEQ),
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = P.ID)
FROM FUN_PROJECT P;

-------------- VIEW : 구매
CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, SCORE, BCOMMENT, NAME, PHONE, POSTCODE, ROADADDRESS, DETAILADDRESS, PTITLE, OTITLE, OCONTENT, STATUS, PRICE)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE, B.SCORE, B.BCOMMENT, B.NAME, B.PHONE, B.POSTCODE, B.ROADADDRESS, B.DETAILADDRESS, 
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),    
    (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ= B.PROJECTSEQ),
    (SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)
FROM FUN_BUY B;

-------------- VIEW : 장바구니
CREATE OR REPLACE VIEW FUN_BASKET_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),
    (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ= B.PROJECTSEQ),
    (SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)
FROM FUN_BASKET B;

-------------- VIEW : 옵션
CREATE OR REPLACE VIEW FUN_OPTION_VIEW (SEQ, PROJECTSEQ, TITLE, CONTENT, PRICE, STOCK, BUYCOUNT)
AS
SELECT O.SEQ, O.PROJECTSEQ, O.TITLE, O.CONTENT, O.PRICE, O.STOCK,
    NVL((SELECT SUM(COUNT) FROM FUN_BUY GROUP BY OPTIONSEQ HAVING OPTIONSEQ = O.SEQ),0)
FROM FUN_OPTION O;

-------------- VIEW : 알람
CREATE OR REPLACE VIEW FUN_ALARM_VIEW (SEQ, PROJECTSEQ, ID, ATYPE, BUYTYPE, REGDATE, PTITLE)
AS
SELECT A.SEQ, A.PROJECTSEQ, A.ID, A.ATYPE, A.BUYTYPE, A.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = A.PROJECTSEQ)
FROM FUN_ALARM A;

-------------- VIEW : 댓글
CREATE OR REPLACE VIEW FUN_QNA_VIEW (SEQ, PROJECTSEQ, ID, REFSEQ, CONTENT, STATUS, REGDATE, TOWHOM, NICKNAME, PROFILE)
AS
SELECT Q.SEQ, Q.PROJECTSEQ, Q.ID, Q.REFSEQ, Q.CONTENT, Q.STATUS, Q.REGDATE, Q.TOWHOM, 
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = Q.ID),
    (SELECT PROFILE FROM FUN_MEMBER WHERE ID = Q.ID)
FROM FUN_QNA Q;

--------------임시 데이터
insert into FUN_PROJECT
values(SEQ_PROJECT.NEXTVAL, 'eee', 'reward', 'food', '떡볶이', '가장 맛있는 떡볶이', '집에서 먹는 가장 맛있는 국물 떡볶이', '#매운#떡볶이#재구매','1111-2222-3333 우리은행',2000000,
       '2018-11-25','2018-12-03','2018-12-04','2018-12-06',sysdate, 'preparing')

insert into FUN_OPTION
values(SEQ_OPTION.NEXTVAL, 1, '얼리버드', '5봉지/10000원', '10000', 50)
insert into FUN_OPTION
values(SEQ_OPTION.NEXTVAL, 1, '아무때나', '3봉지/10000원', '10000', 200)

insert into FUN_NOTICE
values(SEQ_NOTICE.NEXTVAL, 1, '프로젝트준비중', '쉽지 않군', SYSDATE);
insert into FUN_NOTICE
values(SEQ_NOTICE.NEXTVAL, 1, '프로젝트 시작', '많이 후훤해 주세요', '2018-11-25')

insert into FUN_BUY
values(SEQ_BUY.NEXTVAL,'aaa',1,1,1,10000,'2018-11-25',null,null);



