// 가변형 매개변수 처리: 어떠한 개수의 매개변수라도 처리 가능
const add = (...numbers) => {
    let result = 0;
    numbers.forEach((num) => (result += num));
    console.log("result=" + result);
}

add(1,2,3);
add(1,2,3,4,5,6,7,8,9,10);

//////////////////////////////////////////
// 제일 마지막 매개변수를 여러개 받기
function User(name, age, ...skills) {
    this.name = name;
    this.age = age;
    this.skills = skills;
}

const user1 = new User('Mike', 30, 'html', 'css');
const user2 = new User('John', 23, 'html', 'css', 'JS', 'React');
const user3 = new User('Jane', 11);

console.log(user1);
console.log(user2);
console.log(user3);

//////////////////////////////////////////
// 전개 구문
let arr1 = [1,2,3];
let arr2 = [4,5,6];

let result = [0, ...arr1, ...arr2, 7, 8, 9];
console.log(result);

//////////////////////////////
let user = {name:'Mike'};
let mike = {...user, age:30};

console.log(mike);

////////////////////////////////

let member = {name:'Mike'};
let info = {age:30};
let fe = ["JS", "React"];
let lang = ["Korean", "English"];

member = {
    ...member,
    ...info,
    skills: [...fe, ...lang],
};

console.log(member);
