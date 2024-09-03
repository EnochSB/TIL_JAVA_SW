package com.test.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.test.oop.Member;

public class JDBCConnection {
    // ClassNotFoundException: 드라이버가 없을 경우 예외처리
    // 
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        
        String uri = "jdbc:mariadb://127.0.0.1:3306/webdev";
        String userid = "webmaser";
        String userpw = "3946";
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
