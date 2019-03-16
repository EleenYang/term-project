CREATE TYPE gender AS ENUM ('MALE', 'FEMALE');
CREATE TYPE education AS ENUM ('other', 'high school', 'college', 'postgraduate');
CREATE TYPE role AS ENUM ('finder','tasker');

CREATE TABLE Accounts(
	aid 			INTEGER PRIMARY KEY,
  email 		VARCHAR(74) UNIQUE,
  username 	VARCHAR(74) NOT NULL,
  password 	VARCHAR(74) NOT NULL
);

CREATE TABLE Users(
	aid 			INTEGER,
  gen 			gender,
  edu				education,
  rid				INTEGER,
  score     INTEGER,
	PRIMARY KEY (aid),
	FOREIGN KEY (aid) REFERENCES Accounts,
  FOREIGN KEY (RID)	REFERENCES Regions
);

CREATE TABLE Specializes (
	aid				INTEGER REFERENCES Users,
  sname		  VARCHAR(74) REFERENCES Specializations,
  PRIMARY KEY	(aid, eid)
);

CREATE TABLE Bids (
  tid INTEGER REFERENCES Tasks,
  tasker_id INTEGER REFERENCES Users,
  salary INTEGER NOT NULL,
  PRIMARY KEY (tid, tasker_id)
);

CREATE TABLE Specializations (
  sname VARCHAR(74) PRIMARY KEY,
  details VARCHAR(100),
  check (sname <> 'OTHER' OR details NOT NULL)
);

CREATE TABLE Admins(
	aid 			   INTEGER PRIMARY KEY,
  FOREIGN KEY(aid) REFERENCES Accounts
);

CREATE TABLE Tasks(
  tid INTEGER PRIMARY KEY,
  title VARCHAR(74) UNIQUE,
  sname VARCHAR(74) DEFAULT 'Unassigned' REFERENCES States,
  rname VARCHAR(74) DEFAULT 'All' REFERENCES Regions,
  cname VARCHAR(74) DEFAULT 'All' REFERENCES Classifications,
  finder_id INTEGER REFERENCES Users(aid) NOT NULL,
  salary INTEGER NOT NULL,
  tasktime DATETIME NOT NULL,
  description VARCHAR(200),
  tasker_id INTEGER REFERENCES Users(aid)
  check (tasker_id <> finder_id)
);

CREATE TABLE Reviews(
  tid INTEGER REFERENCES Tasks,
  reviewer_id INTEGER NOT NULL REFERENCES Users(aid),
  receiver_id INTEGER NOT NULL REFERENCES Users(aid),
  receiver_role role NOT NULL,
  score INTEGER NOT NULL, 
  PRIMARY KEY (tid, reviewer_id, receiver_id),
  check(score >= 0 and score <= 5),
);

CREATE TABLE Regions (
  rname VARCHAR(74) PRIMARY KEY
);

CREATE TABLE States (
  sname VARCHAR(74) PRIMARY KEY
);

CREATE TABLE Classifications (
  cname VARCHAR(74) PRIMARY KEY
);

INSERT INTO Regions (rname) VALUES ('Kent Ridge');
INSERT INTO Regions (rname) VALUES ('Buona Vista');
INSERT INTO Regions (rname) VALUES ('Bugis');
INSERT INTO Regions (rname) VALUES ('Marina Bay');
INSERT INTO Regions (rname) VALUES ('Orchard');
INSERT INTO Regions (rname) VALUES ('Jurong East');
INSERT INTO Regions (rname) VALUES ('Changi Airport');
INSERT INTO Regions (rname) VALUES ('Malaysia');
INSERT INTO Regions (rname) VALUES ('Bishan');
INSERT INTO Regions (rname) VALUES ('Holland Village');
INSERT INTO Regions (rname) VALUES ('Yishun');

INSERT INTO Specializations (rname) VALUES ('Mandarin');
INSERT INTO Specializations (rname) VALUES ('Highschool Mathemetics');
INSERT INTO Specializations (rname) VALUES ('Singing');
INSERT INTO Specializations (rname) VALUES ('Drawing');
INSERT INTO Specializations (rname) VALUES ('English');
INSERT INTO Specializations (rname) VALUES ('Cooking');
INSERT INTO Specializations (rname) VALUES ('Driving');

INSERT INTO States (sname) VALUES ('Unassigned');
INSERT INTO States (sname) VALUES ('Ongoing');
INSERT INTO States (sname) VALUES ('Completed');
INSERT INTO States (sname) VALUES ('Failed');

INSERT INTO Classifications (cname) VALUES ('Baby Sitting');
INSERT INTO Classifications (cname) VALUES ('Tutor');
INSERT INTO Classifications (cname) VALUES ('Horticulture');
INSERT INTO Classifications (cname) VALUES ('Lifting');
INSERT INTO Classifications (cname) VALUES ('Pets Caring');
INSERT INTO Classifications (cname) VALUES ('Electrical');