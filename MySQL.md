# MySQL

#### SQL의 3가지

- DML 

1)INSERT INTO table명 VALUES(0,0,0,0)

2)DELECT FROM table명 WHERE emomo=7786
    
 DELECT FROM table명; //table의 모든 데이터가 다 삭제되기때문에 주의!!
      
3)UPDATE table명 SET sal=2000 WHERE ename='SMITH';
  
4)SELECT * FROM table명;//모든데이터를 가지고옴.
    
  SELECT * FROM table명 WHERE deptno=10;//조건에 맞는 데이타 행을 가지고옴.
      
- DDL : 

- DCL :

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
























