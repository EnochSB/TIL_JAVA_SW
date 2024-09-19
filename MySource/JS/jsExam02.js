// 생성자 함수 => 코드 중복성 제거
function User(name, age) {
    this.name = name;
    this.age = age;
    this.sayName = function(){
        console.log(this.name);
    }
}

let user1 = new User('Mike', 30);   // User 생성자 함수 객체의 prototype을 상속
// user1은 User.prototype을 상속
let user2 = new User('Jane', 20);

console.log(user1, user2);

user1.sayName();

class User1 {
    constructor(name){
        this.name = name;   // name이라는 멤버변수가 생성
    }

    sayHi(){
        console.log(this.name);
    }
}

let user3 = new User1('John');
user3.sayHi();

// getter, setter
class User2 {
    constructor(name) {
        this.name = name;
    }

    get name() {
        return this._name;  // 변수명 앞 _는 private 제한조건을 의미.
    }

    set name(value) {
        if (value.length <2) {
            console.log("이름이 너무 짧습니다.");
            return;
        }
        this._name = value;
    }
}

let user4 = new User2("보라");
console.log(user4.name);

// 클래스 상속
class Animal {
    constructor(name) {
        this.speed = 0;
        this.name = name;
    }

    run(speed) {
        this.speed = speed;
        console.log(`${this.name}은/는 속도 ${this.speed}로 달립니다.`);
    }

    stop() {
        this.speed = 0;
        console.log(`${this.name}이/가 멈췄습니다.`);
    }
}

class Rabbit extends Animal {
    hide() {
        console.log(`${this.name}이/가 숨었습니다.`);
    }
}

let rabbit = new Rabbit("흰 토끼");

rabbit.run(4);
rabbit.hide();

/////////////////////////////////
// JSON

const str = `{
    "name": "홍길동",
    "age": 25,
    "married": false,
    "family": {"father": "홍판서", "mother": "춘심"},
    "hobbies": ["독서", "음악감상"],
    "jobs": null
}`;

// 외부에서 자바스크립트가 있는 프론트 프로그램으로 JSON 포맷의 데이터가 전송되면
// 자바스크립트에서는 전송된 데이터를 바로 인식하지 못함.
// JSON.parse()로 역직렬화(deserialization)
// 직렬화(serialization): 데이터를 네트워크로 전송시 전송에 편리하도록 데이터 포맷을 변환
// 역직렬화: 직렬화되어 전송된 데이터를 프로그램에서 인식할 수 있도록 변환
const obj = JSON.parse(str);
console.log(obj);
console.log(obj.name + ", " + obj.age);
