var a;  // a라는 변수 선언 => var 타입의 변수일 경우 변수 선언시 자동으로 undefined라는 값이 들어감.
console.log(a);

console.log(null == undefined); // 동등연산자: true
console.log(null === undefined);// 일치연산자: false


// 자바스크립트 일반형(원시형) 데이터 타입
const locationOne = "korea";
const locationTwo = "korea";

console.log(locationOne === locationTwo);   // true: 값도 같고 타입도 같다.


// 자바스크립트 객체(Object) 타입
// 객체기 때문에 선언될 때 객체가 만들어진 주소가 할당됨.
const locationThree = {
    country: "korea",
    currency: "won"
};

const locationFour = {
    country: "korea",
    currency: "won"
};

console.log(locationThree === locationFour);    // false: 값이 같고 타입도 같으나 주소가 다르다.


////////////////////////////////////////

let b;
console.log(b);

// const aa; 선언만 하기 불가
const aa = 10;
// aa = 20; 재할당 불가

const name = {
    eng:'kim',
    kor:'김'
};

console.log(name);

name.eng = 'park';  // const 객체의 재할당
console.log(name);  // const 객체가 참조하는 주소는 바뀌지 않고 해당 주소의 값만 바뀌었기 때문에.

/////////////////////////////////////

const name1 = '김철수';
const age = 25;

// 이름은 김철수이고 나이는 25세 입니다.
console.log('이름은 ' + name1 + '이고 나이는 ' + age + '세 입니다.');
console.log(`이름은 ${name1}이고 나이는 ${age}세 입니다.`);

////////////////////////////////

var a = 1; //var 변수는 중복 선언 가능
if(true){
    var a = 5;
}   // 블록 레벨 스코프가 적용되지 않음. => 전역(Global)변수
console.log(a); // 5출력

var c = 5;
function cc() {
    var c = 30;
    console.log("함수 내부 c: " + c);
};
cc();   // var 변수는 함수 내부에서 선언 및 초기화 될 경우, 함수가 실행될 때만 사용된다.
// 즉, var는 함수 레벨의 scope를 갖는다.
console.log("함수 외부 c: " + c);

let d = 20;
if(true){
    let d = 30;
}   // 블록 레벨 스코프가 적용.
console.log(d); // 20 출력


///////////////////////////////

// 함수 선언식: 호이스트 처리
function main() {   // 함수 선언, 초기화, 할당 동시 처리
    console.log("hello");
}
main(); // 함수 실행

// 함수 표현식: 호이스트 처리 안됨
const main1 = function() {  // 익명함수
    console.log("hello");
}
main1();

// 화살표 함수: 호이스트 처리 안됨
const main2 = () => {
    console.log("hello");
}
main2();

function mul(num) {
    return num * num;
}

// 다른 함수를 매개변수로 받을 수 있다.
// 다른 함수의 결과로 리턴 될 수 있다.
function mulNum(func, number) {
    return func(number);
}

console.log(mulNum(mul, 3));

/////////////////////////////////////////

const person = {    // 자바 스크립트 객체
    name: "홍길동",
    birthday: "20000429",
    pId: "12345",
    sayName: function(){
        return this.name;
    }
};

console.log(person.sayName());

let bb = 'age';

const user = {
    name: 'Mike',
    [bb]: 30    //computed property
};

console.log(user.age);

const user1 = {
    [1 + 4] : 5,
    ["안녕"+"하세요"]: "Hello"
};

console.log(user1);

//////////////////////////////////// 객체 복사/병합
const user2 = {
    name:'Peter',
    age: 34
};

// 참조하는 메모리의 주소값이 할당 => 깊은 복사(Deep Copy)
const cloneUser = user2;
console.log(user2.name);
console.log(cloneUser.name);
cloneUser.name = 'Tom';
console.log(user2.name);
console.log(cloneUser.name);

console.log(user2 === cloneUser);   // true

// 초기값이 빈 객체 {}에 user2객체 병합 => 얕은 복사(Shallow Copy)
const newUser = Object.assign({}, user2);
// newUser와 user2는 참조 주소값이 다르기 때문에 다른 객체.
newUser.name = 'John';
console.log(user2.name);    // Tom
console.log(newUser.name);  // John

////////////////////////////////////

const user3 = {
    name: 'Mike',
    age: 30,
    gender: 'male',
};

console.log(Object.keys(user3));
console.log(Object.values(user3));
console.log(Object.entries(user3));

const arr1 = Object.entries(user3); // 객체의 key/value 전체를 배열로 반환
console.log(Object.fromEntries(arr1));// key/value 배열을 객체로 반환

