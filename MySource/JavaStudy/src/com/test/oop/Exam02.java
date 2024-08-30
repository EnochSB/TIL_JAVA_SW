package com.test.oop;

// 클래스의 구성요소.
// 멤버변수-생성자-메소드

// 생성자의 역할과 생성자/메소드 오버로딩의 이해를 위한 예제
class A {

    int a = 3;
    int b = 4;

    // 원칙적으로 생성자를 작성해야 한다.
    // 인자가 없는 생성자는 작성하지 않아도 컴파일러가 자동으로 생성
    public A(){
        // 멤버 변수 초기화
        a = 30;
        b = 40;

        // 인스턴스 생성 시 어떤 명령을 수행
        System.out.println("클래스 A 인자가 없는 생성자를 통해 인스턴스 생성");
    }

    // 하나의 클래스에 여러개의 생성자(인자의 개수가 다른) 존재 가능(오버로딩)
    public A(int a, int b){
        this.a = a;
        this.b = b;

        System.out.println("클래스 A 인자가 2개인 생성자를 통해 인스턴스 생성");
    }

    public int aa(){
        return a + b;
    }
    
    public int cal(int a, int b){
        return a*b;
    }

    // 같은 이름의 메소드도 인자의 개수가 다르면 가능(오버로딩)
    public int cal(int a, int b, int c){
        return a+b+c;
    }
}

public class Exam02 {
    public static void main(String[] args) {
        
        A a = new A();  
        // A 클래스 생성자를 통해 인스턴스를 생성
        // 생성된 인스턴스의 주소를 a에 할당

        A a1 = new A(100, 200);

        System.out.println("인자가 없는 생성자를 통해 초기화 된 멤버 변수의 합 = " + a.aa());
        System.out.println("인자가 2개인 생성자를 통해 초기화 된 멤버 변수의 합 = " + a1.aa());
        
        System.out.println(a.cal(3, 4));
        System.out.println(a.cal(3, 4, 5));
    }
}
