-- CREATE DATABASE test
-- USE test

-- SELECT name, database_id, create_date
-- From sys.databases ;

-----------------------------------------------------

DROP PROCEDURE IF EXISTS dbo.MULTIPLY
GO

CREATE PROCEDURE MULTIPLY @VAR1 INT, @VAR2 INT AS
BEGIN
    SELECT @VAR1 * @VAR2
END;

EXEC MULTIPLY @VAR1 = 2, @VAR2 = 3;

----------------------------------------------------

DROP FUNCTION IF EXISTS [ADD]
GO

CREATE FUNCTION [ADD] (@no1 INT, @no2 INT) RETURNS INT AS
        BEGIN
            RETURN @no1+@no2
        END;
GO

BEGIN
    DECLARE @no1 INT,  @no2 INT;
    SET @no1 = 1;
    SET @no2 = 5;
    SELECT CONCAT('The sum of ',  @no1, ' and ', @no2 , ' is ', dbo.[ADD](@no1,@no2));
END;

----------------------------------------------
DROP TABLE IF EXISTS LOG
GO
DROP TABLE IF EXISTS ACCOUNT
GO
DROP PROCEDURE IF EXISTS dbo.TESTNAME
GO

CREATE TABLE ACCOUNT (
    AcctNo INT,
    Fname NVARCHAR(100),
    Lname NVARCHAR(100),
    CreditLimit INT,
    Balance INT,
    PRIMARY KEY (AcctNo)
);

CREATE TABLE LOG (
    OrigAcct INT,
    LogDateTime DATE,
    RecAcct INT,
    Amount INT,
    PRIMARY KEY (OrigAcct),
    FOREIGN KEY (OrigAcct) REFERENCES ACCOUNT,
    FOREIGN KEY (RecAcct) REFERENCES ACCOUNT
);

INSERT INTO Account (AcctNo, Fname, Lname, CreditLimit, Balance)
VALUES  (530, 'Lachlin', 'Row', 1000, 600),
        (531, 'Michael', 'Reave', 1000, 350),
        (532, 'Sophie', 'Green', 1500, 3200);

SELECT * FROM ACCOUNT


GO
CREATE PROCEDURE TESTNAME @FromAccountNumber INT, @ToAccountNumber INT, @Amount INT AS

BEGIN
    UPDATE ACCOUNT
    SET Balance = Balance - @Amount
    WHERE AcctNo = @FromAccountNumber

    UPDATE ACCOUNT
    SET Balance = Balance + @Amount
    WHERE AcctNo = @ToAccountNumber

    INSERT INTO LOG (OrigAcct, LogDateTime, RecAcct, Amount)
    VALUES (@FromAccountNumber, SYSDATETIME(), @ToAccountNumber, @Amount);


END;

EXEC TESTNAME @FromAccountNumber = 530, @ToAccountNumber = 531, @Amount = 400;
SELECT * FROM LOG