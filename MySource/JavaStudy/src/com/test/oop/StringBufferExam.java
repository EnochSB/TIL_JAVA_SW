package com.test.oop;

public class StringBufferExam {
    public static void main(String[] args) {
        
        /*
         * StringBuffer는 멀티 스레드 환경에서 안전하다는 장점
         * StringBuilder는 StringBuffer 보다 성능이 우수한 장점이 있다.
         */

        StringBuilder sb = new StringBuilder();
        sb.append("Hello");
        sb.append(" ");
        sb.append("My");
        sb.append(" ");
        sb.append("World");

        String result1 = sb.toString();
        System.out.println(result1);

        sb.insert(0, "Everyone "); // 0번째 위치에 Everyone 삽입
        System.out.println(sb.toString());

        // 문자열 0부터 8번째 자리까지의 문자열 리턴
        String result2 = sb.substring(0, 8);
        System.out.println(result2);
    }
}
