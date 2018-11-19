package donzo.thefun.model;

import java.io.Serializable;

public class ProjectDto implements Serializable {
	
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

	
}
