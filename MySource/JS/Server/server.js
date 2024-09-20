///////////////////// express 웹서버 설정 ///////////////////////
// $npm init -> 프로젝트 초기화, package.json 파일 생성
// $npm install express -> express 서버 설치
// $npm install nodemon -g -> nodemon 설치: 프로그램 상의 변화를 감지해서 자동으로 반영. 한번만 설치하면 다음 프로젝트에는 설치 안해도 됨.

const express = require('express');
const app = express();
app.listen(8080, function(){
    console.log("포트 8080으로 서버 대기중...");
})

/////////////////// ejs 템플리트 엔진 설정 ///////////////////////
// $npm install ejs
app.set('view engine','ejs');

/////////////////// MongoDB 연결 및 설정 ///////////////////////
// $npm install --save mongodb
const mongoclient = require('mongodb').MongoClient;

// Mongo DB에서 제공하는 ObjectId 객체에서 id를 가져오게 하는 API 설정
// $npm install objectid
const ObjId =require('mongodb').ObjectId;
const url = 'mongodb+srv://webmaster:12345@cluster0.c9gen.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'
let mydb;
mongoclient.connect(url)
            .then(client => {
                console.log('몽고DB 접속 성공');
                mydb = client.db('myboard')
            }).catch(err => {
                console.log(err);
            });


/////////////////// POST 방식으로 Form 데이터 읽어 오기 ///////////////////////
// $npm install body-parser
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: true})); // urlencoded: form으로 데이터를 보낼 때 대표적인 인코딩

/////////////////// 라우팅 설정 ///////////////////////

// 초기 접속 화면
app.get('/', (req, res) => {
    res.send('<h1>홈 입니다.</h1>');
});

// 게시물 목록 보기 화면
app.get('/list', (req, res) => {
    mydb.collection('post').find().toArray().then(result => {
        console.log(result);    // 몽고DB API
        // ejs 템플리트 엔진의 경우 루트 문서 디렉토리 내에
        // 반드시 views 폴더를 만들고 그 안에 ***.ejs 파일을 넣어놔야 한다.
        res.render('list.ejs', {data: result});
    });
});

// 게시물 작성 화면
app.get('/enter', (req, res) => {
    res.render('enter.ejs');
});
// 입력한 게시물 데이터 저장
app.post('/save', (req, res) => {
    console.log(req.body.title);
    console.log(req.body.content);
    console.log(req.body.date);
    
    mydb.collection('post').insertOne(
        {
            title: req.body.title,
            content: req.body.content,
            date: req.body.date,
        }
    ).then(result => {
        console.log(result);
        console.log("데이터 추가 성공");
        res.redirect('/list');
    });
});

// 게시물 상세 화면
app.get('/content/:id', (req, res) => {
    req.params.id = new ObjId(req.params.id);
    mydb.collection("post")
        .findOne({_id: req.params.id})
        .then((result) => {
            console.log(result);
            res.render("content.ejs", {data:result});
        });
});


/////////////////// MariaDB 연결 및 설정 ///////////////////////
// $npm install --save node-mysql

/*
var mysql = require('mysql');
var conn = mysql.createConnection({
    host: "localhost",
    user: "webmaser",
    password: "****",
    database: "webdev"
});

conn.connect();

conn.query("select * from tbl_board", function(err, rows, fields){
    if(err) throw err;
    console.log(rows);
});
*/
