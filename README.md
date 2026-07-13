# Chicago Food Inspections Cleanup
Python / Jupyter script used to clean the Food Inspections data found in the [Chicago Data Portal](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections-7-1-2018-Present/qizy-d2wf/about_data), ensuring the data is ready for export and analysis.  Information for violation codes can be [found here](https://www.chicago.gov/city/en/depts/cdph/provdrs/food_safety/svcs/understand_healthcoderequirementsforfoodestablishments.html) for more information on interpretting some of the data as well as the choices made to clean up the file.

PLEASE NOTE - after downloading the file from the portal I renamed it to 'Food_Inspections'.  This updated name is included in the first cell.

Markdown cells are included to explain blocks of code.  The highlights include:
  - Basic formatting cleanup and standidardization.
  - Cleaning establishment names, licenses, and addresses to ensure establishments that are the same are connected rather than considered unique due to typos or inconsistent formatting.
  - Breaking out and establishing clear columns for individual violations per entry, their categories, and whether they are considered high, medium, or low risk as established by the city.
  - Cleaned up facility type and added a neighborhood column for ease.
  - Optional last-minute clean-up and export included.

Fair warning - I do not recommend looking up your favorite restaurant :)
