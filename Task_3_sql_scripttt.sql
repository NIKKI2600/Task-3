# Creating a new schema to load the dataset tables
CREATE SCHEMA ElevateLabs;

#creating a table.1 to load the Employee.dataset

CREATE TABLE ElevateLabs.Employee (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    BusinessTravel VARCHAR(50),
    Department VARCHAR(100),
    DistanceFromHome INT,
    State VARCHAR(10),
    Ethnicity VARCHAR(50),
    Education INT,
    EducationField VARCHAR(100),
    JobRole VARCHAR(100),
    MaritalStatus VARCHAR(20),
    Salary INT,
    StockOptionLevel INT,
    OverTime VARCHAR(5),
    HireDate DATE,
    Attrition VARCHAR(5),
    YearsAtCompany INT,
    YearsInMostRecentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

#creating a table.2 to load Employee's Performance dataset
CREATE TABLE ElevateLabs.PerformanceRating (
    PerformanceID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(20),
    ReviewDate DATE,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken INT,
    WorkLifeBalance INT,
    SelfRating INT,
    ManagerRating INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

#creating a table.3 to load the employees salary 

CREATE TABLE ElevateLabs.ds_salary (
    Age INT,
	Attrition VARCHAR (20),	
    BusinessTravel VARCHAR (20),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

##Loding the datas to the respected tables
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\Employee.csv"
INTO TABLE ElevateLabs.Employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID, FirstName, LastName, Gender, Age, BusinessTravel, Department, DistanceFromHome, State, Ethnicity, Education, EducationField, JobRole, MaritalStatus, Salary, StockOptionLevel, OverTime, @HireDate, Attrition, YearsAtCompany, YearsInMostRecentRole, YearsSinceLastPromotion, YearsWithCurrManager)
SET HireDate = STR_TO_DATE(@HireDate, '%d-%m-%Y');

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\PerformanceRating.csv"
INTO TABLE ElevateLabs.PerformanceRating
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PerformanceID, EmployeeID, @ReviewDate, EnvironmentSatisfaction, JobSatisfaction, RelationshipSatisfaction, TrainingOpportunitiesWithinYear, TrainingOpportunitiesTaken, WorkLifeBalance, SelfRating, ManagerRating)
SET ReviewDate = STR_TO_DATE(@ReviewDate, '%d-%m-%Y');

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\WA_Fn-UseC_-HR-Employee-Attrition.csv"
INTO TABLE ElevateLabs.DS_Salary
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#SELECT, WHERE, ORDER BY, GROUP BY
SELECT EmployeeNumber, JobRole, JobLevel, MonthlyIncome, PercentSalaryHike
FROM ElevateLabs.ds_salary
WHERE JobLevel >= 4
ORDER BY JobLevel ASC;

#GROUPBY
SELECT JobRole, COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM ElevateLabs.ds_salary
GROUP BY JobRole
ORDER BY AttritionCount DESC;

#INNER JOIN
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Gender, e.Department,
e.Salary AS EmployeeTableSalary,d.MonthlyIncome AS DSSalaryMonthlyIncome
FROM ElevateLabs.Employee e
INNER JOIN ElevateLabs.ds_salary d 
ON e.EmployeeID = d.EmployeeNumber
LIMIT 10;

#LEFT JOIN
SELECT e.EmployeeID, e.FirstName, e.LastName, d.MonthlyIncome
FROM ElevateLabs.Employee e
LEFT JOIN ElevateLabs.ds_salary d 
ON e.EmployeeID = d.EmployeeNumber
WHERE d.MonthlyIncome IS NULL;

#RIGHT JOIN 
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Department AS EmpDepartment,
d.EmployeeNumber, d.JobRole AS DSSalaryJobRole, d.MonthlyIncome, JobLevel, d.OverTime
FROM ElevateLabs.Employee e
RIGHT JOIN ElevateLabs.ds_salary d 
ON e.EmployeeID = d.EmployeeNumber
ORDER BY d.MonthlyIncome DESC
LIMIT 10;


#SUYBQUERY
SELECT EmployeeNumber, JobRole, MonthlyIncome
FROM ElevateLabs.ds_salary
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome) FROM ElevateLabs.ds_salary
);

#VIEW CREATION
CREATE VIEW EmployeeSalaryInfo AS
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Gender, 
e.JobRole AS EmpJobRole,e.Salary,
d.JobRole AS DSSJobRole,d.MonthlyIncome, d.OverTime, d.PercentSalaryHike
FROM ElevateLabs.Employee e
JOIN ElevateLabs.ds_salary d 
ON e.EmployeeID = d.EmployeeNumber;
SELECT * FROM EmployeeSalaryInfo WHERE OverTime = 'Yes' LIMIT 10;

#INDEXING
CREATE INDEX idx_ds_employee_number ON ElevateLabs.ds_salary(EmployeeNumber);
SHOW INDEX FROM ElevateLabs.ds_salary;








