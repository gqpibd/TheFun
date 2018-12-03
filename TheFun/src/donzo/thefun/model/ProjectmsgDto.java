package donzo.thefun.model;

import java.io.Serializable;

public class ProjectmsgDto implements Serializable {

	// public static final String SUBMIT = "submit"; --> 기본으로 submit하면 메시지가 따로 필요 없으므로..
	public static final String APPROVE = "approve";
	public static final String REJECT = "reject";
	public static final String REVISE = "revise";
	public static final String RESUBMIT = "resubmit";
	
	public int seq;
	public int projectseq;
	public String status;
	public String message;
	public String regdate;
	
	public ProjectmsgDto() {}

	public ProjectmsgDto(int projectseq, String status, String message) {
		super();
		this.projectseq = projectseq;
		this.status = status;
		this.message = message;
	}

	public ProjectmsgDto(int seq, int projectseq, String status, String message, String regdate) {
		super();
		this.seq = seq;
		this.projectseq = projectseq;
		this.status = status;
		this.message = message;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public String getStatusKor() {
		switch(status.toLowerCase()) {
		case APPROVE:
			return "프로젝트 승인됨";
		case REJECT:
			return "프로젝트 승인 거절됨";
		case REVISE:
			return "프로젝트 보완 요청됨";
		case RESUBMIT:
			return "프로젝트 재승인 요청";
		default:
			return "이건뭐지";
		}
	}

	@Override
	public String toString() {
		return "ProjectmsgDto [seq=" + seq + ", projectseq=" + projectseq + ", status=" + status + ", message="
				+ message + ", regdate=" + regdate + "]";
	}
}
