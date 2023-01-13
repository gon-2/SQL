# 1. 부서명과 부서별 평균급여를 구하시오
# 평균 급여는 소수점에서 내림처리하여 정수로 표현하세요
# 부서에 사원이 존재하지 않아 평균급여가 null일경우는 0원으로 표시하세요
select d.dept_title, floor(avg(e.SALARY)) 
from department d, employee e
where d.dept_id = e.DEPT_CODE
group by dept_id;




# 2. 각 부서별 급여의 합계들을 구하여, 
# 부서 급여합이 1000만을 초과하는 부서명과 부서별 급여합계를 조회하는
# SELECT 문을 작성하시오.
select dept_title, sum(salary)
from department d, employee e
where e.dept_code = d.DEPT_ID
group by dept_code 
having sum(salary) > 10000000;


# 3. 직원 테이블에서 
# 사번, 이름, 부서명, 직급명, 입사일, 보너스를 포함한 연봉, 순위
# 를 출력하세요.
select e.emp_id, e.emp_name, d.DEPT_TITLE, j.JOB_NAME,  e.HIRE_DATE, e.salary * (1+bonus)  * 12
from employee e , job j, department d
where d.dept_id = e.dept_code
and j.job_code = e.job_code
order by e.salary * (1+ bonus)  * 12 desc;


# 4. 직원 테이블에서 보너스 포함한 연봉이 높은 5명의
#  사번, 이름, 부서명, 직급명, 입사일을 조회하세요
select e.emp_id, e.emp_name, d.DEPT_TITLE, e.HIRE_DATE 
from employee e, department d
where e.dept_code = d.DEPT_ID
order by salary desc
limit 0,5;


# 5.70년대 생이면서 성별이 여성이고 성이 전씨인 사원의
# 이름, 주민등록번호, 부서명, 직급명을 출력하세요.
select emp_name, emp_no, dept_title, j.job_name
from employee e, department d, job j
where e.DEPT_CODE  = d.dept_id
and e.JOB_CODE = j.JOB_CODE
and EMP_NO LIKE '7______2%'
and emp_name like '전%';

# 6. 이름에 '형'이 들어가는 사원의 사원ID, 사원이름, 직업명을 출력하세요 
select emp_id, emp_name, d.dept_title 
from employee e, department d
where e.DEPT_CODE = d.DEPT_ID
and emp_name like '%형%';


# 7. 부서코드가 D5, D6 인 사원의 이름, 직급명, 부서코드, 부서명을 출력하세요
select e.emp_name, j.job_name, e.dept_code, d.DEPT_title
from employee e, job j, department d
where 1=1
and e.job_code = j.job_code
and e.dept_code = d.dept_id
and e.dept_code in('D5', 'D6');

# 8. 사번, 사원명, 급여
# 급여가 500만원 이상이면 '고급'
# 급여가 300~500만원이면 '중급'
# 그 이하는 '초급'으로 출력처리 하고 별칭은 '구분' 으로 한다.
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, SALARY AS 급여,
 CASE   WHEN SALARY > 5000000 THEN '고급'
		WHEN SALARY >= 3000000 AND SALARY <= 5000000 THEN '중급'
        ELSE '초급'
END AS 구분        
FROM employee
order by SALARY DESC;


# 9. 부서에서 가장 어린 사원의 사원ID, 이름, 나이, 부서명, 직급명을 출력하세요
select e.emp_id, timestampdiff(year, EMP_NO, now()), e.emp_name, d.dept_title, j.job_name 
from employee e, department d, job j
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
ORDER BY EMP_NO DESC
limit 1;



# 10. 보너스를 받은 사원의 사원명, 보너스, 부서명, 지역명을 출력하세요
select emp_name, bonus, dept_title, local_name
from employee e
join department on dept_code = dept_id
join location on location_id = local_code;

# 11. 부서가 위치한 국가가 한국이나 일본인사원의
# 이름, 부서명, 지역명, 국가명을 출력하시오 한국 ko, 일본 ja
select emp_name, dept_title, local_name, l.national_code, n.national_name
from employee
join department  ON DEPT_CODE = DEPT_ID
join location l ON LOCATION_ID = LOCAL_CODE
join national n on n.NATIONAL_CODE = l.NATIONAL_CODE
where n.national_code IN('KO', 'JP');

# 12. job_code가 'J4', 'J7'이면서 보너스를 받지 못한 사원의 
# 이름, 직급명, 급여, 보너스금액(0원으로) 출력하세요
select emp_name, job_name, salary, ifnull(bonus, 0)
from employee e
join  job j on e.job_code = j.job_code
where j.job_code in('J4', 'J7');
