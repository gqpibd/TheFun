package donzo.thefun.model;

import java.io.Serializable;
/*
-- 장바구니 테이블

DROP TABLE FUN_BASKET
CASCADE CONSTRAINTS;

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
*/

public class BasketDto implements Serializable {
	/*SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE*/
	int seq;
	String id;
	int projectseq; // 프로젝트 번호
	int optionseq; // 옵션 번호
	int count; // 구매수량
	int price; // 단가
	String regdate;
	
	String ptitle; // 프로젝트 이름 -- view에서 가져옴
	String otitle; // 옵션 이름 -- view에서 가져옴
	String ocontent; // 옵션 내용 -- view에서 가져옴
	String status;	
	
	public BasketDto() {}

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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public boolean isOngoing() {
		if(status.equalsIgnoreCase(ProjectDto.ONGOING)) {
			return true;
		}else
			return false;
	}
	public boolean isPreparing() {
		if(status.equalsIgnoreCase(ProjectDto.PREPARING)) {
			return true;
		}else
			return false;
	}
	
	public boolean isComplete() { // 어차피 장바구니 이므로 완료 되면 다 똑같음
		if(status.equalsIgnoreCase(ProjectDto.COMPLETE_SUCCESS) || status.equalsIgnoreCase(ProjectDto.COMPLETE_FAIL)) {
			return true;
		}else
			return false;
	}
	
	public boolean isDeleted() {
		if(status.equalsIgnoreCase(ProjectDto.DELETE)) {
			return true;
		}else
			return false;
	}

	@Override
	public String toString() {
		return "BasketDto [seq=" + seq + ", id=" + id + ", projectseq=" + projectseq + ", optionseq=" + optionseq
				+ ", count=" + count + ", price=" + price + ", regdate=" + regdate + ", ptitle=" + ptitle + ", otitle="
				+ otitle + ", ocontent=" + ocontent + ", status=" + status + "]";
	}
}
