
-- Triggers for auto increment 
//
DELIMITER ;

DROP TRIGGER IF EXISTS AutoIncrement_locations;
DELIMITER  //

CREATE TRIGGER AutoIncrement_locations
  BEFORE INSERT ON locations
FOR EACH ROW BEGIN
  SET @@auto_increment_increment=100;
END ;
//
DELIMITER ;

//
DELIMITER ;

DROP TRIGGER IF EXISTS AutoIncrement_employees;
DELIMITER  //

CREATE TRIGGER AutoIncrement_employees
  BEFORE INSERT ON employees
FOR EACH ROW BEGIN
  SET @@auto_increment_increment=1;
END ;
//
DELIMITER ;

//
DELIMITER ;

DROP TRIGGER IF EXISTS AutoIncrement_departments;
DELIMITER  //

CREATE TRIGGER AutoIncrement_departments
  BEFORE INSERT ON departments
FOR EACH ROW BEGIN
  SET @@auto_increment_increment=10;
END ;
//
DELIMITER ;