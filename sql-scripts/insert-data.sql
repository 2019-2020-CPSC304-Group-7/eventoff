INSERT INTO Host1 VALUES ('studentsofubc@ubc.ca', 'UBC');
INSERT INTO Host1 VALUES ('computerscience@ubc.ca', 'UBC');
INSERT INTO Host1 VALUES ('hello@nwplus.io', 'nwPlus');
INSERT INTO Host1 VALUES ('science@ubc.ca', 'UBC');
INSERT INTO Host1 VALUES ('taco@tacodelmar.com', 'Taco Del Mar');

INSERT INTO Host2 VALUES (3967, 'Students of UBC' ,'studentsofubc@ubc.ca', 0.8);
INSERT INTO Host2 VALUES (4529, 'UBC CS Department' ,'computerscience@ubc.ca', 0.8);
INSERT INTO Host2 VALUES (7820, 'nwPlus' ,'hello@nwplus.io', 1);
INSERT INTO Host2 VALUES (1920, 'UBC Faculty of Science' ,'science@ubc.ca', 0.6);
INSERT INTO Host2 VALUES (2834, 'UBC Taco Del Mar' ,'taco@tacodelmar.com', 0.4);

INSERT INTO `Event` VALUES (4576, 'Fall Reading Week Rally', STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'), 1, 3967);
INSERT INTO `Event` VALUES (3077, 'CPSC 304 Crash Course', STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'), 2, 4529);
INSERT INTO `Event` VALUES (4089, 'NWHacks Hackathon', STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'), 3, 7820);
INSERT INTO `Event` VALUES (2412, 'Science Career Night', STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'), 4, 1920);
INSERT INTO `Event` VALUES (1024, 'Taco Del Mar Grand Opening', STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'), 5, 2834);

INSERT INTO Performer VALUES (3489, 'Linkin Park', 'linkinpark@linkinpark.com', 0.6);
INSERT INTO Performer VALUES (2392, 'Bill Nye', 'billnye@thescienceguy.com', 0.8);
INSERT INTO Performer VALUES (1254, 'Vancouver Canucks', 'canucks@vancouver.ca', 0.777777777777778);
INSERT INTO Performer VALUES (4223, 'Tim Cook', 'timcook@apple.com', 0.9);
INSERT INTO Performer VALUES (6782, 'Toronto Raptors', 'raptors@toronto.ca', 0.95);

INSERT INTO Venue1 VALUES ('ICICS Room 250', 'ICICS Main Mall, Vancouver BC', 40);
INSERT INTO Venue1 VALUES ('BC Place', 'BC Place, Vancouver BC', 20000);
INSERT INTO Venue1 VALUES ('Earth Science Building, Room 1021', 'ESB Main Mall, Vancouver BC', 100);
INSERT INTO Venue1 VALUES ('Vancouver Convention Centre', '1055 Canada Pl, Vancouver, BC', 2000);
INSERT INTO Venue1 VALUES ('Vancouver Public Library, Room 200', '575 Clancy Loranger Way, Vancouver, BC', 100);

INSERT INTO Venue2 VALUES (4829, 'ICICS Room 250', 'ICICS Main Mall, Vancouver BC');
INSERT INTO Venue2 VALUES (1230, 'BC Place', 'BC Place, Vancouver BC');
INSERT INTO Venue2 VALUES (4205, 'Earth Science Building, Room 1021', 'ESB Main Mall, Vancouver BC');
INSERT INTO Venue2 VALUES (4530, 'Vancouver Convention Centre', '1055 Canada Pl, Vancouver, BC');
INSERT INTO Venue2 VALUES (8923, 'Vancouver Public Library, Room 200', '575 Clancy Loranger Way, Vancouver, BC');

INSERT INTO EventCategory VALUES ('Social');
INSERT INTO EventCategory VALUES ('Athletics');
INSERT INTO EventCategory VALUES ('Academic');
INSERT INTO EventCategory VALUES ('Food');
INSERT INTO EventCategory VALUES ('Film');

INSERT INTO RegularUser1 VALUES ('Amman Zaman', 'thezaman76@gmail.com');
INSERT INTO RegularUser1 VALUES ('Divyansh Singhal', 'singhaldivyansh1998@gmail.com');
INSERT INTO RegularUser1 VALUES ('Mourud Ahmed', 'ishmam1@gmail.com');
INSERT INTO RegularUser1 VALUES ('Jessica Wang', 'jessicawang@cs.ubc.ca');
INSERT INTO RegularUser1 VALUES ('John Wick', 'johnwick@thecontinental.com');

INSERT INTO RegularUser2 VALUES ('Amman Zaman', '1234 A St, Surrey BC');
INSERT INTO RegularUser2 VALUES ('Divyansh Singhal', '5671 B St, Burnaby BC');
INSERT INTO RegularUser2 VALUES ('Mourud Ahmed', '2353 C St, Vancouver BC');
INSERT INTO RegularUser2 VALUES ('Jessica Wang', '2123 CC Ave, Vancouver BC');
INSERT INTO RegularUser2 VALUES ('John Wick', '6554 F St, New York City NY');

INSERT INTO RegularUser3 VALUES (2344, 'Amman Zaman');
INSERT INTO RegularUser3 VALUES (4345, 'Divyansh Singhal');
INSERT INTO RegularUser3 VALUES (5645, 'Mourud Ahmed');
INSERT INTO RegularUser3 VALUES (3252, 'Jessica Wang');
INSERT INTO RegularUser3 VALUES (6667, 'John Wick');

INSERT INTO Ticket VALUES (123124, 20, STR_TO_DATE('2019,01,22', '%Y,%m,%d'), 2344, 3967);
INSERT INTO Ticket VALUES (341231, 400, STR_TO_DATE('2020,10,10', '%Y,%m,%d'), 4345, 4529);
INSERT INTO Ticket VALUES (123431, 70, STR_TO_DATE('2018,11,20', '%Y,%m,%d'), 5645, 7820);
INSERT INTO Ticket VALUES (123123, 80, STR_TO_DATE('2019,07,29', '%Y,%m,%d'), 3252, 1920);
INSERT INTO Ticket VALUES (323443, 75, STR_TO_DATE('2017,04,29', '%Y,%m,%d'), 6667, 2834);

INSERT INTO TicketVendor1 VALUES ('TicketMaster', '1344 Marigold Lane', 'ticketmaster@ticketmaster.com');
INSERT INTO TicketVendor1 VALUES ('SeatGeek', '660 Austin Secret Lane', 'seatgeek@seatgeek.com');
INSERT INTO TicketVendor1 VALUES ('Ultimate Ticket Seller', '1253 Blair Court', 'theultimateticketseller@theultimate.ca');
INSERT INTO TicketVendor1 VALUES ('StubHub', '2844 Lynch Street', 'stubhub@stubhub.com');
INSERT INTO TicketVendor1 VALUES ('TicketCity', '3046 Carolina Avenue', 'ticketcity@ticketcity,com');

INSERT INTO TicketVendor2 VALUES (2134, 'TicketMaster', '1344 Marigold Lane');
INSERT INTO TicketVendor2 VALUES (4533, 'SeatGeek', '660 Austin Secret Lane');
INSERT INTO TicketVendor2 VALUES (5465, 'Ultimate Ticket Seller', '1253 Blair Court');
INSERT INTO TicketVendor2 VALUES (3534, 'StubHub', '2844 Lynch Street');
INSERT INTO TicketVendor2 VALUES (7656, 'TicketCity', '3046 Carolina Avenue');

INSERT INTO UserSchedule VALUES  (2344, 341212, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO UserSchedule VALUES  (4345, 124352, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO UserSchedule VALUES  (5645, 453241, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO UserSchedule VALUES  (3252, 342541, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO UserSchedule VALUES  (6667, 543233, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO HostSchedule VALUES  (3967, 352352, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO HostSchedule VALUES  (4529, 134234, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO HostSchedule VALUES  (7820, 452345, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO HostSchedule VALUES  (1920, 312452, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO HostSchedule VALUES  (2834, 453463, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO BookedAt VALUES (4576, 4829, STR_TO_DATE('2020,11,23', '%Y,%m,%d'), STR_TO_DATE('2020,11,23', '%Y,%m,%d'));
INSERT INTO BookedAt VALUES (3077, 1230, STR_TO_DATE('2020,03,25', '%Y,%m,%d'), STR_TO_DATE('2020,03,25', '%Y,%m,%d'));
INSERT INTO BookedAt VALUES (4089, 4205, STR_TO_DATE('2020,02,14', '%Y,%m,%d'), STR_TO_DATE('2020,02,16', '%Y,%m,%d'));
INSERT INTO BookedAt VALUES (2412, 4530, STR_TO_DATE('2020,01,20', '%Y,%m,%d'), STR_TO_DATE('2020,01,20', '%Y,%m,%d'));
INSERT INTO BookedAt VALUES (1024, 8923, STR_TO_DATE('2020,06,10', '%Y,%m,%d'), STR_TO_DATE('2020,06,10', '%Y,%m,%d'));

INSERT INTO PerformsAt VALUES (4576, 3489);
INSERT INTO PerformsAt VALUES (3077, 2392);
INSERT INTO PerformsAt VALUES (4089, 1254);
INSERT INTO PerformsAt VALUES (2412, 4223);
INSERT INTO PerformsAt VALUES (1024, 6782);

INSERT INTO IsCategory VALUES (4576, 'Social');
INSERT INTO IsCategory VALUES (3077, 'Athletics');
INSERT INTO IsCategory VALUES (4089, 'Academic');
INSERT INTO IsCategory VALUES (2412, 'Food');
INSERT INTO IsCategory VALUES (1024, 'Film');

INSERT INTO IsFor VALUES (4576, 123124);
INSERT INTO IsFor VALUES (3077, 341231);
INSERT INTO IsFor VALUES (4089, 123431);
INSERT INTO IsFor VALUES (2412, 123123);
INSERT INTO IsFor VALUES (1024, 323443);

INSERT INTO Reserves VALUES (2344, 4576, 123124);
INSERT INTO Reserves VALUES (4345, 3077, 341231);
INSERT INTO Reserves VALUES (5645, 4089, 123431);
INSERT INTO Reserves VALUES (3252, 2412, 123123);
INSERT INTO Reserves VALUES (6667, 1024, 323443);

INSERT INTO Sells VALUES (2134, 123124);
INSERT INTO Sells VALUES (4533, 341231);
INSERT INTO Sells VALUES (5465, 123431);
INSERT INTO Sells VALUES (3534, 123123);
INSERT INTO Sells VALUES (7656, 323443);
