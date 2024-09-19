const person = {
    name: "김철수",
    birthYear: 1998,
    calcAge: function(){
        console.log(2023 - this.birthYear);
    }
}

person.calcAge();   // 25

const calculateAge = person.calcAge;
calculateAge(); // NaN(Not-A-Number): Number 객체의 속성.
// 숫자가 아닌 값에 연산을 수행하거나 0을 0으로 나누면 NaN 출력
// calculateAge가 참조하는 function(){conslol.log(2023-this.birthYear)}
// this는 전역객체를 가리키게 되고 전역객체는 birthYear라는 property가 없기에 NaN

// 참조할 변수가 영역 내에 위치하면 영역 내 변수를 가져오고,
// 그렇지 않으면 상위 영역 내에 있는 변수 값을 가져 온다.--> 렉시컬 스코핑(Lexical Scoping)
// 이렇게 계속 상위 영역으로 찾아가는 것을 스코프 체인(Scope Chain)
var name = 'zero';
function log(){
    console.log(name);  
}

function wrapper() {
    var name = 'nero';  // 애초에 log함수 입장에서 이 변수를 찾지 못한다.
    log();  // 함수를 호출한 곳이 아닌 함수가 선언된 곳에서 가장 가까운 곳의 변수 참조.
}

wrapper();  // zero

// 네임스페이스: 전역변수명이 겹칠 우려를 최소화하는 방법.
var obj = {
    a: 0,
    b: 1
}

var obj1 = {
    a: 0,
    b: 1
}

//////////////////////////////////////
// 구조분해할당
let users = ['Mike', 'Tom', 'Jane'];
let [user1, user2, user3] = users;
console.log(user1); // Mike

let str = "Mike-Tom-Jane";
let [user4, user5, user6] = str.split('-'); // -를 분리자(delimit)로 인식해서 문자열을 분리
console.log(user5); // Tom

let [user7, ,user8] = ['Mike', 'Tom', 'Jane', 'Tony'];  // 중간에 Tom이 할당.
console.log(user8); // Jane

let [a, b, c] = [3, 2]; // c는 undefined
console.log(`a=${a}, b=${b}, c=${c}`);

let d = 1;
let e = 2;
[d, e] = [e, d];
console.log(d, e);

let user11 = {
    name11: 'Jane',
    age11: 10,
    gender11: 'female'
}

let {name11, age11, gender11} = user11;
console.log(name11);
