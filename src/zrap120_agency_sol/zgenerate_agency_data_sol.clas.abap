 CLASS zgenerate_agency_data_sol DEFINITION
   PUBLIC
   FINAL
   CREATE PUBLIC .

   PUBLIC SECTION.
     INTERFACES if_oo_adt_classrun.

   PROTECTED SECTION.
   PRIVATE SECTION.
 ENDCLASS.


 CLASS zgenerate_agency_data_sol IMPLEMENTATION.

   METHOD if_oo_adt_classrun~main.

     DATA: agencies  TYPE TABLE OF zagencysol.

*     DELETE FROM zagencysol_e.
*     "EXIT.

     "delete existing data
     DELETE FROM zagencysol.
     DELETE FROM zagencysol_d.

     "insert demo agency data
     agencies = VALUE #(
        ( uuid = 'C68D1DF0F7B5ED251900D4AECE7F7813' agency_id = '070001' agency_name = 'Sunshine Travel' street = '134 West Street' postal_code = '54323' city = 'Rochester' country_code = 'US' phone_number = '+1 901-632-5620'
        email_address = 'info@sunshine-travel.sap' web_address = 'http://www.sunshine-travel.sap' local_created_by = '' local_created_at = '0.0000000 ' local_last_changed_by = '' local_last_changed_at = '0.0000000 ' last_changed_at = '0.0000000 '  )
        (  uuid = 'C78D1DF0F7B5ED251900D4AECE7F7813' agency_id = '070002' agency_name = 'Fly High' street = 'Berliner Allee 11' postal_code = '40880' city = 'Duesseldorf' country_code = 'DE' phone_number = '+49 2102 69555'
        email_address = 'info@flyhigh.sap' web_address = 'http://www.flyhigh.sap' local_created_by = '' local_created_at = '0.0000000 ' local_last_changed_by = '' local_last_changed_at = '0.0000000 ' last_changed_at = '0.0000000 '  )
        (  uuid = 'C88D1DF0F7B5ED251900D4AECE7F7813' agency_id = '070003' agency_name = 'Happy Hopping' street = 'Calvinstr. 36' postal_code = '13467' city = 'Berlin' country_code = 'DE' phone_number = '+49 30-8853-0'
        email_address = 'info@haphop.sap' web_address = 'http://www.haphop.sap' local_created_by = '' local_created_at = '0.0000000 ' local_last_changed_by = '' local_last_changed_at = '0.0000000 ' last_changed_at = '0.0000000 '  )
        (  uuid = 'C98D1DF0F7B5ED251900D4AECE7F7813' agency_id = '070004' agency_name = 'Pink Panther' street = 'Auf der Schanz 54' postal_code = '65936' city = 'Frankfurt' country_code = 'DE' phone_number = '+49 69-467653-0'
        email_address = 'info@pinkpanther.sap' web_address = 'http://www.pinkpanther.sap' local_created_by = '' local_created_at = '0.0000000 ' local_last_changed_by = '' local_last_changed_at = '0.0000000 ' last_changed_at = '0.0000000 '  )
        (  uuid = 'CA8D1DF0F7B5ED251900D4AECE7F7813' agency_id = '070005' agency_name = 'Your Choice' street = 'Gustav-Jung-Str. 425' postal_code = '90455' city = 'Nuernberg' country_code = 'DE' phone_number = '+49 9256-4548-0'
        email_address = 'info@yc.sap' web_address = 'http://www.yc.sap' local_created_by = '' local_created_at = '0.0000000 ' local_last_changed_by = '' local_last_changed_at = '0.0000000 ' last_changed_at = '0.0000000 '  )
         ).

*    insert the new table entries
     INSERT zagencysol FROM TABLE @agencies.

     COMMIT WORK.
     out->write( |[RAP120] Demo agency data successfully generated.  | ).
   ENDMETHOD.
 ENDCLASS.
