package com.test.oop;

// 추상 클래스
// 추상 클래스는 청사진의 개념
abstract class PP{
    // 일반 메서드
    void pp1(){
        System.out.println("PP 추상 클래스의 일반 메서드1");
    }

    // 추상 메서드
    abstract void pp2();

    void pp3(){
        System.out.println("PP 추상 클래스의 일반 메서드2");
    }
}

class CCC extends PP{

    int a = 10;
    int b = 20;
    int sum = a + b;

    @Override   // 아노테이션(Annotation): 컴파일러에게 이 코드가 어떤 의미인지 추가 설명
    void pp2() {
        System.out.println("PP 추상 클래스의 추상 메서드");
    }

    // 오버라이딩: 안써줘도 에러는 일으키지 않지만 시인성을 위해 써주는 것이 좋다.
    @Override
    void pp3(){
        System.out.println("CCC 클래스의 멤버 변수 합 = " + sum);
    }

}

public class AbstractExam01 {
    public static void main(String[] args) {
        CCC ccc = new CCC();
        ccc.pp1();
        ccc.pp2();
        ccc.pp3();
    }
}
