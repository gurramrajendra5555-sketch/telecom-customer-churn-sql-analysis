/*
Project Name: Student Academic Performance Analytics

Domain: Education Analytics

Dataset: Open University Learning Analytics Dataset (OULAD)

Datset link : https://www.kaggle.com/datasets/saksh1mishr4/oulada-clean-dataset-for-mooc-dropout-prediction?utm_source=chatgpt.com

Objective:
To analyze student academic performance,
engagement behavior, and risk patterns
using SQL analytics techniques.

End Consumer:(Targeted)
- Educational institutions/Universities
Other End consumers:
- Academic Advisors
- Learning Management Teams

Tools Used:
- SQL

-- Perspective: Academic Performance Perspective

-- 10 KPIs
   10 Easy problems
   10 Medium problems
   10 Difficult problems
   10 Univariate problems
   10 Bivariate problems
   10 Multivariate problems
   10 Cte related problems
   10 Window function related problems
*/
-- ==================================

-- 10 KPIs 
-- =====================================
-- 1. Overall Pass Rate
-- =====================================
-- columns used : Final_result
-- Method:
SELECT 
    ROUND(
        (
            SUM(
                CASE 
                    WHEN final_result IN ('Pass', 'Distinction') 
                    THEN 1 
                    ELSE 0 
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS pass_rate
FROM final_dataset;
-- ======================================
-- ======================================
-- 2. Average Student Score
-- ======================================
-- Columns used: average_score
-- Method:
SELECT 
    ROUND(AVG(avg_score),2) AS average_score
FROM final_dataset;
-- ======================================
-- ======================================
-- 3. Student Engagement Rate
-- ======================================
-- Columns used: total_clicks
-- Method:
-- (Engagement thresold at 500 clicks used)
SELECT 
    ROUND(
        (
            SUM(
                CASE
                    WHEN total_clicks > 500
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS engagement_rate

FROM final_dataset;
-- ===================================
-- ===================================
-- 4. Distinction Percentage
-- ===================================
-- Columns used: final_result
-- Method:
SELECT 
    ROUND(
        (
            SUM(
                CASE
                    WHEN final_result = 'Distinction'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS distinction_percentage

FROM final_dataset;
-- ===================================
-- ===================================
-- 5. Module Success Rate
-- ===================================
-- Columns used: code module,final_result
-- Method:
SELECT 
    code_module,

    ROUND(
        (
            SUM(
                CASE
                    WHEN final_result IN ('Pass','Distinction')
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS success_rate

FROM final_dataset

GROUP BY code_module;
-- ====================================

-- ====================================
-- 6. Average Credits Completed
-- ====================================
-- Columns used: studied_credits
-- Method:
SELECT 
    ROUND(AVG(studied_credits),2) AS avg_credits
FROM final_dataset;
-- ====================================

-- ====================================
-- 7. Student Performance Index
-- ====================================
-- Columns used: avg_score,total_clicks,studied_credits
-- Method:
SELECT 
    id_student,

    ROUND(
        (avg_score * 0.5)
        +
        (total_clicks * 0.3)
        +
        (studied_credits * 0.2),
    2) AS performance_index

FROM final_dataset;
-- =====================================

-- =====================================
-- 8. Average Assessment Attempts
-- =====================================
-- Columns used: num_assess_attempted
-- Method:
SELECT
 
    ROUND(
	AVG(num_assess_attempted),
	2) AS avg_assessment_attempts
FROM final_dataset;
-- ======================================

-- ==================================
-- 9. High-Risk Student Ratio
-- ==================================
-- Columns used: avg_score, final_result
-- Method:
SELECT 
    ROUND(
        (
            SUM(
                CASE
                    WHEN avg_score < 40
                    OR final_result = 'Fail'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS high_risk_ratio

FROM final_dataset;
-- ===================================

-- ===================================
-- 10. Academic Excellence Rate
-- ===================================
-- Columns used: avg_score, final_result
-- Method:
SELECT 
    ROUND(
        (
            SUM(
                CASE
                    WHEN avg_score > 85
                    OR final_result = 'Distinction'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS excellence_rate

FROM final_dataset;
-- ====================================

-- ====================================
-- 10 Easy problems
-- ====================================
-- ====================================
-- 1. Count total students
-- ====================================
-- Columns used: id_student
-- Method:
SELECT COUNT(id_student) AS total_students
FROM final_dataset;
-- ====================================

-- ====================================
-- 2. Find average student score
-- ====================================
-- Columns used: avg_score
-- Formula: Average Score = SUM(avg_score) / COUNT(avg_score)
-- Method:
SELECT ROUND(AVG(avg_score),2) AS average_score
FROM final_dataset;
-- =====================================

-- =====================================
-- 3. List students with distinction
-- =====================================
-- Columns used: id_student,final_result
-- Method:
SELECT 
    id_student,
    final_result
FROM final_dataset
WHERE final_result = 'Distinction';
-- =====================================

-- =====================================
-- 4. Count students by gender
-- =====================================
-- Columns used: gender,id_student
-- Method:
SELECT 
    gender,
    COUNT(id_student) AS total_students
FROM final_dataset
GROUP BY gender;
-- =====================================

-- =====================================
-- 5. Count students by final result
-- =====================================
-- Columns used: final_result
-- Method:
SELECT 
    final_result,
    COUNT(*) AS total_students
FROM final_dataset
GROUP BY final_result;
-- ======================================

-- ======================================
-- 6. Find average clicks per student
-- ======================================
-- Columns used: total_clicks
-- Method:
SELECT 
    ROUND(AVG(total_clicks),2) AS average_clicks
FROM final_dataset;
-- ======================================

-- ======================================
-- 7. List students with high engagement
-- ======================================
-- Columns used:id_student,total_clicks
-- Method:
SELECT
        id_student,
        total_clicks
FROM final_dataset
WHERE total_clicks > 1000;
-- =======================================

-- ====================================
-- 8. Count students by region
-- ====================================
-- Columns usesd: region
-- Method:
       SELECT 
       region,
       COUNT(*) AS total_students
FROM final_dataset
GROUP BY region;
-- ====================================

-- =====================================
-- 9. Find students with failed result
-- =====================================
-- Columns used: id_student,final_result
-- Method:
       SELECT 
       id_student,
       final_result
FROM final_dataset
WHERE final_result = 'Fail';
-- =====================================

-- =====================================
-- 10. Calculate average studied credits
-- =====================================
-- Columns used: studied_credits
-- Method:
       SELECT 
       ROUND(AVG(studied_credits),2) AS average_credits
FROM final_dataset;
-- =====================================

--10 Medium problems
-- =====================================
-- 1. Compare average score by gender
-- =====================================
-- Columns used: gender,average_score
-- Method:
SELECT 
    gender,
    ROUND(AVG(avg_score),2) AS average_score
FROM final_dataset
GROUP BY gender;
-- =====================================

-- ==================================
-- 2. Compare pass rate by region
-- ==================================
-- Columns used: region,final_result
-- Method:
SELECT 
    region,

    ROUND(
        (
            SUM(
                CASE
                    WHEN final_result IN ('Pass','Distinction')
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS pass_rate

FROM final_dataset

GROUP BY region;
-- ==================================

-- ==================================
-- 3. Find average clicks by education level
-- ==================================
-- Columns used: highest_education,total_clicks
-- Method:
SELECT
        highest_education,
        ROUND(AVG(total_clicks),2) AS average_clicks
FROM final_dataset
GROUP BY highest_education;
-- ==================================

-- ==================================
-- 4. Analyze engagement vs performance
-- ==================================
-- Columns used: total_clicks,average_score
-- Method:
SELECT 

    CASE
        WHEN total_clicks < 500 THEN 'Low'
        WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS engagement_level,

    ROUND(AVG(avg_score),2) AS average_score

FROM final_dataset

GROUP BY CASE
        WHEN total_clicks < 500 THEN 'Low'
        WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END;
-- ==================================

-- ==================================
-- 5. Compare performance by age group
-- ==================================
-- Columns used: age_band,average_score
-- Method:
SELECT 
    age_band,
    ROUND(AVG(avg_score),2) AS average_score
	
FROM final_dataset

GROUP BY age_band;
-- ==================================

-- ==================================
-- 6. Find top-performing modules
-- ==================================
-- Columns used: code_module,average_score
-- Method:
SELECT 
    code_module,
    ROUND(AVG(avg_score),2) AS average_score
	
FROM final_dataset

GROUP BY code_module
ORDER BY average_score DESC;
-- ==================================

-- ==================================
-- 7. Compare score by disability status
-- ==================================
-- Columns used: disability,average_Score
-- Method:
SELECT 
    disability,
    ROUND(AVG(avg_score),2) AS average_score
	
FROM final_dataset

GROUP BY disability;
-- ==================================

-- ==================================
-- 8. Analyze repeat attempts vs score
-- ==================================
-- Columns used: num_of_prev_attempts, average_score
-- Method:
SELECT 
    num_of_prev_attempts,
    ROUND(AVG(avg_score),2) AS average_score
	
FROM final_dataset

GROUP BY num_of_prev_attempts;
-- ===================================

-- ===================================
-- 9. Compare module-wise pass rates
-- ===================================
-- Columns used: code_module,pass-rate
-- Method:
SELECT 
    code_module,

    ROUND(
        (
            SUM(
                CASE
                    WHEN final_result IN ('Pass','Distinction')
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS pass_rate

FROM final_dataset

GROUP BY code_module;
-- ====================================

-- ====================================
-- 10. Analyze score trend across presentations
-- ====================================
-- Columns used: code_presentation, average_score
-- Method:
       SELECT 
          code_presentation,
          ROUND(AVG(avg_score),2) AS average_score
FROM final_dataset

GROUP BY code_presentation;
-- ====================================



-- 10 Difficult problems
-- ====================================
-- 1. Rank modules by academic success
-- ====================================
-- Columns used: code_module, average_score
-- Method:
SELECT 
    code_module,

    ROUND(AVG(avg_score),2) AS average_score,

    RANK() OVER(
        ORDER BY AVG(avg_score) DESC
    ) AS module_rank

FROM final_dataset

GROUP BY code_module;
-- =====================================

-- =====================================
-- 2. Identify high-engagement low-score students
-- =====================================
-- Columns used: id_student, total_clicks, average_score
-- Method:
SELECT 
    id_student,
    total_clicks,
    avg_score

FROM final_dataset

WHERE total_clicks > 1000
AND avg_score < 40;
-- =====================================

-- =====================================
-- 3. Predict high-risk academic groups
-- =====================================
-- Columns used: region, age_band,avg_score,final_result
-- Method:
SELECT 
    region,
    age_band,

    ROUND(AVG(avg_score),2) AS average_score,

    ROUND(
        (
     		SUM(
                CASE
                    WHEN final_result = 'Fail'
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
    2) AS failure_rate

FROM final_dataset

GROUP BY region, age_band;
-- ====================================

-- =====================================
-- 4. Detect inconsistent performers
-- =====================================
-- Columns used: id_student, num_assess_attempted, average_score
-- Method:
SELECT 
    id_student,
    num_assess_attempted,
    avg_score

FROM final_dataset

WHERE num_assess_attempted > 5
AND (
        avg_score < 40
        OR avg_score > 85
    );
-- ====================================

-- ====================================
-- 5. Create weighted academic index
-- ====================================
-- Columns used: avg_Score_score, total_clicks, studied_credits
-- Method:
        SELECT 
        id_student,
    ROUND(
        (
		(avg_score / 100.0) * 0.5 +
        (total_clicks / 2000.0) * 0.3 +
        (studied_credits / 120.0) * 0.2
    ) * 100,
2) AS performance_index
FROM final_dataset;
-- ====================================

-- ====================================
-- 6. Analyze performance variance by region
-- ====================================
-- Columns used: region, average_score
-- Method:
SELECT 
    region,

    ROUND(AVG(avg_score),2) AS average_score,

    ROUND(VAR(avg_score),2) AS score_variance

FROM final_dataset

GROUP BY region;
-- ====================================

-- ====================================
-- 7. Identify top 5% students per module
-- ====================================
-- Columns used: id_student, code_module, average_score
-- Method:
WITH ranked_students AS (

    SELECT 
        id_student,
        code_module,
        avg_score,

        NTILE(20) OVER(
            PARTITION BY code_module
            ORDER BY avg_score DESC
        ) AS percentile_group

    FROM final_dataset
)

SELECT *
FROM ranked_students
WHERE percentile_group = 1;
-- ====================================

-- ====================================
-- 8. Detect performance anomalies
-- ====================================
-- Columns used: average_score, total_clicks, studied_credits
-- Method:
SELECT 
    id_student,
    avg_score,
    total_clicks,
    studied_credits

FROM final_dataset
WHERE 
(
    total_clicks > 1000
    AND avg_score < 40
)
OR
(
    total_clicks < 200
    AND avg_score > 85
);
-- =====================================

-- =====================================
-- 9. Build academic segmentation model
-- =====================================
-- Columns used: average_score, total_clicks, final_result
-- Method:
SELECT 
    id_student,

    CASE
        WHEN avg_score >= 85 THEN 'Excellent'
        WHEN avg_score >= 60 THEN 'Good'
        ELSE 'Weak'
    END AS performance_segment,

    CASE
        WHEN total_clicks >= 1000 THEN 'Highly Engaged'
        WHEN total_clicks >= 500 THEN 'Moderately Engaged'
        ELSE 'Low Engaged'
    END AS engagement_segment,
    final_result
FROM final_dataset;
-- ========================================

-- ========================================
-- 10. Compare multi-factor impact on final result
-- =========================================
-- Columns used: average_score, total_clicks, studied_credits, highest_education, final_result
-- Method:
SELECT 
    highest_education,
    final_result,

    ROUND(AVG(avg_score),2) AS average_score,
    ROUND(AVG(total_clicks),2) AS average_clicks,
    ROUND(AVG(studied_credits),2) AS average_credits

FROM final_dataset
GROUP BY highest_education, final_result;
-- ===========================================



-- 10 Univariate problems

-- =======================================
-- 1. Distribution of average score
-- =======================================
-- Columns used: average_score
-- Method:
SELECT

CASE
    WHEN avg_score BETWEEN 0 AND 20 THEN '0-20'
    WHEN avg_score BETWEEN 21 AND 40 THEN '21-40'
    WHEN avg_score BETWEEN 41 AND 60 THEN '41-60'
    WHEN avg_score BETWEEN 61 AND 80 THEN '61-80'
    ELSE '81-100'
END AS score_range,

COUNT(*) AS total_students

FROM final_dataset

GROUP BY CASE
    WHEN avg_score BETWEEN 0 AND 20 THEN '0-20'
    WHEN avg_score BETWEEN 21 AND 40 THEN '21-40'
    WHEN avg_score BETWEEN 41 AND 60 THEN '41-60'
    WHEN avg_score BETWEEN 61 AND 80 THEN '61-80'
    ELSE '81-100'
END

ORDER BY score_range;
-- =======================================
-- =======================================
-- 2. Distribution of total clicks
-- =======================================
-- Columns used: total_clicks
-- Method:
SELECT

CASE
    WHEN total_clicks < 500 THEN 'Low Engagement'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium Engagement'
    ELSE 'High Engagement'
END AS engagement_level,

COUNT(*) AS total_students

FROM final_dataset

GROUP BY CASE
    WHEN total_clicks < 500 THEN 'Low Engagement'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium Engagement'
    ELSE 'High Engagement'
END;
-- =======================================

-- =======================================
-- 3. Distribution of credits studied
-- =======================================
-- Columns used: studied_credits
-- Method:
SELECT

CASE
    WHEN studied_credits < 60 THEN 'Low Credits'
    WHEN studied_credits BETWEEN 60 AND 120 THEN 'Medium Credits'
    ELSE 'High Credits'
END AS credit_category,

COUNT(*) AS total_students

FROM final_dataset

GROUP BY CASE
    WHEN studied_credits < 60 THEN 'Low Credits'
    WHEN studied_credits BETWEEN 60 AND 120 THEN 'Medium Credits'
    ELSE 'High Credits'
END;
-- =======================================

-- =======================================
-- 4. Distribution of assessment attempts
-- =======================================
-- Columns used: num_assess_attempted
-- Method:
SELECT
              num_assess_attempted,
              COUNT(*) AS total_students

FROM final_dataset

GROUP BY num_assess_attempted

ORDER BY num_assess_attempted;
-- =======================================

-- =======================================
-- 5. Distribution of age groups
-- =======================================
-- Columns used: age_band
-- Method:
SELECT
             age_band,
             COUNT(*) AS total_students

FROM final_dataset
GROUP BY age_band;
-- =======================================

-- =======================================
-- 6. Distribution of education levels
-- =======================================
-- Columns used: highest_education
-- Method:
SELECT
              highest_education,
              COUNT(*) AS total_students

FROM final_dataset
GROUP BY highest_education;
-- =======================================

-- =======================================
-- 7. Distribution of final results
-- =======================================
-- Columns used: final_result
-- Method:
SELECT
              final_result,
              COUNT(*) AS total_students

FROM final_dataset
GROUP BY final_result;
-- =======================================

-- =======================================
-- 8. Distribution of modules
-- =======================================
-- Columns used: code_module
-- Method:
SELECT
              code_module,
              COUNT(*) AS total_students

FROM final_dataset
GROUP BY code_module;
-- =======================================

-- =======================================
-- 9. Distribution of regions
-- =======================================
-- Columns used: region
-- Method:
SELECT
             region,
             COUNT(*) AS total_students

FROM final_dataset
GROUP BY region;
-- =======================================

-- =======================================
-- 10. Distribution of engagement levels
-- =======================================
-- Columns used: total_clicks
-- Method:
SELECT
CASE
    WHEN total_clicks < 500 THEN 'Low'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'High'
END AS engagement_level,

COUNT(*) AS total_students

FROM final_dataset
GROUP BY CASE
    WHEN total_clicks < 500 THEN 'Low'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'High'
END;
-- ======================================


-- 10 Bivariate problems
-- ======================================
-- 1. Score vs clicks
-- ======================================
-- Columns used: average_score,total_clicks
-- Method:
       SELECT 
    CASE
        WHEN total_clicks < 500 THEN 'Low'
        WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS engagement_level,
    
    ROUND(AVG(avg_score),2) AS average_score
FROM final_dataset

GROUP BY CASE
    WHEN total_clicks < 500 THEN 'Low'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'High'
END;
-- ======================================

-- ======================================
-- 2. Score vs credits
-- ======================================
-- Columns used: studied_credits,average_score
-- Method:
SELECT
             studied_credits,
             ROUND(AVG(avg_score),2) AS average_score

FROM final_dataset
GROUP BY studied_credits
ORDER BY studied_credits;
-- ======================================

-- ======================================
-- 3. Gender vs score
-- ======================================
-- Columns used: gender,average_score
-- Method:
SELECT
             gender,
             ROUND(AVG(avg_score),2) 
			 AS average_score

FROM final_dataset
GROUP BY gender;
-- ======================================

-- ======================================
-- 4. Region vs pass rate
-- ======================================
-- Columns used: region,final_result
-- Method:

SELECT 
region,
ROUND(
(
SUM(
CASE
    WHEN final_result IN ('Pass','Distinction')
    THEN 1
    ELSE 0
END
) * 100.0
) / COUNT(*),
2
) AS pass_rate

FROM final_dataset

GROUP BY region;
-- ======================================

-- ======================================
-- 5. Education level vs score
-- ======================================
-- Columns used: highest_education,avg_score

-- Method:
SELECT
    highest_education,
    ROUND(AVG(avg_score),2)
	AS average_score

FROM final_dataset

GROUP BY highest_education;
-- ======================================

-- ======================================
-- 6. Disability vs performance
-- ======================================
-- Columns used: disability,average_score
-- Method:
SELECT
             disability,
             ROUND(AVG(avg_score),2)
			 AS average_score

FROM final_dataset
GROUP BY disability;
-- ======================================

-- ======================================
-- 7. Attempts vs score
-- ======================================
-- Columns used: num_of_prev_attempts,average_score
-- Method:
SELECT
        num_of_prev_attempts,
        ROUND(AVG(avg_score),2) 
		AS average_score

FROM final_dataset

GROUP BY num_of_prev_attempts
ORDER BY num_of_prev_attempts;
-- ======================================

-- ======================================
-- 8. Engagement vs result
-- ======================================
-- Columns used: final_result,total_clicks
-- Method:
SELECT
        final_result,
        ROUND(AVG(total_clicks),2) 
		AS average_clicks

FROM final_dataset
GROUP BY final_result;
-- ======================================

-- ======================================
-- 9. Age band vs score
-- ======================================
-- Columns used: age_band,average_score
-- Method:
SELECT
        age_band,
        ROUND(AVG(avg_score),2)
		AS average_score

FROM final_dataset
GROUP BY age_band;
-- ======================================

-- ======================================
-- 10. Module vs average performance
-- ======================================
-- Columns used: code_module,average_score
-- Method:
SELECT
        code_module,
        ROUND(AVG(avg_score),2)
		AS average_score

FROM final_dataset
GROUP BY code_module
ORDER BY average_score DESC;
-- ======================================


-- 10 Multi variate problems

-- ======================================
-- 1. Score + clicks + credits analysis
-- ======================================
-- Columns used: id-student,total_clicks,avg_Score,studied_credits
-- Method:
       SELECT 
    CASE
        WHEN total_clicks < 500 THEN 'Low'
        WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS engagement_level,

    ROUND(AVG(avg_score),2) AS average_score,
    ROUND(AVG(studied_credits),2) AS average_credits

FROM final_dataset

GROUP BY CASE
    WHEN total_clicks < 500 THEN 'Low'
    WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'High'
END;
-- ======================================

-- ======================================
-- 2. Gender + education + score analysis
-- ======================================
-- Columns used: gender,highest_education,avg_score
-- Method:
SELECT
        gender,
        highest_education,
    ROUND(AVG(avg_score),2) AS avg_score
FROM final_dataset
GROUP BY gender,
         highest_education; 
-- ======================================

-- ======================================
-- 3. Region + engagement + result analysis
-- ======================================
-- Columns used: region,final_result,total_clicks
-- Method:
SELECT 
    region,
    ROUND(AVG(total_clicks),2) AS avg_engagement,
    ROUND(
        (
            SUM(CASE WHEN final_result IN ('Pass','Distinction') THEN 1 ELSE 0 END) * 100.0
        ) / COUNT(*),
    2) AS pass_rate
FROM final_dataset

GROUP BY region;
-- ======================================

-- ======================================
-- 4. Attempts + score + module analysis
-- ======================================
-- Columns used: num_of_prev_attempts,code_module,avg_score
-- Method:
SELECT 
    code_module,
    ROUND(AVG(num_of_prev_attempts),
	2) AS avg_attempts,
    ROUND(AVG(avg_score),
	2) AS avg_score
FROM final_dataset

GROUP BY code_module;
-- ======================================

-- ======================================
-- 5. Age + clicks + score analysis
-- ======================================
-- Columns used: age,total_clicks,avg_score
-- Method:
       SELECT 
       age_band,
	   
    ROUND(AVG(total_clicks),2) AS avg_clicks,
    ROUND(AVG(avg_score),2) AS avg_score
FROM final_dataset

GROUP BY age_band;
-- ======================================

-- ======================================
-- 6. Disability + engagement + performance analysis
-- ======================================
-- Columns used: disability,total_clicks,avg_score
-- Method:
SELECT
    disability,
    ROUND(AVG(total_clicks),2) AS avg_engagement,
    ROUND(AVG(avg_score),2) AS avg_score
FROM final_dataset

GROUP BY disability;
-- ======================================

-- ======================================
-- 7. Credits + attempts + result analysis
-- ======================================
-- Columns used: studied_credits,num_of_prev_attempts,final_result
-- Method:
SELECT
    studied_credits,
    ROUND(AVG(num_of_prev_attempts),2) AS avg_attempts,
    ROUND(
        (
            SUM(CASE WHEN final_result IN ('Pass','Distinction') THEN 1 ELSE 0 END) * 100.0
        ) / COUNT(*),
    2) AS pass_rate
FROM final_dataset

GROUP BY studied_credits;
-- ======================================

-- ======================================
-- 8. Education + module + score analysis
-- ======================================
-- Columns used: highest_education,code_module,avg_Score
-- Method:
SELECT
        highest_education,
        code_module,
    ROUND(AVG(avg_score),2) AS avg_score
FROM final_dataset

GROUP BY highest_education, code_module;
-- ======================================

-- ======================================
-- 9. Region + education + pass rate analysis
-- ======================================
-- Columns used: region,highest_education,final_result
-- Method:
SELECT
    region,
    highest_education,
    ROUND(
        (
            SUM(CASE WHEN final_result IN ('Pass','Distinction') THEN 1 ELSE 0 END) * 100.0
        ) / COUNT(*),
    2) AS pass_rate
FROM final_dataset

GROUP BY region, highest_education;
-- ======================================

-- ======================================
-- 10. Multi-factor academic success model
-- ======================================
-- Columns used: id_student,avg_Score,total_clicks,studied_credits
-- Method:
SELECT
    id_student,
    ROUND(
        (avg_score * 0.5) + 
        (total_clicks * 0.3) + 
        (studied_credits * 0.2),
    2) AS success_index
FROM final_dataset;
-- ======================================


-- 10 CTE related problems

-- 1. Create average score per module CTE
-- ======================================
-- Columns used: avg_score,code_module
-- Method:
WITH module_avg_score AS (

    SELECT 
        code_module,
        ROUND(AVG(avg_score),2) AS average_score

    FROM final_dataset

    GROUP BY code_module
)
SELECT *
FROM module_avg_score;
-- ======================================

-- ======================================
-- 2. Build pass-rate CTE
-- ======================================
-- Columns used: final_result,code_module
-- Method:
WITH pass_rate_cte AS (

    SELECT 

        code_module,

        ROUND(
            (
                SUM(
                    CASE
                        WHEN final_result IN ('Pass','Distinction')
                        THEN 1
                        ELSE 0
                    END
                ) * 100.0
            ) / COUNT(*),
        2) AS pass_rate

    FROM final_dataset

    GROUP BY code_module
)
SELECT *
FROM pass_rate_cte;
-- ======================================

-- ======================================
-- 3. Create high-performing student CTE
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
WITH high_performing_students AS (
    SELECT 
        id_student,
        avg_score

    FROM final_dataset

    WHERE avg_score >= 85
)
SELECT *
FROM high_performing_students;
-- ======================================

-- ======================================
-- 4. Build engagement classification CTE
-- ======================================
-- Columns used: id_student,total_clicks
-- Method:
WITH engagement_classification AS (

    SELECT 
        id_student,
        CASE
            WHEN total_clicks < 500 THEN 'Low'
            WHEN total_clicks BETWEEN 500 AND 1000 THEN 'Medium'
            ELSE 'High'
        END AS engagement_level
    FROM final_dataset
)
SELECT *
FROM engagement_classification;
-- ======================================

-- ======================================
-- 5. Create module ranking CTE
-- ======================================
-- Columns used: code_module,avg_score
-- Method:
WITH module_ranking AS (

    SELECT 
        code_module,
        ROUND(AVG(avg_score),2) AS average_score,
        RANK() OVER(
            ORDER BY AVG(avg_score) DESC
        ) AS module_rank

    FROM final_dataset
    GROUP BY code_module
)
SELECT *
FROM module_ranking;
-- ======================================

-- ======================================
-- 6. Build score percentile CTE
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
WITH score_percentile AS (

    SELECT 
        id_student,
        avg_score,
        NTILE(10) OVER(
            ORDER BY avg_score DESC
        ) AS percentile_rank

    FROM final_dataset
)
SELECT *
FROM score_percentile;
-- ======================================

-- ======================================
-- 7. Create student segmentation CTE
-- ======================================
-- Columns used: avg_Score,total_clicks
-- Method:
WITH student_segmentation AS (

    SELECT 
        id_student,
        CASE
            WHEN avg_score >= 85 THEN 'Excellent'
            WHEN avg_score >= 60 THEN 'Good'
            ELSE 'Weak'
        END AS performance_segment,

        CASE
            WHEN total_clicks >= 1000 THEN 'Highly Engaged'
            WHEN total_clicks >= 500 THEN 'Moderately Engaged'
            ELSE 'Low Engaged'
        END AS engagement_segment

    FROM final_dataset
)
SELECT *
FROM student_segmentation;
-- ======================================

-- ======================================
-- 8. Build academic risk CTE
-- ======================================
-- Columns used: id_student,avg_Score,final_result
-- Method:
WITH academic_risk AS (

    SELECT 
        id_student,
        avg_score,
        final_result
    FROM final_dataset
    WHERE avg_score < 40
    OR final_result = 'Fail'
)
SELECT *
FROM academic_risk;
-- ======================================

-- ======================================
-- 9. Create average clicks CTE
-- ======================================
-- Columns used: code_module,total_clicks
-- Method:
WITH average_clicks_cte AS (

    SELECT 
        code_module,
        ROUND(AVG(total_clicks),2) AS average_clicks
    FROM final_dataset
    GROUP BY code_module
)
SELECT *
FROM average_clicks_cte;
-- ======================================

-- ======================================
-- 10. Build education-level comparison CTE
-- ======================================
-- Columns used: highest_education,avg_score
-- Method:
WITH education_comparison AS (

    SELECT 
        highest_education,
        ROUND(AVG(avg_score),2) AS average_score
    FROM final_dataset
    GROUP BY highest_education
)
SELECT *
FROM education_comparison;
-- ======================================


-- 10 Window functions related problems

-- 1.Rank students by score
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
SELECT
        id_student,
        avg_score,
        RANK() OVER (
		ORDER BY avg_score DESC) AS student_rank
FROM final_dataset;
-- ======================================

-- ======================================
-- 2. Rank students within modules
-- ======================================
-- Columns used: id_student,code_module,avg_score
-- Method:
SELECT

    id_student,
    code_module,
    avg_score,
    RANK() OVER(
        PARTITION BY code_module
        ORDER BY avg_score DESC
    ) AS module_rank

FROM final_dataset;
-- ======================================

-- ======================================
-- 3. Calculate moving average score
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
SELECT

    id_student,
    avg_score,
    ROUND(
        AVG(avg_score) OVER(
            ORDER BY id_student
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
    2) AS moving_average

FROM final_dataset;
-- ======================================

-- ======================================
-- 4. Find cumulative clicks
-- ======================================
-- Columns used: id_student,total_clicks
-- Method:
    SELECT 
        id_student,
        total_clicks,
		
        SUM(total_clicks) OVER (
		ORDER BY id_student
		) AS cumulative_clicks
FROM final_dataset;
-- ======================================

-- ======================================
-- 5. Use DENSE_RANK for performance
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
       SELECT 
	   id_student, 
	   avg_score,
	   
       DENSE_RANK() OVER (
	     ORDER BY avg_score DESC
		 ) AS dense_rank_performance
FROM final_dataset;
-- ======================================

-- ======================================
-- 6. Compare student score using LAG
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
       SELECT 
       id_student,
       avg_score,

    LAG(avg_score) OVER(
        ORDER BY avg_score DESC
    ) AS previous_student_score

FROM final_dataset;
	   
-- ======================================

-- ======================================
-- 7. Compare next score using LEAD
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
       SELECT 
       id_student,
       avg_score,

    LEAD(avg_score) OVER(
        ORDER BY avg_score DESC
    ) AS next_student_score

FROM final_dataset;
-- ======================================

-- ======================================
-- 8. Find top 3 students per region
-- ======================================
-- Columns used: region,id_student,avg_Score
-- Method:
       WITH ranked_students AS (

    SELECT 
        id_student,
        region,
        avg_score,

        RANK() OVER(
            PARTITION BY region
            ORDER BY avg_score DESC
        ) AS rank_no
    FROM final_dataset
)
SELECT *
FROM ranked_students

WHERE rank_no <= 3;
-- ======================================

-- ======================================
-- 9. Create percentile ranking
-- ======================================
-- Columns used: id_student,avg_score
-- Method:
       SELECT 
       id_student,
       avg_score,

    PERCENT_RANK() OVER(
        ORDER BY avg_score
    ) AS percentile_ranking

FROM final_dataset;
-- ======================================

-- ======================================
-- 10. Running total of engagement
-- ======================================
-- Columns used: id_student,total_clicks
-- Method:
       SELECT 
       id_student,
       total_clicks,

    SUM(total_clicks) OVER(
        ORDER BY id_student
    ) AS running_total_engagement

FROM final_dataset;
-- ======================================

-- ======================================
-- FINAL FINDINGS, INSIGHTS & RECOMMENDATIONS
-- ======================================

-- PROJECT SUMMARY:
-- This project analyzes student academic performance using SQL.
-- The analysis focuses on pass rate, average score, student engagement,
-- assessment attempts, studied credits, module performance, demographic factors,
-- academic risk identification, student segmentation, CTE analysis,
-- and window function-based ranking.

-- ======================================
-- KEY FINDINGS
-- ======================================

-- 1. Multiple KPIs were used to evaluate student performance,
-- including pass rate, average score, distinction rate,
-- academic excellence rate, and engagement rate.

-- 2. Student engagement was analyzed using total clicks,
-- engagement levels, cumulative engagement, and participation metrics.

-- 3. Academic risk was evaluated using score-based,
-- engagement-based, and performance-based classifications.

-- 4. Module-level analysis was performed to compare module performance,
-- average scores, success rates, and student outcomes.

-- 5. Demographic analysis was conducted across gender,
-- age band, region, highest education level, and disability status.

-- 6. Student segmentation was performed using score ranges,
-- engagement levels, credit categories, and performance categories.

-- 7. CTEs were used to create advanced student performance analysis,
-- risk classification, and academic segmentation.

-- 8. Window functions were used for ranking students,
-- percentile analysis, moving averages, running totals,
-- and score comparisons.

-- ======================================
-- BUSINESS INSIGHTS
-- ======================================

-- 1. Low engagement and low score metrics can be used
-- to identify potentially high-risk students.

-- 2. Engagement metrics provide useful indicators
-- for monitoring student participation and learning activity.

-- 3. Module-level performance analysis helps identify
-- areas requiring academic improvement and support.

-- 4. Demographic analysis provides additional context
-- for understanding differences in student performance.

-- 5. Student ranking and percentile analysis can help identify
-- top-performing students as well as students requiring intervention.

-- ======================================
-- RECOMMENDATIONS
-- ======================================

-- 1. Develop an early-warning system for students showing
-- low engagement and poor academic performance.

-- 2. Provide targeted academic support for students
-- identified as high-risk.

-- 3. Monitor engagement metrics regularly to improve
-- student participation and retention.

-- 4. Review module-level performance trends to support
-- continuous academic improvement.

-- 5. Use student segmentation techniques to support
-- personalized academic advising.

-- 6. Build an academic performance dashboard displaying
-- pass rate, average score, engagement level,
-- risk category, module performance, and student rankings.

-- ======================================
-- FINAL CONCLUSION
-- ======================================

-- This project demonstrates the use of SQL for educational analytics,
-- including KPI development, segmentation, risk analysis,
-- demographic analysis, CTEs, window functions, and business-oriented insights.
-- The analysis can support data-driven academic decision-making and student success initiatives.