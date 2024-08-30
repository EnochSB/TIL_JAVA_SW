package com.test.oop;

// interface Animal1{
//     public void move();
// }

// class Human1 implements Animal1{
//     public void move(){
//         System.out.println("사람이 두 발로 걷습니다.");
//     }
// }

// class Tiger1 implements Animal1{
//     public void move(){
//         System.out.println("호랑이가 네 발로 뜁니다.");
//     }
// }

// class Eagle1 implements Animal1{
//     public void move(){
//         System.out.println("독수리가 하늘을 납니다.");
//     }
// }

// 의존성을 생성하는 것보다 의존성을 주입하는 게 의존성이 낮아진다.(dependency injection)
class AnimalMove{
    Animal animal;
    public AnimalMove(Animal animal){   // 생성자를 통한 인스턴스 주입
        this.animal = animal;
        animal.move(); 
    }
}

public class PolymorphismExam03 {
    public static void main(String[] args) {
        new AnimalMove(new Human());
        new AnimalMove(new Tiger());
        new AnimalMove(new Eagle());
    }
}
