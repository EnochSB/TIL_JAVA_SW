package com.test.oop;

interface InterfaceTest {
    void ii1();
    int ii2(int a, int b);

}

class I1 implements InterfaceTest{

    @Override
    public void ii1() {
        System.out.println("InterfaceTest 인터페이스의 ii1 메소드를 구현");
    }

    @Override
    public int ii2(int a, int b) {
        System.out.println("InterfaceTest 인터페이스의 ii2 메소드를 구현");
        return a + b;
    }

}

// class I2 implements InterfaceTest{

//     @Override
//     public void ii1() {
//         System.out.println("InterfaceTest 인터페이스의 ii1 메소드를 구현");
//     }

//     @Override
//     public int ii2(int a, int b) {
//         return a + b;

//     }

// }

public class InterfaceExam {
    public static void main(String[] args) {
        I1 i1 = new I1();
        i1.ii1();
        System.out.println(i1.ii2(3, 4));
    }
}