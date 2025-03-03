[Home - RAP120](../../README.md)

# Exercise 6: Utilize the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM)

## Introduction

In the exercises 1-5, you've created a SAP Fiori elements based _Travel_ app to process travel data. In the last exercise, you defined and implemented a determination called **`setInitialTravelStatus`**, which is used to set a default value for the overall status of a _Travel_ entity instance (_see [Exercise 5](../ex05/README.md)_).  
> ℹ️ **Important note**: To complete the present exercise, you must have completed at least _[Exercise 1](../ex01/README.md)_. The exercises 2-5 are optional.

In this exercise, you will learn how to use the ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM). It is the official client to consume large language models in ABAP. 

For that, you will create an intelligent scenario (aka _ISLM scenario_), an intelligent scenario model (aka _ISLM model_), and then test the ABAP AI SDK within the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** that have been created in _[Exercise 1](../ex01/README.md)_. 

#### About ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM)
<details>
  <summary>ℹ️Click to expand!</summary>

ABAP AI SDK powered by Intelligent Scenario Lifecycle Management (ISLM) is an ABAP re-use library that supports you to interact with large language models (LLMs) hosted on the generative AI hub in SAP AI Core. With the ABAP AI SDK, you can build your own AI-based features in ABAP.

As an ABAP developer, you can access large language models from within your ABAP system. The ABAP AI SDK powered by ISLM is designed to standardize and ease the access to large language models and provide convenient features for ABAP developers. The ISLM and ABAP AI SDK integration offers a unified solution for business and technical use cases, facilitating prompt execution within the context of business applications.
  
ABAP AI SDK powered by ISLM is the official client to consume large language models in ABAP. 

> ℹ️ Curious to learn more about ABAP AI SDK powered by ISLM?   
  Check out the [Developing your own AI-enabled applications | SAP Help Portal](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/developing-your-own-ai-enabled-applications?locale=en-US) or the Devtoberfest 2024 session [Integrating Generative AI in SAP S/4HANA with ISLM](https://www.youtube.com/watch?v=SezO4_HTHfQ)

<!-- 
The ISLM and ABAP AI SDK integration offers a unified solution for business and technical use cases, facilitating prompt execution within the context of business applications.
> [ABAP AI SDK powered by Intelligent Scenario Lifecycle Management](https://help.sap.com/docs/abap-cloud/generative-ai-in-abap-cloud/abap-ai-sdk-powered-by-intelligent-scenario-lifecycle-management?locale=en-US&state=DRAFT) 
--> 
 
</details>

### Exercises

- [6.1 - Create an intelligent scenario](#exercise-61-create-an-intelligent-scenario)
- [6.2 - Create an intelligent scenario model](#exercise-62-create-an-intelligent-scenario-model)
- [6.3 - Test the ABAP AI SDK within the ABAP helper class](#exercise-63-test-the-abap-ai-sdk-within-the-abap-helper-class)
- [Summary & Next Exercise](#summary--next-exercise)

> ℹ️ **Reminder**: Don't forget to replace the suffix placeholder **`###`** with your chosen or assigned group ID in the exercise steps below. 

## Exercise 6.1: Create an intelligent scenario
[^Top of page](#)

> Create an intelligent scenario, aka _ISLM scenario_, which is an ABAP representation of a predictive business specific use case - **`SIDEBYSIDE`** in the present exercise.

 <details>
  <summary>🔵 Click to expand!</summary>

  1. Go to the **Project Explorer** in ADT, right-click on your package ![package](images/adt_package.png)**`ZRAP120_AI_###`**, and select **New** > **Other** from the context menu and then choose **`Intelligent Scenario`** in the wizard.

  2. Maintain the required information with the corresponding values provided below and click on **Next**.    
     - Name: **`ZINTS_RAP120_AI_###`**
     - Description: **`RAP AI Intelligent Scenario ###`**
     - Scenario Technology: **`SIDEBYSIDE`**
     
  3. Select your transport request and click **Finish** to create the new intelligent scenario.
 
  4. Maintain the required information with the corresponding values provided below in the editor as shown on the screenshot below: 
     - Intelligent Scenario Type: **`SAPGENAI`**
     - Automate Turnkey Switch On: ☑️ (PS: _Make sure to check the checkbox._)
     - Usage type: **`CUSTOMER`** 
     - OAuth Profile: (_This information will be filled automatically._)
  
  5.  Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes.
  
      ![](/exercises/ex06/images/6_1_ints_abap_ai_sdk.gif)

</details>

## Exercise 6.2: Create an intelligent scenario model
[^Top of page](#)

> Create an intelligent scenario model, aka _ISLM model_.

 <details>
  <summary>🔵 Click to expand!</summary>

  1. In ADT, go to the **Project Explorer**, right-click on your package ![package](images/adt_package.png)**`ZRAP120_AI_###`**, and select **New** > **Other** from the context menu and then choose  **`Intelligent Scenario Model`** in the wizard.

  2. Maintain the information provided below and click **Next**.  
     - Name: (_The name will be filled automatically by the entry in Model Name_) 
     - Description: **`RAP AI Intelligent Scenario Model ###`**
     - Intelligent Scenario Name: **`ZINTS_RAP120_AI_###`** 
     - Model Name: **`ZMODEL_RAP120_AI_###`**  (_PS: You can use the "Browse..." button to assign the previously created Intelligent scenario name_.)

     > ℹ️ **Please note**: The object name of the intelligent scenario model is auto generated based on the `Intelligent Scenario Name` and `Model Name`

  3. Select your transport request and click **Finish** to create the new intelligent scenario model.  
  
  3. In the editor, maintain values for the fields `ExecutableId`, `Large Language Model Name` and `Large Language Model Version` fields with your desired available model. For example, (_see below_)
     - ExecutableId: **`azure-openai`**
     - Large Language Model Name: **`gpt-4o`**
     - Large Language Model Version: **`2024-05-13`** 

     <br/>
  
     > ℹ️ **Please note**: The value help displays a list of supported Executable IDs that is supported by the ABAP system. The object name of the intelligent scenario model is auto generated based on the `Intelligent Scenario Name` and Model Name
     > 
     > ℹ️ **Info:** Feel free to check [Recommendations and constraints for the ABAP AI SDK | SAP Help Portal](https://help.sap.com/docs/abap-ai/generative-ai-in-abap-cloud/recommendations-and-constraints-for-abap-ai-sdk?state=DRAFT) 

  4. Save ![save icon](images/adt_save.png) and activate ![activate icon](images/adt_activate.png) the changes.

     ![](/exercises/ex06/images/6_2_intm_abap_ai_sdk.gif)
  
</details>


## Exercise 6.3: Test the ABAP AI SDK within the ABAP helper class
[^Top of page](#)

> Now test the ABAP AI SDK powered by ISLM within the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`**.

<details>
  <summary>🔵 Click to expand!</summary>

  1. Open the ABAP helper class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** and paste the source code provided below in the **`if_oo_adt_classrun~main`** method. 
  
  Don't forget to replace all occurences of **`###`** in the source code with your choosen suffix or assigned group ID. You can use use the **Replace All** function by pressing **Ctrl + F** to do that.  

  
  ```ABAP
  METHOD if_oo_adt_classrun~main.
    "We will use this method to test the ABAP AI SDK
    TRY.
      FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = 'ZINTS_RAP120_AI_###' ).
    CATCH cx_aic_api_factory INTO DATA(lx_api).
      out->write( |There was an issue with the factory api: { lx_api->get_longtext(  ) }| ).
    ENDTRY.

    TRY.
      DATA(messages) = api->create_message_container( ).
      messages->set_system_role( 'You are a travel expert' ).
      messages->add_user_message( 'Provide me recommendations on five activities to do in Chicago' ).
      DATA(answer) = api->execute_for_messages( messages )->get_completion( ).
      out->write( answer ).
    CATCH cx_aic_completion_api INTO DATA(lx_completion).
        out->write( |There was an issue with the completion api: { lx_completion->get_longtext(  ) }| ).
    ENDTRY.
  ENDMETHOD. 
  ```

The full source code in the class should now look like this:

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
        messages->set_system_role( 'You are a travel expert' ).
        messages->add_user_message( 'Provide me recommendations on five activities to do in Chicago' ).
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
        FINAL(api) = cl_aic_islm_compl_api_factory=>get( )->create_instance( islm_scenario = '<ISLM Scenario provided by the instructor>' ).
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
  
  2. Save![save icon](images/adt_save.png) and activate![activate icon](images/adt_activate.png) the changes.
 
  3. Run the ABAP class ![class](images/adt_class.png)**`ZCL_TRAVEL_HELPER_###`** as ABAP Application (Console) . 
 
     For that, select the **Run** button > **Run As** > **ABAP Application (Console) F9** or press **F9**.    

     ![](/exercises/ex06/images/6_3_class_abap_ai_sdk.gif)
 
</details>


## Summary & Next Exercise
[^Top of page](#)

Now that you've... 
- created an intelligent scenario (aka _ISLM scenario_),
- created an intelligent scenario (aka _ISLM model_), and 
- tested the ABAP AI SDK within an ABAP class,

you can continue with the next exercise – **[Exercise 7: Add a determination and enhance it with the ABAP AI SDK powered by ISLM](../ex07/README.md)**

[Home - RAP120](../../README.md)

---
