package donzo.thefun.model;

import java.io.Serializable;

public class BuyGroupParam implements Serializable{

	private int groupCount; // 한 번에 구매한 옵션 종류의 수
	private int totalprice;
	private int totalcount;
	
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
	@Override
	public String toString() {
		return "BuyGroupParam [groupCount=" + groupCount + ", totalprice=" + totalprice + ", totalcount=" + totalcount
				+ "]";
	}
}
