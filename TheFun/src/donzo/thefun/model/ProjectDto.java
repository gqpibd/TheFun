package donzo.thefun.model;

import java.io.Serializable;
import java.util.Arrays;
/*-- 프로젝트 테이블

DROP TABLE FUN_PROJECT
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PROJECT;

CREATE TABLE FUN_PROJECT(
   SEQ NUMBER(8) PRIMARY KEY,
   ID VARCHAR2(50) NOT NULL,
   
   FUNDTYPE VARCHAR2(50) NOT NULL, -- REWARD | DONATION
   CATEGORY VARCHAR2(50) NOT NULL, -- FOOD, ANIMAL, IT | ANIMAL, HUMAN
   TITLE VARCHAR2(200) NOT NULL, 
   CONTENT VARCHAR2(4000) NOT NULL,
   SUMMARY VARCHAR2(1000) NOT NULL,
   TAGS VARCHAR2(400), -- 태그를 넣는거는 선택사항으로? NOT NULL 없앰.
   BANK VARCHAR2(200) NOT NULL,
   GOALFUND NUMBER(10) NOT NULL, -- GOAL 오타 GOALPRICE? GOALFUND? GOALFUNDAMOUNT?
   
   SDATE DATE NOT NULL, -- DATE로 변경
   EDATE DATE NOT NULL,-- DATE로 변경
   PDATE DATE NOT NULL, -- DATE로 변경 -- 결제일
   SHIPDATE DATE, -- DATE로 변경 -- 배송일 --> 기부인 경우 배송이 없으므로 NOT NULL 삭제
   REGDATE DATE NOT NULL,
   
   STATUS VARCHAR2(50) NOT NULL -- 1: 준비중, 2: 승인대기, 3: 진행중, 4: 완료됨(성공), 5: 완료됨(실패), 6: 삭제
);

CREATE SEQUENCE SEQ_PROJECT
START WITH 1 INCREMENT BY 1;

ALTER TABLE FUN_PROJECT ADD CONSTRAINT PROJECT_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제(참조하는 데이터가 삭제되면 함께 삭제)

-------------- VIEW : 프로젝트 전체 내용 

CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, STATUS, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED)
AS
SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE, P.STATUS,
   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(*) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),   
    NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
    NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
    NVL((SELECT SUM(PRICE * COUNT) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0)
FROM FUN_PROJECT P;*/

public class ProjectDto implements Serializable {
	
	public static final String TYPE_REWARD = "reward"; 
	public static final String TYPE_DONATION = "donation"; 
	public static final String CATEGORY_FOOD = "food"; //reward
	public static final String CATEGORY_IT = "it";  // reward
	public static final String CATEGORY_ANIMAL = "animal";  //reward | donation
	public static final String CATEGORY_HUMAN = "human"; // donation
	
	public static final int WAITING = 1; // 승인대기 
	public static final int PREPARING = 2; // 준비중
	public static final int ONGOING = 3; // 진행중
	public static final int COMPLETE_SUCCESS = 4; // 완료됨(성공)
	public static final int COMPLETE_FAIL = 5; // 완료됨(실패)
	public static final int DELETE = 6; // 삭제
		
	int seq;
	String id; // 작성자
	String fundtype; // REWARD | DONATION
	String category; // FOOD, ANIMAL, IT | ANIMAL, HUMAN
	String title; // 프로젝트 이름
	String content; // 프로젝트 설명 + 이미지 포함해야 되는데....
	String summary; // 프로젝트 요약 설명
	String[] tags; // 태그
	String bank; // 계좌번호
	int goalfund; // 목표 모금액
	String sdate; // 시작일
	String edate; // 종료일
	String pdate; // 결제일
	String shipdate; // 배송시작일
	String regdate; // 등록일
	int status; // 상테 준비중|승인대기|진행중|완료됨(성공)|완료됨(실패)|삭제
	
	int qnacount; // 댓글 갯수
	int buycount; // 구매 갯수
	int noticecount; // 공지 갯수
	int likecount; // 좋아요 갯수
	int fundachived; // 달성 모금액
	
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

	public String getFundtype() {
		return fundtype;
	}

	public void setFundtype(String fundtype) {
		this.fundtype = fundtype;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String[] getTags() {
		return tags;
	}

	public void setTags(String[] tags) {
		this.tags = tags;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public int getGoalfund() {
		return goalfund;
	}

	public void setGoalfund(int goalfund) {
		this.goalfund = goalfund;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getQnacount() {
		return qnacount;
	}

	public void setQnacount(int qnacount) {
		this.qnacount = qnacount;
	}

	public int getBuycount() {
		return buycount;
	}

	public void setBuycount(int buycount) {
		this.buycount = buycount;
	}

	public int getNoticecount() {
		return noticecount;
	}

	public void setNoticecount(int noticecount) {
		this.noticecount = noticecount;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	public int getFundachived() {
		return fundachived;
	}

	public void setFundachived(int fundachived) {
		this.fundachived = fundachived;
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
