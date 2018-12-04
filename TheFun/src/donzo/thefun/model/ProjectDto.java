package donzo.thefun.model;

import java.io.Serializable;
import java.util.ArrayList;
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
   
   CONTENT CLOB NOT NULL -- 사진 포함한 본문
);

-- 새 CLOB 컬럼을 추가합니다
ALTER TABLE FUN_PROJECT ADD(TMP_CONTENT CLOB NOT NULL);
-- 데이터를 복사합니다
UPDATE FUN_PROJECT SET TMP_CONTENT = CONTENT;
COMMIT;
-- 기존 컬럼을 삭제합니다
ALTER TABLE FUN_PROJECT DROP COLUMN CONTENT;
-- 새로 추가한 임시 컬럼의 이름을 변경합니다
ALTER TABLE FUN_PROJECT RENAME COLUMN TMP_CONTENT TO CONTENT;
-- 이제 해당 칼럼에 NOT NULL 추가
ALTER TABLE FUN_PROJECT MODIFY (CONTENT NOT NULL);

ALTER TABLE FUN_PROJECT ADD CONSTRAINT PROJECT_ID_FK
FOREIGN KEY(ID)
REFERENCES FUN_MEMBER(ID)
ON DELETE CASCADE; -- 종속 삭제(참조하는 데이터가 삭제되면 함께 삭제)

-------------- VIEW : 프로젝트 전체 내용 
CREATE OR REPLACE VIEW FUN_PROJECTALL (SEQ, ID, FUNDTYPE, CATEGORY, TITLE, CONTENT, SUMMARY, TAGS, BANK, GOALFUND, SDATE, EDATE, PDATE, SHIPDATE, REGDATE, QNACOUNT, BUYCOUNT, NOTICECOUNT, LIKECOUNT, FUNDACHIVED, STATUS, NICKNAME, OPTIONTOTAL)
AS
SELECT P.SEQ, P.ID, P.FUNDTYPE, P.CATEGORY, P.TITLE, P.CONTENT, P.SUMMARY, P.TAGS, P.BANK, P.GOALFUND, P.SDATE, P.EDATE, P.PDATE, P.SHIPDATE, P.REGDATE,
   NVL((SELECT COUNT(*) FROM FUN_QNA  GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(DISTINCT ID) FROM FUN_BUY GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),      
   NVL((SELECT COUNT(*) FROM FUN_NOTICE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT COUNT(*) FROM FUN_LIKE GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   NVL((SELECT SUM((SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ) * COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0),
   (SELECT 
    CASE 
        WHEN LOWER(STATUS) = 'waiting' THEN 'waiting'
        WHEN LOWER(STATUS) = 'delete' THEN 'delete'
        WHEN LOWER(STATUS) = 'reject' THEN 'reject'
        WHEN LOWER(STATUS) = 'revise' THEN 'revise'
        WHEN SDATE >= SYSDATE THEN 'preparing' 
        WHEN EDATE-SYSDATE >= 0 THEN 'ongoing' 
        WHEN NVL((SELECT SUM((SELECT PRICE FROM FUN_OPTION WHERE SEQ = B.OPTIONSEQ) * COUNT) FROM FUN_BUY B GROUP BY PROJECTSEQ HAVING PROJECTSEQ = P.SEQ),0) >=  GOALFUND THEN 'complete_success'         
        ELSE 'complete_fail'  
     END AS "status" 
     FROM FUN_PROJECT WHERE SEQ = P.SEQ),
    (SELECT NICKNAME FROM FUN_MEMBER WHERE ID = P.ID),
    NVL((SELECT COUNT(*) FROM FUN_OPTION WHERE PROJECTSEQ = P.SEQ),0)
FROM FUN_PROJECT P;
*/

public class ProjectDto implements Serializable {
	
	public static final String TYPE_REWARD = "reward"; 
	public static final String TYPE_DONATION = "donation"; 
	public static final String CATEGORY_FOOD = "food"; //reward
	public static final String CATEGORY_IT = "it";  // reward
	public static final String CATEGORY_ANIMAL = "animal";  //reward | donation
	public static final String CATEGORY_HUMAN = "human"; // donation
	
	public static final String WAITING = "waiting"; // 승인대기 
	public static final String PREPARING = "preparing"; // 준비중
	public static final String ONGOING = "ongoing"; // 진행중
	public static final String COMPLETE_SUCCESS = "complete_success"; // 완료됨(성공)
	public static final String COMPLETE_FAIL = "complete_fail"; // 완료됨(실패)
	public static final String DELETE = "delete"; // 삭제
	
	//public static final String APPROVE = "approve"; // 승인됨
	public static final String REJECT = "reject"; // 거절됨
	public static final String REVISE = "revise"; // 보완요청
	public static final String RESUBMIT = "resubmit";	// 재승인요청(수정한 펀딩)
	
	int seq;  
	String id; // 작성자
	String fundtype; // REWARD | DONATION
	String category; // FOOD, ANIMAL, IT | ANIMAL, HUMAN
	String title; // 프로젝트 이름
	String content; // 프로젝트 설명 + 이미지 포함해야 되는데....
	String summary; // 프로젝트 요약 설명
	String[] tags; // 태그
	String tag;		// 프로젝트 입력용 임시변수 
	String bank; // 계좌번호
	int goalfund; // 목표 모금액
	String sdate; // 시작일
	String edate; // 종료일
	String pdate; // 결제일
	String shipdate; // 배송시작일
	String regdate; // 등록일
	String status; // 상테 준비중|승인대기|진행중|완료됨(성공)|완료됨(실패)|삭제
	
	int qnacount; // 댓글 갯수
	int buycount; // 구매 갯수
	int noticecount; // 공지 갯수
	int likecount; // 좋아요 갯수
	int fundachived; // 달성 모금액
	String nickname; // 이름
	String optiontotal;	// 보유 리워드 갯수
	
	public ProjectDto() {		
		shipdate = "";
		status = WAITING; // 처음 프로젝트 생성하면 승인 대기 상태로 저장
	}

	public ProjectDto(int seq, String id, String fundtype, String category, String title, String content,
			String summary, String[] tags, String tag, String bank, int goalfund, String sdate, String edate,
			String pdate, String shipdate, String regdate, String status, int qnacount, int buycount, int noticecount,
			int likecount, int fundachived, String nickname, String optiontotal) {
		super();
		this.seq = seq;
		this.id = id;
		this.fundtype = fundtype;
		this.category = category;
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.tags = tags;
		this.tag = tag;
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
		this.nickname = nickname;
		this.optiontotal = optiontotal;
	}
	public ProjectDto(String id, String fundtype, String category, String title, String content, String summary,
			String tag, String bank, int goalfund, String sdate, String edate, String pdate, String shipdate, String nickname) {
		this.id = id;
		this.fundtype = fundtype;
		this.category = category;
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.tag = tag;
		this.bank = bank;
		this.goalfund = goalfund;
		this.sdate = sdate;
		this.edate = edate;
		this.pdate = pdate;
		this.shipdate = shipdate;
		this.nickname = nickname;
	}
	public ProjectDto(String id, String fundtype, String category, String title, String content, String summary,
			String[] tags, String bank, int goalfund, String sdate, String edate, String pdate, String shipdate, String nickname) {
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
		this.nickname = nickname;
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

	public void setTags(String tags) {		
		String temp = tags.replaceAll(" ", "#"); // 한 칸 공백은 #으로 만든다
		int startIndex = 1;
		if(!temp.startsWith("#")) { // #으로 시작하지 않으면 맨 처음부터
			startIndex = 0;
		}
		String tempArr[] = temp.substring(startIndex).split("#");
		ArrayList<String> tempList = new ArrayList<>(); 
		for(int i=0;i<tempArr.length;i++) {
			if(tempArr[i].length() != 0) { // ##같은게 있을수 있으므로 처리
				tempList.add(tempArr[i]);
			}
		}
		this.tags = tempList.toArray(new String[tempList.size()]);
		//System.out.println(tags);
		System.out.println("수정한 태그: " + Arrays.toString(this.tags));
	}
	
	public String getTag() {
		return tag;
	}
	
	// 태그 띄어쓰기칸을 전부 #로 치환
	public void setTag(String tag) {
		String temp = tag.replaceAll(" ", "#"); // 한 칸 공백은 #으로 만든다
		if(!temp.startsWith("#")) { // #으로 시작하지 않으면 맨 처음에도 #를 넣어준다
			temp = "#" + temp;
		}
		this.tag = temp;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
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

	public String getDateForm(String datetime) {
		String date = datetime;
		if(datetime.lastIndexOf(' ')>-1) {
			date = datetime.substring(0, datetime.lastIndexOf(' '));
		}
		return date;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getOptiontotal() {
		return optiontotal;
	}

	public String getCategoryKr() {		
		switch(category.toLowerCase()) {
		case CATEGORY_FOOD:
			return "음식";
		case CATEGORY_ANIMAL:
			return "동물";
		case CATEGORY_IT:
			return "IT";
		case CATEGORY_HUMAN:
			return "인권";		
		}
		return "";
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
	public boolean isOnsubmission() {
		if(status.equalsIgnoreCase(WAITING) || status.equalsIgnoreCase(REJECT) || status.equalsIgnoreCase(REVISE) || status.equalsIgnoreCase(PREPARING)) {
			return true;
		}else
			return false;
	}
	
	@Override
	public String toString() {
		return "ProjectDto [seq=" + seq + ", id=" + id + ", fundtype=" + fundtype + ", category=" + category
				+ ", title=" + title + ", content=" + content + ", summary=" + summary + ", tags="
				+ Arrays.toString(tags) + ", tag=" + tag + ", bank=" + bank + ", goalfund=" + goalfund + ", sdate="
				+ sdate + ", edate=" + edate + ", pdate=" + pdate + ", shipdate=" + shipdate + ", regdate=" + regdate
				+ ", status=" + status + ", qnacount=" + qnacount + ", buycount=" + buycount + ", noticecount="
				+ noticecount + ", likecount=" + likecount + ", fundachived=" + fundachived + ", nickname=" + nickname + "]";
	}

	
}
