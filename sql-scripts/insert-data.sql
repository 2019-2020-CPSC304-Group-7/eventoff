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

INSERT INTO `event` VALUES (4576, 'Fall Reading Week Rally', STR_TO_DATE('20201123 1130', '%Y%m%d %H%i'), STR_TO_DATE('20201125 2330', '%Y%m%d %H%i'), 1, 3967);
INSERT INTO `event` VALUES (3077, 'CPSC 304 Crash Course', STR_TO_DATE('20200325 1800', '%Y%m%d %H%i'), STR_TO_DATE('20200328 0600', '%Y%m%d %H%i'), 2, 4529);
INSERT INTO `event` VALUES (4089, 'NWHacks Hackathon', STR_TO_DATE('20200214 0900', '%Y%m%d %H%i'), STR_TO_DATE('20200216 2100', '%Y%m%d %H%i'), 3, 7820);
INSERT INTO `event` VALUES (2412, 'Science Career Night', STR_TO_DATE('20200120 1900', '%Y%m%d %H%i'), STR_TO_DATE('20200123 0700', '%Y%m%d %H%i'), 4, 1920);
INSERT INTO `event` VALUES (1024, 'Taco Del Mar Grand Opening', STR_TO_DATE('20200610 1200', '%Y%m%d %H%i'), STR_TO_DATE('20200613 0000', '%Y%m%d %H%i'), 5, 2834);

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

INSERT INTO `ticket` VALUES (123123, 80);
INSERT INTO `ticket` VALUES (123124, 20);
INSERT INTO `ticket` VALUES (123125, 40);
INSERT INTO `ticket` VALUES (123126, 20);
INSERT INTO `ticket` VALUES (123127, 100);
INSERT INTO `ticket` VALUES (123129, 70);
INSERT INTO `ticket` VALUES (123130, 100);
INSERT INTO `ticket` VALUES (123131, 110);
INSERT INTO `ticket` VALUES (123132, 120);
INSERT INTO `ticket` VALUES (123133, 100);
INSERT INTO `ticket` VALUES (123431, 70);
INSERT INTO `ticket` VALUES (323443, 75);
INSERT INTO `ticket` VALUES (323444, 76);
INSERT INTO `ticket` VALUES (323445, 77);
INSERT INTO `ticket` VALUES (323446, 78);
INSERT INTO `ticket` VALUES (323447, 79);
INSERT INTO `ticket` VALUES (323448, 80);
INSERT INTO `ticket` VALUES (341231, 400);

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

INSERT INTO `bookedat` VALUES (4576, 4829);
INSERT INTO `bookedat` VALUES (3077, 1230);
INSERT INTO `bookedat` VALUES (4089, 4205);
INSERT INTO `bookedat` VALUES (2412, 4530);
INSERT INTO `bookedat` VALUES (1024, 8923);

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

INSERT INTO `isfor` VALUES (4576, 123123);
INSERT INTO `isfor` VALUES (3077, 123124);
INSERT INTO `isfor` VALUES (4089, 123125);
INSERT INTO `isfor` VALUES (2412, 123126);
INSERT INTO `isfor` VALUES (4089, 123127);
INSERT INTO `isfor` VALUES (3077, 123129);
INSERT INTO `isfor` VALUES (4576, 123130);
INSERT INTO `isfor` VALUES (3077, 123131);
INSERT INTO `isfor` VALUES (4089, 123132);
INSERT INTO `isfor` VALUES (1024, 123133);
INSERT INTO `isfor` VALUES (4576, 123431);
INSERT INTO `isfor` VALUES (4576, 323443);
INSERT INTO `isfor` VALUES (1024, 323444);
INSERT INTO `isfor` VALUES (1024, 323445);
INSERT INTO `isfor` VALUES (1024, 323446);
INSERT INTO `isfor` VALUES (1024, 323447);
INSERT INTO `isfor` VALUES (1024, 323448);
INSERT INTO `isfor` VALUES (1024, 341231);

INSERT INTO `purchased` VALUES (2344, 123123);
INSERT INTO `purchased` VALUES (4345, 123124);
INSERT INTO `purchased` VALUES (5645, 123125);
INSERT INTO `purchased` VALUES (3252, 123126);
INSERT INTO `purchased` VALUES (3252, 123130);
INSERT INTO `purchased` VALUES (3252, 123131);
INSERT INTO `purchased` VALUES (3252, 123132);
INSERT INTO `purchased` VALUES (3252, 123133);
INSERT INTO `purchased` VALUES (6667, 341231);

INSERT INTO `sells` VALUES (2134, 123123);
INSERT INTO `sells` VALUES (4533, 123124);
INSERT INTO `sells` VALUES (5465, 123125);
INSERT INTO `sells` VALUES (3534, 123126);
INSERT INTO `sells` VALUES (3534, 123127);
INSERT INTO `sells` VALUES (3534, 123129);
INSERT INTO `sells` VALUES (3534, 123130);
INSERT INTO `sells` VALUES (5465, 123131);
INSERT INTO `sells` VALUES (2134, 123132);
INSERT INTO `sells` VALUES (3534, 123133);
INSERT INTO `sells` VALUES (7656, 123431);
INSERT INTO `sells` VALUES (7656, 323443);
INSERT INTO `sells` VALUES (7656, 323444);
INSERT INTO `sells` VALUES (7656, 323445);
INSERT INTO `sells` VALUES (3534, 323446);
INSERT INTO `sells` VALUES (3534, 323447);
INSERT INTO `sells` VALUES (3534, 323448);
INSERT INTO `sells` VALUES (7656, 341231);
