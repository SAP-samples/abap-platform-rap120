 CLASS zgenerator_agency_data_sol DEFINITION
   PUBLIC
   FINAL
   CREATE PUBLIC .

   PUBLIC SECTION.
     INTERFACES if_oo_adt_classrun.

   PROTECTED SECTION.
   PRIVATE SECTION.
ENDCLASS.


CLASS ZGENERATOR_AGENCY_DATA_SOL IMPLEMENTATION.

   METHOD if_oo_adt_classrun~main.

*     DELETE FROM zagencysol_e.
*     "EXIT.

     "delete existing data
     DELETE FROM zagencysol.
     DELETE FROM zagencysol_d.
     "EXIT.                     "PS: uncomment this line if you only want to delete data from databases.

     "insert demo agency data
     INSERT zagencysol  FROM (
         SELECT
           FROM /dmo/agency AS agency
           FIELDS
             uuid(  ) AS uuid,
             agency~agency_id      AS agency_id,
             agency~name           AS agency_name,
             agency~street         AS street,
             agency~postal_code    AS postal_code,
             agency~city           AS city,
             agency~country_code   AS country_code,
             agency~phone_number   AS phone_number ,
             agency~email_address  AS email_address,
             agency~web_address    AS web_address
             ORDER BY agency_id UP TO 5 ROWS
       ).
     COMMIT WORK.
     out->write( |[RAP120] Demo agency data successfully generated.  | ).
   ENDMETHOD.
ENDCLASS.
