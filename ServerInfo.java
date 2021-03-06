package config;
/*
 * 인터페이스는 
 * 상수와 추상메소드로만 구성되어져 있다.
 * 이런 점을 이용해서
 * 상수값을 담아두도록 한다.
 * 
 * config --> configuration(구성,설정)
 * 서버정보, 기타 다른정보들을 저장하는 모듈은 
 * 거의 대부분 configuration을 뜻하는 config 패키지 하위에 모듈화 시키는 것이 관례이다.
 */
public interface ServerInfo {
	//인터페이스에 선언된 변수 앞에 무조건 public static final이 지정된다.
	//인터페이스에는 필드가 없기때문에 무조건 상수로 취급함.
	String DRIVER_NAME ="com.mysql.cj.jdbc.Driver";
	String URL = "jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8";
	String USER = "root";
	String PASS = "1234";
}
