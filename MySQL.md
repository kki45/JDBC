# MySQL

#### SQL의 3가지

- DML (데이터 조작어) : SELECT, INSERT, UPDATE, DELETE, MERGE

1)INSERT INTO table명 VALUES(0,0,0,0)

2)DELECT FROM table명 WHERE emomo=7786
    
 DELECT FROM table명; //table의 모든 데이터가 다 삭제되기때문에 주의!!
      
3)UPDATE table명 SET sal=2000 WHERE ename='SMITH';
  
4)SELECT * FROM table명;//모든데이터를 가지고옴.
    
  SELECT * FROM table명 WHERE deptno=10;//조건에 맞는 데이타 행을 가지고옴.
      
- DDL (데이터 정의어) : CREATE, ALTER, DROP, RENAME

- DCL (데이터 제어어) : GRANT, REVOKE

#### SELECT(Projection + Selection)

- Projection : 컬럼명을 직접 지정함
          distinct 컬럼의 중복을 제거함
          
- Selection : where 절을 추가해서 원하는 행만 검색
         ORDER BY정렬, ALIAS 지정방법
         
 문제1. EMP 테이블에서 업무가 SALESMAN 사원과 사원의 이름이 FORD인 사원의 이름, 업무, 급여를 검색 하시오.

 ```sql
 select ename, job, sal 
from emp 
where job='SALESMAN' or ename='FORD';

+--------+----------+------+
| ename  | job      | sal  |
+--------+----------+------+
| ALLEN  | SALESMAN | 1600 |
| WARD   | SALESMAN | 1250 |
| MARTIN | SALESMAN | 1250 |
| TURNER | SALESMAN | 1500 |
| FORD   | ANALYST  | 3000 |
+--------+----------+------+
5 rows in set (0.01 sec)
 ```
 
-- 위 결과에서 SAL값이 점점 높은순으로 출력되도록 결과를 정렬하려면 order by 절이 필요

-- 1) 절의 작성 순서 : select -> from -> where -> order by

```sql
SELECT ename, job, sal 
from emp 
where job='SALESMAN' or ename='FORD' 
order by sal asc;
+--------+----------+------+
| ename  | job      | sal  |
+--------+----------+------+
| WARD   | SALESMAN | 1250 |
| MARTIN | SALESMAN | 1250 |
| TURNER | SALESMAN | 1500 |
| ALLEN  | SALESMAN | 1600 |
| FORD   | ANALYST  | 3000 |
+--------+----------+------+
5 rows in set (0.00 sec)
```

문제 2. EMP 테이블에서, 이름, 월금, 연봉을 출력, 이때 연봉순으로 내림차순정렬(DESC)

Alias(AS)별칭사용 --> 별칭에 공백이있으면 " "사용, AS생략가능함, 한칸띄워서 생성할 별칭이름 작성.

```sql
select ename, sal, sal * 12 + comm  AnnualSalary
FROM emp 
order by sal * 12 + comm DESC;
+--------+------+--------------+
| ename  | sal  | AnnualSalary |
+--------+------+--------------+
| ALLEN  | 1600 |        19500 |
| TURNER | 1500 |        18000 |
| MARTIN | 1250 |        16400 |
| WARD   | 1250 |        15500 |
| SMITH  |  800 |         NULL |
| JONES  | 2975 |         NULL |
| BLAKE  | 2850 |         NULL |
| CLARK  | 2450 |         NULL |
| SCOTT  | 3000 |         NULL |
| KING   | 5000 |         NULL |
| ADAMS  | 1100 |         NULL |
| JAMES  |  950 |         NULL |
| FORD   | 3000 |         NULL |
| MILLER | 1300 |         NULL |
+--------+------+--------------+
14 rows in set (0.00 sec)
```

- null값

sql에서 null값은 연산이 적용되지 않는 값이다.

null을 다른 값으로 치환해서 계산을 해야한다. -> ifNull()를 사용.

ifNull(comm,0)--comm이 null값이 아니면 그대로 리턴/comm이 null이면 0으로 리턴.

SQL에서 NULL값은 제대로 다룰 수 있어야 함.

1) comm값은 아직 정해지지 않았거나 / 자격이 없거나 일때 사용되는 값.

2) 0을 의미하는 값이 아니다.

3) 값이 없는 것도 아니다. 나름 의미를 가지는 값이다...1)에서 언급

4) 0과는 전혀다른 값이기 때문에 비교, 연산 적용이 안된다.

    --> =, != 연산자 사용 못한다.
    
    --> +, -, *, / 사용 안된다. 대신에 ifNull()을 사용해서 값을 치환시키고 연산 적용 가능

문제 2-1. ifNull()사용
```sql
select ename, sal, sal * 12 + ifnull(comm,0)  AnnualSalary
FROM emp 
order by sal * 12 + comm DESC;
+--------+------+--------------+
| ename  | sal  | AnnualSalary |
+--------+------+--------------+
| ALLEN  | 1600 |        19500 |
| TURNER | 1500 |        18000 |
| MARTIN | 1250 |        16400 |
| WARD   | 1250 |        15500 |
| SMITH  |  800 |         9600 |
| JONES  | 2975 |        35700 |
| BLAKE  | 2850 |        34200 |
| CLARK  | 2450 |        29400 |
| SCOTT  | 3000 |        36000 |
| KING   | 5000 |        60000 |
| ADAMS  | 1100 |        13200 |
| JAMES  |  950 |        11400 |
| FORD   | 3000 |        36000 |
| MILLER | 1300 |        15600 |
+--------+------+--------------+
14 rows in set (0.00 sec)
```
- limit( )

출력 갯수를 제한하는 기능, 시작은 0부터...ex)....0,5....상위 5개만 출력

문제 3. emp 테이블에서, sal가 가장 많은 사원 3명을 출력(sal ORDER BY DESC)
```sql
SELECT * FROM emp ORDER BY sal DESC limit 3;
+-------+-------+-----------+------+---------------------+------+------+--------+
| EMPNO | ENAME | JOB       | MGR  | HIREDATE            | SAL  | COMM | DEPTNO |
+-------+-------+-----------+------+---------------------+------+------+--------+
|  7839 | KING  | PRESIDENT | NULL | 1981-11-17 00:00:00 | 5000 | NULL |     10 |
|  7902 | FORD  | ANALYST   | 7566 | 1981-12-03 00:00:00 | 3000 | NULL |     20 |
|  7788 | SCOTT | ANALYST   | 7566 | 1987-04-19 00:00:00 | 3000 | NULL |     20 |
+-------+-------+-----------+------+---------------------+------+------+--------+
3 rows in set (0.01 sec)
```

문제 4. emp테이블에서 comm을 받지않는 사원을 검색...이름,업무,comm이 출력
```sql
SELECT ename, job, comm FROM emp WHERE comm is null;
+--------+-----------+------+
| ename  | job       | comm |
+--------+-----------+------+
| SMITH  | CLERK     | NULL |
| JONES  | MANAGER   | NULL |
| BLAKE  | MANAGER   | NULL |
| CLARK  | MANAGER   | NULL |
| SCOTT  | ANALYST   | NULL |
| KING   | PRESIDENT | NULL |
| ADAMS  | CLERK     | NULL |
| JAMES  | CLERK     | NULL |
| FORD   | ANALYST   | NULL |
| MILLER | CLERK     | NULL |
+--------+-----------+------+
10 rows in set (0.00 sec)
```

- 숫자함수 : abs(), round(), floor(), mod()

문제 5. 사원 번호중에서 홀수번호만 출력...mod()

empno를 2로 나눴을때 1이 나오면 홀수.

mod( ) :: 분자를 분모로 나눈 나머지를 구하는 함수.

```sql
SELECT ename, empno, job FROM emp WHERE MOD(empno,2) = 1;
+-------+-------+-----------+
| ename | empno | job       |
+-------+-------+-----------+
| SMITH |  7369 | CLERK     |
| ALLEN |  7499 | SALESMAN  |
| WARD  |  7521 | SALESMAN  |
| KING  |  7839 | PRESIDENT |
+-------+-------+-----------+
4 rows in set (0.00 sec)
```
- 문자함수 : concat(), substr(), trim()

문제 6. emp테이블에서 사원들의 입사월을 출력,,,이때 사원의 이름과 함께 출력, 별칭부여

hiredate를 6번재부터 2글자만 잘라서 출력.

substr( ) :: 문자열을 자르는 함수
```sql
SELECT ename, substr(hiredate,6,2) 입사월 FROM emp;
+--------+--------+
| ename  | 입사월 |
+--------+--------+
| SMITH  | 12     |
| ALLEN  | 02     |
| WARD   | 02     |
| JONES  | 04     |
| MARTIN | 09     |
| BLAKE  | 05     |
| CLARK  | 06     |
| SCOTT  | 04     |
| KING   | 11     |
| TURNER | 09     |
| ADAMS  | 05     |
| JAMES  | 12     |
| FORD   | 12     |
| MILLER | 01     |
+--------+--------+
14 rows in set (0.00 sec)
```

- 날짜함수 : now(), sysdate(), curdate(), year(), month()

- 스칼라 서버쿼리 :: one row, one col

전체쿼리에서 서버쿼리가 먼저 돌아감 -> 메인쿼리가 된다.

스칼라 서버쿼리 == 괄호안에 괄호에 있는 쿼리

문제 7. 이름이 'KING'인 사람과 이름이 'ALLEN'인 사람의 급여차이를 출력.....abs()

```sql
SELECT DISTINCT ABS((SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename= 'ALLEN')) 급여차이 FROM emp;
+----------+
| 급여차이 |
+----------+
|     3400 |
+----------+
1 row in set (0.00 sec)
```
- like연산자와 와일드카드

 특정 단어가 포함된 것을 검색할때 like연산자를 쓴다.
 
 와일드 카드 : %(0~many), _(정확하게 1대1 매핑)

문제 8. 사원의 이름중에서 두번째 철자가 A인 사원을 검색..LIKE _A

```sql
SELECT ename FROM emp WHERE ename LIKE '_A%';
+--------+
| ename  |
+--------+
| WARD   |
| MARTIN |
| JAMES  |
+--------+
3 rows in set (0.00 sec)
```

문제 9. 사원의 이름중에서 R철자가 포함된 사원을 검색

```sql
SELECT ename FROM emp WHERE ename LIKE '%R%';
+--------+
| ename  |
+--------+
| WARD   |
| MARTIN |
| CLARK  |
| TURNER |
| FORD   |
| MILLER |
+--------+
6 rows in set (0.00 sec)
```
- 그룹함수 

null값은 그룹함수에서 제외시킨다.

count() - 테이블 행의 갯수를 리턴 ->  count(column), count(*) == count(-1)
          
avg() -  평균값을 리턴

문제 10. 모든 사원의 평균급여를 구하는데 소숫점 두자리까지 출력...
```sql
SELECT ROUND(AVG(sal),2) 평균급여 FROM emp;
+----------+
| 평균급여 |
+----------+
|  2073.21 |
+----------+
1 row in set (0.00 sec)
```
문제 11. 모든 사원의 보너스(comm)의 평균을 구하세요.
```sql
SELECT ROUND(AVG(ifnull(comm,0))) 보너스평균 FROM emp; 
+------------+
| 보너스평균 |
+------------+
|        157 |
+------------+
1 row in set (0.00 sec)
```
sum() - 총합을 리턴

max() - 최대값 리턴

문제 12 . emp 테이블에서 가장 최근에 입사한 사원의 입사일을 검색...그룹함수 사용
```sql
SELECT MAX(hiredate) FROM emp;
+---------------------+
| MAX(hiredate)       |
+---------------------+
| 1987-05-23 00:00:00 |
+---------------------+
1 row in set (0.00 sec)
```

min() - 최소값 리턴

- GROUP BY 절

1. 그룹함수에서 적용되지 않는 컬럼이 SELECT절에 명시되어서는 안된다.

2. 그룹함수에서 적용되지 않는 컬럼이 SELECT절에 명시되기 위해서는 GROUP BY절에 나열되어져야 한다.

3. 그룹함수에서 적용되지 않는 컬럼이 있다는 것은 해당 컬럼으로 그룹함수를 세분화시키겠다는 정의...

- HAVING절

1. where절에서는 그룹함수를 사용할 수 없다.
  
   where절은 일종의 조건을 부여해서 select하는 절이기 때문에 grouping이 일어나기전에 먼저 실행된다.
  
2. 문제 5번의 경우, "부서별 평균급여를 구했다"

   10 ---- 2517
   20 ---- 1790
   30 ---- 2190
   
   "이중에서 평균급여가 2000이상인 부서와 그 부서의 평균급여를 구하라"
   
   포인트는 group by 절의 결과를 다시 조건을 줘서 디스플레이하려고 한다.
   
   이때 HAVING절을 사용한다, HAVING절은 GROUPB BY절 뒤에 나온다.

문제 13. 평균급여가 2000이상인 부서와 그 부서의 평균급여를 구하라
```sql
SELECT deptno, ROUND(AVG(sal)) avgsal
FROM emp
GROUP BY  deptno
HAVING avgsal>2000;
+--------+--------+
| deptno | avgsal |
+--------+--------+
|     10 |   2917 |
|     20 |   2175 |
+--------+--------+
2 rows in set (0.00 sec)
```

- Sub Query

문제 . CLARK의 급여보다 더 많은 급여를 받는 사원의 이름과 급여를 검색.

1) SELECT sal FROM emp WHERE ename = 'CLARK';

2) 1)결과의 값을 가지고 다시 쿼리문으로 질의를 진행한다.

    SELECT ename,sal FROM emp WHERE sal >2450;

    위 결과처럼 먼저 질의를 통해서 값을 받은 후에 그 값을 다시 전체 쿼리문에 넣어서 돌릴때 우리는 Sub Query문을 사용해서 하나의 쿼리문으로 진행할 수 있다.

    서브쿼리는 반드시( )안에 싸여져야 한다.

    ()의 의미는 우선 먼저진행된다는 뜻이다.

    서브쿼리로 진행된 결과값이 전체 메인쿼리에서 돌아간다

    SUB QUERY 	    VS 		MAIN QUERY

    Inner QUERY 	VS 		Outer QUERY

- JOIN

2개이상(하나이상)의 테이블에서 질의를 던지는 경우

각각의 사원이 어느 부서에서 일하는지를 검색....사원의 이름, 업무, 부서위치를 검색...join

SELECT * FROM emp; -- 사원의 정보를 검색

SELECT * FROM dept; -- 사원이 소속된 부서의 정보를 검색

문제 14. emp, dept테이블에서 사원의 이름과 부서명, 부서위치를 검색하세요

각각의 컬럼을 어느 테이블에서 검색하는지를 지정하는 것이 성능에 좋다...테이블Alias
```sql
SELECT e.ename, d.dname, d.loc FROM emp e, dept d 
WHERE e.deptno = d.deptno;
+--------+------------+----------+
| ename  | dname      | loc      |
+--------+------------+----------+
| CLARK  | ACCOUNTING | NEW YORK |
| KING   | ACCOUNTING | NEW YORK |
| MILLER | ACCOUNTING | NEW YORK |
| SMITH  | RESEARCH   | DALLAS   |
| JONES  | RESEARCH   | DALLAS   |
| SCOTT  | RESEARCH   | DALLAS   |
| ADAMS  | RESEARCH   | DALLAS   |
| FORD   | RESEARCH   | DALLAS   |
| ALLEN  | SALES      | CHICAGO  |
| WARD   | SALES      | CHICAGO  |
| MARTIN | SALES      | CHICAGO  |
| BLAKE  | SALES      | CHICAGO  |
| TURNER | SALES      | CHICAGO  |
| JAMES  | SALES      | CHICAGO  |
+--------+------------+----------+
14 rows in set (0.00 sec)
```
문제 15. 사원이름, 급여, 부서번호, 부서이름, 부서위치를 검색.

        단, 급여가 2000달러 이상이고 30번 부서에 한해서만 검색을 합니다.
```sql
SELECT e.sal , e.deptno, d.dname, d.loc 
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND 
e.sal>2000
AND
e.deptno = 30;
+------+--------+-------+---------+
| sal  | deptno | dname | loc     |
+------+--------+-------+---------+
| 2850 |     30 | SALES | CHICAGO |
+------+--------+-------+---------+
1 row in set (0.00 sec)
```









