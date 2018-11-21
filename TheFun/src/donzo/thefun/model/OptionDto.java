package donzo.thefun.model;

import java.io.Serializable;
import java.util.Arrays;
/*-- 프로젝트 옵션 테이블

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

-------------- VIEW : 옵션
CREATE OR REPLACE VIEW FUN_OPTION_VIEW (SEQ, PROJECTSEQ, TITLE, CONTENT, PRICE, STOCK, BUYCOUNT)
AS
SELECT O.SEQ, O.PROJECTSEQ, O.TITLE, O.CONTENT, O.PRICE, O.STOCK,
    NVL((SELECT COUNT(*) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = O.PROJECTSEQ),0)
FROM FUN_OPTION O;*/

public class OptionDto implements Serializable {

	int seq;
	int projectseq;
	String op_title;
	String[] op_content;
	int price;
	int stock; // 재고
	
	int buycount; // 구매 수량
	
	public OptionDto() {}

	public OptionDto(int seq, int projectseq, String op_title, String[] op_content, int price, int stock,
			int buycount) {
		super();
		this.seq = seq;
		this.projectseq = projectseq;
		this.op_title = op_title;
		this.op_content = op_content;
		this.price = price;
		this.stock = stock;
		this.buycount = buycount;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getProjectseq() {
		return projectseq;
	}

	public void setProjectseq(int projectseq) {
		this.projectseq = projectseq;
	}

	public String getOp_title() {
		return op_title;
	}

	public void setOp_title(String op_title) {
		this.op_title = op_title;
	}

	public String[] getOp_content() {
		return op_content;
	}

	public void setOp_content(String[] op_content) {
		this.op_content = op_content;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getBuycount() {
		return buycount;
	}

	public void setBuycount(int buycount) {
		this.buycount = buycount;
	}

	@Override
	public String toString() {
		return "OptionDto [seq=" + seq + ", projectseq=" + projectseq + ", op_title=" + op_title + ", op_content="
				+ Arrays.toString(op_content) + ", price=" + price + ", stock=" + stock + ", buycount=" + buycount
				+ "]";
	}
	
	
}
