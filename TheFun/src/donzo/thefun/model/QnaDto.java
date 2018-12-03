package donzo.thefun.model;
//DROP TABLE FUN_QNA
//CASCADE CONSTRAINTS;
//
//DROP SEQUENCE SEQ_QNA;
//
//CREATE TABLE FUN_QNA(
//   SEQ NUMBER(8) PRIMARY KEY,
//   PROJECTSEQ NUMBER(8) NOT NULL,
//   ID VARCHAR2(50) NOT NULL,
//   
//   REFSEQ NUMBER(8) NOT NULL, -- 대댓일 때 원래 댓글
//   CONTENT VARCHAR2(1000) NOT NULL,
//   STATUS VARCHAR2(50) NOT NULL, -- 1. 일반, 2. 비밀, 3 삭제
//   
//   REGDATE DATE NOT NULL
//);
//
//CREATE SEQUENCE SEQ_QNA
//START WITH 1
//INCREMENT BY 1;
//
//ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_PROJECTSEQ_FK
//FOREIGN KEY(PROJECTSEQ)
//REFERENCES FUN_PROJECT(SEQ)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_ID_FK
//FOREIGN KEY(ID)
//REFERENCES FUN_MEMBER(ID)
//ON DELETE CASCADE; -- 종속 삭제
//
//ALTER TABLE FUN_QNA ADD CONSTRAINT QNA_REFSEQ_FK
//FOREIGN KEY(REFSEQ)
//REFERENCES FUN_QNA(SEQ)
//ON DELETE CASCADE; -- 종속 삭제

//-------------- VIEW : 댓글
//CREATE OR REPLACE VIEW FUN_QNA_VIEW (SEQ, PROJECTSEQ, ID, REFSEQ, CONTENT, STATUS, REGDATE, TOWHOM, NICKNAME, PROFILE, TOWHOMNICKNAME)
//AS
//SELECT Q.SEQ, Q.PROJECTSEQ, Q.ID, Q.REFSEQ, Q.CONTENT, Q.STATUS, Q.REGDATE, Q.TOWHOM, 
//    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = Q.ID),
//    (SELECT PROFILE FROM FUN_MEMBER WHERE ID = Q.ID),
//    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = Q.TOWHOM)
//FROM FUN_QNA Q;

import java.io.Serializable;

public class QnaDto implements Serializable {

	public static final String NORMAL = "normal";
	public static final String HIDE = "hide";
	public static final String DELETE = "delete";
		
	int seq;
	int projectseq; 
	String id;
	int refseq; // 참조하는 댓글. 없으면 나
	String content; // 내용
	String status; // 일반, 비밀, 삭제
	String regdate;
	
	String towhom;
	String towhomnickname;
	
	

	String nickname;
	String profile; 
	
	public QnaDto() {
		this.status = NORMAL;
		this.towhom = "";
	}

	public QnaDto(int seq, int projectseq, String id, int refseq, String content, String status,
			String regdate) {
		super();
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.refseq = refseq;
		this.content = content;
		this.status = status;
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

	public int getRefseq() {
		return refseq;
	}

	public void setRefseq(int refseq) {
		this.refseq = refseq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public boolean isDel() {
		if(status.equalsIgnoreCase(DELETE)) {
			return true;
		}
		return false;
	}
	
	public boolean isHidden() {
		if(status.equalsIgnoreCase(HIDE)) {
			return true;
		}
		return false;
	}
	
	public String getTowhom() {
		return towhom;
	}

	public void setTowhom(String towhom) {
		this.towhom = towhom;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	public boolean isNormal() {
		if(status==NORMAL) {
			return true;
		}else {
			return false;
		}
		
	}
	public String getTowhomnickname() {
		return towhomnickname;
	}

	public void setTowhomnickname(String towhomnickname) {
		this.towhomnickname = towhomnickname;
	}

	@Override
	public String toString() {
		return "QnaDto [seq=" + seq + ", projectseq=" + projectseq + ", id=" + id + ", refseq=" + refseq + ", content="
				+ content + ", status=" + status + ", regdate=" + regdate + ", towhom=" + towhom + ", towhomnickname="
				+ towhomnickname + ", nickname=" + nickname + ", profile=" + profile + "]";
	}
}
