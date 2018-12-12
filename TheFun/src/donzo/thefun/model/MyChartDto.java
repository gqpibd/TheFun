package donzo.thefun.model;

import java.io.Serializable;

public class MyChartDto implements Serializable {
	
	private String projectLenth;
	private String reward;
	private String donation;
	
	private String food;
	private String r_animal;
	private String it;
	private String human;
	private String d_animal;
	
	public MyChartDto() {}
	
	// fundtype 차트용
	public MyChartDto(String projectLenth, String reward, String donation) {
		super();
		this.projectLenth = projectLenth;
		this.reward = reward;
		this.donation = donation;
	}
	
	// category 차트용
	public MyChartDto(String projectLenth, String food, String r_animal, String it, String human, String d_animal) {
		super();
		this.projectLenth = projectLenth;
		this.food = food;
		this.r_animal = r_animal;
		this.it = it;
		this.human = human;
		this.d_animal = d_animal;
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

	public String getFood() {
		return food;
	}

	public void setFood(String food) {
		this.food = food;
	}

	public String getR_animal() {
		return r_animal;
	}

	public void setR_animal(String r_animal) {
		this.r_animal = r_animal;
	}

	public String getIt() {
		return it;
	}

	public void setIt(String it) {
		this.it = it;
	}

	public String getHuman() {
		return human;
	}

	public void setHuman(String human) {
		this.human = human;
	}

	public String getD_animal() {
		return d_animal;
	}

	public void setD_animal(String d_animal) {
		this.d_animal = d_animal;
	}

	@Override
	public String toString() {
		return "MyChartDto [projectLenth=" + projectLenth + ", reward=" + reward + ", donation=" + donation + ", food="
				+ food + ", r_animal=" + r_animal + ", it=" + it + ", human=" + human + ", d_animal=" + d_animal + "]";
	}
	
	
}
