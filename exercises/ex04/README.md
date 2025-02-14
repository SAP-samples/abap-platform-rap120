[Home - RAP120](../../README.md)

# Exercise 4: Add a validation

## Introduction 

In the previous exercise, you've analyzed the ABAP helper class created in [Exercise 1.7](../ex01/README.md/#exercise-16-publish-and-preview-the-travel-app) and created ABAP unit tests for it using **Joule ABAP Unit Test Skill💎**. (_see [Exercise 3](../ex03/README.md)_).

In this exercise, you will define and implement a backend validation called **`validateCustomer`** to verify if the customer ID entered is valid.

### Exercises

- [4.1 - Define and implement the validation](#exercise-41-define-and-implement-the-validation)
- [4.2 - Enhance validation with Joule Predictive Code Completion](#exercise-42-enhance-validation-with-joule-predictive-code-completion)
- [4.3 - Preview and test the enhanced Travel App](#exercise-43-preview-and-test-the-enhanced-travel-app)
- [Summary & Next Exercise](#summary--next-exercise)

<br/>

> ℹ️ **Reminder**: Do not forget to replace the suffix placeholder **`###`** with your choosen or assigned group ID in the exercise steps below. 

<!-- 
### About Validations

<details>
  <summary>Click to expand!</summary>

A validation is an optional part of the business object behavior that checks the consistency of business object instances based on trigger conditions. 

A validation is implicitly invoked by the business object’s framework if the trigger condition of the validation is fulfilled. Trigger conditions can be `MODIFY` operations and modified fields. The trigger condition is evaluated at the trigger time, a predefined point during the BO runtime. An invoked validation can reject inconsistent instance data from being saved by passing the keys of failed instances to the corresponding table in the `FAILED` structure. Additionally, a validation can return messages to the consumer by passing them to the corresponding table in the `REPORTED` structure.

> **Further reading**: [Validations](https://help.sap.com/docs/btp/sap-abap-restful-application-programming-model/validations?version=Cloud) 

</details>
-->

## Exercise 4.1: Define and implement the validation
[^Top of page](#)

> Define the validation **`validateCustomer`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL_###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>
  
1. Go to the **Project Explorer** and open your behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL_###`**.  

2. Because empty values should not be accepted for the field **`CustomerID`**, specify it as a _mandatory_ field. 
 
   For that, add the source code below in the curly brackets to your behavior definition as shown in the screenshot below.
 
    ```ABAP 
      field ( mandatory )
        CustomerID;
    ```

3. Now, define the validation **`validateCustomer`**.
     
   For that, add the following code snippet after the `delete;` statement
   
   ```ABAP
     validation validateCustomer on save { create; field CustomerID; }
   ```         

4. In order to have draft instances being checked by validations before they become active, they have to be specified for the **`draft determine action prepare`** in the behavior definition.
  
   Replace the code line **`draft determine action Prepare;`** with the following code snippet as shown on the screenshot below.

   ```ABAP
     draft determine action Prepare{
       validation validateCustomer;
     }
   ```    
     
   The source code in your behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL_###`** should look like this:

   ```BDL
    managed implementation in class ZBP_R_TRAVEL_### unique;
    strict ( 2 );
    with draft;
    define behavior for ZR_TRAVEL_### alias Travel
    persistent table ZTRAVEL_###
    draft table ZTRAVEL_###_D
    etag master LocalLastChangedAt
    lock master total etag LastChangedAt
    authorization master( global )

    {
      field ( mandatory : create )
        TravelId;

      field ( mandatory )
         CustomerID;

      field ( readonly )
        CreatedBy,
        CreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt;

      field ( readonly : update )
        TravelId;

      create;
      update;
      delete;

      validation validateCustomer on save { create; field CustomerID; }

      draft action Activate optimized;
      draft action Discard;
      draft action Edit;
      draft action Resume;
      draft determine action Prepare{
        validation validateCustomer;
      }

      mapping for ZTRAVEL_###
      {
        TravelId = travel_id;
        AgencyId = agency_id;
        CustomerId = customer_id;
        BeginDate = begin_date;
        EndDate = end_date;
        Destination = destination;
        BookingFee = booking_fee;
        TotalPrice = total_price;
        CurrencyCode = currency_code;
        Description = description;
        Status = status;
        CreatedBy = created_by;
        CreatedAt = created_at;
        LocalLastChangedBy = local_last_changed_by;
        LocalLastChangedAt = local_last_changed_at;
        LastChangedAt = last_changed_at;
      }
    }
   ``` 

   > **Short explanation**:    
   > - Validations are always invoked during the save and specified with the keyword `validateCustomer on save`.    
   > - `validateCustomer` is a validation with trigger operation `create` and trigger field `CustomerID`.    
     
5. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`**.

6. Declare the required method in behavior implementation class ![](images/adt_class.png)**`ZBP_R_TRAVEL_###`** using the ADT Quick Fix (**Ctrl + 1**).

   > ℹ️ **Info**: The ADT Quick Fix is a feature within the ABAP Development Tools (ADT) for Eclipse that helps developers quickly resolve issues in their code. In this case, it's helping to add automatically the validation method's definition and implementation in the class ![](images/adt_class.png)**`ZBP_R_TRAVEL_###`**
  
   To do that, remain in the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`** and set your cursor on the name of the validation **`validateCustomer`**. 
  
   Then press **Ctrl + 1** to open the **Quick Assist** view and select the entry _**`Add validation method validateCustomer of entity zr_travel_### ...`**_ from the dialog. 
  
   As a result, the behavior implementation class ![](images/adt_class.png)**`ZBP_R_TRAVEL_###`** will be enhanced with the new validation method. 

7. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in **`ZBP_R_TRAVEL_###`**.

   ![](/exercises/ex04/images/4_Define_implement_validation.gif)

   > **Hint**:   
   > If you get the error message _**`The entity ZR_TRAVEL_### does not have a validation VALIDATECUSTOMER.`**_ in the behavior implementation, then try to activate![activate icon](images/adt_activate.png) the behavior definition once again.  

</details>
  
## Exercise 4.2: Enhance validation with Joule Predictive Code Completion💎
[^Top of page](#)

> Implement the validation **`validateCustomer`** which checks if the customer ID, **`CustomerID`**, that is entered by the consumer is valid using **Joule Predictive Code Completion💎**. An appropriate message should be raised and displayed on the UI for each invalid value.  
> 
> ⚠ **Warning regarding Joule's outputs** ⚠    
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

 <details>
  <summary>🔵 Click to expand!</summary>

1. Go to your implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL_###`** and add the below comment in the `validateCustomer` method implementation.

   ```
     "ABAP EML to read the field CustomerId from CDS view ZR_TRAVEL_###
   ```

2. Press **Enter** on your keyboard. 
 
   **Joule Predictive Code Completion** will suggest the next lines based on the previous comment that you've added in the previous step. 
 
   > ℹ️**Hint**: Make sure **Joule Predictive Code Completion** is switched on in the toolbar ![](/exercises/images/adt_joule_code_completion2.png).

3. Review the code and press _Tab_. Adjust the code if needed. 

4. Add the following code to finish the implementation of the method `validateCustomer`. 
  
   For the implementation, we will call the method **`validate_customer`** from our helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** created in _[Exercise 1](../ex03/README.md)_.

   Do not forget to replace **`###`** with your assigned *Group ID* or choosen suffix.

   ```ABAP
   LOOP AT lt_travel INTO DATA(travel).
     DATA(lo_travel_helper) = NEW zcl_travel_helper_###(  ).
     DATA(customer_id) = travel-CustomerID.

     IF customer_id IS INITIAL.
         APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
         APPEND VALUE #( %tky                = travel-%tky
                         %state_area         = 'VALIDATE_CUSTOMER'
                         %msg                = NEW /dmo/cm_flight_messages(
                                                                 textid   = /dmo/cm_flight_messages=>enter_customer_id
                                                                 severity = if_abap_behv_message=>severity-error )
                         %element-CustomerID = if_abap_behv=>mk-on
                       ) TO reported-travel.

     ELSEIF lo_travel_helper->validate_customer( customer_id ) = abap_false.

     APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
     APPEND VALUE #( %tky                = travel-%tky
                     %state_area         = 'VALIDATE_CUSTOMER'
                     %msg                = NEW /dmo/cm_flight_messages( textid   = /dmo/cm_flight_messages=>customer_unkown
                                                                         customer_id = travel-CustomerId
                                                                         severity = if_abap_behv_message=>severity-error )
                     %element-CustomerID = if_abap_behv=>mk-on
                     ) TO reported-travel.
     ENDIF.
   ENDLOOP.
   ```

   Your code should look like this:

   ```ABAP
   CLASS LHC_ZR_TRAVEL_### DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
     PRIVATE SECTION.
       METHODS:
         GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
           IMPORTING
              REQUEST requested_authorizations FOR Travel
           RESULT result,
         validateCustomer FOR VALIDATE ON SAVE
               IMPORTING keys FOR Travel~validateCustomer.
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

   ENDCLASS.
   ```

5. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes.

   ![](/exercises/ex04/images/4_Joule_Predictive_Code_Completion.gif)

</details>


## Exercise 4.3: Preview and test the enhanced _Travel_ app
[^Top of page](#)

> Now preview and test the enhanced _Travel_ app. 

 <details>
  <summary>🔵 Click to expand!</summary>

  1. You can either refresh your _Travel_ app in the browser using **F5** if the browser is still open - or go to your service binding ![service binding](../images/adt_srvb.png)**`ZUI_TRAVEL_###_O4`** in ADT and start the Fiori elements App preview for the **`Travel`** entity set.
  
  2. Play around with the app.

 </details>

## Summary & Next Exercise
[^Top of page](#)

Now that you've... 
- defined and implemented a validation, 
- enhanced the validation using *Joule Predictive Code Completion*, and
- launched and tested the enhanced Fiori elements app,

you can continue with the next exercise – **[Exercise 5: Add a determination](../ex05/README.md)**

---

