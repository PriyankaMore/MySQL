-- *********** QUERIES TO TEST AUTO INCREEMENT FEATURE ********
use hr;

INSERT INTO `hr`.`employees`
(`first_name`,
`last_name`,
`email`,
`phone_INT`,
`hire_date`,
`job_id`,
`salary`,
`commission_pct`,
`manager_id`,
`department_id`)
VALUES
('Manuel'
, 'Kochhar'
, 'MAGNI' -- UNIQUE
, '515.123.4568'
, STR_TO_DATE('21-SEP-2015', '%d-%b-%Y')
, 'AD_VP'
, 17000
, NULL
, 100
, 90
);

Select * from employees;

INSERT INTO `hr`.`locations`
(`street_address`,
`postal_code`,
`city`,
`state_province`,
`country_id`)
VALUES
('FoggyBottom'
, '00989'
, 'Roma'
, NULL
, 'IT'
);

Select * from locations;

INSERT INTO `hr`.`departments`
(`department_name`,
`manager_id`,
`location_id`)
VALUES
('Marketing-GWU'
, 201
, 1800
);


-- *******Query to test trigger secure dml **********

INSERT INTO employees (employee_id,first_name,last_name,email,phone_INT,hire_date,job_id,salary,commission_pct,manager_id,department_id) 
		VALUES 
        ( 221
         ,'William'
        , 'Gietz'
        , 'TestId'
        , '515.123.8181'
        , STR_TO_DATE('07-JUN-1994', '%d-%b-%Y')
        , 'AC_ACCOUNT'
        , 8300
        , NULL
        , 205
        , 110
        );

-- ******** Query to test update jb history table on update of employee job_id and dept_id *******
        
UPDATE `hr`.`employees`
SET
`job_id` = 'IT_PROG',
`department_id` = 60,
`hire_date` = STR_TO_DATE('23-JAN-2016', '%d-%b-%Y')
WHERE `employee_id` = 197;

select * from employees where employee_id=197;

select * from job_history where employee_id=197;

-- *********** call get_last_custom_error()

use HR;
CALL get_last_custom_error();