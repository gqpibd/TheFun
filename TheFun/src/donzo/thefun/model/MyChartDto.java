package donzo.thefun.model;

import java.io.Serializable;

public class MyChartDto implements Serializable {
	
	private String projectLenth;
	private String reward;
	private String donation;
	
	public MyChartDto() {}

	public MyChartDto(String projectLenth, String reward, String donation) {
		super();
		this.projectLenth = projectLenth;
		this.reward = reward;
		this.donation = donation;
	}

	public String getProjectLenth() {
		return projectLenth;
	}

	public void setProjectLenth(String projectLenth) {
		this.projectLenth = projectLenth;
	}

	public String getReward() {
		return reward;
	}

	public void setReward(String reward) {
		this.reward = reward;
	}

	public String getDonation() {
		return donation;
	}

	public void setDonation(String donation) {
		this.donation = donation;
	}

	@Override
	public String toString() {
		return "MyChartDto [projectLenth=" + projectLenth + ", reward=" + reward + ", donation=" + donation + "]";
	}
	
	
}
