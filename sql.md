# SQL
## Oracle
### 뷰
#### PL/SQL 프로시저
```sql
-- 1. 입력 매개변수가 있는 프로시저
CREATE OR REPLACE PROCEDURE greet_user(p_name IN VARCHAR2)
AS
BEGIN
    DBMS_OUTPUT.put_line('Hello World!!!'||' '||p_name);
END;

exec greet_user('김철수');

-- 2. 출력 매개변수가 있는 프로시저
CREATE OR REPLACE PROCEDURE add_numbers(p_num1 IN number, p_num2 IN number, p_result OUT number)
AS
BEGIN
    p_result := p_num1 + p_num2;
END;

DECLARE
    v_result NUMBER;
BEGIN
    add_numbers(5, 10, v_result);
    dbms_output.put_line('Result = ' || v_result);
end;

-- 3. IN OUT (Oracle에서만 지원)
CREATE OR REPLACE PROCEDURE increament_number(p_num IN OUT number)
AS
BEGIN
    p_num := p_num + 1;
END;

DECLARE
    v_num number := 20;
BEGIN
    increament_number(v_num);
    dbms_output.put_line('p_num = '|| v_num);
END;
```

#### PL/SQL 함수
```sql
-- Oracle
create or replace FUNCTION f_grade (in_value number)
    RETURN varchar2
AS
    v_grade varchar2(20);
begin
    v_grade := 'Low salary';
    if in_value > 2500 then
        v_grade := 'High salary';
    end if;
    return v_grade;
end;

select ename, sal, f_grade(sal)
from emp;

-- mySQL
DELIMITER $$
CREATE OR REPLACE FUNCTION f_hitno(v_seqno INT)
RETURNS INT
BEGIN
	UPDATE tbl_board
	SET hitno = (
		SELECT IFNULL(hitno, 0)
		FROM tbl_board
		WHERE seqno = v_seqno
		) + 1
	WHERE seqno = v_seqno;
	RETURN 0;
END $$
```

#### PL/SQL 트리거
```sql
--mySQL
DELIMITER &&
CREATE OR REPLACE TRIGGER tbl_board_log
AFTER INSERT ON tbl_board FOR EACH ROW
BEGIN
	INSERT INTO tbl_board_log (userid, bseqno)
	VALUES (NEW.userid, NEW.seqno);
END &&
```

### 트랜잭션
- 데이터베이스의 상태를 변화시키는 업무처리의 논리적 단위

#### 트랜잭션의 특성
1. 원자성
    - 트랜잭션을 구성하는 작업들은 전부 수행이 되거나 전혀 수행이 되지 않아야 한다.
2. 일관성
    - 트랜잭션을 수행하기 이전의 데이터베이스와 수행한 이후의 데이터베이스가 논리적으로 일관된 상태.
3. 격리성
    - 여러 트랜잭션들이 병렬적으로 수행되는 상황에서 트랜잭션들 간에 상호 간섭에 의한 문제를 일으키지 않는 성질.
4. 지속성
    - 트랜잭션이 성공적으로 완료된 후에는 트랜잭션의 수행 결과가 데이터 베이스에 영구적으로 유지되는 특성.

#### 장애와 회복
- 백업과 로그
    - 시스템 종료에 따른 백업 구분
        1. 콜드 백업
            - 실행 중인 운영 시스템을 중지한 후 백업 실시
        2. 핫 백업
            - 운영시스템을 중지하지 않고 백업을 수행
        3. 웜 백업
            - 위 두 방법을 조합한 형태.
            - 운영시스템을 중지하지는 않으나, 외부 사용자가 데이터베이스를 변경하는 것을 막아 유사 중지 효과
    - 백업 범위에 따른 백업 구분
        1. 전체 백업
        2. 증분 백업
            - 과거의 백업 시점 이후 변화된 부분만 백업