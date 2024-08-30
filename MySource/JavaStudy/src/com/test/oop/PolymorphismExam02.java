package com.test.oop;

class Animal{
    public void move(){
        System.out.println("동물이 움직입니다.");
    }
}

class Human extends Animal{
    public void move(){
        System.out.println("사람이 두 발로 걷습니다.");
    }
}

class Tiger extends Animal{
    public void move(){
        System.out.println("호랑이가 네 발로 뜁니다.");
    }
}

class Eagle extends Animal{
    public void move(){
        System.out.println("독수리가 하늘을 납니다.");
    }
}

public class PolymorphismExam02 {
    public static void main(String[] args) {
        PolymorphismExam02 animalTest = new PolymorphismExam02();
        animalTest.moveAnimal(new Human()); // 인스턴스를 생성하지 않고 주입(injection)
        animalTest.moveAnimal(new Tiger());
        animalTest.moveAnimal(new Eagle());
    }

    public void moveAnimal(Animal animal){
        animal.move();
    }
}
