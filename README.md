# Chicago Food Inspections Data Analysis Project

## Python Cleanup

Python / Jupyter script used to clean Chicago Food Inspection Data.
Data and definitions were sourced from:

[Chicago Food Inspections Data Portal](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections-7-1-2018-Present/qizy-d2wf/about_data)

[Priority and Violations Guide](https://www.chicago.gov/city/en/depts/cdph/provdrs/food_safety/svcs/understand_healthcoderequirementsforfoodestablishments.html) 

*Please note: after downloading the file from the portal, I renamed it to `Food_Inspections`. This updated name is referenced in the first cell.*

Markdown cells are included throughout to explain each block of code. Highlights include:
- Basic formatting cleanup and standardization
- Cleaning establishment names, licenses, and addresses to ensure establishments that are the same are connected, rather than treated as unique due to typos or inconsistent formatting
- Breaking out individual violations per entry into clear columns, including their categories and risk level (high, medium, or low) as established by the city
- Cleaned up facility type and added a neighborhood column for ease of analysis
- Optional last-minute cleanup and export included

---

## SQL Scripts

This script contains the SQL queries used to clean, transform, and aggregate Chicago food establishment inspection data for use in Tableau visualizations.

**Environment:** Written for Microsoft SQL Server (T-SQL). Code may not run as-is in other database systems due to syntax differences (e.g., `OPENJSON`, 
`CROSS APPLY`/`OUTER APPLY`).

**Usage:** Run queries sequentially in SQL Server Management Studio (SSMS) or your preferred SQL client. Each section is labeled with a title describing its purpose.

---

## Tableau Visualization

Interactive dashboards and a storyboard visualizing Chicago food establishment inspection data, including failure rates, violation priority levels, and 
trends by establishment, year, and location.

[**View on Tableau Public**](https://public.tableau.com/shared/73GSYDR4X?:display_count=n&:origin=viz_share_link)

---

## Disclaimer

This project is independent and is not affiliated with, endorsed by, or produced on behalf of the City of Chicago, the Chicago Department of Public Health, or any other entity. Data reflects inspection records as reported by CDPH and may not match real-time records on the Chicago Data Portal. This analysis is intended for informational purposes only and should not be used as an official record of establishment compliance.

---

*Fair warning — I do not recommend looking up your favorite restaurant :)*
