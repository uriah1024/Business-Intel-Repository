## This tool allows districts to generate special codes for teachers. 
An explanation of the tool's behavior and input options is below:

> *Note: Customization of this tool is not supported at this time.*

---

## **Behavior**

* **Staff Identification:** This tool looks for active staff by checking both statuses on staff and user account records.
* **Selection Logic:** If the staff is marked as active by the district preference and enabled for the user's login record, they will be collected for application. Additional criteria can be applied to limit which staff this tool affects.
* **Special Code Generation:** Once the staff are collected, the tool will begin to generate 2 special codes for staff: A **'pass'** and **'fail'** code. These are generated at *Staff View > Tools > Special Codes*.
* **Hard-Programmed Attributes:** The tool is hard-programmed to set these codes to be:
    * Exempt from calculations.
    * Not counted as missing.
    * Color-coded **dark blue**.
* **Input Requirements:** The tool allows for only a single code to be entered; however, if both are missing, a unique exception error is provided to prevent the tool from being run. The exception will begin with: *"This tool is intended to generate at least one code. Please supply a code when running this tool."*
* **Safety Match:** Included is a safety to identify a matching code (if previously run) or a similar code, which prevents adding your new code to the staff. A message is provided to identify which staff have this match for review.
* **Interruption/Rollback:** The tool can be interrupted and will attempt to roll back any codes already added. *Please be careful to not rely on this function and review your inputs before running.*

---

## **Inputs**

* **School:** If blank, it will run for the entire district. If schools are provided, only staff at those schools will be considered.
* **Pick Lists:** Note that pick lists allow for multiple selections.
* **Limit Staff by Type?** Selecting this checkbox enables a **multiple** selection picklist for limiting which staff to include based on the district's type codes.
* **Limit Staff by Department Code?** Selecting this checkbox enables a **multiple** selection picklist for limiting which staff to include based on the district's department codes.
* **Limit Staff by Bargaining Unit?** Selecting this checkbox enables a **multiple** selection picklist for limiting which staff to include based on the district's bargaining unit codes.
* **PASSING/FAILING Grade Entry:** This is a text box that allows any entry. It is best to keep these codes to **4 or less characters**. Again, *one of these fields can be left blank.*
* **Preview Mode:** On by default, this selection prevents the tool from saving any data to the database. 
    * **Warning:** This tool is not capable of undoing code generation. Manual deletion or a data restore are the only ways to revert incorrect code entries.
* **Provide Verbose Logging:** This selection provides a very detailed breakdown of the tool's functioning, primarily for troubleshooting purposes.