[Home - RAP120](../../README.md)

# Exercise 2: Enhance the CDS data model and create CDS unit tests


## Introduction
In the previous exercise, you've created a database table for storing _Travel_ data, filled it with mock data, and generated your UI service along with the one-node  _Travel_ business object (_see [Exercise 1](../ex01/README.md)_).

In this exercise, you'll now enhance the base BO data model by adding a calculated field to the CDS data definition. Then, you'll generate a unit tests for the CDS view using **Joule CDS Unit Test Skill**💎.

### Exercises
- [2.1 - Add a simple calculated field in the CDS view](#exercise-21-add-a-simple-calculated-field-in-the-cds-view)
- [2.2 - Generate unit tests using Joule CDS Unit Test Skill](#exercise-22-generate-unit-tests-using-joule-cds-unit-test-skill)
- [Summary & Next Exercise](#summary--next-exercise)

> ℹ️ **Reminder**: Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID in the exercise steps below. 

> ℹ️ **Info: Warnings about missing CDS access control**   
> Please ignore the warnings about missing access control that will be displayed for the CDS views entities `ZC_TRAVEL_###` and `ZR_TRAVEL_###`. These is due to the view annotation `@AccessControl.authorizationCheck: #CHECK` specified in these entities. 
> Due to time constraints, we will not define CDS access control in this workshop. 

## Exercise 2.1: Add a simple calculated field in the CDS view
[^Top of page](#)

> Add the calculated field **`VatTax`** to the CDS view ![datadefinition](images/adt_ddls.png)**`ZR_TRAVEL_###`** to calculate the value-added tax of a _travel_ entry.

 <details>
  <summary>🔵Click to expand!</summary>

 1. Go to the **Project Explorer** and open the CDS data definition ![datadefinition](images/adt_ddls.png)**`ZR_TRAVEL_###`** 
 
 2. Add the following code lines after the field **`CurrencyCode`** to define the field **`VatTax`** which is used to calculate the value-added tax based on the total price of the _Travel_:    
     
    ```ABAP
    @Semantics.amount.currencyCode: 'CurrencyCode'
    division(5 * cast(total_price as abap.dec(15,2)),100,2) as VatTax,
    ```
    
    Your CDS data definition ![data definition](images/adt_ddls.png)**`ZR_TRAVEL_###`** should look like this:
    
    ```ABAP
    @AccessControl.authorizationCheck: #CHECK
    @Metadata.allowExtensions: true
    @EndUserText.label: '##GENERATED Core Data Service Entity'
    define root view entity ZR_TRAVEL_### as select from ztravel_###
    {
       key travel_id as TravelId,
       agency_id as AgencyId,
       customer_id as CustomerId,
       begin_date as BeginDate,
       end_date as EndDate,
       destination as Destination,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       booking_fee as BookingFee,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       total_price as TotalPrice,
       @Consumption.valueHelpDefinition: [ {
          entity.name: 'I_CurrencyStdVH', 
          entity.element: 'Currency', 
          useForValidation: true
       } ]
       currency_code as CurrencyCode,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       division(5 * cast(total_price as abap.dec(15,2)),100,2) as VatTax,
       description as Description,
       status as Status,
       @Semantics.user.createdBy: true
       created_by as CreatedBy,
       @Semantics.systemDateTime.createdAt: true
       created_at as CreatedAt,
       @Semantics.user.localInstanceLastChangedBy: true
       local_last_changed_by as LocalLastChangedBy,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
       local_last_changed_at as LocalLastChangedAt,
       @Semantics.systemDateTime.lastChangedAt: true
       last_changed_at as LastChangedAt
    }
    ```        
       
   2. Save ![save icon](images/adt_save.png) (**Ctrl+S**) and activate ![activate icon](images/adt_activate.png) the changes.

   3. Now that the calculated field **`VatTax`** was added, you need to recreate the draft table ![table](images/adt_tabl.png)**`ZR_TRAVEL_###_D`** for the changed _Travel_ entity **`ZR_TRAVEL_###`**. 
   
      To do that, go to the **Project Explorer** and open the behavior definition ![bdef icon](images/adt_bdef.png)**`ZR_TRAVEL_###`**.
 
      To recreate the draft table, set the cursor on the draft table name ![databasetable](images/adt_tabl.png)**`ZR_TRAVEL_###_D`**, start the ADT Quick Fix by clicking **Ctrl+1**, and select the entry **`Recreate draft table ztravel_###_d for entity zr_travel_###`** in the Quick Assist view. Alternatively use the displayed icon as shown on the picture.

      ![ADT Quick Fix](/exercises/ex02/images/2_BDEF_QuickFix.gif)

   4. Save ![save icon](images/adt_save.png) (**Ctrl+S**) and activate ![activate icon](images/adt_activate.png) the changes.

</details>


## Exercise 2.2: Generate unit tests using Joule CDS Unit Test Skill💎
[^Top of page](#)

> You will now generate unit tests for the CDS view ![datadefinition](images/adt_ddls.png)**`ZR_TRAVEL_###`** using **Joule CDS Unit Test Skill**💎.
>
> ⚠ **Warning regarding Joule's outputs** ⚠   
> Please be aware that the outputs generated by Joule in this exercise description may differ from yours, and the provided code snippets should be adjusted accordingly. **Always review the code generated by Joule**.

<details>
  <summary>🔵Click to expand!</summary>
 
 1. In the **Project Explorer**, right-click on the CDS data definition ![datadefinition](images/adt_ddls.png)**`ZR_TRAVEL_###`** and   
    select **Joule > New ABAP Test Class** from the context menu.

 2. Enter the information below in the wizard for the new ABAP Class that will be created and click on **Next**. 
    - Name: **`ZCL_TEST_CDS_TRAVEL_###`**
    - Description: ***`Test Class for CDS View ZR_TRAVEL_###`***     

    The wizard now displays the SQL dependencies for the CDS Test Double Framework. 
 
 3. Click on **Next**.

 4. Select the **`CALCULATION`** Test Case in the wizards and click **Next**. 
 
    Joule will generate unit tests with test data for the calculated field **`VatTax`** that you added in the CDS data definition ![data definition](images/adt_ddls.png)**`ZR_TRAVEL_##`**.

 5. Check the generated test data and click **Next**.

 6. Select your transport request and click **Finish**. 

 7. As you can see, the ABAP class ![abapclass](images/adt_class.png)**`ZCL_TEST_CDS_TRAVEL_###`** was generated.   
 
    Review the code and activate ![activate icon](images/adt_activate.png) the changes.

 8. Now you can run your unit tests. 
 
    To do that, go to the **Project Explorer**, right-click on the previously generated ABAP class ![abapclass](images/adt_class.png)**`ZCL_TEST_CDS_TRAVEL_###`** and select **Run as > ABAP Unit Test** from the context menu.

    ![](/exercises/ex02/images/2_CDS_Unit_Test.gif)

</details>

## Summary & Next Exercise
[^Top of page](#)

Now that you've... 
- enhanced the base BO data model with a calculated field,
- adjusted the draft table to reflect the changes of the enhanced BO data model, and
- generated unit tests for your enhanced CDS data definition using **Joule CDS Unit Test Skill**,

you can continue with the next exercise – **[Exercise 3: Analyze the ABAP helper class and create ABAP unit tests](../ex03/README.md)**

---
