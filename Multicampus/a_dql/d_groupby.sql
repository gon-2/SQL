# group by
# 특정 컬럼을 기준으로 그룹핑하여 그룹함수를 사용해 원하는 데이터를 추출할 목적으로 사용
# group 함수 : sum(), count(), 에버리지: avg(), 최대값: max(), 최소값 : min()
# select절에는 그룹핑한 기준이 되는 컬럼과, 그외 함수의 결과만 올 수 있다.

# 부서별 급여의 총액과 평균급여를 구해보자
select dept_code, sum(salary), avg(salary)
from employee
group by dept_code;

# 직급별 급여 평균, 직급별 최고급여, 최저급여, 사원수를 조회하시오
select  job_code, avg(salary), max(SALARY), min(SALARY), count(*)
from employee
group by job_code;

# 급여가 300만원 이상인 사원들의 부서별 급여 총액을 구하시오.
select  dept_code, sum(salary)
from employee
where salary >= 3000000
group by dept_code;

# 부서의 평균 급여가 300만원 이상인 부서를 조회하시오.
select dept_code
from employee
group by dept_code
having sum(salary) >= 3000000; # group by 사용시 사용하는 조건문 같은거?


# 부서내, 직급별 급여의 최소 최대값을 구해보자.
select dept_code, job_code, max(salary), min(salary), count(*)
from employee
group by dept_code, job_code;

# 집계함수(rollup) : 그룹별 중간집계와 총 집계를 계산해준다
select dept_code, job_code, sal_level, sum(salary), count(*)
from employee
where dept_code is not null
group by dept_code, job_code, sal_level with rollup
order by 
dept_code is null asc
,job_code is null asc
,sal_level is null asc
, dept_code asc
, job_code asc
, sal_level asc;

# grouping 함수
# 해당 row의 집계값이 인자로 전달받은 컬럼집합의 산출물이면 0, 아니면 1을 반환
select dept_code, job_code, sal_level,
		grouping(dept_code),
        grouping(job_code),
        grouping(sal_level),
        sum(salary), count(*)
from employee
where dept_code is not null
group by dept_code, job_code, sal_level with rollup
order by 
dept_code is null asc
,job_code is null asc
,sal_level is null asc
, dept_code asc
, job_code asc
, sal_level asc;
