
-- Procedure & Triggers

-- ********* PROCEDURE TRIGGER TO RAISE APPLICATION ERROR ************

DROP PROCEDURE IF EXISTS raise_application_error;
DROP PROCEDURE IF EXISTS get_last_custom_error;
DROP TABLE IF EXISTS RAISE_ERROR;

DELIMITER $$
CREATE PROCEDURE raise_application_error(IN CODE INTEGER, IN MESSAGE VARCHAR(255)) SQL SECURITY INVOKER DETERMINISTIC
BEGIN
  CREATE TEMPORARY TABLE IF NOT EXISTS RAISE_ERROR(F1 INT NOT NULL);

  SELECT CODE, MESSAGE INTO @error_code, @error_message;
  INSERT INTO RAISE_ERROR VALUES(NULL);
END;
$$

CREATE PROCEDURE get_last_custom_error() SQL SECURITY INVOKER DETERMINISTIC
BEGIN
  SELECT @error_code, @error_message;
END;
$$
DELIMITER ;

-- *********** PROCEDURE TO SECURE DML OPERATIONS ***********
DROP PROCEDURE IF EXISTS secure_dml;
DELIMITER  $$
CREATE PROCEDURE secure_dml ()
BEGIN
IF DATE_FORMAT(current_time(), '%H:%i') NOT BETWEEN '08:00' AND '21:00'
        OR DATE_FORMAT(CURRENT_TIMESTAMP, '%a') IN ('SAT', 'SUN') THEN
	CALL raise_application_error (-20205, 
		'You may only make changes during normal office hours');
	CALL get_last_custom_error();
  END IF;
END;
$$
DELIMITER ;

-- ************ TRIGGER TO SECURE EMPLOYEES *************
DROP TRIGGER IF EXISTS secure_employeesInsert;
DELIMITER  //

CREATE TRIGGER secure_employeesInsert
  BEFORE INSERT ON employees
FOR EACH ROW BEGIN
  CALL secure_dml;
END ;
//
DELIMITER ;

DROP TRIGGER IF EXISTS secure_employeesUpdate;
DELIMITER  //

CREATE TRIGGER secure_employeesUpdate
  BEFORE UPDATE ON employees
FOR EACH ROW BEGIN
  CALL secure_dml;
END ;
//
DELIMITER ;

DROP TRIGGER IF EXISTS secure_employeesDelete;
DELIMITER  //

CREATE TRIGGER secure_employeesDelete
  BEFORE DELETE ON employees
FOR EACH ROW BEGIN
  CALL secure_dml;
END ;
//
DELIMITER ;

-- ************* procedure to add a row to the JOB_HISTORY table and row trigger 
 -- to call the procedure when data is updated in the job_id or 
 -- department_id columns in the EMPLOYEES table ***************
 
DROP PROCEDURE IF EXISTS add_job_history;
DELIMITER  $$
CREATE PROCEDURE add_job_history (IN p_emp_id INTEGER, 
								  IN p_start_date DATE,
                                  IN p_end_date DATE, 
                                  IN p_job_id varchar(10),
                                  IN p_department_id INTEGER)
	 
BEGIN
	INSERT INTO job_history (employee_id,start_date,end_date,job_id,department_id)
    VALUES(p_emp_id,p_start_date,p_end_date,p_job_id,p_department_id);
END;
$$
DELIMITER ;

-- **********TRIGGER TO CALL ADD_JOB_HISTORY *********

DROP TRIGGER IF EXISTS update_job_history;
DELIMITER  //

CREATE TRIGGER update_job_history
AFTER UPDATE ON employees
FOR EACH ROW BEGIN
-- IF NEW.job_id IS NOT NULL || NEW.department_id IS NOT NULL THEN
-- IF NEW.job_id <> OLD.job_id || NEW.department_id <> OLD.department_id THEN
  CALL add_job_history(old.employee_id, old.hire_date, CURRENT_TIMESTAMP, 
                  old.job_id, old.department_id);
-- END IF;
-- END IF;
END ;
//
DELIMITER ;