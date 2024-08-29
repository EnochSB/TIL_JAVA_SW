package com.test.oop;

class AA {
    int a = 1;  // 멤버 변수 선언
    int b = 2;

    void aa(){
        System.out.println("a = " + a + ", b = "+ b);
    }
}

class BB {
    private int a = 3;  // 외부에서 직접 접근 불가. 클래스의 메소드를 통해서만 접근이 가능. 상속받은 클래스에서도 접근 불가능.
    int b = 4;

    void bb(){
        System.out.println("a = " + a + ", b = "+ b);
    }

    int getA(){
        return this.a;
    }

    void setA(int a){
        this.a = a;
    }
}

// static으로 선언한 변수는 여러 인스턴스가 여려 변수 주소를 생성하는 것이 아니라 하나의 변수 주소를 공유한다.
class CC {
    static int c = 33;
    
    void cc(){
        System.out.println("c = " + c);
    }
}

class DD {
    static int d = 88;
    static void dd(){
        System.out.println("d = " + d);
    }
}

public class Exam01 {
    public static void main(String[] args) {
        
        AA aa1 = new AA();   // 인스턴스화: 생성자에 의한 초기화
        AA aa2 = new AA();

        aa1.aa();
        aa1.a = 10;
        aa1.b = 20;
        aa1.aa();

        aa2.aa();

        BB bb = new BB();
        bb.setA(100);
        System.out.println(bb.getA());

        CC cc1 = new CC();
        CC cc2 = new CC();
        cc1.c = 44;
        
        cc1.cc();
        cc2.cc();

        DD.dd();    // static으로 선언된 메소드는 인스턴스 객체 생성 없이도 메소드 호출 가능.
    }
}
