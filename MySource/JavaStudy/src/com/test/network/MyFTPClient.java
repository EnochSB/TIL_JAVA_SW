package com.test.network;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.SocketException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

public class MyFTPClient {
    public static void main(String[] args) throws SocketException, IOException {
        String server = "192.168.137.27";
        int port = 21; // FTP 접속 시 인증과 제어를 위한 포트
        String id = "hasb";
        String pw = "****";
        String path = "c:\\Repository\\file\\";
        String file = "SamsungUniversalPrintDriver2.exe";

        FTPClient ftpClient = new FTPClient();
        ftpClient.setControlEncoding("UTF-8");
        ftpClient.connect(server, port);

        int replyCode = ftpClient.getReplyCode();
        if(FTPReply.isPositiveCompletion(replyCode)){
            System.out.println("FTP 서버에 연결되었습니다.");
            System.out.println("접속코드: " + ftpClient.getReplyCode() + " FTP 접속에 성공했습니다.");

            boolean success = ftpClient.login(id, pw);
            if(!success) {
                System.out.println("접속코드: " + ftpClient.getReplyCode() + " 로그인 실패");
                System.exit(1); // 비정상 종료
            } else {
                System.out.println("접속코드: " + ftpClient.getReplyCode() + " 로그인 성공");
                ftpClient.setFileType(FTP.BINARY_FILE_TYPE);    // 파일 전송 타입 선택(텍스트냐 바이너리냐)
                ftpClient.enterLocalPassiveMode();  // 사슬 IP에서 파일 전송이 가능하게끔 패시브모드로 설정
                FileInputStream fileInputStream = new FileInputStream(path + file);
                if(ftpClient.storeFile(file, fileInputStream)){
                    System.out.println("업로드 된 파일명: " + file);
                } else {
                    System.out.println("파일 업로드 실패");
                }
            }
        }

    }
}
