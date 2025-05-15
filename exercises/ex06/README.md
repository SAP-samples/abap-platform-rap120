[Home - RAP120](../../README.md)

# Exercise 6: Add a determination and enhance it with the ABAP AI SDK powered by ISLM

## Introduction

In the exercises 1-5, you've created a SAP Fiori elements based _Travel_ app to process travel data. In the previous exercise, you've defined and implemented a determination called **`setInitialTravelStatus`**, which is used to set a default value for the overall status of a _Travel_ entity instance (_see [Exercise 5](../ex05/README.md)_).  
> ℹ️ **Important note**: To complete the present exercise, you must have completed at least _[Exercise 1](../ex01/README.md)_. The exercises 2-5 are optional.

In this exercise, you will learn how to use the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM). It is the official client to consume large language models in ABAP. You will also learn how to instantiate the ABAP AI SDK and call it within a determination named **`setDescription`** to integrate AI capabilities into your RAP business object.

#### About ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM)
<details>
  <summary>ℹ️Click to expand!</summary>

  ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM) is an ABAP re-use library that supports you to interact with large language models (LLMs) hosted on the generative AI hub in SAP AI Core. With the ABAP AI SDK, you can build your own AI-based features in ABAP.

  As an ABAP developer, you can access large language models from within your ABAP system. The ABAP AI SDK powered by ISLM is designed to standardize and ease the access to large language models and provide convenient features for ABAP developers. The ISLM and ABAP AI SDK integration offers a unified solution for business and technical use cases, facilitating prompt execution within the context of business applications.
    
  ABAP AI SDK powered by ISLM is the official client to consume large language models in ABAP. 

  > ℹ️ Curious to learn more about ABAP AI SDK powered by ISLM?   
  Check out the [Developing your own AI-enabled applications | SAP Help Portal](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/developing-your-own-ai-enabled-applications?locale=en-US) or the Devtoberfest 2024 session [Integrating Generative AI in SAP S/4HANA with ISLM](https://www.youtube.com/watch?v=SezO4_HTHfQ)

 </details>

### Exercises

- [6.1 - Define and implement new method in ABAP helper class](#exercise-61-define-and-implement-a-new-method-in-the-abap-helper-class)
- [6.2 - Define and implement the determination](#exercise-62-define-and-implement-the-determination)
- [6.3 - Preview and test the enhanced Travel App](#exercise-63-preview-and-test-the-enhanced-travel-app)
- [Summary](#summary)  

> ℹ️ **Reminder**: Do not forget to replace the suffix placeholder **`###`** with your choosen or assigned group ID in the exercise steps below. 

## Exercise 6.1: Define and implement a new method in the ABAP helper class
[^Top of page](#Introduction)

>  Define and implement a new method named **`generate_description`** in the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`**.

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Go to the ABAP class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** and define the **`generate_description`** method 

     ```ABAP
       METHODS: generate_description IMPORTING iv_city TYPE /dmo/city RETURNING VALUE(rv_description) TYPE /dmo/description.
     ```

  2. Replace the implementation of the method **`generate_description`** with the source code provided below.

      > ⚠️ **Please note** ⚠️
      > - If you're using your own system, please ensure that the [ABAP AI SDK powered by ISLM setup](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/set-up-abap-ai-sdk-powered-by-intelligent-scenario-lifecycle-management?locale=en-US) is correct and then [create an intelligent scenario and an intelligent scenario model](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/creating-intelligent-scenario-and-intelligent-scenario-model?locale=en-US).
      > - If you're participating in SAP-led Event, such as DSAG, TechXChange, etc the **`islm_scenario`** parameter will be provided below in the code snippet.

      
     ```ABAP
           METHOD generate_description.

           TRY.
           "If you're using your own system, replace ZINTS_RAP120 with your own ISLM Scenario '
             FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120' ).
           CATCH cx_aic_api_factory INTO DATA(lx_api).
            rv_description = ''.
           ENDTRY.

           TRY.
             DATA(messages) = api->create_message_container( ).
             messages->set_system_role( 'You are a travel agent expert' ).
             messages->add_user_message( 'Generate a travel description for ' && iv_city && '.It should be less than 100 characters' ).
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
           METHODS: validate_customer IMPORTING iv_customer_id TYPE /dmo/customer_id RETURNING VALUE(rv_exists) TYPE abap_bool.
           METHODS: get_booking_status IMPORTING iv_status TYPE /dmo/booking_status_text RETURNING VALUE(rv_status) TYPE /dmo/booking_status.
           METHODS: generate_description IMPORTING iv_city TYPE /dmo/city RETURNING VALUE(rv_description) TYPE /dmo/description
         PROTECTED SECTION.
         PRIVATE SECTION.
       ENDCLASS.


       CLASS zcl_travel_helper_### IMPLEMENTATION. 

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
           "If you're using your own system, replace ZINTS_RAP120 with your own ISLM Scenario '
             FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120' ).
           CATCH cx_aic_api_factory INTO DATA(lx_api).
            rv_description = ''.
           ENDTRY.

           TRY.
             DATA(messages) = api->create_message_container( ).
             messages->set_system_role( 'You are a travel agent expert' ).
             messages->add_user_message( 'Generate a travel description for ' && iv_city && '.It should be less than 100 characters' ).
             rv_description = api->execute_for_messages( messages )->get_completion( ).
           CATCH cx_aic_completion_api INTO DATA(lx_completion).
             rv_description = ''.
           ENDTRY.
         ENDMETHOD.

       ENDCLASS.
     ```
  4.  Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes.

</details>


## Exercise 6.2: Define and implement the determination
[^Top of page](#Introduction)

> Define the determination **`setDescription`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Go to the behavior definiton ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**  
  
  Add the **`Destination`** as mandatory field:

  ```BDL
    field ( mandatory : create )
      Destination;
  ```  

  Then, define the **`setDescription`** determination:

  ```BDL
    determination setDescription on modify { create; }
  ```
 
  2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**.
 
  3. Declare the required method in behavior implementation class [](images/adt_class.png) **`ZBP_R_TRAVEL###`** using ADT Quick Fix (**Ctrl + 1**).
 
  4. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**. 
 
  5. Please complete the **`setDescription`** implementation by incorporating the code provided below.

     Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID/suffix.

     ```ABAP
       METHOD setDescription.

         DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).

         READ ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
         ENTITY Travel
           FIELDS ( Description ) WITH CORRESPONDING #( keys )
           RESULT DATA(lt_travel).

         DELETE lt_travel WHERE Description IS NOT INITIAL.
         CHECK lt_travel IS NOT INITIAL.

         MODIFY ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
           ENTITY Travel
             UPDATE FIELDS ( Description )
             WITH VALUE #( FOR key IN lt_travel ( %tky   = key-%tky
                                                  Description = lo_travel_helper->generate_description(  key-Destination )  ) )
           REPORTED DATA(update_reported).

         reported = CORRESPONDING #( DEEP update_reported ).
       ENDMETHOD.
     ```

     The complete updated source code in the class should look like this: 

     ```ABAP
       CLASS LHC_ZR_TRAVEL### DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
         PRIVATE SECTION.
           METHODS:
             GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
               IMPORTING
                 REQUEST requested_authorizations FOR Travel
               RESULT result,
             validateCustomer FOR VALIDATE ON SAVE
                   IMPORTING keys FOR Travel~validateCustomer,
             calcTotalTravelPrice FOR DETERMINE ON SAVE
                   IMPORTING keys FOR Travel~calcTotalTravelPrice,
             setDescription FOR DETERMINE ON MODIFY
                   IMPORTING keys FOR Travel~setDescription.
       ENDCLASS.

       CLASS LHC_ZR_TRAVEL### IMPLEMENTATION.
         METHOD GET_GLOBAL_AUTHORIZATIONS.
         ENDMETHOD.

         METHOD validateCustomer.
           "ABAP EML to read the field CustomerId from CDS view ZR_TRAVEL###
             READ ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
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

         METHOD calcTotalTravelPrice.
          "1) Read Travel and Booking entities
            READ ENTITIES OF zr_travel003 IN LOCAL MODE
              ENTITY travel
              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_travel)
            ENTITY travel BY \_Booking
              ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(lt_booking).

            DATA(lv_total_price) = VALUE #( lt_travel[ 1 ]-TotalPrice OPTIONAL ).
            DATA(lv_currency_code) = VALUE #( lt_booking[ 1 ]-CurrencyCode OPTIONAL ).

            "2)Calculate the total price. Use reduce operator
            DATA(total_price) = REDUCE /dmo/total_price( INIT sum TYPE /dmo/total_price
                                                                      FOR booking IN lt_booking
                                                                      NEXT sum     = sum + booking-FlightPrice ).
            "3)Update the total price of the Travel
            IF lv_total_price <> total_price.
              MODIFY ENTITIES OF zr_travel003 IN LOCAL MODE
              ENTITY travel
                UPDATE
                  FIELDS ( TotalPrice CurrencyCode )
                  WITH VALUE #( FOR key IN keys
                                    ( %tky            = key-%tky
                                      TotalPrice      = total_price
                                      CurrencyCode    = lv_currency_code ) )
              REPORTED DATA(reported_modify).
            ENDIF.
         ENDMETHOD.

         METHOD setDescription.

           DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).

           READ ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
           ENTITY Travel
             FIELDS ( Description ) WITH CORRESPONDING #( keys )
             RESULT DATA(lt_travel).

           DELETE lt_travel WHERE Description IS NOT INITIAL.
           CHECK lt_travel IS NOT INITIAL.

           MODIFY ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
             ENTITY Travel
               UPDATE FIELDS ( Description )
               WITH VALUE #( FOR key IN lt_travel ( %tky   = key-%tky
                                                   Description = lo_travel_helper->generate_description( key-Destination )  ) )
             REPORTED DATA(update_reported).

           reported = CORRESPONDING #( DEEP update_reported ).
         ENDMETHOD.

       ENDCLASS.
     ```

  6. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

  
  ![](/exercises/ex06/images/rap120_2505_ex62.gif)

</details>


## Exercise 6.3: Preview and test the enhanced Travel App
[^Top of page](#Introduction)
<details>
  <summary>🔵 Click to expand!</summary>

  1. Refresh your application in the browser using **F5** if the browser is still open   
    or go to your service binding ![service binding](images/adt_srvb.png)**`ZUI_TRAVEL_###_04`** and start the Fiori elements App preview for the **`Travel`** entity set.
 
  2. Create a new _Travel_ instance. 
 
     The **`Description`** field should now be set automatically by the determination **`setDescription`** that you've just implemented. It means that the initial description of the created entity should now be set coming from the LLM output through the ABAP AI SDK powered by ISLM. 

 ![](/exercises/ex06/images/rap120_2505_ex63.gif)
    
</details>


## Summary
[^Top of page](#Introduction)

Now that you've... 
- defined and implemented a determination
- enhanced the determination using ABAP AI SDK

Thank you for attending this workshop! 🎉🎉🎉

**Optionally**, you can continue with the next exercise – **[Exercise 7: Try out the ABAP Cloud Generator: Transactional App from Scratch](../ex07/README.md)**

[Home - RAP120](../../README.md)

---
