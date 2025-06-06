[Home - RAP120](../../README.md)

# Exercise 2: Enhance the CDS data model and create CDS unit tests

## Introduction
In the previous exercise, you've  generated your UI service along with the _Travel_ and _Booking_ business objects (_see [Exercise 1](../ex01/README.md)_).

In this exercise, you'll now enhance the base BO data model by adding a calculated field to the CDS data definition. Then, you'll generate a unit tests for the CDS view using **Joule CDS Unit Test Skill**💎.

### Exercises
- [2.1 - Enhance DiscountedFlightPrice field in the CDS view Booking](#exercise-21-Enhance-DiscountedFlightPrice-field-in-the-CDS-view-Booking)
- [2.2 - Get an explanation of the added logic for **`DiscountedFlightPrice`** using Code Explain](#exercise-22-Get-an-explanation-of-the-added-logic-for-DiscountedFlightPrice-using-Code-Explain)
- [2.3 - Generate unit tests using Joule CDS Unit Test Skill](#exercise-22-generate-unit-tests-using-joule-cds-unit-test-skill)
- [Summary & Next Exercise](#summary--next-exercise)

> ℹ️ **Reminder**: Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID in the exercise steps below. 

> ℹ️ **Info: Warnings about missing CDS access control**   
> Please ignore the warnings about missing access control that will be displayed for the CDS views entities like `ZC_TRAVEL###` and `ZR_TRAVEL###`. These is due to the view annotation `@AccessControl.authorizationCheck: #CHECK` specified in these entities. 
> Due to time constraints, we will not define CDS access control in this workshop. 

## Exercise 2.1: Enhance **`DiscountedFlightPrice`** field in the CDS view _Booking_
[^Top of page](#Introduction)

> You'll enhance the field **`DiscountedFlightPrice`** of the entity _Booking_ ![datadefinition](images/adt_ddls.png)**`ZR_BOOKING###`** to apply a discount based on the airline

 <details>
  <summary>🔵 Click to expand!</summary>

 1. Go to the **Project Explorer** and open the CDS data definition ![datadefinition](images/adt_ddls.png)**`ZR_BOOKING###`** 
 
 2. Add the following code lines for the field **`DiscountedFlightPrice`**  to calculate the total price with discount based on the carrier: 

   - If the **`carrier_id`** is equal to **LH**, the discount is 10% of **`flight_price`**
   - If the **`carrier_id`** is equal to **AF**, the discount is 15% of **`flight_price`**
     
   ```ABAP
      case
         when carrier_id = 'LH' then cast(flight_price as abap.dec(16,2)) * cast('0.90' as abap.dec(5,2))
         when carrier_id = 'AF' then cast(flight_price as abap.dec(16,2)) * cast('0.85' as abap.dec(5,2))
         else cast(flight_price as abap.dec(16,2))
      end as DiscountedFlightPrice,
   ```
    
 Your CDS data definition ![data definition](images/adt_ddls.png)**`ZR_BOOKING###`** should look like this:
 
 > ℹ️ NOTE: The names of the artifacts, database fields, and other elements in your project may differ from those shown in this tutorial, as they are generated by GenAI
    
   ```ABAP
      @AccessControl.authorizationCheck: #CHECK
      @Metadata.allowExtensions: true
      @EndUserText.label: '###GENERATED Core Data Service Entity'
      define view entity ZR_BOOKING###
      as select from zbooking### as Booking
      association to parent ZR_TRAVEL### as _Travel on $projection.ParentUuid = _Travel.Uuid
      {
         key uuid as Uuid,
         parent_uuid as ParentUuid,
         booking_date as BookingDate,
         customer_id as CustomerId,
         carrier_id as CarrierId,
         connection_id as ConnectionId,
         flight_date as FlightDate,
         @Semantics.amount.currencyCode: 'CurrencyCode'
         flight_price as FlightPrice,
         currency_code as CurrencyCode,
         @Semantics.amount.currencyCode: 'CurrencyCode'
         case
            when carrier_id = 'LH' then cast(flight_price as abap.dec(16,2)) * cast('0.90' as abap.dec(5,2))
            when carrier_id = 'AF' then cast(flight_price as abap.dec(16,2)) * cast('0.85' as abap.dec(5,2))
            else cast(flight_price as abap.dec(16,2))
         end as DiscountedFlightPrice,
         _Travel
      }
   ```        
       
   3. Save ![save icon](images/adt_save.png) (**Ctrl+S**) and activate ![activate icon](images/adt_activate.png) the changes.

   4. Now that the field **`DiscountedFlightPrice`** was enhanced, you need to recreate the draft table ![table](images/adt_tabl.png)**`ZBOOKING_D###`** for the changed _Booking_ entity **`ZR_BOOKING###`**. 
   
      To do that, go to the **Project Explorer** and open the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL###`**.
 
      To recreate the draft table, set the cursor on the draft table name ![databasetable](images/adt_tabl.png)**`ZBOOKING_D###`**, start the ADT Quick Fix by clicking **Ctrl+1**, and select the entry **`Recreate draft table zbooking_d### so that it fits for entity zr_booking## and reflects recent changes.`** in the Quick Assist view. Alternatively use the displayed icon as shown on the picture.

      <!-- ![ADT Quick Fix](/exercises/ex02/images/2_BDEF_QuickFix.gif) -->

   5. Save ![save icon](images/adt_save.png) (**Ctrl+S**) and activate ![activate icon](images/adt_activate.png) the changes.

   ![](/exercises/ex02/images/rap120_2505_ex21.gif)

</details>


## Exercise 2.2: Get an explanation of the added logic for **`DiscountedFlightPrice`** using Code Explain💎
[^Top of page](#Introduction)

> You will use Joule Code Explain💎 to get a better understanding about the added logic for **`DiscountedFlightPrice`** field.

<details>
   <summary>🔵 Click to expand!</summary>

   1. Select the previous added **CASE** logic for **`DiscountedFlightPrice`** field and perform right-click, **Joule > Explain**

   ![](/exercises/ex02/images/rap120_2505_ex22.gif)

</details>

## Exercise 2.3: Generate unit tests using Joule CDS Unit Test Skill💎
[^Top of page](#Introduction)

> You will now generate unit tests for the CDS view ![datadefinition](images/adt_ddls.png)**`ZR_BOOKING###`** using **Joule CDS Unit Test Skill**💎.
>
> ⚠ **Warning regarding Joule's outputs** ⚠   
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

<details>
  <summary>🔵Click to expand!</summary>
 
 1. In the **Project Explorer**, right-click on the CDS data definition ![datadefinition](images/adt_ddls.png)**`ZR_BOOKING###`** and   
    select **Joule > New ABAP Test Class** from the context menu.

 2. Enter the information below in the wizard for the new ABAP Class that will be created and click on **Next**. 
    - Name: **`ZCL_TEST_CDS_BOOKING_###`**
    - Description: ***`Test Class for CDS View ZR_BOOKING###`***     

    The wizard now displays the SQL dependencies for the CDS Test Double Framework. 
 
 3. Click on **Next**.

 4. Select all the suggested Test Cases in the wizards and click **Next**. 
 
    Joule will generate unit tests with test data for the logic applied to the field **`DiscountedFlightPrice`** in the CDS data definition ![data definition](images/adt_ddls.png)**`ZR_BOOKING###`**.

 5. Check the generated test data for each test case and click **Next**.

 6. Select your transport request and click **Finish**. 

 7. As you can see, the ABAP class ![abapclass](images/adt_class.png)**`ZCL_TEST_CDS_BOOKING_###`** was generated.   
 
    Review the code and activate ![activate icon](images/adt_activate.png) the changes.

 8. Now you can run your unit tests. 
 
    To do that, go to the **Project Explorer**, right-click on the previously generated ABAP class ![abapclass](images/adt_class.png)**`ZCL_TEST_CDS_BOOKING_###`** and select **Run as > ABAP Unit Test** from the context menu.

   ![](/exercises/ex02/images/rap120_2505_ex23.gif)

</details>

## Summary & Next Exercise
[^Top of page](#Introduction)

Now that you've... 
- enhanced the base BO data model with a calculated field,
- adjusted the draft table to reflect the changes of the enhanced BO data model, and
- generated unit tests for your enhanced CDS data definition using **Joule CDS Unit Test Skill**,

you can continue with the next exercise – **[Exercise 3: Analyze the ABAP helper class and create ABAP unit tests](../ex03/README.md)**

---
