package donzo.thefun.util;

import java.io.Serializable;
import java.util.Calendar;

public class myCal implements Serializable {
	private int year = -100;
	private int month = -100;
	private int day = -100;
	private int lastDay;		// 28, 30, 31
	private int dayOfWeek;		// 요일
	
	private int hour = 0;
	private int min = 0;
	
	Calendar cal = Calendar.getInstance();
	
	public myCal() {}
	
	public void calculate() { // 이전 달로 가다가 0 이 되면 전년도로 넘기는 건데 솔직히 내가 쓰기엔 딱히 필요 없을듯
		if(month == 0) {
			year--;
			month = 12;
		}else if(month == 13) { //년도를 넘기다가 다음 년도가 되면 1월로 바꿔주는거. 이건 냅두자
			year++;
			month = 1;
		}else if(month < 0) { // 달이 0보다 작게 되면 
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH) + 1;
			if(day < 0) {
				day = cal.get(Calendar.DATE);
			}
		}
		cal.set(year, month-1, 1);
		dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);		
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getLastDay() {
		return lastDay;
	}

	public void setLastDay(int lastDay) {
		this.lastDay = lastDay;
	}

	public int getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(int dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getMin() {
		return min;
	}

	public void setMin(int min) {
		this.min = min;
	}

	public Calendar getCal() {
		return cal;
	}

	public void setCal(Calendar cal) {
		this.cal = cal;
	}

	@Override
	public String toString() {
		return "myCal [year=" + year + ", month=" + month + ", day=" + day + ", lastDay=" + lastDay + ", dayOfWeek="
				+ dayOfWeek + ", hour=" + hour + ", min=" + min + ", cal=" + cal + "]";
	}
	
	
}











