SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `host1`;
DROP TABLE IF EXISTS `host2`;
DROP TABLE IF EXISTS `event`;
DROP TABLE IF EXISTS `performer`;
DROP TABLE IF EXISTS `venue1`;
DROP TABLE IF EXISTS `venue2`;
DROP TABLE IF EXISTS `eventcategory`;
DROP TABLE IF EXISTS `regularuser1`;
DROP TABLE IF EXISTS `regularuser2`;
DROP TABLE IF EXISTS `regularuser3`;
DROP TABLE IF EXISTS `ticket`;
DROP TABLE IF EXISTS `ticketvendor1`;
DROP TABLE IF EXISTS `ticketvendor2`;
DROP TABLE IF EXISTS `userschedule`;
DROP TABLE IF EXISTS `hostschedule`;
DROP TABLE IF EXISTS `bookedat`;
DROP TABLE IF EXISTS `performsat`;
DROP TABLE IF EXISTS `iscategory`;
DROP TABLE IF EXISTS `isfor`;
DROP TABLE IF EXISTS `reserves`;
DROP TABLE IF EXISTS `sells`;

SET FOREIGN_KEY_CHECKS=1;

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
    start_date DATE,
    end_date DATE,
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
    price INT,
    booked_on DATE,
    user_id INT,
    host_id INT,
    FOREIGN KEY (user_id) REFERENCES `regularuser3` (user_id),
    FOREIGN KEY (host_id) REFERENCES `host2` (host_id)
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

CREATE TABLE `userschedule` (
    user_id INT,
    schedule_id INT,
    time_block_start DATE,
    time_block_end DATE,
    PRIMARY KEY (user_id, schedule_id),
    FOREIGN KEY (user_id) REFERENCES `regularuser3` (user_id) ON DELETE CASCADE
);

CREATE TABLE `hostschedule` (
    host_id INT,
    schedule_id INT,
    time_block_start DATE,
    time_block_end DATE,
    PRIMARY KEY (host_id, schedule_id),
    FOREIGN KEY (host_id) REFERENCES `host2` (host_id) ON DELETE CASCADE
);

CREATE TABLE `bookedat` (
    event_id INT,
    venue_id INT,
    start_date DATE,
    end_date DATE,
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
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE
);

CREATE TABLE `isfor` (
    event_id INT,
    ticket_id INT,
    PRIMARY KEY (event_id, ticket_id),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES `ticket` (ticket_id) ON DELETE CASCADE
);

CREATE TABLE `reserves` (
    user_id INT,
    event_id INT,
    ticket_id INT,
    PRIMARY KEY (ticket_id, event_id),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
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

INSERT INTO `host1` VALUES ('studentsofubc@ubc.ca', 'UBC');
INSERT INTO `host1` VALUES ('computerscience@ubc.ca', 'UBC');
INSERT INTO `host1` VALUES ('hello@nwplus.io', 'nwPlus');
INSERT INTO `host1` VALUES ('science@ubc.ca', 'UBC');
INSERT INTO `host1` VALUES ('taco@tacodelmar.com', 'Taco Del Mar');

INSERT INTO `host2` VALUES (3967, 'Students of UBC', 'studentsofubc@ubc.ca', 0.8);
INSERT INTO `host2` VALUES (4529, 'UBC CS Department', 'computerscience@ubc.ca', 0.8);
INSERT INTO `host2` VALUES (7820, 'nwPlus', 'hello@nwplus.io', 1);
INSERT INTO `host2` VALUES (1920, 'UBC Faculty of Science', 'science@ubc.ca', 0.6);
INSERT INTO `host2` VALUES (2834, 'UBC Taco Del Mar', 'taco@tacodelmar.com', 0.4);

INSERT INTO `event` VALUES (4576, 'Fall Reading Week Rally', STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'), 1, 3967);
INSERT INTO `event` VALUES (3077, 'CPSC 304 Crash Course', STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'), 2, 4529);
INSERT INTO `event` VALUES (4089, 'NWHacks Hackathon', STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'), 3, 7820);
INSERT INTO `event` VALUES (2412, 'Science Career Night', STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'), 4, 1920);
INSERT INTO `event` VALUES (1024, 'Taco Del Mar Grand Opening', STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'), 5, 2834);

INSERT INTO `performer` VALUES (3489, 'Linkin Park', 'linkinpark@linkinpark.com', 0.6);
INSERT INTO `performer` VALUES (2392, 'Bill Nye', 'billnye@thescienceguy.com', 0.8);
INSERT INTO `performer` VALUES (1254, 'Vancouver Canucks', 'canucks@vancouver.ca', 0.777777777777778);
INSERT INTO `performer` VALUES (4223, 'Tim Cook', 'timcook@apple.com', 0.9);
INSERT INTO `performer` VALUES (6782, 'Toronto Raptors', 'raptors@toronto.ca', 0.95);

INSERT INTO `venue1` VALUES ('ICICS Room 250', 'ICICS Main Mall, Vancouver BC', 40);
INSERT INTO `venue1` VALUES ('BC Place', 'BC Place, Vancouver BC', 20000);
INSERT INTO `venue1` VALUES ('Earth Science Building, Room 1021', 'ESB Main Mall, Vancouver BC', 100);
INSERT INTO `venue1` VALUES ('Vancouver Convention Centre', '1055 Canada Pl, Vancouver, BC', 2000);
INSERT INTO `venue1` VALUES ('Vancouver Public Library, Room 200', '575 Clancy Loranger Way, Vancouver, BC', 100);

INSERT INTO `venue2` VALUES (4829, 'ICICS Room 250', 'ICICS Main Mall, Vancouver BC');
INSERT INTO `venue2` VALUES (1230, 'BC Place', 'BC Place, Vancouver BC');
INSERT INTO `venue2` VALUES (4205, 'Earth Science Building, Room 1021', 'ESB Main Mall, Vancouver BC');
INSERT INTO `venue2` VALUES (4530, 'Vancouver Convention Centre', '1055 Canada Pl, Vancouver, BC');
INSERT INTO `venue2` VALUES (8923, 'Vancouver Public Library, Room 200', '575 Clancy Loranger Way, Vancouver, BC');

INSERT INTO `eventcategory` VALUES ('Social');
INSERT INTO `eventcategory` VALUES ('Athletics');
INSERT INTO `eventcategory` VALUES ('Academic');
INSERT INTO `eventcategory` VALUES ('Food');
INSERT INTO `eventcategory` VALUES ('Film');

INSERT INTO `regularuser1` VALUES ('Amman Zaman', 'thezaman76@gmail.com');
INSERT INTO `regularuser1` VALUES ('Divyansh Singhal', 'singhaldivyansh1998@gmail.com');
INSERT INTO `regularuser1` VALUES ('Mourud Ahmed', 'ishmam1@gmail.com');
INSERT INTO `regularuser1` VALUES ('Jessica Wang', 'jessicawang@cs.ubc.ca');
INSERT INTO `regularuser1` VALUES ('John Wick', 'johnwick@thecontinental.com');

INSERT INTO `regularuser2` VALUES ('Amman Zaman', '1234 A St, Surrey BC');
INSERT INTO `regularuser2` VALUES ('Divyansh Singhal', '5671 B St, Burnaby BC');
INSERT INTO `regularuser2` VALUES ('Mourud Ahmed', '2353 C St, Vancouver BC');
INSERT INTO `regularuser2` VALUES ('Jessica Wang', '2123 CC Ave, Vancouver BC');
INSERT INTO `regularuser2` VALUES ('John Wick', '6554 F St, New York City NY');

INSERT INTO `regularuser3` VALUES (2344, 'Amman Zaman');
INSERT INTO `regularuser3` VALUES (4345, 'Divyansh Singhal');
INSERT INTO `regularuser3` VALUES (5645, 'Mourud Ahmed');
INSERT INTO `regularuser3` VALUES (3252, 'Jessica Wang');
INSERT INTO `regularuser3` VALUES (6667, 'John Wick');

INSERT INTO `ticket` VALUES (123124, 20, STR_TO_DATE('2019,01,22', '%Y,%m,%d'), 2344, 3967);
INSERT INTO `ticket` VALUES (341231, 400, STR_TO_DATE('2020,10,10', '%Y,%m,%d'), 4345, 4529);
INSERT INTO `ticket` VALUES (123431, 70, STR_TO_DATE('2018,11,20', '%Y,%m,%d'), 5645, 7820);
INSERT INTO `ticket` VALUES (123123, 80, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, 1920);
INSERT INTO `ticket` VALUES (123129, 70, NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (123125, 40, NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (123126, 20, NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (123127, 100, NULL, NULL, NULL);
INSERT INTO `ticket` VALUES (123130, 100, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, NULL);
INSERT INTO `ticket` VALUES (123131, 110, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, NULL);
INSERT INTO `ticket` VALUES (123132, 120, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, NULL);
INSERT INTO `ticket` VALUES (123133, 100, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, NULL);
INSERT INTO `ticket` VALUES (323443, 75, STR_TO_DATE('2017,04,29', '%Y,%m,%d'), 6667, 2834);

INSERT INTO `ticketvendor1` VALUES ('TicketMaster', '1344 Marigold Lane', 'ticketmaster@ticketmaster.com');
INSERT INTO `ticketvendor1` VALUES ('SeatGeek', '660 Austin Secret Lane', 'seatgeek@seatgeek.com');
INSERT INTO `ticketvendor1` VALUES ('Ultimate Ticket Seller', '1253 Blair Court', 'theultimateticketseller@theultimate.ca');
INSERT INTO `ticketvendor1` VALUES ('StubHub', '2844 Lynch Street', 'stubhub@stubhub.com');
INSERT INTO `ticketvendor1` VALUES ('TicketCity', '3046 Carolina Avenue', 'ticketcity@ticketcity,com');

INSERT INTO `ticketvendor2` VALUES (2134, 'TicketMaster', '1344 Marigold Lane');
INSERT INTO `ticketvendor2` VALUES (4533, 'SeatGeek', '660 Austin Secret Lane');
INSERT INTO `ticketvendor2` VALUES (5465, 'Ultimate Ticket Seller', '1253 Blair Court');
INSERT INTO `ticketvendor2` VALUES (3534, 'StubHub', '2844 Lynch Street');
INSERT INTO `ticketvendor2` VALUES (7656, 'TicketCity', '3046 Carolina Avenue');

INSERT INTO `userschedule` VALUES (2344, 341212, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO `userschedule` VALUES (4345, 124352, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO `userschedule` VALUES (5645, 453241, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO `userschedule` VALUES (3252, 342541, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO `userschedule` VALUES (6667, 543233, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO `hostschedule` VALUES (3967, 352352, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO `hostschedule` VALUES (4529, 134234, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO `hostschedule` VALUES (7820, 452345, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO `hostschedule` VALUES (1920, 312452, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO `hostschedule` VALUES (2834, 453463, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO `bookedat` VALUES (4576, 4829, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO `bookedat` VALUES (3077, 1230, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO `bookedat` VALUES (4089, 4205, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO `bookedat` VALUES (2412, 4530, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO `bookedat` VALUES (1024, 8923, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO `performsat` VALUES (4576, 3489);
INSERT INTO `performsat` VALUES (3077, 2392);
INSERT INTO `performsat` VALUES (4089, 1254);
INSERT INTO `performsat` VALUES (2412, 4223);
INSERT INTO `performsat` VALUES (1024, 4223);
INSERT INTO `performsat` VALUES (1024, 3489);
INSERT INTO `performsat` VALUES (1024, 2392);
INSERT INTO `performsat` VALUES (1024, 1254);
INSERT INTO `performsat` VALUES (1024, 6782);

INSERT INTO `iscategory` VALUES (4576, 'Social');
INSERT INTO `iscategory` VALUES (3077, 'Athletics');
INSERT INTO `iscategory` VALUES (4089, 'Academic');
INSERT INTO `iscategory` VALUES (2412, 'Food');
INSERT INTO `iscategory` VALUES (1024, 'Film');

INSERT INTO `isfor` VALUES (4576, 123124);
INSERT INTO `isfor` VALUES (3077, 341231);
INSERT INTO `isfor` VALUES (4089, 123431);
INSERT INTO `isfor` VALUES (2412, 123123);
INSERT INTO `isfor` VALUES (4576, 123130);
INSERT INTO `isfor` VALUES (3077, 123131);
INSERT INTO `isfor` VALUES (4089, 123132);
INSERT INTO `isfor` VALUES (1024, 123133);
INSERT INTO `isfor` VALUES (1024, 323443);

INSERT INTO `reserves` VALUES (2344, 4576, 123124);
INSERT INTO `reserves` VALUES (4345, 3077, 341231);
INSERT INTO `reserves` VALUES (5645, 4089, 123431);
INSERT INTO `reserves` VALUES (3252, 2412, 123123);
INSERT INTO `reserves` VALUES (NULL, 2412, 123129);
INSERT INTO `reserves` VALUES (NULL, 2412, 123125);
INSERT INTO `reserves` VALUES (NULL, 2412, 123126);
INSERT INTO `reserves` VALUES (NULL, 2412, 123127);
INSERT INTO `reserves` VALUES (3252, 4576, 123130);
INSERT INTO `reserves` VALUES (3252, 3077, 123131);
INSERT INTO `reserves` VALUES (3252, 4089, 123132);
INSERT INTO `reserves` VALUES (3252, 1024, 123133);

INSERT INTO `sells` VALUES (2134, 123124);
INSERT INTO `sells` VALUES (4533, 341231);
INSERT INTO `sells` VALUES (5465, 123431);
INSERT INTO `sells` VALUES (3534, 123123);
INSERT INTO `sells` VALUES (3534, 123124);
INSERT INTO `sells` VALUES (3534, 123125);
INSERT INTO `sells` VALUES (3534, 123126);
INSERT INTO `sells` VALUES (3534, 123127);
INSERT INTO `sells` VALUES (7656, 323443);


