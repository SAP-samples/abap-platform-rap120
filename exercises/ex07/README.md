[Home - RAP120](../../README.md)


# Exercise 7: Play Around with the ABAP Cloud Generator - Transactional App from Scratch💎

## Introduction

In this exercise, you can play around with ABAP Cloud Generator - Transactioanal App from Scratch using your own prompts. 

### Exercises

- [7.1 - Create another ABAP Package](#exercise-71-create-another-abap-package)
- [7.2 - Play Around with the ABAP Cloud Generator: Transactional App from Scratch](#exercise-72-play-around-with-the-abap-cloud-generator-transactional-app-from-scratch)
- [Summary & Next Exercise](#summary--next-exercise)  

### Exercises

## Exercise 7.1: Create another ABAP Package
[^Top of page](#)

> Create a new exercise package ![package](../images/adt_package.png)**`ZRAP120_RAP_GEN_###`**, where **`###`** with your suffix.   
> This ABAP package will contain all the new artifacts you will be generated in this exercise.

 <details>
  <summary>🔵 Click to expand!</summary>

   1. Go to the **Project Explorer** in ADT, right-click on your ABAP Cloud Project, select **New** > **ABAP Package** from the context menu.
 
      Maintain the required information provided below and then click **Next >**. 
 
      Replace the placeholder **`###`** with your chosen or assigned suffix, which should be a combination of three (3) numbers and/or letters, e.g. **`476`** or **`AP3`**.
 
      > ℹ️ The suffix **`000`** is used for the screenshots in this exercise. Use a different suffix.            
 
      - Name: **`ZRAP120_RAP_GEN_###`**
      - Description: _**`Play around with ABAP Cloud Generator`**_
      - Select the box **Add to favorites package**
      - Superpackage: **`ZLOCAL`**         
 
      Click **Next >**, select a transport request or create a new one, and click **Finish** to create the package.

</details>


## Exercise 7.2: Play Around with the ABAP Cloud Generator: Transactional App from Scratch💎
[^Top of page](#)

> Generate read-only and transactional an OData-based UI service.

 <details>
  <summary>🔵 Click to expand!</summary>

   1. Right-click on your ABAP package **`ZRAP120_RAP_GEN_###`** and select **New** > **Generate ABAP Repository Objects** from the context menu.
      
      Select the entry **`OData UI Service from Scratch`** in the wizard and click **Next >** to continue.
      
      Maintain your package name **`ZRAP120_RAP_GEN_###`** and then click **Next >**.                  

   3. Enter a prompt with a description of the UI service you would like to generate, and press **Enter**.

      🟠 For prompts examples, see this document: **[📄Prompt Guidelines and Examples for ABAP GenAI](./ABAP_GenAI_Prompt_Guidelines.md)**
 
   4. Joule will display a summary of the entities with their correspoding fields that they will be created. Click on **Accept**

   5. Now, you can check the entities and their corresponding fields. You can also change the data type of them. Click on **Next >**

   5. Joule shows a preview of all artifacts that will be generated.
 
      You can for example have a look at the database table definition.
 
      > ℹ️ **Hint:** You don't have to generate all your prompts. 
      > - Make good use of the _**Preview**_ to have a look at the artifacts that will be generated. 
      > - Switch back and forth between the **Prompt** and the **Preview** to watch your changes, before starting the generation.

 
   5. Click **Next >**, select a transport request, and click **Finish** to start the generation of all artifacts.
 
   6. Now that the artifacts are generated, publish the local service endpoint of your service binding![service binding] - to view the service URL, entity sets, and associations - by clicking **Publish** in the service binding editor.
 
   7. Preview the generated apps and play around in the browser.
 
      For that, select an entity in the area **Entity Set** in your service binding![service binding](../images/adt_srvb.png), and double-click on it or click **Preview** to start the Fiori Elements App Preview and open the app in the browser. 
 
 </details>


## Summary & Next Exercise
[^Top of page](#)

Congratulations, you have completed the exercise! 🎉

We hope you have gained some insight into how GenAI can help ABAP developers build applications and services!

You can now return to ► **[Home - RAP120](/README.md#exercises)**.

## License

Copyright (c) 2024 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
