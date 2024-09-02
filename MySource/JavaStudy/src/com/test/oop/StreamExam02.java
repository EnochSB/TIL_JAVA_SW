package com.test.oop;

import java.util.ArrayList;
import java.util.List;


public class StreamExam02 {
    public static void main(String[] args) {
        
        List<Member> list = new ArrayList<Member>();    // 업캐스팅
        list.add(new Member("James", "Male", 20));  // 생성자를 통해 주소 전달
        list.add(new Member("John", "Male", 31));
        list.add(new Member("Zill", "Female", 16));
        list.add(new Member("Christina", "Female", 41));
        list.stream().map(c->c.getName()).sorted().forEach(s->System.out.println("이름 = " + s));

        System.out.println();

        for(int i=0; i<list.size(); i++){   // 리스트 길이 호출 list.size()
            System.out.println("이름: " + list.get(i).getName() + "\t" +    // 리스트 인덱스 접근 get(i)
                               "성별: " + list.get(i).getGender() + "\t" +
                               "나이: " + list.get(i).getAge());
        }
        System.out.println();

        // 컬렉터 전용 for 문 --> for(리스트 요소 타입:리스트명){}
        for(Member member: list){
            System.out.println("이름: " + member.getName() + "\t" +    // 리스트 인덱스 접근 get(i)
                               "성별: " + member.getGender() + "\t" +
                               "나이: " + member.getAge());
        }
    }
}
