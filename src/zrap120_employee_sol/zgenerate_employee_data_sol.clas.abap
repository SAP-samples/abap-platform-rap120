 CLASS zgenerate_employee_data_sol DEFINITION
   PUBLIC
   FINAL
   CREATE PUBLIC .
   PUBLIC SECTION.
     INTERFACES if_oo_adt_classrun.

   PROTECTED SECTION.
   PRIVATE SECTION.
 ENDCLASS.

 CLASS zgenerate_employee_data_sol IMPLEMENTATION.

   METHOD if_oo_adt_classrun~main.
     DATA dummy_manager_uuid TYPE sysuuid_x16.

     "delete existing data, if available
     DELETE FROM zemployeesol.

     "insert employee data
     INSERT zemployeesol  FROM (
         SELECT
           FROM /DMO/I_Employee_HR AS employee
           FIELDS
             uuid(  )                  AS uuid,
             employee~employee         AS employee_id,
             employee~FirstName       AS first_name,
             employee~LastName        AS last_name,
             employee~SalaryCurrency  AS salary_curr,
             employee~salary           AS salary,
             employee~manager          AS manager_id,
             @dummy_manager_uuid       AS manager_uuid   "dummy manager UUID

             ORDER BY employee UP TO 2010 ROWS
       ).

     "assign correct manager UUID
     SELECT * FROM zemployeesol INTO TABLE @DATA(employees_hr).
     LOOP AT employees_hr INTO DATA(employee_hr).
       SELECT SINGLE * FROM zemployeesol WHERE employee_id = @employee_hr-manager_id INTO @DATA(manager_empl).
       employee_hr-manager_uuid = manager_empl-uuid.  "manager uuid EQ employee uuid
       MODIFY zemployeesol FROM @employee_hr.
     ENDLOOP.
     COMMIT WORK.
     out->write( |RAP120 - Employee data successfully generated. / sy-subrc { sy-subrc } | ).
   ENDMETHOD.
 ENDCLASS.
