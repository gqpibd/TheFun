package donzo.thefun.model;

import java.io.Serializable;

public class BuyDto implements Serializable {

	int seq;
	String id;
	int projectseq;
	int optionseq;
	int count;
	int price;
	String regdate;
	int score;
	String bcomment;
	String ptitle;
	String otitle;
	String ocontent;	
	
	public BuyDto() {}
	
	// 전체 다 있는거
	public BuyDto(int seq, String id, int projectseq, int optionseq, int count, int price, String regdate, int score,
			String bcomment, String ptitle, String otitle, String ocontent) {
		this.seq = seq;
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
		this.price = price;
		this.regdate = regdate;
		this.score = score;
		this.bcomment = bcomment;
		this.ptitle = ptitle;
		this.otitle = otitle;
		this.ocontent = ocontent;
	}
	
	// 새 구매 또는 새 장바구니
	public BuyDto(String id, int projectseq, int optionseq, int count, int price) {
		this.id = id;
		this.projectseq = projectseq;
		this.optionseq = optionseq;
		this.count = count;
		this.price = price;
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

	public int getProjectseq() {
		return projectseq;
	}

	public void setProjectseq(int projectseq) {
		this.projectseq = projectseq;
	}

	public int getOptionseq() {
		return optionseq;
	}

	public void setOptionseq(int optionseq) {
		this.optionseq = optionseq;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getBcomment() {
		return bcomment;
	}

	public void setBcomment(String bcomment) {
		this.bcomment = bcomment;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getOtitle() {
		return otitle;
	}

	public void setOtitle(String otitle) {
		this.otitle = otitle;
	}

	public String getOcontent() {
		return ocontent;
	}

	public void setOcontent(String ocontent) {
		this.ocontent = ocontent;
	}

	@Override
	public String toString() {
		return "BuyDto [seq=" + seq + ", id=" + id + ", projectseq=" + projectseq + ", optionseq=" + optionseq
				+ ", count=" + count + ", price=" + price + ", regdate=" + regdate + ", score=" + score + ", bcomment="
				+ bcomment + ", ptitle=" + ptitle + ", otitle=" + otitle + ", ocontent=" + ocontent + "]";
	}
}
