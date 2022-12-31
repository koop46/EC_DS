USE master

DROP DATABASE IF EXISTS Hoppet;

CREATE DATABASE Hoppet;
GO

USE Hoppet;

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 


CREATE TABLE Customers( ---Parents Tabell
    customerID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    companyName VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    phoneNr INT NOT NULL,    
);

CREATE TABLE Staff( ---Parent Tabell    
    staffID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    product VARCHAR(50) NOT NULL,
    names varchar(50),
    address VARCHAR(50) NOT NULL,
    phoneNr VARCHAR(50) NOT NULL,
);

CREATE TABLE Products ( -- Parent 
    productID INT NOT NULL IDENTITY (1,1),
    product VARCHAR(20) PRIMARY KEY,
    unit_price INT NOT NULL,
    staffID INT NOT NULL FOREIGN KEY REFERENCES
        Staff (staffID) ON DELETE CASCADE,
);

CREATE TABLE Sales( ---Parent/Child Tabell 
    salesID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    salesDate DATETIME,
    product_amount INT NOT NULL,
    product VARCHAR(20) FOREIGN KEY REFERENCES
        Products (product) ON DELETE CASCADE,
    customerID INT NOT NULL FOREIGN KEY REFERENCES
        Customers (customerID) ON DELETE CASCADE,
);

CREATE TABLE Invoice( ---Child Tabell 
    invoiceID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    total INT NOT NULL,
    SalesID INT FOREIGN KEY REFERENCES
        Sales (salesID) ON DELETE CASCADE,
    reference VARCHAR(20),
    due_date DATETIME
);


--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- 


INSERT INTO Customers(companyName, address, phoneNr) ---customers
VALUES ('Nike','tornfalskgatan 105', 0731),
        ('Barcelona','drottninggatan 28',0732),
        ('Chelsea','kronikegatan 28', 0733),
        ('Deichman','poesigatan 11', 0734),
        ('Emmaus','kungsgatan 11', 0735)

INSERT INTO Staff (names, address, phoneNr, product)---staff
VALUES ('Afrah Nasser', 'kronikegatan 12', 111, 'Falafel'),
        ('Benedicte Basel', 'kronikegatan 28', 222, 'Shawarma'),
        ('Caterine Cielos', 'diktargatan 32', 333, 'Kobba'),
        ('Diana Danti', 'lyrikgatan 48', 444, 'Ayran'),
        ('Efrata Essaoui', 'kronikegatan 52', 555, 'Ostrullar')

INSERT INTO Products (product, unit_price, staffID) ---invoice
VALUES ('Falafel', 10, 1),
        ('Shawarma', 65, 2),
        ('Kobba', 20, 3),
        ('Ayran', 15, 4),
        ('Ostrullar', 5, 5)

INSERT INTO Sales (salesDate, product, product_amount, customerID) ---sales
VALUES ('2022-2-1 12:30:15', 'Kobba', 2, 3),
        ('2022-2-2 12:45:15','Shawarma', 3, 2),
        ('2022-2-3 13:30:15', 'Falafel', 10, 1),
        ('2022-2-4 13:45:15', 'Ostrullar', 7, 4),
        ('2022-2-5 14:30:15','Ayran', 4, 5),
        ('2022-2-5 18:54:15', 'Kobba', 5, 1),
        ('2022-2-6 12:45:15','Kobba', 3, 2),
        ('2022-2-7 10:30:15', 'Falafel', 3, 3),
        ('2022-2-10 20:15:15', 'Falafel', 12, 2),
        ('2022-2-11 21:30:15','Ostrullar', 6, 1)

INSERT INTO Invoice (total, salesID, reference, due_date) ---invoice
VALUES (40, 1, 'Chiaco Chino', '2024-12-1 12:30:15'),
        (195, 2, 'Benilda Belcatriz', '2023-12-2 12:30:15'),
        (100, 3, 'Ali Agha', '2023-4-3 12:30:15'),
        (35, 4, 'David Denta', '2023-9-4 12:30:15'),
        (60, 5, 'Emilio Emmao', '2023-6-5 12:30:15'),
        (100, 6, 'Ali Agha','2023-9-4 12:30:15'),
        (60, 7, 'Benilda Belcatriz','2023-3-12 12:30:15'),
        (30, 8, 'Chiaco Chino','2023-6-4 12:30:15'),
        (120, 9, 'Benilda Belcatriz','2023-3-12 12:30:15'),
        (30, 10, 'Ali Agha','2023-7-4 14:00:00')

