package com.test.oop;

class Member {
    private String name;
    private String gender;
    private int age;

    public Member(String name, String gender, int age){
        this.name = name;
        this.gender = gender;
        this.age = age;
    }

    public String getName(){
        return this.name;
    }

    public String getGender(){
        return this.gender;
    }

    public int getAge(){
        return this.age;
    }
}