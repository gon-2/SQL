# join
# 관계형 데이터베이스에서는 데이터의 중복을 최소화하고, 무결성을 보장하기 위해(이상현상을 방지하기 위해) 
# 연관된 데이터들을 분리하여 저장하도록 설계한다. 
# 필요할 때 테이블간 join을 통해 원하는 형테의 데이터를 조회한다.

# 모든 직원의 직원번호, 이름, 부서코드, 부서명을 조회
# subquery 방법
select emp_id, emp_name, dept_code, (select DEPT_TITLE from department where DEPT_ID = e.dept_code) as 부서명
from employee e;

# join 방법
select *
from employee e
join department d on(e.dept_code = d.dept_id);

# join
# cross join, inner join, outer join(letf join, right join, full outer join)

# 1.corss join(안씀) : 조인 조건절의 결과가 무조건 참인 join
# 30만개의 상품데이터와 300만개의 주문 데이터를 cross join하면 9천억개 => DB사망, 서비스 뻗음 ...멈춤..재앙
select * from employee cross join department
order by emp_id;

# 2. inner join(equals join, 등가 조인)
# 사번, 이름, 직급코드, 직금명을 출력하시오
select *
from employee e
join job using(job_code);

# 여러테이블 join하기, 테이블도 참조간에 방향이 있다.
# 모든 사원들의 사번, 이름, 부서명, 근무지이름을 출력하시오
select emp_id, emp_name, dept_title, local_name
from employee e
join department on(DEPT_CODE = dept_id)
join location on(location_id = local_code);

# ASIA 지역에서 근무하는 급여 500만원 미만의 직원들을 조회
# ASIA 지역 : ASIA1, ASIA2, ASIA3
select emp_name, salary, local_name
from employee e
join department d on(dept_code = dept_id)
join location on(location_id = local_code)
where SALARY < 5000000
and local_name like 'ASIA%'
order by salary asc;

# outer join
# 특정 테이블을 기준으로 join을 수행
# 특정 테이블을 기준으로 join 조건절이 false를 반환하더라도 특정 테이블의 컬럼은 result에 포함시킨다.
# left join, right join, full outer join

# 부서별 사원수를 조회해보자.
#left join
select dept_id, dept_title, count(emp_id)
from department left join employee on(DEPT_CODE = dept_id)
group by dept_code, dept_title
order by dept_id;

# right join
select dept_id, dept_title, count(emp_id)
from employee right join department on(DEPT_CODE = dept_id)
group by dept_code, dept_title
order by dept_id;

# full outer join : right join + left join
# union : 합집합
# 두 result set의 합집합을 반환
select dept_id, dept_title, count(emp_id)
from department left join employee on(DEPT_CODE = dept_id)
group by dept_code, dept_title
union
select dept_id, dept_title, count(emp_id)
from employee right join department on(DEPT_CODE = dept_id)
group by dept_code, dept_title
order by dept_id;

# self join
# 자기 자신과 join하는 방식
select emp_name, dept_code, manager_id,
 (select emp_name from employee where emp_id = e.manager_id)
from employee e;

select e.emp_name, e.dept_code, e.manager_id, e2.emp_name
from employee e
left join employee e2 on(e2.emp_id = e.manager_id)
order by e2.emp_name;


