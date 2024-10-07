[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-platform-rap120)](https://api.reuse.software/info/github.com/SAP-samples/abap-platform-rap120)

# RAP120 - Build SAP Fiori Apps with ABAP Cloud powered by Joule's ABAP developer capabilities

## Description

This repository contains the **solution packages** for jump-start session called **AD180 - Build SAP Fiori Apps with ABAP Cloud powered by Joule's ABAP developer capabilities** at SAP TechEd Virtual 2024.

ABAP Cloud is the development model for building clean core compliant business apps, services, and extensions on SAP S/4HANA Cloud, SAP S/4HANA, and SAP BTP ABAP Environment. ABAP Cloud covers different development scenarios, i.e. transactional, analytical, and integration scenarios, including enterprise search capabilities. The ABAP RESTful Application Programming Model (RAP) ist at the heart of ABAP Cloud for building transactional SAP Fiori apps, OData-based Web APIs, local APIs, and business events.

In this hands-on tutorial, you will learn how generative AI can support the development of clean core compliant draft-enabled transactional SAP Fiori elements apps with the ABAP RESTful Application Programming Model (RAP) as well as read-only SAP Fiori elements apps in ABAP Cloud. You will also learn how to define and raise business events in RAP-based applications that can be consumed locally or remotely via SAP Event Mesh for loosely coupled integration scenarios.


## 📤Solution Package
[^Top of page](#)

> You can import the solution package **`ZRAP120_SOL`** and its sub-packages **`ZRAP120_AGENCY_SOL`** and **`ZRAP120_EMPLOYEE_SOL`** into your system. 
>
> The supported ABAP systems are SAP BTP ABAP Environment, SAP S/4HANA Cloud Public Edition, or at least the release 2023 of SAP S/4HANA Cloud Private Edition and SAP S/4HANA. 
> 
> The appropriate flavor of the [ABAP Flight Reference Scenario](https://github.com/SAP-samples/abap-platform-refscen-flight) must available in the system before importing the solution package.

Follow these steps to import the solution packages into your system:

1. [Install the abapGit plugin in your ABAP Development Tools (ADT) for Eclipse](https://developers.sap.com/tutorials/abap-install-abapgit-plugin.html) if you have not already done so.
2. Create the ABAP package **`ZRAP120_SOL`** in ADT in the relevant system.
      - Package Name: `ZRAP120_SOL`
      - Description: _`RAP120 - Solution Packages`_
      - ✅ _Add to favorites packages_
      - Superpackage: `ZLOCAL`
      
4. Open the **abapGit Repositories** view in ADT 
5. Create a link to the `rap120` abapGit repository by clicking on the **+** icon and maintaining the required information in the _**Link New abapGit Repository...**_ window:    
    📤 Git repository URL: `https://github.com/SAP-samples/abap-platform-rap100`  
    👤 Credentials: Enter your user and either your password or personal access token.   
    📦 Package: `ZRAP120_SOL`
6. Now pull/import the FULL solution implementation using the context menu _**Pull...**_.
7. Activate the imported development objects (**Ctrl+Shift+F3**) and publish the local endpoint of the service bindings `ZUI_AGENCYSOL_O4` and `ZUI_EMPLOYEESOL_O4` .

<!--
### Create the required packages prior the import

**Main Package:**
- Package Name: **`ZRAP120_SOL`**
- Description: _**`RAP120 - Solution Packages`**_
- Superpackage: **`ZLOCAL`**

**Subpackage 01:**
- Package Name: **`ZRAP120_AGENCY_SOL`**
- Description: _**`RAP120 - Block A: Solution Package for the Agency App`**_
- Superpackage: **`ZRAP120_SOL`**

**Subpackage 02:** 
- Package Name: **`ZRAP120_EMPLOYEE_SOL`**
- Description: _**`RAP120 - Block B: Solution Package for the Employee App`**_
- Superpackage: **`ZRAP120_SOL`**

-->

## Known Issues
[^Top of page](#)

No known issues. 

## How to obtain support
[^Top of page](#)

[Create an issue](../../issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Further Information
[^Top of page](#)

 - [ABAP RESTful Application Programming Model (RAP)](https://community.sap.com/topics/abap/rap) | SAP Community page   
 - [Modernization with RAP](https://blogs.sap.com/2021/10/18/modernization-with-rap/) | SAP Blogs
 - [ABAP Cloud Roadmap Information](https://help.sap.com/docs/abap-cross-product/roadmap-info/ui-services) | SAP Help Portal
 - [Explore the interactive SAP BTP ABAP Environment road map](https://roadmaps.sap.com/board?range=CURRENT-LAST&PRODUCT=6EAE8B28C5D91EDA9FF40F3CC2DBE0E6&PRODUCT=73555000100800001164) | SAP Road Map Explorer
 - [RAP100 Tutorials Mission on SAP Developers Center](https://developers.sap.com/mission.sap-fiori-abap-rap100.html) | SAP Tutorials
 - [Create an SAP Fiori elements app with SAP Business Application Studio and deploy it to the SAP BTP ABAP Environment](https://developers.sap.com/tutorials/abap-environment-deploy-fiori-elements-ui.html) | SAP Tutorials

## Contributing
If you wish to contribute code, offer fixes or improvements, please send a pull request. Due to legal reasons, contributors will be asked to accept a DCO when they create the first pull request to this project. This happens in an automated fashion during the submission process. SAP uses [the standard DCO text of the Linux Foundation](https://developercertificate.org/).

## License
Copyright (c) 2024 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSE) file.
