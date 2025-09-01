[Home - RAP120](../../README.md)

# Exercise 5: Add a determination

## Introduction

In the previous exercise, you've defined and implemented a backend validation called **`validateCustomer`** to verify if the customer ID entered is valid (_see [Exercise 4](../ex04/README.md)_).

In this exercise, you will now define and implement a determination called **`calcTotalTravelPrice`**, which will be used to set a default value for the overall status of a _Travel_ entity instance.  

### Exercises

- [5.1 - Define and implement the determination](#exercise-51-Define-and-implement-the-determination)
- [5.2 - Enhance determination with Joule Code Prediction Capability](#exercise-52-Enhance-determination-with-Joule-Code-Prediction-Capability)
- [5.3 -Preview and test the enhanced Travel App](#exercise-53-preview-and-test-the-enhanced-travel-app)
- [Summary & Next Exercise](#summary--next-exercise)

> ℹ️**Reminder**: Do not forget to replace the suffix placeholder **`###`** with your choosen or assigned group ID in the exercise steps below. 

<!-- ### About Determinations  
> A determination is an optional part of the business object behavior that modifies instances of business objects based on trigger conditions. A determination is implicitly invoked by the RAP framework if the trigger condition of the determination is fulfilled. Trigger conditions can be modify operations and modified fields.   
>  
> **Further reading**: [Determinations](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/determinations?version=Cloud)

<!--
ℹ️ **Exkurs**

 <details>
  <summary>Click to expand!</summary>

   ### About Entity Manipulation Language (EML)
   > The Entity Manipulation Language (EML) is an extension of the ABAP language which offers an API-based access to RAP business objects. EML is used to implement the transactional behavior of RAP BOs and also access existing RAP BOs from outside the RAP context.   
   > 
   > PS: Some EML statements can be used in the so-called local mode - by using the [addition **`IN LOCAL MODE`**](https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/index.htm?file=abapin_local_mode.htm) - to exclude feature controls and authorization checks. This addition can only be used in the behavior implementation (aka behavior pool) of a particular RAP BO when accessing its own instances, i. e. not for accessing instances of other RAP BOs.
   >
   > The EML reference documentation is provided in the ABAP Keyword Documentation.   
   > You can use the classic **F1 Help** to get detailed information on each statement by pressing **F1** in the ABAP editors. 
   >
   > **Further reading**: [Entity Manipulation Language (EML)](https://help.sap.com/docs/abap-cloud/abap-rap/entity-manipulation-language-eml?version=sap_btp) | [ABAP for RAP Business Objects](https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/index.htm?file=abenabap_for_rap_bos.htm)  
</details>
--> 

## Exercise 5.1: Define and implement the determination
[^Top of page](#Introduction)

> Define the determination **`calcTotalTravelPrice`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>

   <!-- 1. In the the behavior definiton ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**, define the fields **`TotalPrice`** and **`CurrencyCode`** fields as readonly

      ```ABAP
      managed implementation in class ZBP_R_TRAVEL### unique;
      strict ( 2 );
      with draft;
      extensible;
      define behavior for ZR_TRAVEL### alias Travel
      persistent table ZTRAVEL###
      extensible
      draft table ZTRAVEL_D###
      etag master LocalLastChangedAt
      lock master total etag LastChangedAt
      authorization master( global )

      {
        field ( readonly )
        Uuid,
        LocalCreatedBy,
        LocalCreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt,
        //Define TotalPrice and CurrencyCode as readonly
        TotalPrice,
        CurrencyCode;

        .......
      }
      ``` -->
   
   1. Go to the behavior definiton ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`** and add the following determination. The statement specifies the name of the new determination, **`calcTotalTravelPrice`** and **`on save`** as the determination time when creating and updating new _Travel_ instance (**`{ create; update; }`**)

      ```ABAP
      determination calcTotalTravelPrice on save { create; update; }
      ``` 

   2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**  

   3. Declare the required method in the behavior implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`** using the ADT Quick Fix by setting the cursor on the determination name and pressing *Ctrl/Cmd + 1* to open the **Quick Assist** view. 
   
   4. Select the entry _**`Add method for determination calcTotalTravelPrice of entity ZR_TRAVEL###...`**_. 

   5. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

      As result, the `FOR DETERMINE` method **`calcTotalTravelPrice`** will be added to the local handler class **`lcl_handler`** of the behavior pool of the _Travel_ BO entity ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL###`**. 

  ![](/exercises/ex05/images/rap120_ex51.gif)


</details>

## Exercise 5.2: Enhance determination with Joule Code Prediction Capability💎
[^Top of page](#Introduction)

> Enhance the determination **`calcTotalTravelPrice`** using **Joule Code Prediction Capability💎**.
> 
> ⚠ **Warning regarding Joule's outputs** ⚠    
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

 <details>
  <summary>🔵 Click to expand!</summary>

 1. Disable **Joule Code Prediction Capability** by pressing ![](/exercises/images/adt_joule_code_completion2.png) in the toolbar. 
 
 2. Go to your implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`** and add the following ABAP comments in the **`calcTotalTravelPrice`** method implementation

    ```ABAP

        "1) Read Travel and Booking entities
        "2) Calculate the total flight price of the bookings using reduce operator in calculated_total_price variable
        "3) Update the total price of the Travel

    ```
 
3. Enable **Joule Code Prediction Capability** by pressing ![](/exercises/images/adt_joule_code_completion2.png) in the toolbar. 

4. Press **Enter** after each comment. 
 
  >**Joule Code Prediction Capability**💎 will suggest the next lines based on the previous comment that you've added in the previous step.

5. Review the code and press _**Tab**_.  

6. Make sure to finish the implementation of **`calcTotalTravelPrice`** as below. At the end, the code should look something like this:

   ```ABAP
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

   ```

   Your source code should look like this:

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
                   IMPORTING keys FOR Travel~calcTotalTravelPrice.

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

     ENDCLASS.
   ```

5. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes. 


 ![](/exercises/ex05/images/rap120_ex52.gif)



</details>

## Exercise 5.3: Preview and test the enhanced Travel App

[^Top of page](#Introduction)

> You can now preview and test the changes by creating a new travel instance in the _Travel_ app.

 <details>
  <summary>🔵 Click to expand!</summary>

1. Refresh your application in the browser using **F5** if the browser is still open   
   or go to your service binding ![service binding](images/adt_srvb.png)**`ZUI_TRAVEL_###_04`** and start the Fiori elements App preview for the **`Travel`** entity set.

2. Create a new _Travel_ instance with one ore more _Booking_ instances. The **`Total Price`** field should calculated by the logic you just implemented. 

 
</details>

## Summary & Next Exercise
[^Top of page](#Introduction)

Now that you've... 
- defined a determination,
- implemented it using _Joule Code Prediction Capability_, and
- launched and tested the enhanced Fiori elements app, 

you've completed the main exercises of this hands-on workshop and hopefully gained some insights about **SAP Joule for developers, with ABAP capabilities💎**. Congratulations! 🎉🎉🎉

Thank you for attending this workshop!

**Optionally**, you can continue with the next exercise – **[Exercise 6: Utilize the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM)](../ex06/README.md)**


[Home - RAP120](../../README.md)

---
