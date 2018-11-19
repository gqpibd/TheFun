package donzo.thefun.model;

import java.io.Serializable;
import java.util.Arrays;
//-- 프로젝트 테이블
//
//DROP TABLE FUN_PROJECT
//CASCADE CONSTRAINTS;
//
//DROP SEQUENCE SEQ_PROJECT;
//
//CREATE TABLE FUN_PROJECT(
//   SEQ NUMBER(8) PRIMARY KEY,
//   ID VARCHAR2(50) NOT NULL,
//   
//   FUNDTYPE VARCHAR2(50) NOT NULL, -- REWARD | DONATION
//   CATEGORY VARCHAR2(50) NOT NULL, -- FOOD, ANIMAL, IT | ANIMAL, HUMAN
//   TITLE VARCHAR2(200) NOT NULL, 
//   CONTENT VARCHAR2(4000) NOT NULL, -- 사진 포함한 본문
//   SUMMARY VARCHAR2(1000) NOT NULL,
//   TAGS VARCHAR2(400), -- 태그를 넣는거는 선택사항으로? NOT NULL 없앰.
//   BANK VARCHAR2(200) NOT NULL,
//   GOALFUND NUMBER(10) NOT NULL, -- GOAL 오타 GOALPRICE? GOALFUND? GOALFUNDAMOUNT?
//   
//   SDATE DATE NOT NULL, -- DATE로 변경
//   EDATE DATE NOT NULL,-- DATE로 변경
//   PDATE DATE NOT NULL, -- DATE로 변경 -- 결제일
//   SHIPDATE DATE, -- DATE로 변경 -- 배송일 --> 기부인 경우 배송이 없으므로 NOT NULL 삭제
//   REGDATE DATE NOT NULL,
//   
//   STATUS VARCHAR2(50) NOT NULL -- 1: 준비중, 2: 승인대기, 3: 진행중, 4: 완료됨(성공), 5: 완료됨(실패), 6: 삭제
//);
//
//CREATE SEQUENCE SEQ_PROJECT
//START WITH 1 INCREMENT BY 1;
//
//ALTER TABLE FUN_PROJECT ADD CONSTRAINT PROJECT_ID_FK
//FOREIGN KEY(ID)
//REFERENCES FUN_MEMBER(ID)
//ON DELETE CASCADE; -- 종속 삭제(참조하는 데이터가 삭제되면 함께 삭제)
//
//-------------- VIEW : 프로젝트 전체 내용 
//
//CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, STATUS, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED)
//AS
//SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE, P.STATUS,
//   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
//   NVL((SELECT COUNT(*) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),   
//    NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
//    NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
//    NVL((SELECT SUM(PRICE * COUNT) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0)
//FROM FUN_PROJECT P;

public class ProjectDto implements Serializable {
	
	public static final String TYPE_REWARD = "reward"; 
	public static final String TYPE_DONATION = "donation"; 
	public static final String CATEGORY_FOOD = "food"; //reward
	public static final String CATEGORY_IT = "it";  // reward
	public static final String CATEGORY_ANIMAL = "animal";  //reward | donation
	public static final String CATEGORY_HUMAN = "human"; // donation
	
	public static final int WAITING = 1; // 준비중
	public static final int PREPARING = 2; // 승인대기
	public static final int ONGOING = 3; // 진행중
	public static final int COMPLETE_SUCCESS = 4; // 완료됨(성공)
	public static final int COMPLETE_FAIL = 5; // 완료됨(실패)
	public static final int DELETE = 6; // 삭제
		
	int seq;
	String id;
	String fundtype;
	String category;
	String title;
	String content;
	String summary;
	String[] tags;
	String bank;
	int goalfund;
	String sdate;
	String edate;
	String pdate;
	String shipdate;
	String regdate;
	int status;
	
	int qnacount;
	int buycount;
	int noticecount;
	int likecount;
	int fundachived;
	
	public ProjectDto() {}

	public ProjectDto(int seq, String id, String fundtype, String category, String title, String content,
			String summary, String[] tags, String bank, int goalfund, String sdate, String edate, String pdate,
			String shipdate, String regdate, int status, int qnacount, int buycount, int noticecount, int likecount,
			int fundachived) {
		this.seq = seq;
		this.id = id;
		this.fundtype = fundtype;
		this.category = category;
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.tags = tags;
		this.bank = bank;
		this.goalfund = goalfund;
		this.sdate = sdate;
		this.edate = edate;
		this.pdate = pdate;
		this.shipdate = shipdate;
		this.regdate = regdate;
		this.status = status;
		this.qnacount = qnacount;
		this.buycount = buycount;
		this.noticecount = noticecount;
		this.likecount = likecount;
		this.fundachived = fundachived;
	}

	public ProjectDto(String id, String fundtype, String category, String title, String content, String summary,
			String[] tags, String bank, int goalfund, String sdate, String edate, String pdate, String shipdate) {
		this.id = id;
		this.fundtype = fundtype;
		this.category = category;
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.tags = tags;
		this.bank = bank;
		this.goalfund = goalfund;
		this.sdate = sdate;
		this.edate = edate;
		this.pdate = pdate;
		this.shipdate = shipdate;
	}

	@Override
	public String toString() {
		return "ProjectDto [seq=" + seq + ", id=" + id + ", fundtype=" + fundtype + ", category=" + category
				+ ", title=" + title + ", content=" + content + ", summary=" + summary + ", tags="
				+ Arrays.toString(tags) + ", bank=" + bank + ", goalfund=" + goalfund + ", sdate=" + sdate + ", edate="
				+ edate + ", pdate=" + pdate + ", shipdate=" + shipdate + ", regdate=" + regdate + ", status=" + status
				+ ", qnacount=" + qnacount + ", buycount=" + buycount + ", noticecount=" + noticecount + ", likecount="
				+ likecount + ", fundachived=" + fundachived + "]";
	}
}
