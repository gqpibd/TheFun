﻿-- 멤버 테이블

DROP TABLE FUN_MEMBER
CASCADE CONSTRAINTS; -- S추가
 
CREATE TABLE FUN_MEMBER(
   ID VARCHAR2(50) PRIMARY KEY,
   PWD VARCHAR2(50),
   NICKNAME VARCHAR2(50) NOT NULL,
   PHONE VARCHAR2(50),
   EMAIL VARCHAR2(50),
   ADDRESS VARCHAR2(100),
   INFO VARCHAR2(2000), -- 소개글 (NOT NULL 삭제)
   POINT NUMBER(15),
   AUTH NUMBER(1) NOT NULL -- 1: 일반회원 3: 관리자
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
   CONTENT VARCHAR2(4000) NOT NULL, -- 사진 포함한 본문
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
);

CREATE SEQUENCE SEQ_PROJECT
START WITH 1 INCREMENT BY 1;

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

CREATE TABLE FUN_BUY( -- 어차피 BUY 하나당 REVIEW하나니까.. 합치면
   SEQ NUMBER(8) PRIMARY KEY, -- 후기를 남기려면 구매 번호 필요
   ID VARCHAR2(50) NOT NULL,
   
   PROJECTSEQ NUMBER(8) NOT NULL,
   OPTIONSEQ NUMBER(8),  -- 기부인 경우는 OPTION이 없음
   
   COUNT NUMBER(8) NOT NULL,
   PRICE NUMBER(8) NOT NULL,
   REGDATE DATE NOT NULL,
   
   -- 후기 + 별점..
   SCORE NUMBER(2), -- 5점만점. 10점만점
   BCOMMENT VARCHAR2(1000) -- 후기
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
ON DELETE CASCADE; -- 종속 삭제


-- 장바구니 테이블

DROP TABLE FUN_BASKET
CASCADE CONSTRAINTS;

CREATE TABLE FUN_BASKET(
   SEQ NUMBER(8) PRIMARY KEY, -- SEQ 추가
   ID VARCHAR2(50) NOT NULL,
   
   PROJECTSEQ NUMBER(8) NOT NULL,
   OPTIONSEQ NUMBER(8), -- 기부인 경우는 OPTION이 없음
   
   COUNT NUMBER(8) NOT NULL,
   PRICE NUMBER(8) NOT NULL,
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
   
   REGDATE DATE NOT NULL
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



-- 별점 테이블 ---> FUN_BUY 테이블에 통합??
/*
CREATE TABLE FUN_SCORE(
   PROJECTSEQ NUMBER(8) NOT NULL,
   REPLYSEQ NUMBER(8) NOT NULL,
   ID VARCHAR2(50) NOT NULL,
   
   SCORE NUMBER(10) NOT NULL,
);

ALTER TABLE FUN_SCORE ADD CONSTRAINT SCORE_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_SCORE ADD CONSTRAINT SCORE_REPLYSEQ_FK
FOREIGN KEY(REPLYSEQ)
REFERENCES FUN_REPLY(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_SCORE ADD CONSTRAINT SCORE_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제
*/

-------------- VIEW : 프로젝트 전체 내용 

CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, STATUS, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED)
AS
SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE, P.STATUS,
   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(*) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),   
    NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
    NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
    NVL((SELECT SUM(PRICE * COUNT) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0)
FROM FUN_PROJECT P;

-------------- VIEW : 구매
CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, PRICE, REGDATE, SCORE, BCOMMENT, PTITLE, OTITLE, OCONTENT)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.PRICE, B.REGDATE, B.SCORE, B.BCOMMENT,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ)
FROM FUN_BUY B;

-------------- VIEW : 장바구니
CREATE OR REPLACE VIEW FUN_BASKET_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, PRICE, REGDATE, PTITLE, OTITLE, OCONTENT)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.PRICE, B.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ)
FROM FUN_BASKET B;

-------------- VIEW : 옵션
CREATE OR REPLACE VIEW FUN_OPTION_VIEW (SEQ, PROJECTSEQ, TITLE, CONTENT, PRICE, STOCK, BUYCOUNT)
AS
SELECT O.SEQ, O.PROJECTSEQ, O.TITLE, O.CONTENT, O.PRICE, O.STOCK,
    NVL((SELECT COUNT(*) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = O.PROJECTSEQ),0)
FROM FUN_OPTION O;

-------------- VIEW : 알람
CREATE OR REPLACE VIEW FUN_ALARM_VIEW (SEQ, PROJECTSEQ, ID, ATYPE, BUYTYPE, REGDATE, PTITLE)
AS
SELECT A.SEQ, A.PROJECTSEQ, A.ID, A.ATYPE, A.BUYTYPE, A.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = A.PROJECTSEQ)
FROM FUN_ALARM A;

commit;