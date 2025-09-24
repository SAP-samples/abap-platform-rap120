[Home - RAP120](../../README.md)

# Exercise 6: Add a determination and enhance it with the ABAP AI SDK powered by ISLM

## Introduction

In the exercises 1-5, you've created a SAP Fiori elements based _Travel_ app to process travel data.

> ℹ️ **Important note**: To complete the present exercise, you must have completed at least _[Exercise 1](../ex01/README.md)_. 

In this exercise, you will learn how to use the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM). It is the official client to consume large language models in ABAP. You will also learn how to instantiate the ABAP AI SDK and call it within a determination named **`setSightseeingTips`** to integrate AI capabilities into your RAP business object.

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
- [6.2 - Define and implement the determination with Predict RAP Business Logic](#exercise-62-define-and-implement-the-determination-with-Predict-RAP-Business-Logic)
- [6.3 - Preview and test the enhanced Travel App](#exercise-63-preview-and-test-the-enhanced-travel-app)
- [Summary](#summary)  

> ℹ️ **Reminder**: Do not forget to replace the suffix placeholder **`###`** with your choosen or assigned group ID in the exercise steps below. 

## Exercise 6.1: Define and implement a new method in the ABAP helper class
[^Top of page](#Introduction)

>  Define and implement a new method named **`get_sightseeing_tips`** in the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`**.

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Replace the implementation of the method **`get_sightseeing_tips`** with the source code provided below.

      > ⚠️ **Please note** ⚠️
      > - If you're using your own system, please ensure that the [ABAP AI SDK powered by ISLM setup](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/set-up-abap-ai-sdk-powered-by-intelligent-scenario-lifecycle-management?locale=en-US) is correct and then [create an intelligent scenario and an intelligent scenario model](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/creating-intelligent-scenario-and-intelligent-scenario-model?locale=en-US).
      > - If you're participating in SAP-led Event, such as DSAG, TechXChange, etc the **`islm_scenario`** parameter will be provided below in the code snippet.

      
     ```ABAP
         METHOD get_sightseeing_tips.
            " We will call an LLM to generate the sightseeing tips for a given city using the ABAP AI SDK powered by ISLM


              DATA(system_prompt) = | You support by giving sightseeing tips for a given city. | &&
                                    | Write a short summary of the 10 top most sightseeing tips | &&
                                    | using a brief listing without a caption | &&
                                    | It should be less 1000 characters. |.
              " User specific promt, including the city selection from the UI
              DATA(user_prompt)   = |The city is { iv_city }.|.

              " create an instance of the ABAP AI SDK using the get method of cl_aic_islm_compl_api_factory and islm_scenario 'ZINTS_RAP120'
              TRY.
                FINAL(api) =  cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120' ).
              CATCH cx_aic_api_factory INTO DATA(lx_api).
                rv_sightseeing_tips = ''.
              ENDTRY.

              TRY.
                FINAL(message_container) = api->create_message_container( ).
                message_container->set_system_role( system_prompt ).
                message_container->add_user_message( user_prompt ).
                rv_sightseeing_tips = api->execute_for_messages( message_container )->get_completion( ).
              CATCH cx_aic_completion_api INTO DATA(lx_completion).
                rv_sightseeing_tips = ''.
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
           METHODS: get_sightseeing_tips IMPORTING iv_city TYPE /dmo/city RETURNING VALUE(rv_sightseeing_tips) TYPE /dmo/description.
         PROTECTED SECTION.
         PRIVATE SECTION.
       ENDCLASS.


       CLASS zcl_travel_helper_### IMPLEMENTATION. 

         METHOD validate_customer.
          SELECT SINGLE
            FROM /dmo/customer
            FIELDS @abap_true AS line_exists
            WHERE customer_id = @iv_customer_id
            INTO @rv_exists.
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

         METHOD get_sightseeing_tips.
            " We will call an LLM to generate the sightseeing tips for a given city using the ABAP AI SDK powered by ISLM

              DATA(system_prompt) = | You support by giving sightseeing tips for a given city. | &&
                                    | Write a short summary of the 10 top most sightseeing tips | &&
                                    | using a brief listing without a caption | &&
                                    | It should be less 1000 characters. |.
              " User specific prompt, including the city selection from the UI
              DATA(user_prompt)   = |The city is { iv_city }.|.

              " create an instance of the ABAP AI SDK powered by ISLM
              TRY.
                FINAL(api) =  cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120' ).
              CATCH cx_aic_api_factory INTO DATA(lx_api).
                rv_sightseeing_tips = ''.
              ENDTRY.

              TRY.
                FINAL(message_container) = api->create_message_container( ).
                message_container->set_system_role( system_prompt ).
                message_container->add_user_message( user_prompt ).
                rv_sightseeing_tips = api->execute_for_messages( message_container )->get_completion( ).
              CATCH cx_aic_completion_api INTO DATA(lx_completion).
                rv_sightseeing_tips = ''.
              ENDTRY.
          ENDMETHOD.

       ENDCLASS.
     ```
  4.  Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes.

</details>


## Exercise 6.2: Define and implement the determination with Predict RAP Business Logic💎
[^Top of page](#Introduction)

> Define the determination **`setSightseeingTips`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Define the **`setSightseeingTips`** determination:

  ```BDL
    determination setSightseeingTips on modify { create; }
  ```
 
  2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**.
 
  3. Declare the required method in behavior implementation class [](images/adt_class.png) **`ZBP_R_TRAVEL###`** using ADT Quick Fix *Ctrl/Cmd + 1*.
 
  4. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**. 

  5. Let's implement the determination **`setSightseeingTips`** using **Predict RAP Business Logic 💎**. In your implementaion class ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`** , position the cursor on **`setSightseeingTips`** method implementation.

  6. Enter the following the description in the **Method Description** section. Then, press **Run**.
   
   Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID/suffix.
   
   ```
    Instantiate a helper class zcl_travel_helper_###. 
    Read the SightseeingsTips field from the Travel entity. 
    Check if SightseeingsTips is empty and then call get_sightseeing_tips to generate sightseeing tips based on the Destination field.
    Update the SightseeingsTips field with the generated value.

   ```

  7. Your code should look something like this:

     Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID/suffix.

     ```ABAP
       METHOD setSightseeingTips.

        DATA(lo_travel_helper) = NEW zcl_travel_helper_###( ).

        READ ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
          ENTITY Travel
            FIELDS ( Destination SightseeingTips )
            WITH CORRESPONDING #( keys )
          RESULT DATA(lt_travels).

        LOOP AT lt_travels INTO DATA(ls_travel).
          IF ls_travel-SightseeingTips IS INITIAL.
            DATA(lv_tips) = lo_travel_helper->get_sightseeing_tips( ls_travel-Destination ).
            MODIFY ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
              ENTITY Travel
                UPDATE FIELDS ( SightseeingTips )
                WITH VALUE #(
                  ( %tky = ls_travel-%tky
                    SightseeingTips = lv_tips )
                ).
          ENDIF.
        ENDLOOP.
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
             setSightseeingTips FOR DETERMINE ON MODIFY
                   IMPORTING keys FOR Travel~setSightseeingTips.
       ENDCLASS.

       CLASS LHC_ZR_TRAVEL### IMPLEMENTATION.
         METHOD GET_GLOBAL_AUTHORIZATIONS.
         ENDMETHOD.

         METHOD validateCustomer.
          DATA(lo_travel_helper) = NEW zcl_travel_helper_###( ).

          READ ENTITIES OF zr_travel### IN LOCAL MODE
            ENTITY Travel
              FIELDS ( CustomerID )
              WITH CORRESPONDING #( keys )
            RESULT DATA(lt_travel).

          LOOP AT lt_travel INTO DATA(ls_travel).
            IF ls_travel-CustomerID IS INITIAL OR
              lo_travel_helper->validate_customer( ls_travel-CustomerID ) = abap_false.
              APPEND VALUE #( %tky = ls_travel-%tky ) TO failed-Travel.
              APPEND VALUE #(
                  %tky        = ls_travel-%tky
                  %state_area = 'Validation'
                  %msg        = new_message_with_text(
                                  text     = 'Invalid or missing CustomerID'
                                  severity = if_abap_behv_message=>severity-error
                                )
              ) TO reported-Travel.
            ENDIF.
          ENDLOOP.
         ENDMETHOD.

         METHOD calcTotalTravelPrice.
           "1) Read Travel and Booking entities
          READ ENTITIES OF zr_travel### IN LOCAL MODE
            ENTITY travel
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(lt_travel)
          ENTITY travel BY \_Booking
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lt_booking).

          "Let's add this
          DATA(current_total_price) = VALUE #( lt_travel[ 1 ]-TotalPrice OPTIONAL ).
          DATA(booking_fee) = VALUE #( lt_travel[ 1 ]-BookingFee OPTIONAL ).
          DATA(currency_code) = VALUE #( lt_booking[ 1 ]-CurrencyCode OPTIONAL ).

          "2)Calculate the total flight price of the bookings using reduce operator in calculated_total_price variable
          DATA(calculated_total_price) = REDUCE i( INIT sum TYPE i FOR booking IN lt_booking NEXT sum += booking-FlightPrice ).

          "Let's add this
          calculated_total_price += booking_fee.

          "3)Update the total price of the Travel
          IF current_total_price <> calculated_total_price.
            MODIFY ENTITIES OF zr_travel### IN LOCAL MODE
            ENTITY travel
              UPDATE
                FIELDS ( TotalPrice CurrencyCode )
                WITH VALUE #( FOR key IN keys
                                  ( %tky            = key-%tky
                                    TotalPrice      = calculated_total_price
                                    CurrencyCode    = currency_code ) )
            REPORTED DATA(reported_modify).
          ENDIF.
         ENDMETHOD.

       METHOD setSightseeingTips.

        DATA(lo_travel_helper) = NEW zcl_travel_helper_###( ).

        READ ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
          ENTITY Travel
            FIELDS ( Destination SightseeingTips )
            WITH CORRESPONDING #( keys )
          RESULT DATA(lt_travels).

        LOOP AT lt_travels INTO DATA(ls_travel).
          IF ls_travel-SightseeingTips IS INITIAL.
            DATA(lv_tips) = lo_travel_helper->get_sightseeing_tips( ls_travel-Destination ).
            MODIFY ENTITIES OF ZR_TRAVEL### IN LOCAL MODE
              ENTITY Travel
                UPDATE FIELDS ( SightseeingTips )
                WITH VALUE #(
                  ( %tky = ls_travel-%tky
                    SightseeingTips = lv_tips )
                ).
          ENDIF.
        ENDLOOP.
       ENDMETHOD.

       ENDCLASS.
     ```

  6. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

  
  ![](/exercises/ex06/images/rap120_ex62.gif)

</details>


## Exercise 6.3: Preview and test the enhanced Travel App
[^Top of page](#Introduction)
<details>
  <summary>🔵 Click to expand!</summary>

  1. Refresh your application in the browser using **F5** if the browser is still open   
    or go to your service binding ![service binding](images/adt_srvb.png)**`ZUI_TRAVEL_###_04`** and start the Fiori elements App preview for the **`Travel`** entity set.
 
  2. Create a new _Travel_ instance. 
 
     The **`SightseeingTips`** field should now be set automatically by the determination **`setSightseeingTips`** that you've just implemented. This means that the initial sightseeing tips for the new Travel will be provided from the LLM output via the ABAP AI SDK powered by ISLM.

 ![](/exercises/ex06/images/rap120_ex63.gif)
    
</details>


## Summary
[^Top of page](#Introduction)

Now that you've... 
- defined and implemented a determination using **Predict RAP Business Logic 💎**
- enhanced the determination using **ABAP AI SDK powered by ISLM**

Thank you for attending this workshop! 🎉🎉🎉

As **optional**, you can continue with the next exercise – **[Exercise 7: Try out the ABAP Cloud Generator: Transactional App from Scratch](../ex07/README.md)**

[Home - RAP120](../../README.md)

---
