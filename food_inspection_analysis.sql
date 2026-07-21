-- Project: Chicago Food Establishment Inspections Analysis
-- Author: Mercedes Brown
-- Data Source: https://data.cityofchicago.org/Health-Human-Services/Food-Inspections-7-1-2018-Present/qizy-d2wf/about_data
-- Description: SQL queries used for cleaning, transforming, and aggregating.
-- Chicago food inspection data for Tableau visualizations.
-- Note: Data was first cleaned using Python Script found here: https://github.com/mercedes-brown/chicago_food_inspections/blob/main/food_inspections_data_cleanup.ipynb


-- ===========================
-- Table Creation for Analysis
-- ===========================

SELECT * INTO temp_ccfi
FROM dbo.cleaned_chicago_food_inspections
WHERE year NOT IN (2018, 2026)
  AND results NOT IN ('Out of Business', 'No Entry', 'Business Not Located', 'Not Ready');


-- =============================
-- Establishment Mapping Cleanup
-- =============================

WITH establishment_mapping AS (
    SELECT * FROM (VALUES
        ('Subway', 'Subway'),
        ('Subway Sandwiches', 'Subway'),
        ('Subway Sandwich', 'Subway'),
        ('Starbucks', 'Starbucks'),
        ('Starbucks Coffee', 'Starbucks'),
        ('Dunkin', 'Dunkin Donuts'),
        ('Chipotle Mexican Grill', 'Chipotle'),
        ('Potbelly Sandwich Works', 'Potbelly'),
        ('Potbelly Sandwich Shop', 'Potbelly'),
        ('Potbelly Sandwich Works Llc', 'Potbelly'),
        ('Mcdonalds', 'McDonalds'),
        ('Mc Donalds', 'McDonalds'),
        ('Popeyes', 'Popeyes'),
        ('Popeyes Chicken', 'Popeyes'),
        ('7-Eleven','7 Eleven'),
        ('Wingstop Restaurant','Wingstop'),
        ('Taco Bell Cantina','Taco Bell'),
        ('Cermak Fresh Market','Cermak'),
        ('Cermak Produce','Cermak'),
        ('Kentucky Fried Chicken','KFC'),
        ('Kfc','KFC'),
        ('Dominos Pizza','Dominos'),
        ('Marianos Fresh Market','Marianos'),
        ('Jj Fish','J & J Fish'),
        ('Jj Fish & Chicken','J & J Fish'),
        ('J & J Fish & Chicken','J & J Fish'),
        ('Sharks Fish & Chicken','Sharks'),
        ('Rosatis Pizza','Rosatis'),
        ('Little Caesar Pizza','Little Caesars'),
        ('Little Caesars Pizza','Little Caesars'),
        ('Nandos Peri-Peri','Nandos Peri Peri'),
        ('Jersey Mikes Subs','Jersey Mikes'),
        ('Corner Bakery Cafe','Corner Bakery'),
        ('Foxtrot Market','Foxtrot'),
        ('Stans Donuts & Coffee','Stans Donuts'),
        ('Giordanos','Giordanos Pizza'),
        ('Billy Goat Tavern','Billy Goat'),
        ('Roti Modern Mediterranean','Roti'),
        ('Citgo Gas','Citgo'),
        ('Popeyes #862','Popeyes')
    ) AS x(aka_name, grouped_name)
)

UPDATE t
SET aka_name = m.grouped_name
FROM temp_ccfi t
JOIN establishment_mapping m ON t.aka_name = m.aka_name;


-- ==============================================
-- Violation Category, Title, and Priority Counts
-- ==============================================

CREATE TABLE violation_lookup (
    violation_num INT PRIMARY KEY,
    violation_title VARCHAR(255),
    priority VARCHAR(10)
);

INSERT INTO violation_lookup (violation_num, violation_title, priority) VALUES
(1, 'Person in Charge', 'high'),
(2, 'Sanitation Certificate', 'high'),
(3, 'Employee Knowledge', 'high'),
(4, 'Restriction/Exclusion', 'high'),
(5, 'Vomit/Diarrhea Procedures', 'high'),
(6, 'Eating/Drinking Rules', 'high'),
(7, 'No Bodily Discharge', 'high'),
(8, 'Handwashing facilities and practices', 'high'),
(9, 'Cross contamination prevention', 'high'),
(10, 'Handwash Sink Access', 'medium'),
(11, 'Food Obtained from Approved Source', 'medium'),
(12, 'Food Obtained at Proper Temperature', 'medium'),
(13, 'Food in good condition, safe, & unadulterated', 'medium'),
(14, 'Required Records Available', 'medium'),
(15, 'Food properly labeled and stored', 'medium'),
(16, 'Food protected during storage/prep/display', 'medium'),
(17, 'Proper garbage disposal', 'medium'),
(18, 'Proper Cooking Time & Temperature', 'medium'),
(19, 'Proper Reheating Procedures', 'medium'),
(20, 'Proper Cooling Time & Temperature', 'medium'),
(21, 'Proper hot holding temperatures', 'medium'),
(22, 'Proper cold holding temperatures', 'medium'),
(23, 'Proper date marking and disposition', 'medium'),
(24, 'Time as a Public Health Control; procedures & records', 'medium'),
(25, 'Consumer advisory provided for raw/undercooked food', 'medium'),
(26, 'Pasteurized foods used; prohibited foods not offered', 'medium'),
(27, 'Food additives: approved and properly used', 'medium'),
(28, 'Toxic substances properly identified, stored, & used', 'medium'),
(29, 'Compliance with variance/specialized process/HACCP', 'medium'),
(30, 'Pasteurized eggs used where required', 'medium'),
(31, 'Water & ice from approved source', 'medium'),
(32, 'Variance obtained for specialized processing methods', 'medium'),
(33, 'Proper cooling methods used', 'medium'),
(34, 'Plant food properly cooked for hot holding', 'medium'),
(35, 'Approved thawing methods used', 'medium'),
(36, 'Thermometers provided & accurate', 'medium'),
(37, 'Food properly labeled; original container', 'medium'),
(38, 'Insects, rodents, & animals not present', 'medium'),
(39, 'Contamination prevented during food prep', 'medium'),
(40, 'Personal cleanliness', 'medium'),
(41, 'Wiping cloths: properly used & stored', 'low'),
(42, 'Washing fruits & vegetables', 'low'),
(43, 'In-use utensils: properly stored', 'low'),
(44, 'Utensils, equipment & linens properly stored & handled', 'low'),
(45, 'Single-use/service articles properly stored & used', 'low'),
(46, 'Gloves used properly', 'low'),
(47, 'Contact Surfaces Cleanable & Designated', 'low'),
(48, 'Warewashing facilities: installed & maintained', 'low'),
(49, 'Non-food contact surfaces clean', 'low'),
(50, 'Hot & cold water available; adequate pressure', 'low'),
(51, 'Plumbing installed; proper backflow devices', 'low'),
(52, 'Sewage & waste water properly disposed', 'low'),
(53, 'Toilet facilities supplied & cleaned', 'low'),
(54, 'Garbage & refuse properly disposed', 'low'),
(55, 'Physical facilities installed, maintained & clean', 'low'),
(56, 'Adequate ventilation & lighting', 'low'),
(57, 'All food employees have food handler training', 'low'),
(58, 'Allergen training as required', 'low'),
(59, 'Previous priority foundation violation corrected', 'low'),
(60, 'Previous core violation corrected', 'low'),
(61, 'Summary Report displayed and visible to the public','low'),
(62, 'Compliance with Clean Indoor Air Ordinance','low'),
(63, 'Removal of Suspension Sign','low');

WITH exploded AS (
    SELECT
        t.inspection_id,
        LTRIM(RTRIM(nums.[key])) AS position_index,
        LTRIM(RTRIM(nums.[value])) AS violation_num,
        LTRIM(RTRIM(cats.[value])) AS category,
        pris.[value] AS priority
    FROM temp_ccfi t
    CROSS APPLY OPENJSON(
        '["' + REPLACE(t.violation_nums, ';', '","') + '"]') nums
    OUTER APPLY OPENJSON(
        '["' + REPLACE(t.violation_categories, ';', '","') + '"]') cats
    OUTER APPLY OPENJSON(
        '["' + REPLACE(t.violation_priorities, ';', '","') + '"]') pris
    WHERE nums.[key] = cats.[key]
      AND nums.[key] = pris.[key]
)

SELECT
    e.category,
    CAST(e.violation_num AS INT) AS violation_num,
    l.violation_title,
    l.priority,
    COUNT(*) AS instance_count
FROM exploded e
LEFT JOIN violation_lookup l
    ON CAST(e.violation_num AS INT) = l.violation_num
GROUP BY e.category, e.violation_num, l.violation_title, l.priority
ORDER BY CAST(e.violation_num AS INT);


-- =================================
-- Priority Violations Count by Year
-- =================================

WITH exploded AS (
    SELECT
        t.inspection_id,
        t.year,
        LTRIM(RTRIM(nums.[key])) AS position_index,
        LTRIM(RTRIM(nums.[value])) AS violation_num,
        LTRIM(RTRIM(cats.[value])) AS category,
        pris.[value] AS priority
    FROM temp_ccfi t
    CROSS APPLY OPENJSON('["' + REPLACE(t.violation_nums, ';', '","') + '"]') nums
    OUTER APPLY OPENJSON('["' + REPLACE(t.violation_categories, ';', '","') + '"]') cats
    OUTER APPLY OPENJSON('["' + REPLACE(t.violation_priorities, ';', '","') + '"]') pris
    WHERE nums.[key] = cats.[key]
      AND nums.[key] = pris.[key]
)
SELECT
    COALESCE(l.priority, 'Pass') AS priority,
    e.year,
    COUNT(*) AS priority_count
FROM exploded e
LEFT JOIN violation_lookup l
    ON CAST(e.violation_num AS INT) = l.violation_num
GROUP BY COALESCE(l.priority, 'Pass'), e.year
ORDER BY e.year, priority;


-- =====================
-- Result Counts by Year
-- =====================

SELECT 
    year, 
    results, 
    COUNT(inspection_id) AS num
FROM temp_ccfi
GROUP BY year, results
ORDER BY year, results;


-- ================================================
-- Top 10 Establishments by Most Failed Inspections
-- ================================================

WITH top_10 AS (
    SELECT TOP 10
        aka_name,
        COUNT(inspection_id) AS inspection_count
    FROM temp_ccfi
    GROUP BY aka_name
    ORDER BY COUNT(inspection_id) DESC
)
SELECT
    t.aka_name,
    t.inspection_count,
    COUNT(DISTINCT c.address) AS unique_locations
FROM top_10 t
JOIN temp_ccfi c ON t.aka_name = c.aka_name
GROUP BY t.aka_name, t.inspection_count
ORDER BY t.inspection_count DESC;


-- =======================================================
-- Top 10 Establishments Yearly Rate of Failed Inspections
-- =======================================================

WITH top_10 AS (
    SELECT TOP 10
        aka_name,
        COUNT(inspection_id) AS total_inspections
    FROM temp_ccfi
    WHERE results = 'Fail'
    GROUP BY aka_name
    ORDER BY COUNT(inspection_id) DESC
),
yearly_counts AS (
    SELECT
        t.aka_name,
        t.year,
        COUNT(t.inspection_id) AS num
    FROM temp_ccfi t
    JOIN top_10 x ON t.aka_name = x.aka_name
    WHERE t.results = 'Fail'
    GROUP BY t.aka_name, t.year
)
SELECT
    aka_name,
    year,
    num,
    LAG(num) OVER (PARTITION BY aka_name ORDER BY year) AS prior_year_num,
    ROUND((CAST(num AS FLOAT) - LAG(num) OVER (PARTITION BY aka_name ORDER BY year))
        / NULLIF(LAG(num) OVER (PARTITION BY aka_name ORDER BY year), 0) * 100, 2) AS yoy_percent_change
FROM yearly_counts
ORDER BY aka_name, year;


-- ==========================================
-- Establishments with 30+ Failed Inspections
-- ==========================================

SELECT 
    aka_name,
    COUNT(inspection_id) AS f_inspection_cnt
FROM temp_ccfi
WHERE results = 'Fail'
GROUP BY aka_name
HAVING COUNT(inspection_id) >= 30
ORDER BY f_inspection_cnt DESC;


-- ==========================================
-- Top 10 Establishment with Location Counts
-- ==========================================

WITH top_10 AS (
    SELECT TOP 10
        aka_name,
        COUNT(inspection_id) AS f_inspection_cnt
    FROM temp_ccfi
    WHERE results = 'Fail'
    GROUP BY aka_name
    ORDER BY COUNT(inspection_id) DESC
    )
SELECT
    t.aka_name,
    t.f_inspection_cnt,
    COUNT(DISTINCT c.address) AS unique_locations
    FROM top_10 t
JOIN temp_ccfi c ON t.aka_name = c.aka_name
WHERE c.results = 'Fail'
GROUP BY t.aka_name, t.f_inspection_cnt
ORDER BY t.f_inspection_cnt DESC;


-- =================================================
-- Top 10 Establishment with Location Counts by Year
-- =================================================

WITH qualifying_names AS (
    SELECT TOP 10 
        aka_name
    FROM temp_ccfi
    WHERE results = 'Fail'
    GROUP BY aka_name
    ORDER BY COUNT(inspection_id) DESC)

SELECT
    t.aka_name,
    t.year,
    COUNT(t.inspection_id) AS f_inspection_cnt
FROM temp_ccfi t
JOIN qualifying_names q ON t.aka_name = q.aka_name
WHERE t.results = 'Fail'
GROUP BY t.aka_name, t.year
ORDER BY t.year, f_inspection_cnt DESC;


-- ========================================================================
-- Inspection Type Count by Year (Removed types with less than 20 in total)
-- ========================================================================

SELECT 
    CASE 
        WHEN inspection_type IN (
            'Assessment', 
            'Consultation', 
            'COVID COMPLAINT', 
            'No Entry', 
            'Non-Inspection'
            ) 
        THEN 'Other'
        ELSE inspection_type
    END AS inspection_type,
    year,
    COUNT(*) AS inspection_count
FROM temp_ccfi
GROUP BY 
    CASE 
        WHEN inspection_type IN (
            'Assessment', 
            'Consultation', 
            'COVID COMPLAINT', 
            'No Entry', 
            'Non-Inspection') 
        THEN 'Other'
        ELSE inspection_type
    END,
    year
ORDER BY year, inspection_type DESC;