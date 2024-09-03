# JDBC_guide
## 정의
- 관계형 데이터베이스에 저장된 데이터를 접근 및 조작할 수 있게 하는 자바 API.
- 다양한 DBMS에 대해 일관된 API.
- 데이터베이스 연결, 검색, 수정, 관리 등
- JDBC 드라이버
    - DBMS마다 고유한 JDBC 드라이버 제공
    - JDBC 드라이버와 DBMS는 전용 프로토콜로 데이터베이스 처리
    - 오라클
        - 드라이버: oracle.jdbc.driver.OracleDriver
        - 연결 URL: jdbc:oracle:thin:@localhost:1521:xe => @서버:포트:SID
    - MySQL
        - 드라이버: com.mysql.jdbc.Driver
        - 연결 URL: jdbc:mysql://localhost:3306/webdev => jdbc:mysql://서버:포트/데이터베이스​
    - MariaDB
        - 드라이버: org.mariadb.jdbc.Driver​
        - 연결 URL: jdbc:mariadb://localhost:3306/webdev => jdbc:mariadb://서버:포트/데이터베이스​
- JDBC 드라이버 환경변수 등록
    - CLASSPATH에 드라이버 위치 + 파일명 등록

## JDBC 연동에 사용되는 객체
- Class: JDBC 드라이버 로딩(java에서 객체를 생성할 때 사용하는 Class가 아닌 Class 타입 객체)
- DriverManager: 데이터베이스 Connection 객체 생성
- Connection: SQL문을 실행하는 Statement 객체 생성 및 JDBC 연결 종료
- Statement: SQL문을 실행해서 ResultSet 객체 생성
- ResultSet: SQL문 실행 결과를 얻어 오는 객체. 현재 데이터의 행(레코드 위치)의 위치를 나타내는 커서(cursor) 관리

## JDBC 사용 예
```java
package com.test.jdbc;

public class Member {
    private String name;
    private String gender;
    private int age;

    public Member(String name, String gender, int age){
        this.name = name;
        this.gender = gender;
        this.age = age;
    }

    public String getName(){
        return this.name;
    }

    public String getGender(){
        return this.gender;
    }

    public int getAge(){
        return this.age;
    }
}
```
```java
package com.test.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JDBCConnection {
    // ClassNotFoundException: 드라이버가 없을 경우 예외처리
    // 
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        
        String uri = "jdbc:mariadb://127.0.0.1:3306/webdev";
        String userid = "webmaster";
        String userpw = "****";
        String query = "select name,gender,age from tbl_test";
        
        Connection con;
        Statement stmt;
        ResultSet rs;
        
        // JDBC 드라이버 연결
        Class.forName("org.mariadb.jdbc.Driver");
        /*
        드라이버 설치
        IDE의 JAVA PROJECTS의 Referenced Libraries를 통해 DBMS의 JDBC 드라이버 jar 파일 연결
        */
        // DBMS와 연결(데이터 베이스 Connection 객체 생성)
        con = DriverManager.getConnection(uri, userid, userpw);

        // serialization 연결 시 명령문 전달 계통 설정
        stmt = con.createStatement();

        // SQL을 실행 시키고 그 결과(데이터셋: Data Set)를 갖고 옴
        rs = stmt.executeQuery(query);

        List<Member> list = new ArrayList<>();

        while (rs.next()) { // rs.next()가 false(행 끝남)를 반환 할 때까지
            list.add(new Member(rs.getString("name"),
                                rs.getString("gender"),
                                rs.getInt("age")
                                ));
        }

        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(con != null) con.close();

        list.stream().forEach(s->{
            System.out.println("이름: " + s.getName() + "\t" +
                               "성별: " + s.getGender() + "\t" +
                               "나이: " + s.getAge()
            );
        });
    }
}
```

## JDBC 사용 예: 파일로부터 데이터 가져와 DB에 저장
```java
package com.test.jdbc;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;



class MachineInfo { // DTO: Data Transfer Object
    private String machineName;
    private String managerName;
    private int temperature;
    private int power;
    private int runTime;

    public MachineInfo(String machineName, String managerName, int temperature, int power, int runTime){
        this.machineName = machineName;
        this.managerName = managerName;
        this.temperature = temperature;
        this.power = power;
        this.runTime = runTime;
    }

    public String getMachineName(){
        return this.machineName;
    }

    public String getManagerName(){
        return this.managerName;
    }

    public int getTemperature(){
        return this.temperature;
    }

    public int getPower(){
        return this.power;
    }

    public int getRunTime(){
        return this.runTime;
    }
}

// 파일 스트림 생성해서 읽어주는 클래스
class FileManager {

    public static void fileReader() throws IOException, ClassNotFoundException, SQLException {

        BufferedReader reader
            = new BufferedReader(new FileReader("C:\\Repository\\machine\\MachineLog.txt", Charset.forName("UTF-8")));
        
            String str;
            String query;
            String[] lineArray;
            while ((str = reader.readLine()) != null) {
                lineArray = str.split(","); // --> 구분자
                query = "";  // null과 같은 의미
                query = "insert into tbl_machine (machinename, managername, temperature, power, runtime) " +
                        "values (\'" + lineArray[0] + "\',\'" + lineArray[1] + "\'," + lineArray[2] +
                        "," + lineArray[3] + "," + lineArray[4] + ")"; // int형은 작은따옴표가 필요 없다.
                // System.out.println("query" + query);
                DBControl.insertDB(query);
            }

            // 스트림이 생성되었기 때문에 닫기
            reader.close();
    }
}

// 읽은 파일의 데이터를 DB에 저장하는 클래스
class DBControl {
    
    // 상수화
    private final static String uri = "jdbc:mariadb://127.0.0.1:3306/webdev";
    private final static String userid = "webmaser";
    private final static String userpw = "****";

    public static void insertDB(String query) throws SQLException, ClassNotFoundException{
        
        Connection con;
        Statement stmt;

        Class.forName("org.mariadb.jdbc.Driver");
        con = DriverManager.getConnection(uri, userid, userpw);
        stmt = con.createStatement();
        stmt.executeUpdate(query); // insert, delete, update 등 테이블 수정을 하는 쿼리문 처리

        if (stmt != null) stmt.close();
        if (con != null) con.close();

    }
}

public class FileExam01 {
    public static void main(String[] args) throws IOException, ClassNotFoundException, SQLException {
        // 파일에서 데이터 읽어오기
        FileManager.fileReader();   // static으로 선언했기 때문에 인스턴스 생성 없이 사용 가능.

    }    
}
```