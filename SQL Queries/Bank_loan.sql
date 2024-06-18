SELECT * FROM bank_loan_data

SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

SELECT COUNT(id) AS MTD_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT MAX(issue_date) FROM bank_loan_data

SELECT MIN(issue_date) FROM bank_loan_data

-- MoM applications MTD - Previous MTD / PMTD

SELECT COUNT(id) AS PMTD_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

SELECT SUM(loan_amount) AS MTD_loan_amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) FROM bank_loan_data


SELECT SUM(total_payment) AS MTD_total_amount_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- average interest rate

SELECT ROUND(AVG(int_rate)*100,2) AS AVG_int_rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- DTI debt to income ratio

SELECT AVG(dti)*100 AS avg_mtd_dti FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- good loans with loan status : current and fully paid

SELECT loan_status FROM bank_loan_data

SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
	/COUNT(id) AS Good_loan_percentage
FROM bank_loan_data

SELECT COUNT(id) AS Good_loan_applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(total_payment) AS Good_loan_funds_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- bad loans


SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)
	/COUNT(id) AS Bad_loan_percentage
FROM bank_loan_data

SELECT COUNT(id) AS Bad_loan_applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off' 

SELECT SUM(total_payment) AS Bad_loan_funds_received FROM bank_loan_data
WHERE loan_status = 'Charged Off' 

-- LOAN STATUS

SELECT 
		loan_status, 
		COUNT(id) AS Total_loan_apps,
		SUM(total_payment) AS Total_amount_received,
		SUM(loan_amount) AS Total_Funded_Amount,
		AVG(int_rate * 100) AS Interest_rate,
		AVG(dti * 100) AS DTI
	FROM bank_loan_data
	GROUP BY
	loan_status

	SELECT
		loan_status,
		SUM(total_payment) AS MTD_Total_amount_received,
		SUM(loan_amount) AS MTD_Total_Funded_Amount
	FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 
	GROUP BY
	loan_status



	SELECT 
		home_ownership, 
		COUNT(id) AS Total_loan_apps,
		SUM(total_payment) AS Total_amount_received,
		SUM(loan_amount) AS Total_Funded_Amount
	FROM bank_loan_data
	GROUP BY home_ownership
	ORDER BY COUNT(id) DESC

	-- 