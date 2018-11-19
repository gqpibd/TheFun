package donzo.thefun.model;

import java.io.Serializable;
//-- 구매 테이블
//
//DROP TABLE FUN_BUY
//CASCADE CONSTRAINTS;
//
//CREATE TABLE FUN_BUY( -- 어차피 BUY 하나당 REVIEW하나니까.. 합치면
//   SEQ NUMBER(8) PRIMARY KEY, -- 후기를 남기려면 구매 번호 필요
//   ID VARCHAR2(50) NOT NULL,
//   
//   PROJECTSEQ NUMBER(8) NOT NULL,
//   OPTIONSEQ NUMBER(8),  -- 기부인 경우는 OPTION이 없음
//   
//   COUNT NUMBER(8) NOT NULL,
//   PRICE NUMBER(8) NOT NULL,
//   REGDATE DATE NOT NULL,
//   
//   -- 후기 + 별점..
//   SCORE NUMBER(2), -- 5점만점. 10점만점
//   BCOMMENT VARCHAR2(1000) -- 후기
//);
//
//--- SEQ 추가
//CREATE SEQUENCE SEQ_BUY
//START WITH 1
//INCREMENT BY 1;
//
//ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_PROJECTSEQ_FK
//FOREIGN KEY(PROJECTSEQ)
//REFERENCES FUN_PROJECT(SEQ)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_OPTIONSEQ_FK
//FOREIGN KEY(OPTIONSEQ)
//REFERENCES FUN_OPTION(SEQ)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_ID_FK
//FOREIGN KEY(ID)
//REFERENCES FUN_MEMBER(ID)
//ON DELETE CASCADE; -- 종속 삭제
//
//
//-- 장바구니 테이블
//
//DROP TABLE FUN_BASKET
//CASCADE CONSTRAINTS;
//
//CREATE TABLE FUN_BASKET(
//   SEQ NUMBER(8) PRIMARY KEY, -- SEQ 추가
//   ID VARCHAR2(50) NOT NULL,
//   
//   PROJECTSEQ NUMBER(8) NOT NULL,
//   OPTIONSEQ NUMBER(8), -- 기부인 경우는 OPTION이 없음
//   
//   COUNT NUMBER(8) NOT NULL,
//   PRICE NUMBER(8) NOT NULL,
//   REGDATE DATE NOT NULL -- 필요할까?
//);
//
//-- BASKET SEQ 추가
//CREATE SEQUENCE SEQ_BASKET
//START WITH 1
//INCREMENT BY 1;
//
//ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_PROJECTSEQ_FK
//FOREIGN KEY(PROJECTSEQ)
//REFERENCES FUN_PROJECT(SEQ)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_OPTIONSEQ_FK
//FOREIGN KEY(OPTIONSEQ)
//REFERENCES FUN_OPTION(SEQ)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_BASKET ADD CONSTRAINT BASKET_ID_FK
//FOREIGN KEY(ID)
//REFERENCES FUN_MEMBER(ID)
//ON DELETE CASCADE; -- 종속 삭제
//
//-------------- VIEW : 구매
//CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, PRICE, REGDATE, SCORE, BCOMMENT, PTITLE, OTITLE, OCONTENT)
//AS
//SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.PRICE, B.REGDATE, B.SCORE, B.BCOMMENT,
//    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
//    (SELECT TITLE FROM FUN_OPTION WHERE PROJECTSEQ = B.PROJECTSEQ),
//    (SELECT CONTENT FROM FUN_OPTION WHERE PROJECTSEQ = B.PROJECTSEQ)
//FROM FUN_BUY B;
//
//-------------- VIEW : 장바구니
//CREATE OR REPLACE VIEW FUN_BASKET_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, PRICE, REGDATE, PTITLE, OTITLE, OCONTENT)
//AS
//SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.PRICE, B.REGDATE,
//    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
//    (SELECT TITLE FROM FUN_OPTION WHERE PROJECTSEQ = B.PROJECTSEQ),
//    (SELECT CONTENT FROM FUN_OPTION WHERE PROJECTSEQ = B.PROJECTSEQ)
//FROM FUN_BASKET B;

public class BuyDto implements Serializable {

	int seq;
	String id;
	int projectseq;
	int optionseq;
	int count;
	int price;
	String regdate;
	int score;
	String bcomment;
	String ptitle;
	String otitle;
	String ocontent;	
	
	public BuyDto() {}
	
	// 전체 다 있는거
	public BuyDto(int seq, String id, int projectseq, int optionseq, int count, int price, String regdate, int score,
			String bcomment, String ptitle, String otitle, String ocontent) {
		this.seq = seq;
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
		this.price = price;
		this.regdate = regdate;
		this.score = score;
		this.bcomment = bcomment;
		this.ptitle = ptitle;
		this.otitle = otitle;
		this.ocontent = ocontent;
	}
	
	// 새 구매 또는 새 장바구니
	public BuyDto(String id, int projectseq, int optionseq, int count, int price) {
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
		this.price = price;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getProjectseq() {
		return projectseq;
	}

	public void setProjectseq(int projectseq) {
		this.projectseq = projectseq;
	}

	public int getOptionseq() {
		return optionseq;
	}

	public void setOptionseq(int optionseq) {
		this.optionseq = optionseq;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getBcomment() {
		return bcomment;
	}

	public void setBcomment(String bcomment) {
		this.bcomment = bcomment;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getOtitle() {
		return otitle;
	}

	public void setOtitle(String otitle) {
		this.otitle = otitle;
	}

	public String getOcontent() {
		return ocontent;
	}

	public void setOcontent(String ocontent) {
		this.ocontent = ocontent;
	}

	@Override
	public String toString() {
		return "BuyDto [seq=" + seq + ", id=" + id + ", projectseq=" + projectseq + ", optionseq=" + optionseq
				+ ", count=" + count + ", price=" + price + ", regdate=" + regdate + ", score=" + score + ", bcomment="
				+ bcomment + ", ptitle=" + ptitle + ", otitle=" + otitle + ", ocontent=" + ocontent + "]";
	}
}