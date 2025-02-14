[Home - RAP120](../../README.md)

# Exercise 7: Add a determination and enhance it with the ABAP AI SDK powered by ISLM

## Introduction

In the previous exercise, you've learned to utilze the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM) (_see [Exercise 6](../ex06/README.md)_).

In this exercise, you will learn how to instantiate the ABAP AI SDK and call it within a determination named **`setDescription`** to integrate AI capabilities into your RAP business object.

### Exercises

- [7.1 - Define and implement new method in ABAP helper class](#exercise-71-define-and-implement-a-new-method-in-the-abap-helper-class)
- [7.2 - Define and implement the determination](#exercise-72-define-and-implement-the-determination)
- [7.3 - Preview and test the enhanced Travel App](#exercise-73-preview-and-test-the-enhanced-travel-app)
- [Summary](#summary)  

> ℹ️ **Reminder**: Do not forget to replace the suffix placeholder **`###`** with your choosen or assigned group ID in the exercise steps below. 

## Exercise 7.1: Define and implement a new method in the ABAP helper class
[^Top of page](#Introduction)

>  Define and implement a new method named **`generate_description`** in the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`**.

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Go to the ABAP class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** and define the **`generate_description`** method 

     ```ABAP
       METHODS: generate_description RETURNING VALUE(rv_description) TYPE /dmo/description.
     ```

  2. Replace the implementation of the method **`generate_description`** with the source code provided below.

     ```ABAP
           METHOD generate_description.

           TRY.
             FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120_AI_###' ).
           CATCH cx_aic_api_factory INTO DATA(lx_api).
            rv_description = ''.
           ENDTRY.

           TRY.
             DATA(messages) = api->create_message_container( ).
             messages->set_system_role( 'You are a travel agent expert' ).
             messages->add_user_message( 'Generate a travel destination description. It should be less than 100 characters' ).
             rv_description = api->execute_for_messages( messages )->get_completion( ).
           CATCH cx_aic_completion_api INTO DATA(lx_completion).
             rv_description = ''.
           ENDTRY.

         ENDMETHOD.
     ```

     The complete updated source code in the class should now look like this:   

     ```ABAP
         CLASS zcl_travel_helper_### DEFINITION
         PUBLIC
         FINAL
         CREATE PUBLIC .

         PUBLIC SECTION.
           INTERFACES if_oo_adt_classrun.
           METHODS: validate_customer IMPORTING iv_customer_id TYPE /dmo/customer_id RETURNING VALUE(rv_exists) TYPE abap_bool.
           METHODS: get_booking_status IMPORTING iv_status TYPE /dmo/booking_status_text RETURNING VALUE(rv_status) TYPE /dmo/booking_status.
           METHODS: generate_description RETURNING VALUE(rv_description) TYPE string.
         PROTECTED SECTION.
         PRIVATE SECTION.
       ENDCLASS.


       CLASS zcl_travel_helper_### IMPLEMENTATION.

         METHOD if_oo_adt_classrun~main.
           "We will use this method to test the ABAP AI SDK
           TRY.
             FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120_AI_###' ).
           CATCH cx_aic_api_factory INTO DATA(lx_api).
             out->write( |There was an issue with the factory api: { lx_api->get_longtext(  ) }| ).
           ENDTRY.

           TRY.
             DATA(messages) = api->create_message_container( ).
             messages->set_system_role( 'You are an expert in ABAP Cloud development.' ).
             messages->add_user_message( 'How to implement a BO step by step?' ).
             DATA(answer) = api->execute_for_messages( messages )->get_completion( ).
             out->write( answer ).
           CATCH cx_aic_completion_api INTO DATA(lx_completion).
               out->write( |There was an issue with the completion api: { lx_completion->get_longtext(  ) }| ).
           ENDTRY.
         ENDMETHOD. 

         METHOD validate_customer.
           rv_exists = abap_false.
           SELECT FROM /dmo/customer FIELDS customer_id
               WHERE customer_id = @iv_customer_id
           INTO TABLE @DATA(customers).

           IF customers IS NOT INITIAL.
             rv_exists = abap_true.
           ENDIF.
         ENDMETHOD.

         METHOD get_booking_status.
           CASE iv_status.
             WHEN 'Booked'.
               rv_status = 'B'.
             WHEN 'New'.
               rv_status = 'N'.
             WHEN 'Cancelled'.
               rv_status = 'X'.
           ENDCASE.
         ENDMETHOD.

         METHOD generate_description.
           "This method will be called in the determination setDescription
           TRY.
             FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120_AI_###' ).
           CATCH cx_aic_api_factory INTO DATA(lx_api).
            rv_description = ''.
           ENDTRY.

           TRY.
             DATA(messages) = api->create_message_container( ).
             messages->set_system_role( 'You are a travel agent expert' ).
             messages->add_user_message( 'Generate a travel destination description. It should be less than 100 characters' ).
             rv_description = api->execute_for_messages( messages )->get_completion( ).
           CATCH cx_aic_completion_api INTO DATA(lx_completion).
             rv_description = ''.
           ENDTRY.
         ENDMETHOD.

       ENDCLASS.
     ```
 
  4.  Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes.

</details>


## Exercise 7.2: Define and implement the determination
[^Top of page](#Introduction)

> Define the determination **`setDescription`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL_###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Go to the behavior definiton ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`** and define the following determination:

     ```BDL 
       determination setDescription on modify { create; }
     ```
 
  2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`**.
 
  3. Declare the required method in behavior implementation class [](images/adt_class.png) **`ZBP_R_TRAVEL_###`** using ADT Quick Fix (**Ctrl + 1**).
 
  4. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL_###`**. 
 
  5. Please complete the **`setDescription`** implementation by incorporating the code provided below.

     Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID/suffix.

     ```ABAP
       METHOD setDescription.

         DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).

         READ ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
         ENTITY Travel
           FIELDS ( Description ) WITH CORRESPONDING #( keys )
           RESULT DATA(lt_travel).

         DELETE lt_travel WHERE Description IS NOT INITIAL.
         CHECK lt_travel IS NOT INITIAL.

         MODIFY ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
           ENTITY Travel
             UPDATE FIELDS ( Description )
             WITH VALUE #( FOR key IN lt_travel ( %tky   = key-%tky
                                                  Description = lo_travel_helper->generate_description(  )  ) )
           REPORTED DATA(update_reported).

         reported = CORRESPONDING #( DEEP update_reported ).
       ENDMETHOD.
     ```

     The complete updated source code in the class should look like this: 

     ```ABAP
       CLASS LHC_ZR_TRAVEL_### DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
         PRIVATE SECTION.
           METHODS:
             GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
               IMPORTING
                 REQUEST requested_authorizations FOR Travel
               RESULT result,
             validateCustomer FOR VALIDATE ON SAVE
                   IMPORTING keys FOR Travel~validateCustomer,
             setInitialTravelStatus FOR DETERMINE ON MODIFY
                   IMPORTING keys FOR Travel~setInitialTravelStatus,
             setDescription FOR DETERMINE ON MODIFY
                   IMPORTING keys FOR Travel~setDescription.
       ENDCLASS.

       CLASS LHC_ZR_TRAVEL_### IMPLEMENTATION.
         METHOD GET_GLOBAL_AUTHORIZATIONS.
         ENDMETHOD.

         METHOD validateCustomer.
           "ABAP EML to read the field CustomerId from CDS view ZR_TRAVEL_###
             READ ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
                 ENTITY Travel
                   FIELDS ( CustomerID )
                   WITH CORRESPONDING #( keys )
                 RESULT DATA(lt_travel).


               LOOP AT lt_travel INTO DATA(travel).
                 DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).
                 DATA(customer_id) = travel-CustomerID.

                 IF customer_id IS INITIAL.
                     APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
                     APPEND VALUE #( %tky                = travel-%tky
                                     %state_area         = 'VALIDATE_CUSTOMER'
                                     %msg                = NEW /dmo/cm_flight_messages( textid   = /dmo/cm_flight_messages=>enter_customer_id
                                                                                       severity = if_abap_behv_message=>severity-error )
                                     %element-CustomerID = if_abap_behv=>mk-on
                                   ) TO reported-travel.


                 ELSEIF lo_travel_helper->validate_customer( customer_id ) = abap_false.

                 APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
                 APPEND VALUE #( %tky                = travel-%tky
                                 %state_area         = 'VALIDATE_CUSTOMER'
                                 %msg                = NEW /dmo/cm_flight_messages( textid      = /dmo/cm_flight_messages=>customer_unkown
                                                                                   customer_id = travel-CustomerId
                                                                                   severity    = if_abap_behv_message=>severity-error )
                                 %element-CustomerID = if_abap_behv=>mk-on
                                 ) TO reported-travel.
                 ENDIF.
               ENDLOOP.
         ENDMETHOD.

         METHOD setInitialTravelStatus.

           DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).

           "1) ABAP EML to read the field Status from CDS view ZR_TRAVEL_###
           READ ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
             ENTITY Travel
               FIELDS ( Status ) WITH CORRESPONDING #( keys )
               RESULT DATA(lt_travel).

           "2) If Status is already set, do nothing, i.e. remove such instances
           DELETE lt_travel WHERE Status IS NOT INITIAL.
           CHECK lt_travel IS NOT INITIAL.

           "3) ABAP EML to update the field Status in CDS view ZR_TRAVEL_###. Use variable update_reported
           MODIFY ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
             ENTITY Travel
               UPDATE FIELDS ( Status )
               WITH VALUE #( FOR key IN lt_travel ( %tky   = key-%tky
                                                   Status = lo_travel_helper->get_booking_status( 'New' )  ) )
             REPORTED DATA(update_reported).

           "4) Set the changing parameter reported
           reported = CORRESPONDING #( DEEP update_reported ).

         ENDMETHOD.

         METHOD setDescription.

           DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).

           READ ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
           ENTITY Travel
             FIELDS ( Description ) WITH CORRESPONDING #( keys )
             RESULT DATA(lt_travel).

           DELETE lt_travel WHERE Description IS NOT INITIAL.
           CHECK lt_travel IS NOT INITIAL.

           MODIFY ENTITIES OF ZR_TRAVEL_### IN LOCAL MODE
             ENTITY Travel
               UPDATE FIELDS ( Description )
               WITH VALUE #( FOR key IN lt_travel ( %tky   = key-%tky
                                                   Description = lo_travel_helper->generate_description(  )  ) )
             REPORTED DATA(update_reported).

           reported = CORRESPONDING #( DEEP update_reported ).
         ENDMETHOD.

       ENDCLASS.
     ```

  6. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL_###`**.  

</details>


## Exercise 7.3: Preview and test the enhanced Travel App
[^Top of page](#Introduction)
<details>
  <summary>🔵 Click to expand!</summary>

  1. Refresh your application in the browser using **F5** if the browser is still open   
    or go to your service binding ![service binding](images/adt_srvb.png)**`ZUI_TRAVEL_###_04`** and start the Fiori elements App preview for the **`Travel`** entity set.
 
  2. Create a new _Travel_ instance. 
 
     The **`Description`** field should now be set automatically by the determination `setInitialTravelStatus` you've just implemented. It means that the initial description of the created entity should now be set coming from the LLM output through the ABAP AI SDK powered by ISLM. 
    
</details>


## Summary
[^Top of page](#Introduction)

Now that you've... 
- defined and implemented a determination
- enhanced the determination using ABAP AI SDK

Thank you for attending this workshop! 🎉🎉🎉

[Home - RAP120](../../README.md)

---
