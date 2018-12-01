package donzo.thefun.util;

import java.util.Date;

public class FUpUtil {
	//f=abc.zip => f.indexOf('.') 3
	//f.substring(3) .zip
	//f.substring(0,3) abc
	
	// 대표 이미지를 '프로젝트seq.jpg'로 변환(승지)
	public static String getSeqFileName(String realFileName, int projectSeq){
		String newfilename="";
		//String typeOfFile = "";
		//String fre="";
		if(realFileName.indexOf('.')>=0){
			//typeOfFile=realFileName.substring(realFileName.indexOf('.'));	// .png
			//newfilename=projectSeq+typeOfFile;	// 1.png
			newfilename=projectSeq+".jpg";	// 무조건 jpg파일로 만들거임.
		}else{
			newfilename=projectSeq+".jpg";
		}
		return newfilename;
	}
	
	// myfile.txt ---> 현재시간.txt 또는 현재시간.back로 변환
	public static String getNewFile(String f, String id){
		String filename="";
		String fpost="";
		//String fre="";
		if(f.indexOf('.')>=0){
			fpost=f.substring(f.indexOf('.'));
			//fre=f.substring(0,f.indexOf('.'));
			filename=id+fpost;
		}else{
			filename=id+".back";
		}
		return filename;
	} 
	public static String getNewjpg(String f){
		String filename="";
		String fpost="";
		String fre="";
		if(f.indexOf('.')>=0){
			fpost=f.substring(f.indexOf('.'));
			fre=f.substring(0,f.indexOf('.'));
			filename=fre+fpost;
		}else{
			filename=f+".jpg";
		}
		return filename;
	} 
	
}
