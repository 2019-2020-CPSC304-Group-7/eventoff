CREATE TABLE `host1` (
    email CHAR(80) PRIMARY KEY,
    organization CHAR(80)
);

CREATE TABLE `host2` (
    host_id INT PRIMARY KEY,
    name CHAR(80),
    email CHAR(80),
    rating FLOAT,
    FOREIGN KEY (email) REFERENCES `host1` (email) ON DELETE SET NULL
);

CREATE TABLE `event` (
    event_id INT PRIMARY KEY,
    name CHAR(80),
    start_date DATETIME,
    end_date DATETIME,
    ranking FLOAT,
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES `host2` (host_id) ON DELETE CASCADE
);

CREATE TABLE `performer` (
    performer_id INT PRIMARY KEY,
    name CHAR(80),
    contact CHAR(80),
    ranking FLOAT
);

CREATE TABLE `venue1` (
    name CHAR(80),
    address CHAR(80),
    capacity INT,
    PRIMARY KEY (name, address)
);

CREATE TABLE `venue2` (
    venue_id INT PRIMARY KEY,
    name CHAR(80),
    address CHAR(80),
    FOREIGN KEY (name, address) REFERENCES `venue1` (name, address)
);

CREATE TABLE `eventcategory` (
    name CHAR(80) PRIMARY KEY
);


CREATE TABLE `regularuser1` (
    name CHAR(80) PRIMARY KEY,
    email CHAR(80) NOT NULL
);

CREATE TABLE `regularuser2` (
    name CHAR(80) PRIMARY KEY,
    address CHAR(80) NOT NULL
);

CREATE TABLE `regularuser3` (
    user_id INT PRIMARY KEY,
    name CHAR(80),
    FOREIGN KEY (name) REFERENCES `regularuser1` (name),
    FOREIGN KEY (name) REFERENCES `regularuser2` (name)
);

CREATE TABLE `ticket` (
    ticket_id INT PRIMARY KEY,
    event_id INT,
    price INT,
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE
);

CREATE TABLE `ticketvendor1` (
    name CHAR(80),
    address CHAR(80),
    contact CHAR(80),
    PRIMARY KEY (name, address)
);

CREATE TABLE `ticketvendor2` (
    vendor_id INT PRIMARY KEY,
    name CHAR(80),
    address CHAR(80),
    FOREIGN KEY (name, address) REFERENCES `ticketvendor1` (name, address)
);

CREATE TABLE `bookedat` (
    event_id INT,
    venue_id INT,
    PRIMARY KEY (event_id, venue_id),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (venue_id) REFERENCES `venue2` (venue_id) ON DELETE CASCADE
);

CREATE TABLE `performsat` (
    event_id INT,
    performer_id INT,
    PRIMARY KEY (event_id, performer_id),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (performer_id) REFERENCES `performer` (performer_id) ON DELETE CASCADE
);

CREATE TABLE `iscategory` (
    event_id INT,
    category CHAR(80),
    PRIMARY KEY (event_id, category),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES `eventcategory` (name) ON DELETE SET NULL
);

CREATE TABLE `purchased` (
    user_id INT,
    ticket_id INT PRIMARY KEY,
    FOREIGN KEY (ticket_id) REFERENCES `ticket` (ticket_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES `regularuser3` (user_id) ON DELETE CASCADE
);

CREATE TABLE `sells` (
    vendor_id INT,
    ticket_id INT,
    PRIMARY KEY (vendor_id, ticket_id),
    FOREIGN KEY (vendor_id) REFERENCES `ticketvendor2` (vendor_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES `ticket` (ticket_id) ON DELETE CASCADE
);
