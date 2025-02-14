[Home - RAP120](../../README.md)

# Exercise 5: Add a determination

## Introduction

In the previous exercise, you've defined and implemented a backend validation called **`validateCustomer`** to verify if the customer ID entered is valid (_see [Exercise 4](../ex04/README.md)_).

In this exercise, you will now define and implement a determination called **`setInitialTravelStatus`**, which will be used to set a default value for the overall status of a _Travel_ entity instance.  

### Exercises

- [5.1 - Define and implement the determination](#exercise-51-Define-and-implement-the-determination)
- [5.2 - Enhance determination with Joule Predictive Code Completion](#exercise-52-Enhance-determination-with-Joule-Predictive-Code-Completion)
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
[^Top of page](#)

> Define the determination **`setInitialTravelStatus`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL_###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>

   1. Go to the behavior definiton ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`** and insert the following 

      ```ABAP 
        determination setInitialTravelStatus on save { create; }
      ```

      The statement specifies the name of the new determination, **`setInitialTravelStatus`** and **`on modify`** as the determination time when creating new _travel_ instance (**`{ create }`**). 

   2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`**  

   3. Declare the required method in the behavior implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`** using the ADT Quick Fix by setting the cursor on the determination name and pressing **Ctrl + 1** to open the **Quick Assist** view.
 
      Select the entry _**`Add method for determination setInitialTravelStatus of entity zr_travel_###...`**_. 

   4. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes in ![class icon](images/adt_class.png)**`ZBP_R_TRAVEL_###`**.  

      As result, the `FOR DETERMINE` method **`setInitialTravelStatus`** will be added to the local handler class **`lcl_handler`** of the behavior pool of the _Travel_ BO entity ![class icon](images/adt_class.png)**`ZBP_TRAVELTP_###`**. 

      ![](/exercises/ex05/images/5_1_Determination.gif)

</details>

## Exercise 5.2: Enhance determination with Joule Predictive Code Completion💎
[^Top of page](#)

> Enhance the determination **`setInitialTravelStatus`** using **Joule Predictive Code Completion💎**.
> 
> ⚠ **Warning regarding Joule's outputs** ⚠    
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

 <details>
  <summary>🔵 Click to expand!</summary>

 1. Disable **Joule Predictive Code Completion** by pressing ![](/exercises/images/adt_joule_code_completion2.png) in the toolbar. 
 
 2. Go to your implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`** and add the following ABAP comments in the **`setInitialTravelStatus`** method implementation

    ```ABAP

        "1) ABAP EML to read the field Status from CDS view ZR_TRAVEL_###


        "2) If Status is already set, do nothing, i.e. remove such instances


        "3) ABAP EML to update the field Status in CDS view ZR_TRAVEL_###. Use variable update_reported


        "4) Set the changing parameter reported

    ```
 
3. Enable **Joule Predictive Code Completion** by pressing ![](/exercises/images/adt_joule_code_completion2.png) in the toolbar. 

4. Press **Enter** after each comment. 
 
   **Joule Predictive Code Completion** will suggest the next lines based on the previous comment that you've added in the previous step.

5. Review the code and press _**Tab**_. Adjust the code if needed. 

6. Make sure to finish the implementation of **`setInitialTravelStatus`**. 
 
   We will call the method `get_booking_status` from our helper class ![adt class](/exercises/ex04/images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`**. 
 
   At the end, the code should look something like this:

   ```ABAP
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

   ```

   Your source code should look like this:

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
                   IMPORTING keys FOR Travel~setInitialTravelStatus.

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

       ENDCLASS.
   ```

5. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes. 

   ![](/exercises/ex05/images/5_2_Determination_Joule_Code_Completion.gif)

</details>

## Exercise 5.3: Preview and test the enhanced Travel App

[^Top of page](#)

> You can now preview and test the changes by creating a new travel instance in the _Travel_ app.

 <details>
  <summary>🔵 Click to expand!</summary>

1. Refresh your application in the browser using **F5** if the browser is still open   
   or go to your service binding ![service binding](images/adt_srvb.png)**`ZUI_TRAVEL_###_04`** and start the Fiori elements App preview for the **`Travel`** entity set.

2. Create a new _Travel_ instance. The **`Status`** field should now be set automatically by the logic you just implemented.   
 
   The initial status of the created should now be set to **`New`** (**`N`**). 

</details>

## Summary & Next Exercise
[^Top of page](#)

Now that you've... 
- defined a determination,
- implemented it using _Joule Predictive Code Completion_, and
- launched and tested the enhanced Fiori elements app, 

you've completed the main exercises of this hands-on workshop and hopefully gained some insights about **Joule for Developer, with ABAP capabilities💎**. Congratulations! 🎉🎉🎉

Thank you for attending this workshop!

**Optionally**, you can continue with the next exercise – **[Exercise 6: Utilize the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM)](../ex06/README.md)**


[Home - RAP120](../../README.md)

---
