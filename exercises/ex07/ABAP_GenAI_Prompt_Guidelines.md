# Prompt Guidelines and Examples for ABAP GenAI

To achieve good results with your prompts, please consider the following recommendations. 

## Accuracy 

The quality of a response received from a Large Language Models (LLMs) heavily depends on the level of detail 

comprised in your prompt. The more accurate your prompt, the greater the probability that the response 

received from the AI matches your expectations. Therefore, it is recommended to describe every requirement 

for the RAP Fiori service to be generated accurately. 


## Context 

As mentioned above, the prompt you enter in the wizard is combined with a system prompt before it is sent 

to the AI for evaluation. The prompt provided by the system already contains the required context information 

of your request. Adding general information about the ABAP RESTFul Application Programming Model (RAP), 

the general structure of RAP business objects or the purpose of their artifacts is not required. 

Within the given scope, however, you should describe your requirement accurately, see section above. 


## Terminology 

Avoid ambiguity in your prompts by using the correct terminology when describing the read-only or transactional 
(RAP-based) Fiori service to be generated. For this purpose, choose your terms in accordance with the related technology, e.g. composition association in RAP to describe the composition hierarchy of a RAP business object.


## Model-related Recommendations 

Specify the entities to be included in your data model as accurately as possible. Describe their purpose, the 

desired naming convention and their cardinality, where required. 

**By default**, the wizard generates draft-enabled OData V4 Fiori UI services. In case your requirements differ 

from these defaults, specify them accordingly. 


# Prompt Examples 

Feel free to play around with different types of prompts. If you want to get an impression of how meaningful prompts 

with good results can look like, please refer to the following examples. 

Replace `###` with your own desired prefix or suffix. 

---

### Example 1: Generate a read-only OData V4 UI service


```PROMPT
Generate a read-only application 
Generate a library application. Create entities for library branches, book stock, user and borrowing information. Generate appropriate fields, at least 10 per entity. Use Prefix ‚TST‘ and project name ‚My Library‘.
````

```PROMPT
Generate a read-only application for managing agencies and employees. 
The employee entity requires the fields employee_id, first_name, last_name, salary, and manager_id.
Use numerical text data type with length 8 like data types for the fields employee_id and manager_id. 
Use character like data types for the other fields.
The field salary is a currency field. 

Create the object names with the suffix '###'.
````


### Example 2: Enhance the application

**Add fields and change data types**

```PROMPT
Add new field ‚…‘ for entity ‚…‘. Use ‚…‘ as Data Element for it.​

Add new field ‚…‘ for entity ‚…‘ for representation of start date​

Change Data Type( lenght, decimals etc ) of field ‚…‘
````

**Add new entites based on CDS or as child of other**

```PROMPT
Create entity ‚…‘, use CDS Entity ‚…‘ as template.
````

```PROMPT
Add new entity with name ‚…‘ as child of entity ‚…‘​
````

## License

Copyright (c) 2024 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.