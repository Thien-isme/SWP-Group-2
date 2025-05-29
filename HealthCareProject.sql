CREATE TABLE Class (
    classID INT IDENTITY(1,1) PRIMARY KEY,
    teacherName NVARCHAR(100),
    quantity INT
);

CREATE TABLE Users (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    fullName NVARCHAR(100),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(200),
    role NVARCHAR(50) DEFAULT 'parent' CHECK (role IN ('parent', 'admin', 'nurse'))
);



CREATE TABLE Student (
    studentID INT IDENTITY(1,1) PRIMARY KEY,
    studentName NVARCHAR(100),
    dob DATE,
    gender NVARCHAR(10),
    relationship NVARCHAR(50),
    classID INT FOREIGN KEY REFERENCES Class(classID),
    parentID INT FOREIGN KEY REFERENCES Users(userID)
);


CREATE TABLE MedicalRequest (
    requestID INT IDENTITY(1,1) PRIMARY KEY,
    requestName NVARCHAR(100),
    date DATE,
    note NVARCHAR(255),
    status NVARCHAR(50) CHECK (status IN ('pending', 'approved', 'rejected')),
    [commit] BIT,
    studentID INT FOREIGN KEY REFERENCES Student(studentID),
    parentID INT FOREIGN KEY REFERENCES Users(userID),
	classID INT FOREIGN KEY REFERENCES Class(classID)
);

CREATE TABLE MedicalRequestDetail (
    detailID INT IDENTITY(1,1) PRIMARY KEY,
    medicineName NVARCHAR(100),
    quantity INT,
    instruction NVARCHAR(255),
	time DATETIME,
    requestID INT FOREIGN KEY REFERENCES MedicalRequest(requestID)
);


CREATE TABLE MedicalEvents (
    eventID INT IDENTITY(1,1) PRIMARY KEY,
    typeEvent NVARCHAR(100),
    date DATE,
    description NVARCHAR(255),
    studentID INT FOREIGN KEY REFERENCES Student(studentID),
    nurseID INT FOREIGN KEY REFERENCES Users(userID)
);

CREATE TABLE MedicalSupply (
    supplyID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    quantity INT,
    unit NVARCHAR(50),
    expiryDate DATE,
    note NVARCHAR(255)
);

CREATE TABLE MedicalEventSupply (
    eventID INT,
    supplyID INT,
    quantity INT,
	PRIMARY KEY (eventID, supplyID),
    note NVARCHAR(255),
    FOREIGN KEY (eventID) REFERENCES MedicalEvents(eventID),
    FOREIGN KEY (supplyID) REFERENCES MedicalSupply(supplyID)
);


CREATE TABLE HealthCheckProgram (
    healthCheckID INT IDENTITY(1,1) PRIMARY KEY,
    healthCheckName NVARCHAR(100),
    description NVARCHAR(255),
    startDate DATE,
    endDate DATE,
    status NVARCHAR(50) CHECK (status IN ('ongoing', 'completed', 'not started')),
    note NVARCHAR(255),
    nurseID INT FOREIGN KEY REFERENCES Users(userID)
);

CREATE TABLE HealthCheckForm (
    healthCheckFormID INT IDENTITY(1,1) PRIMARY KEY,
    healthCheckID INT FOREIGN KEY REFERENCES HealthCheckProgram(healthCheckID),
    studentID INT FOREIGN KEY REFERENCES Student(studentID),
    parentID INT FOREIGN KEY REFERENCES Users(userID),
    formDate DATE,
    notes NVARCHAR(255),
    [commit] BIT
);

CREATE TABLE HealthCheckResult (
    resultID INT IDENTITY(1,1) PRIMARY KEY,
    diagnosis NVARCHAR(255),
    level NVARCHAR(50) CHECK (level IN ('good', 'fair', 'average', 'poor')),
    note NVARCHAR(255),
    nurseID INT FOREIGN KEY REFERENCES Users(userID),
    healthCheckFormID INT FOREIGN KEY REFERENCES HealthCheckForm(healthCheckFormID)
);

CREATE TABLE MedicalRecords (
    recordID INT IDENTITY(1,1) PRIMARY KEY,
    studentID INT FOREIGN KEY REFERENCES Student(studentID),
    allergies NVARCHAR(255),
    chronicDisease NVARCHAR(255),
    treatmentHistory NVARCHAR(255),
    version NVARCHAR(50),
    hearing NVARCHAR(50),
    weight FLOAT,
    hight FLOAT,
    lastUpdate DATE,
    note NVARCHAR(255)
);

CREATE TABLE VaccineProgram (
    vaccineID INT IDENTITY(1,1) PRIMARY KEY,
    vaccineName NVARCHAR(100),
    description NVARCHAR(255),
    vaccineDate DATE,
    note NVARCHAR(255),
    nurseID INT FOREIGN KEY REFERENCES Users(userID)
);

CREATE TABLE VaccineForm (
    vaccineFormID INT IDENTITY(1,1) PRIMARY KEY,
    vaccineID INT FOREIGN KEY REFERENCES VaccineProgram(vaccineID),
    studentID INT FOREIGN KEY REFERENCES Student(studentID),
    parentID INT FOREIGN KEY REFERENCES Users(userID),
    formDate DATE,
    note NVARCHAR(255),
    [commit] BIT
);

CREATE TABLE VaccineHistory (
    vaccineHistoryID INT IDENTITY(1,1) PRIMARY KEY,
    vaccineName NVARCHAR(100),
    note NVARCHAR(255),
    recordID INT FOREIGN KEY REFERENCES MedicalRecords(recordID)
);


CREATE TABLE Survey (
    surveyID INT IDENTITY(1,1) PRIMARY KEY,
    satisfaction NVARCHAR(20) CHECK (satisfaction IN ('satisfied', 'unsatisfied')),
    reaction NVARCHAR(255),
    comment NVARCHAR(255),
    createdAt DATETIME,
    parentID INT FOREIGN KEY REFERENCES Users(userID),
    vaccineFormID INT FOREIGN KEY REFERENCES VaccineForm(vaccineFormID),
    healthCheckFormID INT FOREIGN KEY REFERENCES HealthCheckForm(healthCheckFormID)
);
