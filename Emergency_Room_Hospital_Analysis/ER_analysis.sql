/*First of all I created hosp_emergency table and and imported the csv dataset on Emergency room. Now after successful Import we will perform needed analysis on the Dataset to extract needed features*/

--SELECT*FROM hosp_emergency; /*(checking the imported data)*/
--SELECT DISTINCT hosp_emergency.department_referral from hosp_emergency; /*(making a target point from the imported data)*/

/*
This SQL query is made to retrieve specific data on patients that visit the hospital's Orthopaedics department. It offers understanding into patient characteristics, levels of satisfaction, and other important elements. 

   Patients are categorised by age, ethnicity, and gender in the query;  examines satisfaction ratings. The outcomes are grouped and combined for additional research and visualisation.

   Written by Abir Maiti

   Date: 18/09/2023

*/

WITH OrthopedicsPatients AS (
    SELECT
        patient_id,
        patient_age,
        patient_race,
        patient_gender,
        patient_sat_score AS satisfaction_score,
        CASE
            WHEN patient_sat_score >= 8 THEN 'High Satisfaction'
            WHEN patient_sat_score >= 5 THEN 'Medium Satisfaction'
            ELSE 'Low Satisfaction'
        END AS satisfaction_level,
        CASE
            WHEN patient_age < 18 THEN 'Pediatric'
            WHEN patient_age >= 18 AND patient_age < 65 THEN 'Adult'
            ELSE 'Senior'
        END AS age_group,
        CASE
            WHEN patient_race IN ('White', 'Asian') THEN 'Majority Ethnicity'
            ELSE 'Minority Ethnicity'
        END AS ethnicity_group
    FROM
        hosp_emergency
    WHERE
        department_referral = 'Orthopedics'
)
SELECT
    age_group,
    ethnicity_group,
    patient_gender,
    AVG(patient_age) AS average_age,
    COUNT(*) AS total_patients,
    AVG(satisfaction_score) AS average_satisfaction_score,
    COUNT(CASE WHEN satisfaction_level = 'High Satisfaction' THEN 1 END) AS high_satisfaction_count,
    COUNT(CASE WHEN satisfaction_level = 'Medium Satisfaction' THEN 1 END) AS medium_satisfaction_count,
    COUNT(CASE WHEN satisfaction_level = 'Low Satisfaction' THEN 1 END) AS low_satisfaction_count
FROM
    OrthopedicsPatients
GROUP BY
    age_group,
    ethnicity_group,
    patient_gender
ORDER BY
    age_group,
    ethnicity_group,
    patient_gender;




