package com.test.oop;

class Parent {
    int a;
    int b;

    public void p(){

    }
}

class Child extends Parent{
    int c;
    int d;

    public void c(){

    }
}

public class Exam03 {
    public static void main(String[] args) {
        
        Child child = new Child();
        child.p();
    }
}
