*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
 CLASS lhe_agency DEFINITION INHERITING FROM cl_abap_behavior_event_handler.
   PRIVATE SECTION.
     METHODS get_uuid RETURNING VALUE(uuid) TYPE sysuuid_x16.

     METHODS on_entity_created FOR ENTITY EVENT
        created FOR agency~entity_created.
 ENDCLASS.


 CLASS lhe_agency IMPLEMENTATION.

   METHOD get_uuid.
     TRY.
         uuid = cl_system_uuid=>create_uuid_x16_static( ) .
       CATCH cx_uuid_error.
     ENDTRY.
   ENDMETHOD.

   METHOD on_entity_created.
     "close the active modify phase
     cl_abap_tx=>save( ).

     "loop over transfered instances and do the needful ;)
     LOOP AT created REFERENCE INTO DATA(lr_created).
       DATA lr_entity_created TYPE zagencysol_e.
       MOVE-CORRESPONDING lr_created->* TO lr_entity_created.
       lr_entity_created-uuid        = get_uuid( ).
       lr_entity_created-agency_id   = lr_created->agency_id.
       lr_entity_created-agency_name = lr_created->agency_name.
       lr_entity_created-created_by  = lr_created->created_by.
       lr_entity_created-created_at  = lr_created->created_at.

       "insert to db
       INSERT zagencysol_e FROM @lr_entity_created.
     ENDLOOP.
   ENDMETHOD.

 ENDCLASS.
