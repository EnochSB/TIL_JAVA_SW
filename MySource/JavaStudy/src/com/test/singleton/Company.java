package com.test.singleton;

public class Company {
    private static Company instance = new Company();
    private Company(){} // 생성자 선언/정의

    public static Company getInstance(){
        if (instance == null) {
            instance = new Company();
        }
        return instance;
    }
}
