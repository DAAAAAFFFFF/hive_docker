DROP TABLE Logs;
DROP TABLE Statistic;
CREATE TABLE Logs(str STRING);
CREATE TABLE Statistic(ip STRING,sum INT,avg DOUBLE);
LOAD DATA LOCAL INPATH '000000' OVERWRITE INTO TABLE Logs;
INSERT INTO Statistic SELECT t.ip, SUM(CASE WHEN num IS NOT NULL THEN num ELSE 0 END),AVG(CASE WHEN num IS NOT NULL THEN num ELSE 0 END) FROM (SELECT REGEXP_EXTRACT(str,'ip\\d+ ',0) AS ip,CAST(SPLIT(REGEXP_EXTRACT(str,' \\d+ \\d+ ',0),' ')[2] AS DOUBLE) AS num FROM Logs) t GROUP BY t.ip;
SELECT * FROM Statistic;