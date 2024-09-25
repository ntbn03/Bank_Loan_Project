SELECT * 
FROM Bank_loan.financial_loan;

-- Chỉnh loại dữ liệu các cột ngày tháng

UPDATE Bank_loan.financial_loan
SET 
    issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y'),
    last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y'),
    last_payment_date = STR_TO_DATE(last_payment_date, '%d-%m-%Y'),
    next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y');

SELECT COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) AS Average_Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS Average_DebttoIncome_Ratio
FROM financial_loan;

SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM Bank_loan.financial_loan
WHERE MONTH(issue_date) = 12 
	  AND YEAR(issue_date) = 2021;

-- Số Tài khoản mở mới trong tháng

SELECT MONTH(issue_date), 
	   COUNT(id) AS New_Bank_Customers
FROM Bank_loan.financial_loan
GROUP BY MONTH(issue_date)
ORDER BY COUNT(id);
   
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM Bank_loan.financial_loan
WHERE MONTH(issue_date) = 12 
	  AND YEAR(issue_date) = 2021;
      
-- Số tiền giải ngân trong tháng

SELECT MONTH(issue_date), 
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_loan.financial_loan
GROUP BY MONTH(issue_date)
ORDER BY SUM(loan_amount);

-- Số tiền thu nợ được mỗi tháng

SELECT MONTH(issue_date), 
	   SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan.financial_loan
GROUP BY MONTH(issue_date)
ORDER BY SUM(total_payment);

--

SELECT MONTH(issue_date), 
	   ROUND(AVG(int_rate) *100, 2) AS Average_Interest_Rate
FROM Bank_loan.financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

-- Khả năng trả nợ của cá nhân/ tổ chức

SELECT MONTH(issue_date), 
	   ROUND(AVG(dti) * 100, 2) AS Average_DebttoIncome_Ratio
FROM Bank_loan.financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

SELECT *
FROM Bank_loan.financial_loan
WHERE dti >= 0.36;


SELECT id, COUNT(*) AS count_per_id
FROM Bank_loan.financial_loan
GROUP BY id
HAVING COUNT(*) >= 2;

-- TỈ LỆ NỢ TỐT

SELECT (COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END)
		/
	   COUNT(id)) * 100 AS Good_Loan_Per
FROM Bank_loan.financial_loan;

SELECT COUNT(id) AS Good_Loan_Application
FROM Bank_loan.financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');

SELECT SUM(loan_amount) AS Good_Loan_Funded
FROM Bank_loan.financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');


SELECT SUM(total_payment) AS Good_Loan_Received
FROM Bank_loan.financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');


-- Tỉ lệ nợ xấu

SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)
		/
	   COUNT(id)) * 100 AS Bad_Loan_Per
FROM Bank_loan.financial_loan;

SELECT COUNT(id) AS Bad_Loan_Application
FROM Bank_loan.financial_loan
WHERE loan_status = 'Charged Off';

SELECT SUM(loan_amount) AS Bad_Loan_Funded
FROM Bank_loan.financial_loan
WHERE loan_status = 'Charged Off';

SELECT SUM(total_payment) AS Good_Loan_Received
FROM Bank_loan.financial_loan
WHERE loan_status = 'Charged Off';

-- LOAN STATUS

SELECT loan_status,
	   COUNT(id) AS Total_Loan_Application,
       SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS DTI
FROM Bank_loan.financial_loan
GROUP BY loan_status;


SELECT loan_status,
	   COUNT(id) AS Total_Loan_Application,
       SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS DTI
FROM Bank_loan.financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;


SELECT MONTH(issue_date),
	   MONTHNAME(issue_date) AS month,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) AS Average_Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS Average_DebttoIncome_Ratio
FROM financial_loan
GROUP BY MONTH(issue_date),  MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);


SELECT address_state,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received,
       ROUND(AVG(int_rate) * 100, 2) AS Average_Interest_Rate,
       ROUND(AVG(dti) * 100, 2) AS Average_DebttoIncome_Ratio
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;


-- SỐ LƯỢNG KHÁCH HÀNG THEO KỲ HẠN 

SELECT term,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;


SELECT (COUNT(CASE WHEN term = '36 months' THEN id END)
		/
	   COUNT(id)) * 100 AS Term_Per
FROM Bank_loan.financial_loan;



SELECT emp_length,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

SELECT purpose,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
       SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id);








