DROP DATABASE IF EXISTS photoshop;
CREATE DATABASE photoshop;
USE photoshop;

CREATE TABLE photographer(
	PName VARCHAR(20) NOT NULL,
    PBDate DATE NOT NULL,
    PBio VARCHAR(20),
    PAddress VARCHAR(20),
    `Color_B&W` VARCHAR(20),
    PNationality VARCHAR(20),
    index(PName),index(PBDate),
    PRIMARY KEY(PName,PBDate)
)ENGINE=INNODB;

CREATE TABLE customer (
    LoginName VARCHAR(20) NOT NULL,
    PWord VARCHAR(20),
    CName VARCHAR(20),
    CType VARCHAR(20),
    BillingAddress VARCHAR(20),
    Str1 VARCHAR(20),
    Str2 VARCHAR(20),
    City VARCHAR(20),
    State VARCHAR(20),
    Zip INTEGER,
    INDEX (LoginName)
)  ENGINE=INNODB;

CREATE TABLE transactions(
	TransID INTEGER NOT NULL,
    TDate DATE,
    CardNo INTEGER,
    CardExpDate DATE,
    TotalAmount FLOAT,
    LoginName VARCHAR(20),
    index(TransID),
    PRIMARY KEY(TransID),
    CONSTRAINT LN
		FOREIGN KEY(LoginName)
        REFERENCES customer(LoginName)
)ENGINE=INNODB;

CREATE TABLE photo (
    PhotoID INTEGER NOT NULL,
    Speed VARCHAR(20),
    Film VARCHAR(20),
    F_Stop VARCHAR(20),
    Color VARCHAR(20),
    Resolution VARCHAR(20),
    Price INTEGER,
    DateTaken DATE,
    TransID INTEGER,
    PName VARCHAR(20),
    PBDate DATE,
    PRIMARY KEY (PhotoID),
    index (PhotoID),
    CONSTRAINT PBD
		FOREIGN KEY(PBDate)
        REFERENCES photographer(PBDate),
	CONSTRAINT PName
		FOREIGN KEY(PName)
        REFERENCES photographer(PName),
	CONSTRAINT TID
		FOREIGN KEY(TransID)
        REFERENCES transactions(TransID)
)  ENGINE=INNODB;
    
CREATE TABLE location(
	Country VARCHAR(20),
    Place VARCHAR(20),
    Description VARCHAR(20),
    PRIMARY KEY (Place,Country),
    index (Place),
    index (Country)
) ENGINE=INNODB;

CREATE TABLE landscape(
	PhotoID INTEGER NOT NULL,
    Place VARCHAR(20),
    Country VARCHAR(20),
    PRIMARY KEY (PhotoID),
    CONSTRAINT LandscapePID
		FOREIGN KEY(PhotoID) 
		REFERENCES photo(PhotoID),
	CONSTRAINT l_place
		FOREIGN KEY(Place)
		REFERENCES location(Place),
	CONSTRAINT l_country
		FOREIGN KEY (Country)
		REFERENCES location(Country)
) ENGINE=INNODB;

CREATE TABLE abstract(
	PhotoID INTEGER NOT NULL,
    PicComment VARCHAR(20),
    PRIMARY KEY(PhotoID),
    index(PhotoID),
    CONSTRAINT AbstractPID
		FOREIGN KEY(PhotoID)
        REFERENCES photo(PhotoID)
)ENGINE=INNODB;

CREATE TABLE model(
	MName VARCHAR(20) NOT NULL,
    MBDate DATE NOT NULL,
    MBio VARCHAR(20),
    MSex VARCHAR(20),
    index(MName),index(MBDate),
    PRIMARY KEY(MName,MBDate)
)ENGINE=INNODB;

CREATE TABLE models(
	PhotoID INTEGER NOT NULL,
    MName VARCHAR(20) NOT NULL,
    MBDate DATE NOT NULL,
    Agency VARCHAR(20),
    PRIMARY KEY(PhotoID,MName,MBDate),
    index(PhotoID),index(MName),index(MBDate),
    CONSTRAINT ModelsMName
		FOREIGN KEY(MName)
		REFERENCES model(MName),
	CONSTRAINT ModelsMBDate
		FOREIGN KEY(MBDate)
        REFERENCES model(MBDate),
	CONSTRAINT ModelsPID
		FOREIGN KEY(PhotoID)
        REFERENCES photo(PhotoID)
)ENGINE=INNODB;

CREATE TABLE influences(
	EPName VARCHAR(20) NOT NULL,
    EPBDate DATE NOT NULL,
    RPName VARCHAR(20) NOT NULL,
    RPBDate DATE NOT NULL,
    index(EPName),index(EPBDate),index(RPName),index(RPBDate),
    CONSTRAINT EPN
		FOREIGN KEY(EPName)
        REFERENCES photographer(PName),
	CONSTRAINT EPBD
		FOREIGN KEY(EPBDate)
        REFERENCES photographer(PBDate),
	CONSTRAINT RPN
		FOREIGN KEY(RPName)
        REFERENCES photographer(PName),
	CONSTRAINT RPBD
		FOREIGN KEY(RPBDate)
        REFERENCES photographer(PBDate),
	PRIMARY KEY(EPName,EPBDate,RPName,RPBDate)
)ENGINE=INNODB;
    




