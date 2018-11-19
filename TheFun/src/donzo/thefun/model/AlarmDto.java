package donzo.thefun.model;

import java.io.Serializable;

public class AlarmDto implements Serializable{
	int seq;
	int projectseq;
	String id;
	String projecttitle;
	int atype;
	int buytype;
	String regdate;
	
	public AlarmDto() {	}

	public AlarmDto(int seq, int projectseq, String id, String projecttitle, int atype, int buytype, String regdate) {
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.projecttitle = projecttitle;
		this.atype = atype;
		this.buytype = buytype;
		this.regdate = regdate;
	}

	public AlarmDto(int seq, int projectseq, String id, int atype, int buytype, String regdate) {		
		this.seq = seq;
		this.projectseq = projectseq;
		this.id = id;
		this.atype = atype;
		this.buytype = buytype;
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

	public String getProjecttitle() {
		return projecttitle;
	}

	public void setProjecttitle(String projecttitle) {
		this.projecttitle = projecttitle;
	}

	public int getAtype() {
		return atype;
	}

	public void setAtype(int atype) {
		this.atype = atype;
	}

	public int getBuytype() {
		return buytype;
	}

	public void setBuytype(int buytype) {
		this.buytype = buytype;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "AlarmDto [seq=" + seq + ", projectseq=" + projectseq + ", id=" + id + ", projecttitle=" + projecttitle
				+ ", atype=" + atype + ", buytype=" + buytype + ", regdate=" + regdate + "]";
	}
}
