CREATE TABLE users(
username varchar(20) NOT NULL,
password varchar(20) NOT NULL,
email varchar(50),
PRIMARY KEY(username)
);

INSERT INTO users VALUES('bhalu', 'bhalu', 'ankitstone23@gmail.com');
INSERT INTO users VALUES('rajiv', 'rts', 'rajiv.tilakraj.sharma@gmail.com');
INSERT INTO users VALUES('faizan', 'fs', 'sayedfaizan23@gmail.com');
INSERT INTO users VALUES('omkar', 'os', 'omsawant25@gmail.com');
INSERT INTO users VALUES('jibin', 'bantai', 'jibin.varghese@gmail.com');
INSERT INTO users VALUES('orochimaru', 'sasuke', 'oro.chimaru@gmail.com');
INSERT INTO users VALUES('rohit', 'gayboy', 'rohitwriter99@gmail.com');
INSERT INTO users VALUES('sanjay', 'sts', 'sanjay.sharma@gmail.com');
INSERT INTO users VALUES('manav', 'umanav', 'manav.shah@gmail.com');
INSERT INTO users VALUES('gaurav', 'diapli', 'gaurav.dipali@gmail.com');
INSERT INTO users VALUES('nikhil', 'neelam', 'neelNnikki@gmail.com');
INSERT INTO users VALUES('santu', 'bantu', 'santu.bantu@gmail.com');
INSERT INTO users VALUES('gajju', 'mansi', 'gajju.mansi@gmail.com');
INSERT INTO users VALUES('cosu', 'shapa', 'cosu.shapa@gmail.com');
INSERT INTO users VALUES('ramesh', 'suresh', 'ramesh.suresh@gmail.com');


CREATE TABLE offer(
offerID int NOT NULL AUTO_INCREMENT,
seller varchar(20) NOT NULL,
price int NOT NULL,
offerType varchar(10) NOT NULL,
subject varchar(30) NOT NULL,
publication varchar(20),
year int NOT NULL,
semester int NOT NULL,
edition int,
seller varchar(20),
PRIMARY KEY(offerID)
);

INSERT INTO offer(seller, price, offerType, subject, publication, year, semester, edition) VALUES('faizan', 210, 'book', 'MEIT', 'Wiley', 3, 6, 2010);
INSERT INTO offer(seller, price, offerType, subject, publication, year, semester, edition) VALUES('rajiv', 350, 'book', 'SE', 'Technical', 3, 6, 2012);
INSERT INTO offer(seller, price, offerType, subject, publication, year, semester, edition) VALUES('rohit', 300, 'book', 'DBT', 'Wiley', 3, 6, 2013);
INSERT INTO offer(seller, price, offerType, subject, publication, year, semester, edition) VALUES('jibin', 400, 'notes', 'DBT', 'Ramu Classes', 3, 6, 2013);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('ramesh', 200, 'labcoat', 'Workshop', 1, 1);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('santu', 250, 'labcoat', 'Chemistry', 1, 1);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('sanjay', 500, 'drafter', 'ED', 1, 2);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('orochimaru', 600, 'drafter', 'ED', 1, 2);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('manav', 700, 'tools', 'Workshop', 1, 1);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('gaurav', 800, 'tools', 'Workshop', 1, 1);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('cosu', 550, 'drafter', 'ED', 1, 2);
INSERT INTO offer(seller, price, offerType, subject, publication, year, semester, edition) VALUES('gajju', 340, 'notes', 'Mechanics', 'Ramu Classes', 1, 2, 2011);
INSERT INTO offer(seller, price, offerType, subject, year, semester) VALUES('nikhil', 300, 'labcoat', 'Workshop', 1, 1);