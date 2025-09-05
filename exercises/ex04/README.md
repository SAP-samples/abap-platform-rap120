[Home - RAP120](../../README.md)

# Exercise 4: Add a validation

## Introduction 

In the previous exercise, you've analyzed the ABAP helper class created in [Exercise 1.7](../ex01/README.md/#exercise-16-publish-and-preview-the-travel-app) and created ABAP unit tests for it using **ABAP Unit Test Generation Capability💎**. (_see [Exercise 3](../ex03/README.md)_).

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
[^Top of page](#Introduction)

> Define the validation **`validateCustomer`** in the behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`** and implement it in the behavior implementation class, aka behavior pool, ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`**.  

 <details>
  <summary>🔵 Click to expand!</summary>
  
1. Go to the **Project Explorer** and open your behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`**.  

2. Insert the following code into your behavior definition:
 
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
     
   Your behavior definition ![behaviordefinition](images/adt_bdef.png)**`ZR_TRAVEL###`** should look like this:

   ```BDL
      managed implementation in class ZBP_R_TRAVEL### unique;
      strict ( 2 );
      with draft;
      extensible;
      define behavior for ZR_TRAVEL### alias Travel
      persistent table ztravel###
      extensible
      draft table ztravel_d###
      etag master LocalLastChangedAt
      lock master total etag LastChangedAt
      authorization master ( global )
      {
        field ( readonly )
        UUID,
        SightseeingsTips,
        TotalPrice,
        LocalCreatedBy,
        LocalCreatedAt,
        LocalLastChangedBy,
        LocalLastChangedAt,
        LastChangedAt;

        field ( mandatory : create )
        BeginDate,
        EndDate,
        Destination;

        // Add CustomerId as mandatory field
        field ( mandatory )
        CustomerId;

        field ( numbering : managed )
        UUID;


        create;
        update;
        delete;

        // Add validation validateCustomer
        validation validateCustomer on save { create; field CustomerID; }

        draft action Activate optimized;
        draft action Discard;
        draft action Edit;
        draft action Resume;
          draft determine action Prepare{
          validation validateCustomer;
        }

        mapping for ztravel### corresponding extensible
          {
            UUID               = uuid;
            TravelID           = travel_id;
            AgencyID           = agency_id;
            CustomerID         = customer_id;
            BeginDate          = begin_date;
            EndDate            = end_date;
            BookingFee         = booking_fee;
            TotalPrice         = total_price;
            CurrencyCode       = currency_code;
            Description        = description;
            Status             = status;
            Destination        = destination;
            SightseeingsTips   = sightseeings_tips;
            LocalCreatedBy     = local_created_by;
            LocalCreatedAt     = local_created_at;
            LocalLastChangedBy = local_last_changed_by;
            LocalLastChangedAt = local_last_changed_at;
            LastChangedAt      = last_changed_at;
          }

        association _Booking { create; with draft; }

      }

      define behavior for ZR_BOOKING### alias Booking
      persistent table zbooking###
      extensible
      draft table zbooking_d###
      etag dependent by _Travel
      lock dependent by _Travel
      authorization dependent by _Travel
      {
        field ( readonly )
        UUID,
        ParentUUID;

        field ( numbering : managed )
        UUID;


        update;
        delete;

        mapping for zbooking### corresponding extensible
          {
            UUID                  = uuid;
            ParentUUID            = parent_uuid;
            BookingID             = booking_id;
            BookingDate           = booking_date;
            CustomerID            = customer_id;
            CarrierID             = carrier_id;
            ConnectionID          = connection_id;
            FlightDate            = flight_date;
            FlightPrice           = flight_price;
            CurrencyCode          = currency_code;
            DiscountedFlightPrice = discounted_flight_price;
          }

        association _Travel { with draft; }

      }
   ``` 

   > **Short explanation**:    
   > - Validations are always invoked during the save and specified with the keyword `validateCustomer on save`.    
   > - `validateCustomer` is a validation with trigger operation `create` and trigger field `CustomerID`.

   ![](/exercises/ex04/images/rap120_ex41.gif)
     
5. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**.

6. Declare the required method in behavior implementation class ![](images/adt_class.png)**`ZBP_R_TRAVEL###`** using the ADT Quick Fix *Ctrl/Cmd + 1*.

   > ℹ️ **Info**: The ADT Quick Fix is a feature within the ABAP Development Tools (ADT) for Eclipse that helps developers quickly resolve issues in their code. In this case, it's helping to add automatically the validation method's definition and implementation in the class ![](images/adt_class.png)**`ZBP_R_TRAVEL###`**
  
   To do that, remain in the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`** and set your cursor on the name of the validation **`validateCustomer`**. 
  
   Then press *Ctrl/Cmd + 1* to open the **Quick Assist** view and select the entry _**`Add validation method validateCustomer of entity ZR_TRAVEL### ...`**_ from the dialog. 
  
   As a result, the behavior implementation class ![](images/adt_class.png)**`ZBP_R_TRAVEL###`** will be enhanced with the new validation method. 

7. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes in **`ZBP_R_TRAVEL###`**.

   > **Hint**:   
   > If you get the error message _**`The entity ZR_TRAVEL### does not have a validation VALIDATECUSTOMER.`**_ in the behavior implementation, then try to activate![activate icon](images/adt_activate.png) the behavior definition once again.  

</details>
  
## Exercise 4.2: Enhance validation with RAP Predict Business Logic💎
[^Top of page](#Introduction)

> Create **`validateCustomer`** validation to verify whether the entered CustomerID is valid by using **RAP Predict Business Logic**💎. If the value is invalid, ensure that an appropriate message is shown on the UI for each case.
> 
> ⚠ **Warning regarding Joule's outputs** ⚠    
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

 <details>
  <summary>🔵 Click to expand!</summary>

1. Go to your implementation class ![class](images/adt_class.png)**`ZBP_R_TRAVEL###`** and position the cursor on **`validateCustomer`** method implementation.

2. Use ADT Quick Fix _(Ctrl or Cmd +1)_ to select **Predict RAP Business Logic 💎**. To get the prediction, we need to provide a method description in the following input dialog.

3. Enter the following the description in the **Method Description** section. Then, press **Run**.

   Do not forget to replace **`###`** with your assigned *Group ID* or choosen suffix. For the implementation, we will call the method **`validate_customer`** from our helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** created in _[Exercise 1](../ex03/README.md)_.

   ```
    Instantiate the helper class zcl_travel_helper_###, then read the CustomerId field from the CDS view ZR_TRAVEL###.

    Check if the CustomerID is initial, and validate it using the zcl_travel_helper_### helper class.

    If the CustomerID is missing or invalid, append the key failed-travel. Also, add the key to reported-travel with a NEW_MESSAGE_WITH_TEXT error message.

   ```

   <!-- **Joule Predictive Code Completion** will suggest the next lines based on the previous comment that you've added in the previous step. 
 
   > ℹ️**Hint**: Make sure **Joule Predictive Code Completion** is switched on in the toolbar ![](/exercises/images/adt_joule_code_completion2.png). -->

3. Review the code.

4. Your code should look something like this:
  
   Do not forget to replace **`###`** with your assigned *Group ID* or choosen suffix.

   ```ABAP
   CLASS LHC_ZR_TRAVEL### DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
     PRIVATE SECTION.
       METHODS:
         GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
           IMPORTING
              REQUEST requested_authorizations FOR Travel
           RESULT result,
         validateCustomer FOR VALIDATE ON SAVE
               IMPORTING keys FOR Travel~validateCustomer.
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

   ENDCLASS.
   ```

5. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes.

 ![](/exercises/ex04/images/rap120_ex42.gif)

</details>


## Exercise 4.3: Preview and test the enhanced _Travel_ app
[^Top of page](#Introduction)

> Now preview and test the enhanced _Travel_ app. 

 <details>
  <summary>🔵 Click to expand!</summary>

  1. You can either refresh your _Travel_ app in the browser using **F5** if the browser is still open - or go to your service binding ![service binding](../images/adt_srvb.png)**`ZUI_TRAVEL_O4###`** in ADT and start the Fiori elements App preview for the **`Travel`** entity set.
  
  2. Play around with the app.

 </details>

## Summary & Next Exercise
[^Top of page](#Introduction)

Now that you've... 
- defined and implemented a validation, 
- enhanced the validation using *Joule Predictive Code Completion*, and
- launched and tested the enhanced Fiori elements app,

you can continue with the next exercise – **[Exercise 5: Add a determination](../ex05/README.md)**

---

