package com.test.network;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpClient.Version;
import java.net.http.HttpRequest.BodyPublisher;
import java.net.http.HttpRequest.BodyPublishers;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

public class HttpClientTest {
    public static void main(String[] args) throws Exception {
        // Header 값 설정
        String address = "http://127.0.0.1:8080/board/write";
        Map<String, String> params = new HashMap<>();   // 업캐스팅
        params.put("writer", "홍길동");
        params.put("title", "나홍길동이요");
        params.put("content", "반가워요잘부탁해요");

        String[] headers = {"Content-Type", "application/x-www-form-urlencoded"};

        System.out.println(params);
        HttpClientRun.post(address, params, headers);

    }
}

class HttpClientRun {
    
    public static void get() throws Exception {

        // HEADER 값 설정
        String address = "http://127.0.0.1:8080/board/write";
        // HEADER 값 설정 규칙: {"key", "value"}
        String[] headers = {"content-type", "text/html"};
        HttpClient client = HttpClient.newBuilder().version(Version.HTTP_1_1).build();// 빌더 패턴(Builder Pattern)
        // DAO(Data Access Object)
        // 1. 생성자를 통해서 초기화
        // 2. 매개변수
        // 3. 빌더패턴
        String result = client.sendAsync(HttpRequest.newBuilder(new URI(address)).GET().headers(headers).build(),
                                        HttpResponse.BodyHandlers.ofString()).thenApply(HttpResponse::body).get().toString();
        
        System.out.println(result);

    }

    public static void post(String address, Map<String, String> params, String[] headers) throws Exception {
        
        // 값(Request 요청값)을 받아서 서버에서 작업 후 결과(HTTP Response 메시지 중 Body)를 리턴
        BodyPublisher body = BodyPublishers.ofString(getFormDataAsString(params));
        HttpClient client = HttpClient.newBuilder().version(Version.HTTP_1_1).build();

        HttpResponse<String> response = client.send(
            HttpRequest.newBuilder(new URI(address)).POST(body).headers(headers).build(),
            HttpResponse.BodyHandlers.ofString()
        );
        System.out.println(response);

    }

    public static String getFormDataAsString(Map<String, String> formData){
        
        StringBuilder formBodyBuilder = new StringBuilder();

        for(Map.Entry<String, String> singleEntry : formData.entrySet()){
            if(formBodyBuilder.length() > 0)
                formBodyBuilder.append("&");
            formBodyBuilder.append(URLEncoder.encode(singleEntry.getKey(), StandardCharsets.UTF_8)).toString();
            formBodyBuilder.append("=");
            formBodyBuilder.append((URLEncoder.encode(singleEntry.getValue(), StandardCharsets.UTF_8))).toString();

        }
        System.out.println(formBodyBuilder);
        return formBodyBuilder.toString();
    }
}
