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

import java.io.Serializable;

public class QnaDto implements Serializable {

	public static final String NORMAL = "normal";
	public static final String HIDE = "hide";
	public static final String DELETE = "delete";
		
	int seq;
	int projectseq;
	String id;
	int refseq;
	String content;
	int status;
	String regdate;
	
	public QnaDto() { }

	public QnaDto(int seq, int projectseq, String id, int refseq, String content, int status,
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "ReplyDto [seq=" + seq + ", projectseq=" + projectseq + ", id=" + id + ", refseq=" + refseq
				+ ", content=" + content + ", status=" + status + ", regdate=" + regdate + "]";
	}
}
