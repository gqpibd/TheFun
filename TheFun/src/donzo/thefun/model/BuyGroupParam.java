package donzo.thefun.model;

import java.io.Serializable;

public class BuyGroupParam implements Serializable{

	private int groupCount; // 한 번에 구매한 옵션 종류의 수
	private int totalprice;
	private int totalcount;
	private int score; // 후기 등록 한 경우 점수
	
	public int getGroupCount() {
		return groupCount;
	}
	public void setGroupCount(int groupCount) {
		this.groupCount = groupCount;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public int getTotalcount() {
		return totalcount;
	}
	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}
	
	public int getScore() {
		return score;
	}
	
	public void setScore(int score) {
		this.score = score;
	}
	
	@Override
	public String toString() {
		return "BuyGroupParam [groupCount=" + groupCount + ", totalprice=" + totalprice + ", totalcount=" + totalcount
				+ ", score=" + score + "]";
	}

}
