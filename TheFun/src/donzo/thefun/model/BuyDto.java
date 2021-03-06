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
   
   //결제카드정보
   CARDNUMBER VARCHAR2(50),
   BANKNAME VARCHAR2(50),
   
   PRICE NUMBER
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



-------------- VIEW : 구매

CREATE OR REPLACE VIEW FUN_BUY_VIEW (SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, SCORE, BCOMMENT, NAME, PHONE, POSTCODE, ROADADDRESS, DETAILADDRESS, CARDNUMBER, BANKNAME, PTITLE, OTITLE, OCONTENT, STATUS, PRICE, PDATE, SHIPDATE)
AS
SELECT B.SEQ, B.ID, B.PROJECTSEQ, B.OPTIONSEQ, B.COUNT, B.REGDATE, B.SCORE, B.BCOMMENT, B.NAME, B.PHONE, B.POSTCODE, B.ROADADDRESS, B.DETAILADDRESS, B.CARDNUMBER, B.BANKNAME,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = B.PROJECTSEQ),
    (SELECT TITLE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ),
    (SELECT CONTENT FROM FUN_OPTION WHERE SEQ= B.OPTIONSEQ),    
    (SELECT STATUS FROM FUN_PROJECTALL WHERE SEQ= B.PROJECTSEQ),
    NVL(B.PRICE,(SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ)),
    (SELECT PDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ),
    (SELECT SHIPDATE FROM FUN_PROJECT WHERE SEQ=B.PROJECTSEQ)
FROM FUN_BUY B;
*/

import donzo.thefun.util.UtilFunctions;

public class BuyDto implements Serializable {		
	
	public static final String FINISH = "finish";// status 배송 완료, 기부 완료
	  
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
	
	//카드결제정보
	String cardNumber;
	String bankName;
	int usepoint;
	
	public BuyDto() {}
	
	// 전체 다 있는거
	public BuyDto(int seq, String id, int projectseq, int optionseq, int count, int price, String regdate, int score,
			String bcomment, String ptitle, String otitle, String ocontent, String status, String pdate,
			String shipdate, String name, String phone, String postcode, String roadaddress, String detailaddress,
			String cardNumber, String bankName, int usepoint) {
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
		this.cardNumber = cardNumber;
		this.bankName = bankName;
		this.usepoint=usepoint;
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
			String postcode, String roadaddress, String detailaddress, String cardNumber, String bankName,
			int usepoint) {
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
		this.cardNumber = cardNumber;
		this.bankName = bankName;
		this.usepoint = usepoint;
	}

	//내 후원 상세보기 쿼리문에 넣기위함
	public BuyDto(String id, int projectseq, int optionseq, String regdate) {
		super();
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.regdate = regdate;
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
		this.ocontent = ocontent.trim();
	}
	
	public String getDateForm(String datetime) {
		String date = datetime;
		if(datetime.lastIndexOf(' ')>-1) {
			date = datetime.substring(0, datetime.lastIndexOf(' '));
		}
		return date;
	}
	
	public String getDateKr() {
		return UtilFunctions.getDateFormKorean(regdate);
	}
	
	//제목이 길때 뒤에 ... 해주는 거
	public String dot3(String msg){
		String s="";
		if(msg.length()>=20){
			s=msg.substring(0,20); 
			s+="...";
		}else{
			s=msg.trim();
		}
		return s;
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
	
	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	public int getUsepoint() {
		return usepoint;
	}

	public void setUsepoint(int usepoint) {
		this.usepoint = usepoint;
	}
	
	public boolean isReward() {
		if(otitle == null) { // 기부
			return false;
		}else { // 리워드
			return true;
		}
	}

	public String getStatusKr() {
		switch (status.toLowerCase()) {
		case ProjectDto.ONGOING:
			return "프로젝트 진행중";
		case ProjectDto.COMPLETE_SUCCESS:
			if(otitle == null) { // 기부
				return "완료 대기";
			}else { // 리워드
				return "배송 중";
			}
		case ProjectDto.COMPLETE_FAIL:
			return "목표 미달성(결제 취소)";
		case FINISH:
			if(otitle == null) { // 기부
				return "기부 완료";
			}else { // 리워드
				return "배송 완료";
			}
		}
		return "";
	}
	
	public boolean isOngoing() {
		if(status.equalsIgnoreCase(ProjectDto.ONGOING)) {
			return true;
		}else
			return false;
	}
	
	public boolean isComplete_success() {
		if(status.equalsIgnoreCase(ProjectDto.COMPLETE_SUCCESS)) {
			return true;
		}else
			return false;
	}
	public boolean isComplete_fail() {
		if(status.equalsIgnoreCase(ProjectDto.COMPLETE_FAIL)) {
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
	
	public boolean isFinished() {
		if(status.equalsIgnoreCase(FINISH)) {
			return true;
		}else
			return false;
	}

	@Override
	public String toString() {
		return "BuyDto [seq=" + seq + ", id=" + id + ", projectseq=" + projectseq + ", optionseq=" + optionseq
				+ ", count=" + count + ", price=" + price + ", regdate=" + regdate + ", score=" + score + ", bcomment="
				+ bcomment + ", ptitle=" + ptitle + ", otitle=" + otitle + ", ocontent=" + ocontent + ", status="
				+ status + ", pdate=" + pdate + ", shipdate=" + shipdate + ", name=" + name + ", phone=" + phone
				+ ", postcode=" + postcode + ", roadaddress=" + roadaddress + ", detailaddress=" + detailaddress
				+ ", cardNumber=" + cardNumber + ", bankName=" + bankName + ", usepoint=" + usepoint + "]";
	}
	
}
