package donzo.thefun.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;

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
	
	public static String getLoginId(HttpServletRequest req) {
		MemberDto user = (MemberDto) req.getSession().getAttribute("login");
		if(user!=null) {
			return user.getId();	
		}else {
			return null;
		}
				
	}
	
	public static List<String> sortByValue(HashMap<String, Integer> map) { // 내림차순
	    List<String> sortedList = new ArrayList<>();
	    sortedList.addAll(map.keySet());
	    Collections.sort(sortedList,new Comparator<String>() {
	        public int compare(String o1,String o2) {
	            Integer v1 = map.get(o1);
	            Integer v2 = map.get(o2);     
	            return (v2).compareTo(v1);
	        }
	    });
	    return sortedList;
	}
	
	public static List<String> sortByValueReverse(HashMap<String, Integer> map) { // 오름차순 정렬
	    List<String> sortedList = new ArrayList<>();
	    sortedList.addAll(map.keySet());
	    Collections.sort(sortedList,new Comparator<String>() {
	        public int compare(String o1,String o2) {
	            Integer v1 = map.get(o1);
	            Integer v2 = map.get(o2);     
	            return (v1).compareTo(v2);
	        }
	    });
	    return sortedList;
	}
	
	public static HashMap<String, Integer> getHashMap(List<ProjectDto> list){
		HashMap<String, Integer> map = new HashMap<>();
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<list.get(i).getTags().length;j++) {
				String key = list.get(i).getTags()[j];
				if(map.containsKey(key)) {
					int value = map.get(key);
					map.put(key, value+1);
				}else {
					map.put(key, 1);
				}
			}
		}	
		return map;
	}
}
