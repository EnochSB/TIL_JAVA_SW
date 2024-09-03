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
    private final static String userpw = "3946";

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
