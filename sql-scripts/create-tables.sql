CREATE TABLE Host1 (
    email CHAR(80) PRIMARY KEY,
    organization CHAR(80)
);

CREATE TABLE Host2 (
    host_id INT PRIMARY KEY,
    name CHAR(80),
    email CHAR(80),
    rating FLOAT,
    FOREIGN KEY (email) REFERENCES Host1 (email) ON DELETE SET NULL
);

CREATE TABLE `Event` (
    event_id INT PRIMARY KEY,
    name CHAR(80),
    start_date DATE,
    end_date DATE,
    ranking FLOAT,
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES Host2 (host_id) ON DELETE CASCADE
);

CREATE TABLE Performer (
    performer_id INT PRIMARY KEY,
    name CHAR(80),
    contact CHAR(80),
    ranking FLOAT
);

CREATE TABLE Venue1 (
    name CHAR(80),
    address CHAR(80),
    capacity INT,
    PRIMARY KEY (name, address)
);

CREATE TABLE Venue2 (
    venue_id INT PRIMARY KEY,
    name CHAR(80),
    address CHAR(80),
    FOREIGN KEY (name, address) REFERENCES Venue1 (name, address)
);

CREATE TABLE EventCategory (
    name CHAR(80) PRIMARY KEY
);


CREATE TABLE RegularUser1 (
    name CHAR(80) PRIMARY KEY,
    email CHAR(80) NOT NULL
);

CREATE TABLE RegularUser2 (
    name CHAR(80) PRIMARY KEY,
    address CHAR(80) NOT NULL
);

CREATE TABLE RegularUser3 (
    user_id INT PRIMARY KEY,
    name CHAR(80),
    FOREIGN KEY (name) REFERENCES RegularUser1 (name),
    FOREIGN KEY (name) REFERENCES RegularUser2 (name)
);

CREATE TABLE Ticket (
    ticket_id INT PRIMARY KEY,
    price INT,
    booked_on DATE,
    user_id INT NOT NULL,
    host_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES RegularUser3 (user_id),
    FOREIGN KEY (host_id) REFERENCES Host2 (host_id)
);

CREATE TABLE TicketVendor1 (
    name CHAR(80),
    address CHAR(80),
    contact CHAR(80),
    PRIMARY KEY (name, address)
);

CREATE TABLE TicketVendor2 (
    vendor_id INT PRIMARY KEY,
    name CHAR(80),
    address CHAR(80),
    FOREIGN KEY (name, address) REFERENCES TicketVendor1 (name, address)
);

CREATE TABLE UserSchedule (
    user_id INT,
    schedule_id INT,
    time_block_start DATE,
    time_block_end DATE,
    PRIMARY KEY (user_id, schedule_id),
    FOREIGN KEY (user_id) REFERENCES RegularUser3 (user_id) ON DELETE CASCADE
);

CREATE TABLE HostSchedule (
    host_id INT,
    schedule_id INT,
    time_block_start DATE,
    time_block_end DATE,
    PRIMARY KEY (host_id, schedule_id),
    FOREIGN KEY (host_id) REFERENCES Host2 (host_id) ON DELETE CASCADE
);

CREATE TABLE BookedAt (
    event_id INT,
    venue_id INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (event_id, venue_id),
    FOREIGN KEY (event_id) REFERENCES `Event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (venue_id) REFERENCES Venue2 (venue_id) ON DELETE CASCADE
);

CREATE TABLE PerformsAt (
    event_id INT,
    performer_id INT,
    PRIMARY KEY (event_id, performer_id),
    FOREIGN KEY (event_id) REFERENCES `Event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (performer_id) REFERENCES Performer (performer_id) ON DELETE CASCADE
);

CREATE TABLE IsCategory (
    event_id INT,
    category CHAR(80),
    PRIMARY KEY (event_id, category),
    FOREIGN KEY (event_id) REFERENCES `Event` (event_id) ON DELETE CASCADE
);

CREATE TABLE IsFor (
    event_id INT,
    ticket_id INT,
    PRIMARY KEY (event_id, ticket_id),
    FOREIGN KEY (event_id) REFERENCES `Event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES Ticket (ticket_id) ON DELETE CASCADE
);

CREATE TABLE Reserves (
    user_id INT,
    event_id INT,
    ticket_id INT,
    PRIMARY KEY (ticket_id, event_id),
    FOREIGN KEY (event_id) REFERENCES `Event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES Ticket (ticket_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES RegularUser3 (user_id) ON DELETE CASCADE
);

CREATE TABLE Sells (
    vendor_id INT,
    ticket_id INT,
    PRIMARY KEY (vendor_id, ticket_id),
    FOREIGN KEY (vendor_id) REFERENCES TicketVendor2 (vendor_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES Ticket (ticket_id) ON DELETE CASCADE
);