package donzo.thefun.model;
/*-- 알람 테이블

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

-------------- 알람 뷰
ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_PROJECTSEQ_FK
FOREIGN KEY(PROJECTSEQ)
REFERENCES FUN_PROJECT(SEQ)
ON DELETE CASCADE; -- 종속 삭제

ALTER TABLE FUN_ALARM ADD CONSTRAINT ALARM_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제*/

import java.io.Serializable;

public class AlarmDto implements Serializable{
	
	public static final String ATYPE_START = "start";
	public static final String ATYPE_END = "end";
	public static final String ATYPE_PAY = "pay";
	public static final String ATYPE_DELIVERY = "delivery";
	public static final String ATYPE_NOTICE = "notice";
	public static final String ATYPE_REPLY = "reply";
	public static final String BTYPE_LIKE = "like";
	public static final String BTYPE_BASKET = "basket";
	public static final String BTYPE_BUY = "buy";
	public static final String BTYPE_MYPROJECT = "myproject";
		
	int seq;
	int projectseq;
	String id;
	String projecttitle;
	String atype;
	String buytype;
	String regdate;
	
	public AlarmDto() {	}

	public AlarmDto(int seq, int projectseq, String id, String projecttitle, String atype, String buytype, String regdate) {
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.projecttitle = projecttitle;
		this.atype = atype;
		this.buytype = buytype;
		this.regdate = regdate;
	}

	public AlarmDto(int seq, int projectseq, String id, String atype, String buytype, String regdate) {		
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.atype = atype;
		this.buytype = buytype;
		this.regdate = regdate;
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

	public String getProjecttitle() {
		return projecttitle;
	}

	public void setProjecttitle(String projecttitle) {
		this.projecttitle = projecttitle;
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

	@Override
	public String toString() {
		return "AlarmDto [seq=" + seq + ", projectseq=" + projectseq + ", id=" + id + ", projecttitle=" + projecttitle
				+ ", atype=" + atype + ", buytype=" + buytype + ", regdate=" + regdate + "]";
	}
}
