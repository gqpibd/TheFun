package donzo.thefun.util;

import java.io.Serializable;

public class UtilFunctions implements Serializable{
	
	//제목이 길때 뒤에 ... 해주는 거
	public static String dot3(String msg){
		String s="";
		if(msg.length()>=18){
			s=msg.substring(0,18); 
			s+="...";
		}else{
			s=msg.trim();
		}
		return s;
	}
	
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
		newdate += " ";
		newdate += datetime.substring(11, 13)+"시";
		newdate += datetime.substring(14, 16)+"분";
		
		return newdate;		
	}
	
	public static String getDateFormKorean2(String datetime) {
		String newdate = "";
		// yyyy-MM-dd HH:mm:ss
		newdate += datetime.substring(0, 4)+"년";
		newdate += datetime.substring(5, 7)+"월";
		newdate += datetime.substring(8, 10)+"일";
		
		return newdate;		
	}
}
