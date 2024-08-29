package com.test.example;

class FoolException extends Exception{}

class ErrorTest{
    // throw
    public void errorMaking() throws ArithmeticException {// 기능에 제한이 있지만 자동으로 예외처리
        int a = 4 / 0;
        System.out.println("a = " + a);
    }
}

public class ExceptionExam {
    public void sayNickname(String nickname) {
        try {
            // 문자열 끼리 비교: equals를 이용
            // nickname == "fool"을 쓰지 않는 이유: 각각 다른 주소를 가르키기 때문에 항상 false
            if (nickname.equals("fool")) throw new FoolException();
            // throwable: throw new 사용자가 만든 예외 처리 클래스의 생성자
            System.out.println("당신의 별명은" + nickname + "입니다.");
        } catch (FoolException e) {
            System.out.println("FoolException이 발생했습니다.");
        }
    }
    public static void main(String[] args) {
        int b;
        int c;
        b = 0;
        c = 0;
        try {
            c = 4 / b;
        } catch(ArithmeticException e){
            b = -1; // 에러 발생 시 실행되는 명령어
        } finally { // 에러 발생하더라도 반드시 수행해야 하는 명령
            System.out.println("다행이다");
        }
        System.out.println("c = " + c);

        ExceptionExam exam = new ExceptionExam();
        exam.sayNickname("fool");
        exam.sayNickname("genious");

        ErrorTest errorTest = new ErrorTest();
        errorTest.errorMaking();


    }
}
