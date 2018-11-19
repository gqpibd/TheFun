package donzo.thefun.model;

import java.io.Serializable;
/*-- 공지사항 테이블

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
ON DELETE CASCADE; -- 종속 삭제*/

public class NoticeDto implements Serializable {

	int seq;
	int projectseq;
	String title;
	String content;
	String regdate;
	
	public NoticeDto() {}

	public NoticeDto(int seq, int projectseq, String title, String content, String regdate) {
		this.seq = seq;
		this.projectseq = projectseq;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
	}

	public NoticeDto(int seq, int projectseq, String title, String content) {
		this.seq = seq;
		this.projectseq = projectseq;
		this.title = title;
		this.content = content;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "NoticeDto [seq=" + seq + ", projectseq=" + projectseq + ", title=" + title + ", content=" + content
				+ ", regdate=" + regdate + "]";
	}
}
