package donzo.thefun.util;

public class UtilFunctions {

	public static String getDateForm(String datetime) {
		String date = datetime;
		if(datetime.lastIndexOf(' ')>-1) {
			date = datetime.substring(0, datetime.lastIndexOf(' '));
		}
		return date;
	}
	
	public static String getDateFormKorean(String datetime) {
		String newdate = "";
		// yyyy-MM-dd HH:mm:ss
		newdate += datetime.substring(0, 4)+"년";
		newdate += datetime.substring(5, 7)+"월";
		newdate += datetime.substring(8, 10)+"일";
		
		return newdate;		
	}

}
