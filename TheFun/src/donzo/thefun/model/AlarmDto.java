package donzo.thefun.model;
/*-- 알람 테이블

DROP TABLE FUN_ALARM
CASCADE CONSTRAINTS;

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

ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제

CREATE OR REPLACE VIEW FUN_ALARM_VIEW (SEQ, PROJECTSEQ, ID, FROMNICKNAME, ATYPE, BUYTYPE, REGDATE, ACONTENT, PTITLE)
AS
SELECT A.SEQ, A.PROJECTSEQ, A.ID, A.FROMNICKNAME, A.ATYPE, A.BUYTYPE, A.REGDATE, A.ACONTENT,
    (SELECT TITLE FROM FUN_PROJECT WHERE SEQ = A.PROJECTSEQ)
FROM FUN_ALARM A;
*/

import java.io.Serializable;

import donzo.thefun.util.UtilFunctions;

public class AlarmDto implements Serializable{
	
	public static final String ATYPE_START = "start";
	public static final String ATYPE_END = "end";
	public static final String ATYPE_PAY = "pay";
	public static final String ATYPE_DELIVERY = "delivery";
	public static final String ATYPE_NOTICE = "notice";
	public static final String ATYPE_QNA = "qna";
	public static final String BTYPE_LIKE = "like";
	public static final String BTYPE_BASKET = "basket";
	public static final String BTYPE_BUY = "buy";
	public static final String BTYPE_MYPROJECT = "myproject";
	public static final String BTYPE_OTHER = "other"; // 댓글만 다는 경우 -- 프로젝트 상태는 중요하지 않음
		
	int seq;
	int projectseq;	// 프로젝트 번호
	String id; // 받는 사람
	String ptitle; // 프로젝트 제목
	String atype; // 알람 타입
	String buytype; // 구매타입
	String regdate; //등록일
	
	String fromnickname; // 보내는사람 이름
	String acontent; // 댓글인 경우 내용
	
	public String getMessage() {
		String message="";
		if(atype.equals(ATYPE_QNA)) { // 댓글인 경우
			if(buytype.equals(BTYPE_MYPROJECT)) {
				message = "내 프로젝트 QNA게시판에 새로운 글이 올라왔어요<br><hr>";
				message += "<b>" +fromnickname + "</b> ";
				if(acontent.length() >= 20) {
					message +=  acontent.substring(0,20) + "...";
				}else {
					message +=  acontent;
				}
			}else {
				message = "<b>" +fromnickname + "</b>님이 내 글에 답글을 달았어요<br><hr>";
				if(acontent.length() >= 20) {
					message +=  acontent.substring(0,20) + "...";
				}else {
					message +=  acontent;
				}
			}
		}else { // 구매 관련 소식인 경우
			switch(buytype) {
			case BTYPE_LIKE:
				message ="내가 즐겨찾기한 ";
				break;
			case BTYPE_BASKET:
				message ="내가 장바구니에 담은 ";
				break;
			case BTYPE_BUY:
				message = "내가 펀딩한 ";
				break;				
			}
			switch(atype) {
			case ATYPE_START:
				message ="프로젝트가 시작했어요";
				break;
			case ATYPE_END:
				message ="프로젝트가 종료됐어요";
				break;
			case ATYPE_NOTICE:
				message = "프로젝트에 새로 공지가 올라왔어요";
				break;
			case ATYPE_PAY:
				message = "프로젝트가 성공적으로 끝나 결제되었어요";
				break;
			case ATYPE_DELIVERY:
				message = "프로젝트의 리워드 배송이 시작되었어요";
				break;
			}
		}
		return message;
	}
	
	public AlarmDto() {	}

	public AlarmDto(int seq, int projectseq, String fromnickname, String id, String ptitle, String atype, String buytype, String regdate) {
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.ptitle = ptitle;
		this.atype = atype;
		this.buytype = buytype;
		this.regdate = regdate;
		this.fromnickname = fromnickname;
	}

	public AlarmDto(int projectseq, String fromnickname, String id, String atype, String buytype, String acontent) {		
		this.projectseq = projectseq;
		this.id = id;
		this.atype = atype;
		this.buytype = buytype;
		this.fromnickname = fromnickname;
		this.acontent = acontent;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getAtype() {
		return atype;
	}

	public void setAtype(String atype) {
		this.atype = atype;
	}

	public String getBuytype() {
		return buytype;
	}

	public void setBuytype(String buytype) {
		this.buytype = buytype;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public String getFromnickname() {
		return fromnickname;
	}

	public void setFromnickname(String fromnickname) {
		this.fromnickname = fromnickname;
	}
	
	public String getDateKor() {
		return UtilFunctions.getDateFormKorean(regdate);
	}
	
	public String getAcontent() {
		return acontent;
	}

	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}

	@Override
	public String toString() {
		return "AlarmDto [seq=" + seq + ", projectseq=" + projectseq + ", id=" + id + ", ptitle=" + ptitle + ", atype="
				+ atype + ", buytype=" + buytype + ", regdate=" + regdate + ", fromnickname=" + fromnickname
				+ ", acontent=" + acontent + "]";
	}
}
