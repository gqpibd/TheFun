package donzo.thefun.model;

import java.io.Serializable;
/*-- 구매 테이블

DROP TABLE FUN_BUY
CASCADE CONSTRAINTS;

CREATE TABLE FUN_BUY( 
   SEQ NUMBER(8) PRIMARY KEY, 
   ID VARCHAR2(50) NOT NULL,
   
   PROJECTSEQ NUMBER(8) NOT NULL,
   OPTIONSEQ NUMBER(8),  // 기부인 경우는 OPTION이 없음
   
   COUNT NUMBER(8) NOT NULL,
   PRICE NUMBER(8) NOT NULL,
   REGDATE DATE NOT NULL,
   
   // 배송지 정보
   NAME VARCHAR2(50),
   PHONE VARCHAR2(50),
   POSTCODE VARCHAR2(10),
   ROADADDRESS VARCHAR2(100),
   DETAILADDRESS VARCHAR2(100),   

   // 후기 + 별점..
   SCORE NUMBER(2), 
   BCOMMENT VARCHAR2(1000) 
);

CREATE SEQUENCE SEQ_BUY
START WITH 1
INCREMENT BY 1;

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; 

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_OPTIONSEQ_FK
FOREIGN KEY(OPTIONSEQ)
REFERENCES FUN_OPTION(SEQ)
ON DELETE CASCADE; 

ALTER TABLE FUN_BUY ADD CONSTRAINT BUY_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; 

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

-------------- VIEW : 구매

CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, SCORE, BCOMMENT, NAME, PHONE, POSTCODE, ROADADDRESS, DETAILADDRESS, PTITLE, OTITLE, OCONTENT, STATUS, PRICE, PDATE, SHIPDATE)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE, B.SCORE, B.BCOMMENT, B.NAME, B.PHONE, B.POSTCODE, B.ROADADDRESS, B.DETAILADDRESS, 
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),    
    (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ= B.PROJECTSEQ),
    (SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT PDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ),
    (SELECT SHIPDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ)
FROM FUN_BUY B;


-------------- VIEW : 장바구니
CREATE OR REPLACE VIEW FUN_BASKET_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, PRICE, REGDATE, PTITLE, OTITLE, OCONTENT)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.PRICE, B.REGDATE,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ)
FROM FUN_BASKET B;*/

public class BuyDto implements Serializable {

	public static final String WAITING = "waiting"; // 승인대기 
	public static final String PREPARING = "preparing"; // 준비중
	public static final String ONGOING = "ongoing"; // 진행중
	public static final String COMPLETE_SUCCESS = "complete_success"; // 완료됨(성공)
	public static final String COMPLETE_FAIL = "complete_fail"; // 완료됨(실패)
	public static final String DELETE = "delete"; // 삭제
	
	//public static final String APPROVE = "approve"; // 승인됨
	public static final String REJECT = "reject"; // 거절됨
	public static final String REVISE = "revise"; // 보완요청
	
	int seq;
	String id;
	int projectseq; // 프로젝트 번호
	int optionseq; // 옵션 번호
	int count; // 구매수량
	int price; // 단가
	String regdate;
	int score; // 점수
	String bcomment; // 후기
	String ptitle; // 프로젝트 이름 -- view에서 가져옴
	String otitle; // 옵션 이름 -- view에서 가져옴
	String ocontent; // 옵션 내용 -- view에서 가져옴
	String status;
	String pdate;	//결제일 -- project 에서 가져옴
	String shipdate;	//배송일 -- project 에서 가져옴
	
	// 배송지 정보
	String name; // 구매자 이름
	String phone; // 전화번호
	String postcode; // 우편번호
	String roadaddress; // 도로명주소
	String detailaddress; // 상세주소
	
	
	public BuyDto() {}
	
	// 전체 다 있는거
	public BuyDto(int seq, String id, int projectseq, int optionseq, int count, int price, String regdate, int score,
			String bcomment, String ptitle, String otitle, String ocontent, String status, String pdate,
			String shipdate, String name, String phone, String postcode, String roadaddress, String detailaddress) {
		super();
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
		this.status = status;
		this.pdate = pdate;
		this.shipdate = shipdate;
		this.name = name;
		this.phone = phone;
		this.postcode = postcode;
		this.roadaddress = roadaddress;
		this.detailaddress = detailaddress;
	}
	
	// 새 구매 또는 새 장바구니
	public BuyDto(int projectseq, String id, int optionseq, int count) {
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
	}		

	//새 구매
	public BuyDto(String id, int projectseq, int optionseq, int count, int price, String name, String phone,
			String postcode, String roadaddress, String detailaddress) {
		super();
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
		this.price = price;
		this.name = name;
		this.phone = phone;
		this.postcode = postcode;
		this.roadaddress = roadaddress;
		this.detailaddress = detailaddress;
	}

	
	
	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getShipdate() {
		return shipdate;
	}

	public void setShipdate(String shipdate) {
		this.shipdate = shipdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	
	public String getDateForm(String datetime) {
		String date = datetime;
		if(datetime.lastIndexOf(' ')>-1) {
			date = datetime.substring(0, datetime.lastIndexOf(' '));
		}
		return date;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getRoadaddress() {
		return roadaddress;
	}

	public void setRoadaddress(String roadaddress) {
		this.roadaddress = roadaddress;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public boolean isWaiting() {
		if(status.equalsIgnoreCase(WAITING)) {
			return true;
		}
		return false;
	}
	public boolean isOngoing() {
		if(status.equalsIgnoreCase(ONGOING)) {
			return true;
		}else
			return false;
	}
	public boolean isPreparing() {
		if(status.equalsIgnoreCase(PREPARING)) {
			return true;
		}else
			return false;
	}
	public boolean isComplete_success() {
		if(status.equalsIgnoreCase(COMPLETE_SUCCESS)) {
			return true;
		}else
			return false;
	}
	public boolean isComplete_fail() {
		if(status.equalsIgnoreCase(COMPLETE_FAIL)) {
			return true;
		}else
			return false;
	}
	public boolean isDeleted() {
		if(status.equalsIgnoreCase(DELETE)) {
			return true;
		}else
			return false;
	}
	public boolean isRevise() {
		if(status.equalsIgnoreCase(REVISE)) {
			return true;
		}else {
			return false;
		}
	}
	public boolean isReject() {
		if(status.equalsIgnoreCase(REJECT)) {
			return true;
		}else {
			return false;
		}
	}
	
	@Override
	public String toString() {
		return "BuyDto [seq=" + seq + ", id=" + id + ", projectseq=" + projectseq + ", optionseq=" + optionseq
				+ ", count=" + count + ", price=" + price + ", regdate=" + regdate + ", score=" + score + ", bcomment="
				+ bcomment + ", ptitle=" + ptitle + ", otitle=" + otitle + ", ocontent=" + ocontent + ", status="
				+ status + ", pdate=" + pdate + ", shipdate=" + shipdate + ", name=" + name + ", phone=" + phone
				+ ", postcode=" + postcode + ", roadaddress=" + roadaddress + ", detailaddress=" + detailaddress + "]";
	}

	
	
}
