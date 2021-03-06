package donzo.thefun.model.pageparam;

public class ProjectParam extends pageParam {
	
	// --------- search
	private String s_type;		// reward, donation
	private String s_category; 	// food, it, animal, human
	private String s_keyword;	// 검색어
	private String more_s_keyword;	// 상세 검색
	private String s_summary;	// 요약설명
	private String s_sort;		// 정렬 구분 1순위 정렬은
	private String s_asc_desc;	// 오름차순 내림차순
	private String s_complete;	// 성공여부 	
	private String s_condition;	// 조건 : reg_seven_date(최근 7일 내 작성), end_seven_date(7일 내 종료)
	private String doc_title; 	// 제목
	
	public ProjectParam() {
		super(8,8);
	}


	public String getS_type() {
		return s_type;
	}


	public void setS_type(String s_type) {
		this.s_type = s_type;
	}


	public String getS_category() {
		return s_category;
	}


	public void setS_category(String s_category) {
		this.s_category = s_category;
	}


	public String getS_keyword() {
		return s_keyword;
	}


	public void setS_keyword(String s_keyword) {
		this.s_keyword = s_keyword;
	}


	public String getS_summary() {
		return s_summary;
	}


	public void setS_summary(String s_summary) {
		this.s_summary = s_summary;
	}


	public String getS_sort() {
		return s_sort;
	}


	public void setS_sort(String s_sort) {
		this.s_sort = s_sort;
	}


	public String getS_asc_desc() {
		return s_asc_desc;
	}


	public void setS_asc_desc(String s_asc_desc) {
		this.s_asc_desc = s_asc_desc;
	}


	public String getS_complete() {
		return s_complete;
	}


	public void setS_complete(String s_complete) {
		this.s_complete = s_complete;
	}


	public String getS_condition() {
		return s_condition;
	}


	public void setS_condition(String s_condition) {
		this.s_condition = s_condition;
	}
	

	public String getMore_s_keyword() {
		return more_s_keyword;
	}


	public void setMore_s_keyword(String more_s_keyword) {
		this.more_s_keyword = more_s_keyword;
	}

	

	public String getDoc_title() {
		return doc_title;
	}


	public void setDoc_title(String doc_title) {
		this.doc_title = doc_title;
	}


	@Override
	public String toString() {
		return "ProjectParam [" + (s_type != null ? "s_type=" + s_type + ", " : "")
				+ (s_category != null ? "s_category=" + s_category + ", " : "")
				+ (s_keyword != null ? "s_keyword=" + s_keyword + ", " : "")
				+ (more_s_keyword != null ? "more_s_keyword=" + more_s_keyword + ", " : "")
				+ (s_summary != null ? "s_summary=" + s_summary + ", " : "")
				+ (s_sort != null ? "s_sort=" + s_sort + ", " : "")
				+ (s_asc_desc != null ? "s_asc_desc=" + s_asc_desc + ", " : "")
				+ (s_complete != null ? "s_complete=" + s_complete + ", " : "")
				+ (s_condition != null ? "s_condition=" + s_condition + ", " : "")
				+ (doc_title != null ? "doc_title=" + doc_title : "") + "]";
	}


}
