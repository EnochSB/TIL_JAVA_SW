package com.test.network;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

class TestHttpRequest {

    public static void testHttpRequest(String targetURL, String parameter) throws Exception{

        HttpURLConnection connection = null;
    
        // URL 객체 생성
        URL url = new URL(targetURL);

        // HTTP Server 와의 Connection 설정
        connection = (HttpURLConnection)url.openConnection();

        // HTTP Request 메시지의 헤드값 설정
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        connection.setRequestProperty("Content-Language", "ko-KR");
        
        // HTTP 서버로 데이터 전송시 행할 선택 사항
        connection.setUseCaches(false); // 캐쉬 설정 안함

        // 위의 설정대로 HTTP서버로 데이터 전송을 하겠다.
        connection.setDoOutput(true);

        // Request
        // HEADER 값 전송
        DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
        
        // BODY 값 전송
        wr.write(parameter.getBytes("UTF-8"));

        // 임시로 버퍼에 저장된 값을 출력(전송)
        wr.flush();
        wr.close();

        // Response 받기
        int responseCode = connection.getResponseCode();
        BufferedReader rd = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));

        StringBuilder response = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            response.append(line).toString();
            response.append("/r/n");
        }

        rd.close();

        System.out.println("HTTP 응답 코드: " + responseCode);
        System.out.println("HTTP 응답 헤더: " + connection.getHeaderField(responseCode));
        System.out.println("HTTP BODY: " + response.toString());

        connection.disconnect();

    }
}

public class HttpTest {
    public static void main(String[] args) throws Exception {
        String targetURL = "http://127.0.0.1:8080/board/write";
        String parameters = "writer=하성범&title=월요일이싫어&content=피곤해";
        TestHttpRequest.testHttpRequest(targetURL, parameters);
    }
}
