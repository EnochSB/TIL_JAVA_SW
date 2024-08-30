package com.test.oop;

class Family{
    void hello(){
        System.out.println("가족들과 인사합니다.");
    }
}

class KimFamily extends Family{
    void hello(){
        System.out.println("김씨 안녕하세요.");
    }
    void dinner(){
        System.out.println("저녁 식사 할까요");
    }
    void drink(){
        System.out.println("소주 한잔 할래요?");
    }
}

class ParkFamily extends Family{
    void hello(){
        System.out.println("박씨 안녕하세요.");
    }
    void fishing(){
        System.out.println("가족들과 인사합니다.");
    }
}

class ChoiFamily extends Family{
    void hello(){
        System.out.println("최씨 안녕하세요.");
    }
    void meeting(){
        System.out.println("가족들끼리 모임 한 번 어떠세요?");
    }
}


public class PolymorphismExam {
    public static void main(String[] args) {

        // Upcasting의 경우는 생성된 인스턴스의 메서드를 실행 --> 가상 메서드
        Family f;

        f = new KimFamily();
        f.hello();

        f = new ParkFamily();
        f.hello();

        f = new ChoiFamily();
        f.hello();
    }
}
