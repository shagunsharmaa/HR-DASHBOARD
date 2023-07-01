-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count
FROM hr
WHERE age >= 18 
GROUP BY gender;
-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, count(*) AS count
FROM hr
WHERE age >= 18 
GROUP BY race
ORDER BY count(*) DESC;
-- 3. What is the age distribution of employees in the company?
SELECT
min(age) AS youngest,
max(age) AS oldest
FROM hr
WHERE age >= 18 
SELECT
	CASE
	WHEN age >= 18 AND age <=24 THEN '18-24'
	WHEN age >= 25 AND age <=34 THEN '25-34'
	WHEN age >= 35 AND age <=44 THEN '35-44'
	WHEN age >= 45 AND age <=54 THEN '44-54'
	WHEN age >= 55 AND age <=64 THEN '18-24'
	ELSE '65+'
    
END AS age_group,
count(*) AS count
FROM hr
WHERE age >= 18
GROUP BY age_group
ORDER BY age_group;

-- Gender amongst age group

SELECT
	CASE
	WHEN age >= 18 AND age <=24 THEN '18-24'
	WHEN age >= 25 AND age <=34 THEN '25-34'
	WHEN age >= 35 AND age <=44 THEN '35-44'
	WHEN age >= 45 AND age <=54 THEN '44-54'
	WHEN age >= 55 AND age <=64 THEN '18-24'
	ELSE '65+'
    
	END AS age_group,gender,
	count(*) AS count
	FROM hr
	WHERE age >= 18
GROUP BY age_group,gender
ORDER BY age_group,gender;


-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18
GROUP BY location;


-- 5. What is the average length of employment for employees who have been terminated?
SELECT
round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS count
FROM hr
WHERE age >= 18 
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?

	SELECT department,
	total_count,
	terminated_count,
	terminated_count/total_count AS termination_rate
	FROM (
	SELECT department,
	count(*) AS total_count,
	SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
	FROM hr
	WHERE age >= 18 
	GROUP BY department
	)AS SUBQUERY
ORDER BY termination_rate desc;



-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state,count(*) AS count
FROM HR
WHERE AGE>=18 
group by LOCATION_STATE
ORDER BY COUNT DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
	year,
    HIRES,
    TERMINATIONS,
    HIRES-TERMINATIONS AS NET_CHANGE,
    round((hires-terminations)/hires *100, 2) AS NET_CHANGE_PERCENT
    FROM(
		SELECT 
        YEAR(HIRE_DATE) AS YEAR,
        COUNT(*) AS HIRES,
        SUM(CASE WHEN termdate <> '0000-00-00' AND TERMDATE <= CURDATE() THEN 1 ELSE 0 END) AS TERMINATIONS
        FROM HR
        WHERE AGE>=18
        GROUP BY YEAR(HIRE_DATE)
        )AS SUBQUERY
        ORDER BY YEAR ASC;
    
-- 11. What is the tenure distribution for each department?

select department,round(avg(datediff(termdate,hire_date)/365),01) AS avg_tenure
from hr
where termdate<=curdate() AND termdate<>'0000-00-00' AND age>=18
GROUP BY department;