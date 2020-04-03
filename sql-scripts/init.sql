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
DROP TABLE IF EXISTS `bookedat`;
DROP TABLE IF EXISTS `performsat`;
DROP TABLE IF EXISTS `iscategory`;
DROP TABLE IF EXISTS `isfor`;
DROP TABLE IF EXISTS `purchased`;
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
    price INT
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
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE
);

CREATE TABLE `isfor` (
    event_id INT,
    ticket_id INT,
    PRIMARY KEY (event_id, ticket_id),
    FOREIGN KEY (event_id) REFERENCES `event` (event_id) ON DELETE CASCADE,
    FOREIGN KEY (ticket_id) REFERENCES `ticket` (ticket_id) ON DELETE CASCADE
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
INSERT INTO `regularuser1` VALUES ('Lacota Graves', 'vel.vulputate.eu@utlacus.net');
INSERT INTO `regularuser1` VALUES ('Tanek Hurley', 'Fusce.fermentum@necluctusfelis.net');
INSERT INTO `regularuser1` VALUES ('Noel Mcfarland', 'eget@tellusfaucibus.org');
INSERT INTO `regularuser1` VALUES ('Rowan Zimmerman', 'Phasellus.ornare@eueleifend.net');
INSERT INTO `regularuser1` VALUES ('Ima Morton', 'nulla.vulputate.dui@faucibus.net');
INSERT INTO `regularuser1` VALUES ('Plato Beard', 'ultrices.Vivamus@semmagna.net');
INSERT INTO `regularuser1` VALUES ('Calvin Riggs', 'Integer@elitpedemalesuada.net');
INSERT INTO `regularuser1` VALUES ('Leila Savage', 'eleifend.vitae.erat@eget.org');
INSERT INTO `regularuser1` VALUES ('Burke Whitley', 'est.Nunc.ullamcorper@magnaSedeu.net');
INSERT INTO `regularuser1` VALUES ('Derek Walls', 'vel.quam.dignissim@Utsagittislobortis.com');
INSERT INTO `regularuser1` VALUES ('Vielka Kirk', 'eu.arcu.Morbi@egestas.org');
INSERT INTO `regularuser1` VALUES ('Brandon Charles', 'fermentum.metus.Aenean@erosNam.ca');
INSERT INTO `regularuser1` VALUES ('Tanisha Cabrera', 'eros@sitametrisus.org');
INSERT INTO `regularuser1` VALUES ('Raya Church', 'hendrerit.id@tellus.com');
INSERT INTO `regularuser1` VALUES ('Priscilla Vance', 'lectus@dolorNulla.ca');
INSERT INTO `regularuser1` VALUES ('Wynne Dudley', 'quis.turpis.vitae@sociosquad.ca');
INSERT INTO `regularuser1` VALUES ('Dolan Holder', 'commodo@necdiam.edu');
INSERT INTO `regularuser1` VALUES ('Lara Maddox', 'mollis.non@nostraper.edu');
INSERT INTO `regularuser1` VALUES ('Alec Craig', 'velit.dui.semper@nec.edu');
INSERT INTO `regularuser1` VALUES ('Jacqueline Harmon', 'Fusce@afacilisisnon.org');
INSERT INTO `regularuser1` VALUES ('Colin Casey', 'Cum.sociis.natoque@InloremDonec.ca');
INSERT INTO `regularuser1` VALUES ('Alfonso Greene', 'hendrerit.neque.In@et.co.uk');
INSERT INTO `regularuser1` VALUES ('Dillon Gilbert', 'nunc.est@nuncnullavulputate.edu');
INSERT INTO `regularuser1` VALUES ('Cody Stanley', 'quam.vel@turpisvitaepurus.edu');
INSERT INTO `regularuser1` VALUES ('Levi Morton', 'dictum.augue@erosturpisnon.ca');
INSERT INTO `regularuser1` VALUES ('Ila Hughes', 'dui.Fusce.aliquam@nullaDonecnon.ca');
INSERT INTO `regularuser1` VALUES ('Clayton Shannon', 'sit.amet.faucibus@elementum.ca');
INSERT INTO `regularuser1` VALUES ('Quinn Cross', 'justo@scelerisqueneque.org');
INSERT INTO `regularuser1` VALUES ('Berk Brennan', 'Aliquam.adipiscing.lobortis@accumsanneque.net');
INSERT INTO `regularuser1` VALUES ('Inga Padilla', 'turpis@Infaucibus.ca');
INSERT INTO `regularuser1` VALUES ('Serena Serrano', 'odio.tristique@egestaslacinia.co.uk');
INSERT INTO `regularuser1` VALUES ('Colby Vance', 'non@eleifendnuncrisus.edu');
INSERT INTO `regularuser1` VALUES ('Garrett Mayo', 'vulputate.posuere.vulputate@imperdiet.co.uk');
INSERT INTO `regularuser1` VALUES ('Candace Lang', 'arcu@egestas.net');
INSERT INTO `regularuser1` VALUES ('Wylie Burt', 'taciti.sociosqu.ad@dapibus.org');
INSERT INTO `regularuser1` VALUES ('Bruno Carver', 'sit.amet.massa@facilisisnonbibendum.org');
INSERT INTO `regularuser1` VALUES ('Rana Whitney', 'montes@atvelitCras.com');
INSERT INTO `regularuser1` VALUES ('Chloe Gordon', 'nunc.id@magnaPhasellusdolor.edu');
INSERT INTO `regularuser1` VALUES ('Robin Bradshaw', 'ultricies.dignissim.lacus@sapien.ca');
INSERT INTO `regularuser1` VALUES ('Dahlia Stout', 'pede.Praesent@enim.org');
INSERT INTO `regularuser1` VALUES ('Samuel Mckay', 'et.ultrices@ridiculus.co.uk');
INSERT INTO `regularuser1` VALUES ('Kane Bruce', 'ultrices.sit@urnaetarcu.co.uk');
INSERT INTO `regularuser1` VALUES ('Jane Raymond', 'ligula.Donec.luctus@quistristiqueac.org');
INSERT INTO `regularuser1` VALUES ('Mariam Rosales', 'nec.euismod@nuncinterdum.com');
INSERT INTO `regularuser1` VALUES ('Desiree Salas', 'gravida.sagittis@eu.net');
INSERT INTO `regularuser1` VALUES ('Britanney Dyer', 'eu@non.co.uk');
INSERT INTO `regularuser1` VALUES ('Nolan Olson', 'ultricies.ornare.elit@utnulla.com');
INSERT INTO `regularuser1` VALUES ('Eve Kidd', 'Proin.ultrices@cursus.edu');
INSERT INTO `regularuser1` VALUES ('Lynn English', 'ac.feugiat.non@feugiat.edu');
INSERT INTO `regularuser1` VALUES ('Imogene Hodge', 'aliquet@vitaepurus.edu');
INSERT INTO `regularuser1` VALUES ('Christen Norris', 'rutrum@condimentum.org');
INSERT INTO `regularuser1` VALUES ('Tiger Blair', 'pharetra@loremut.edu');
INSERT INTO `regularuser1` VALUES ('Risa Hill', 'et.magnis@nectellusNunc.org');
INSERT INTO `regularuser1` VALUES ('Aquila Olson', 'lacus@nequeMorbiquis.org');
INSERT INTO `regularuser1` VALUES ('Claire Brooks', 'erat.in@aliquetliberoInteger.edu');
INSERT INTO `regularuser1` VALUES ('Russell Duran', 'consequat.purus@massaMaurisvestibulum.com');
INSERT INTO `regularuser1` VALUES ('Portia Lane', 'per.conubia@rutrumloremac.net');
INSERT INTO `regularuser1` VALUES ('Jenette Richard', 'vulputate@nonnisi.co.uk');
INSERT INTO `regularuser1` VALUES ('Kennan Herrera', 'risus.varius.orci@lectusquis.ca');
INSERT INTO `regularuser1` VALUES ('Randall Porter', 'ultrices.posuere@gravidamolestie.org');
INSERT INTO `regularuser1` VALUES ('Amal Velasquez', 'quam.a.felis@sempertellus.com');
INSERT INTO `regularuser1` VALUES ('Pearl Wynn', 'dapibus@urna.org');
INSERT INTO `regularuser1` VALUES ('Daria Ray', 'purus.mauris@ipsum.com');
INSERT INTO `regularuser1` VALUES ('Fredericka Conway', 'sociosqu.ad@nullaCraseu.org');
INSERT INTO `regularuser1` VALUES ('Gemma Valencia', 'libero@Proinnisl.ca');
INSERT INTO `regularuser1` VALUES ('Imogene Thomas', 'eget.venenatis.a@egestasligula.edu');
INSERT INTO `regularuser1` VALUES ('Rina Sears', 'Integer.id@fringillapurus.edu');
INSERT INTO `regularuser1` VALUES ('Venus Britt', 'Quisque.tincidunt.pede@mauriselitdictum.org');
INSERT INTO `regularuser1` VALUES ('Malik Pickett', 'arcu.Vestibulum@vestibulummassa.net');
INSERT INTO `regularuser1` VALUES ('Austin Robertson', 'molestie.pharetra@velitegestaslacinia.edu');
INSERT INTO `regularuser1` VALUES ('Heather Pruitt', 'aliquet.sem.ut@Maurisvelturpis.org');
INSERT INTO `regularuser1` VALUES ('Asher Mclean', 'dignissim.magna@Quisqueornaretortor.com');
INSERT INTO `regularuser1` VALUES ('Rhoda Parsons', 'posuere.cubilia@ac.ca');
INSERT INTO `regularuser1` VALUES ('Roth Donaldson', 'enim@disparturient.net');
INSERT INTO `regularuser1` VALUES ('Giacomo Ray', 'ultricies.sem@Donecporttitor.org');
INSERT INTO `regularuser1` VALUES ('Hayley Hodge', 'nisi.Cum@ut.com');
INSERT INTO `regularuser1` VALUES ('Hakeem Carney', 'euismod@eratEtiamvestibulum.co.uk');
INSERT INTO `regularuser1` VALUES ('Indira Porter', 'neque.pellentesque@ategestas.ca');
INSERT INTO `regularuser1` VALUES ('Madeline Brooks', 'posuere.cubilia@posuere.net');
INSERT INTO `regularuser1` VALUES ('Sylvia Mercado', 'fermentum.vel@arcuSed.ca');
INSERT INTO `regularuser1` VALUES ('Tad Aguilar', 'pede.et.risus@hymenaeos.co.uk');
INSERT INTO `regularuser1` VALUES ('Harding Doyle', 'aliquam.enim@orci.org');
INSERT INTO `regularuser1` VALUES ('Daquan Robertson', 'turpis@facilisis.org');
INSERT INTO `regularuser1` VALUES ('Wallace Mendoza', 'quis.lectus@odio.ca');
INSERT INTO `regularuser1` VALUES ('Connor Key', 'risus.odio.auctor@insodaleselit.edu');
INSERT INTO `regularuser1` VALUES ('Hermione King', 'neque.et.nunc@etrisusQuisque.org');
INSERT INTO `regularuser1` VALUES ('Anne Guzman', 'taciti.sociosqu@liberodui.net');
INSERT INTO `regularuser1` VALUES ('Quamar Harrell', 'Lorem.ipsum@aultricies.net');
INSERT INTO `regularuser1` VALUES ('Dexter Campos', 'consectetuer.ipsum.nunc@aodiosemper.edu');
INSERT INTO `regularuser1` VALUES ('Ariana Prince', 'Phasellus.ornare.Fusce@dolornonummy.net');
INSERT INTO `regularuser1` VALUES ('Levi Mcbride', 'libero.Morbi.accumsan@vulputatelacus.ca');
INSERT INTO `regularuser1` VALUES ('Salvador Stanton', 'Suspendisse.aliquet@dui.org');
INSERT INTO `regularuser1` VALUES ('Aurelia Perry', 'vulputate.velit.eu@infelis.ca');
INSERT INTO `regularuser1` VALUES ('Lillith Moses', 'ornare@acmetusvitae.com');
INSERT INTO `regularuser1` VALUES ('Kirsten Franks', 'Donec.feugiat@vitaeodiosagittis.ca');
INSERT INTO `regularuser1` VALUES ('Rama Mcgowan', 'at@Cras.edu');
INSERT INTO `regularuser1` VALUES ('Chloe Sheppard', 'libero.lacus.varius@Loremipsumdolor.edu');
INSERT INTO `regularuser1` VALUES ('Victor Shepherd', 'euismod.mauris@auctorvitaealiquet.net');
INSERT INTO `regularuser1` VALUES ('Britanni Elliott', 'lorem.lorem.luctus@iaculis.com');
INSERT INTO `regularuser1` VALUES ('Jamalia Holland', 'tincidunt.nibh@utcursusluctus.org');
INSERT INTO `regularuser1` VALUES ('John Wick', 'johnwick@thecontinental.com');

INSERT INTO `regularuser2` VALUES ('Amman Zaman', '1234 A St, Surrey BC');
INSERT INTO `regularuser2` VALUES ('Divyansh Singhal', '5671 B St, Burnaby BC');
INSERT INTO `regularuser2` VALUES ('Mourud Ahmed', '2353 C St, Vancouver BC');
INSERT INTO `regularuser2` VALUES ('Jessica Wang', '2123 CC Ave, Vancouver BC');
INSERT INTO `regularuser2` VALUES ('Lacota Graves', 'Ap #690-7833 Arcu. Rd.');
INSERT INTO `regularuser2` VALUES ('Tanek Hurley', '724-1982 Nulla St.');
INSERT INTO `regularuser2` VALUES ('Noel Mcfarland', 'P.O. Box 257, 3971 Dapibus Road');
INSERT INTO `regularuser2` VALUES ('Rowan Zimmerman', 'P.O. Box 955, 1886 Porttitor Street');
INSERT INTO `regularuser2` VALUES ('Ima Morton', '623-2187 Purus, Rd.');
INSERT INTO `regularuser2` VALUES ('Plato Beard', '901-2854 Eu St.');
INSERT INTO `regularuser2` VALUES ('Calvin Riggs', 'P.O. Box 796, 792 Suspendisse Rd.');
INSERT INTO `regularuser2` VALUES ('Leila Savage', 'P.O. Box 314, 1379 Sagittis. Road');
INSERT INTO `regularuser2` VALUES ('Burke Whitley', 'P.O. Box 214, 9037 Tincidunt Avenue');
INSERT INTO `regularuser2` VALUES ('Derek Walls', 'Ap #156-8021 Enim. Av.');
INSERT INTO `regularuser2` VALUES ('Vielka Kirk', 'Ap #957-5435 Donec Av.');
INSERT INTO `regularuser2` VALUES ('Brandon Charles', '484-1286 Natoque Avenue');
INSERT INTO `regularuser2` VALUES ('Tanisha Cabrera', 'P.O. Box 544, 6232 A, Rd.');
INSERT INTO `regularuser2` VALUES ('Raya Church', '411-2777 Justo St.');
INSERT INTO `regularuser2` VALUES ('Priscilla Vance', '7408 Eget Ave');
INSERT INTO `regularuser2` VALUES ('Wynne Dudley', '9645 Sodales Rd.');
INSERT INTO `regularuser2` VALUES ('Dolan Holder', '393-717 Adipiscing Av.');
INSERT INTO `regularuser2` VALUES ('Lara Maddox', '724-9063 Pede Avenue');
INSERT INTO `regularuser2` VALUES ('Alec Craig', 'Ap #461-7548 Dapibus Street');
INSERT INTO `regularuser2` VALUES ('Jacqueline Harmon', 'P.O. Box 458, 8363 Amet, Rd.');
INSERT INTO `regularuser2` VALUES ('Colin Casey', 'P.O. Box 451, 308 In St.');
INSERT INTO `regularuser2` VALUES ('Alfonso Greene', 'Ap #943-7762 Egestas. St.');
INSERT INTO `regularuser2` VALUES ('Dillon Gilbert', 'Ap #948-9894 Massa. Rd.');
INSERT INTO `regularuser2` VALUES ('Cody Stanley', '3831 Vestibulum Road');
INSERT INTO `regularuser2` VALUES ('Levi Morton', 'P.O. Box 229, 2753 Imperdiet Rd.');
INSERT INTO `regularuser2` VALUES ('Ila Hughes', '5663 In, Road');
INSERT INTO `regularuser2` VALUES ('Clayton Shannon', '310-8132 Accumsan Road');
INSERT INTO `regularuser2` VALUES ('Quinn Cross', 'P.O. Box 398, 5206 Fusce Ave');
INSERT INTO `regularuser2` VALUES ('Berk Brennan', '192-6536 Orci. Rd.');
INSERT INTO `regularuser2` VALUES ('Inga Padilla', 'Ap #849-2624 Sit Avenue');
INSERT INTO `regularuser2` VALUES ('Serena Serrano', 'P.O. Box 554, 9175 Libero. Rd.');
INSERT INTO `regularuser2` VALUES ('Colby Vance', 'Ap #159-3291 Velit St.');
INSERT INTO `regularuser2` VALUES ('Garrett Mayo', 'P.O. Box 137, 914 Sem Rd.');
INSERT INTO `regularuser2` VALUES ('Candace Lang', '6526 Magna. Road');
INSERT INTO `regularuser2` VALUES ('Wylie Burt', '833-2867 Placerat, Street');
INSERT INTO `regularuser2` VALUES ('Bruno Carver', '908-5350 Rhoncus. Ave');
INSERT INTO `regularuser2` VALUES ('Rana Whitney', '8455 Ante Ave');
INSERT INTO `regularuser2` VALUES ('Chloe Gordon', '973-2826 Adipiscing Rd.');
INSERT INTO `regularuser2` VALUES ('Robin Bradshaw', '2535 Interdum Ave');
INSERT INTO `regularuser2` VALUES ('Dahlia Stout', 'P.O. Box 964, 8223 Commodo Ave');
INSERT INTO `regularuser2` VALUES ('Samuel Mckay', '3132 Dignissim Rd.');
INSERT INTO `regularuser2` VALUES ('Kane Bruce', 'P.O. Box 403, 2202 Tellus. St.');
INSERT INTO `regularuser2` VALUES ('Jane Raymond', '583-4281 Auctor Av.');
INSERT INTO `regularuser2` VALUES ('Mariam Rosales', '243-8552 Phasellus Rd.');
INSERT INTO `regularuser2` VALUES ('Desiree Salas', 'P.O. Box 901, 5217 Consequat Av.');
INSERT INTO `regularuser2` VALUES ('Britanney Dyer', '686-5802 Nam Rd.');
INSERT INTO `regularuser2` VALUES ('Nolan Olson', '752-4969 Augue St.');
INSERT INTO `regularuser2` VALUES ('Eve Kidd', '644-8428 Odio Street');
INSERT INTO `regularuser2` VALUES ('Lynn English', '196-6156 Egestas Street');
INSERT INTO `regularuser2` VALUES ('Imogene Hodge', 'P.O. Box 510, 9173 Risus. Rd.');
INSERT INTO `regularuser2` VALUES ('Christen Norris', '2666 Ligula. Road');
INSERT INTO `regularuser2` VALUES ('Tiger Blair', '637-3552 Primis Street');
INSERT INTO `regularuser2` VALUES ('Risa Hill', 'Ap #306-8082 Ut Street');
INSERT INTO `regularuser2` VALUES ('Aquila Olson', '8246 Non, St.');
INSERT INTO `regularuser2` VALUES ('Claire Brooks', 'Ap #661-5303 Scelerisque Ave');
INSERT INTO `regularuser2` VALUES ('Russell Duran', '336 Tincidunt Av.');
INSERT INTO `regularuser2` VALUES ('Portia Lane', 'P.O. Box 385, 2284 Id Ave');
INSERT INTO `regularuser2` VALUES ('Jenette Richard', '666-5998 Nullam Rd.');
INSERT INTO `regularuser2` VALUES ('Kennan Herrera', 'P.O. Box 603, 5831 Sed Rd.');
INSERT INTO `regularuser2` VALUES ('Randall Porter', 'Ap #870-7081 Vitae Avenue');
INSERT INTO `regularuser2` VALUES ('Amal Velasquez', '631-9205 Metus Rd.');
INSERT INTO `regularuser2` VALUES ('Pearl Wynn', 'Ap #126-2480 Ipsum St.');
INSERT INTO `regularuser2` VALUES ('Daria Ray', '488-4208 Non, Avenue');
INSERT INTO `regularuser2` VALUES ('Fredericka Conway', 'P.O. Box 206, 715 Ut Street');
INSERT INTO `regularuser2` VALUES ('Gemma Valencia', '483-5173 Pede. Rd.');
INSERT INTO `regularuser2` VALUES ('Imogene Thomas', '6242 Quis Rd.');
INSERT INTO `regularuser2` VALUES ('Rina Sears', '9590 Diam Road');
INSERT INTO `regularuser2` VALUES ('Venus Britt', '9253 Eleifend Rd.');
INSERT INTO `regularuser2` VALUES ('Malik Pickett', 'Ap #582-6232 Vivamus St.');
INSERT INTO `regularuser2` VALUES ('Austin Robertson', 'P.O. Box 101, 2406 Interdum. Av.');
INSERT INTO `regularuser2` VALUES ('Heather Pruitt', 'Ap #686-9875 Metus. Av.');
INSERT INTO `regularuser2` VALUES ('Asher Mclean', 'P.O. Box 861, 4793 Interdum Av.');
INSERT INTO `regularuser2` VALUES ('Rhoda Parsons', '345-4752 Justo. Road');
INSERT INTO `regularuser2` VALUES ('Roth Donaldson', 'P.O. Box 295, 1739 Nascetur St.');
INSERT INTO `regularuser2` VALUES ('Giacomo Ray', '615-7208 Ac Ave');
INSERT INTO `regularuser2` VALUES ('Hayley Hodge', 'Ap #506-4942 Fermentum Rd.');
INSERT INTO `regularuser2` VALUES ('Hakeem Carney', '750-4376 Nec, Avenue');
INSERT INTO `regularuser2` VALUES ('Indira Porter', '1895 Est. Rd.');
INSERT INTO `regularuser2` VALUES ('Madeline Brooks', 'P.O. Box 321, 1305 Enim. Avenue');
INSERT INTO `regularuser2` VALUES ('Sylvia Mercado', '696-3375 Vestibulum St.');
INSERT INTO `regularuser2` VALUES ('Tad Aguilar', '943-2451 Interdum. Av.');
INSERT INTO `regularuser2` VALUES ('Harding Doyle', 'Ap #320-3795 Vehicula St.');
INSERT INTO `regularuser2` VALUES ('Daquan Robertson', 'P.O. Box 557, 6441 Suspendisse Road');
INSERT INTO `regularuser2` VALUES ('Wallace Mendoza', 'Ap #640-5547 Ac Road');
INSERT INTO `regularuser2` VALUES ('Connor Key', 'P.O. Box 584, 1862 Nec St.');
INSERT INTO `regularuser2` VALUES ('Hermione King', 'Ap #662-6650 Penatibus St.');
INSERT INTO `regularuser2` VALUES ('Anne Guzman', 'Ap #465-7398 Imperdiet, Avenue');
INSERT INTO `regularuser2` VALUES ('Quamar Harrell', 'Ap #641-7617 Dolor Rd.');
INSERT INTO `regularuser2` VALUES ('Dexter Campos', 'P.O. Box 624, 8769 Mauris, Av.');
INSERT INTO `regularuser2` VALUES ('Ariana Prince', '2848 Lorem St.');
INSERT INTO `regularuser2` VALUES ('Levi Mcbride', 'Ap #836-5599 Ipsum. St.');
INSERT INTO `regularuser2` VALUES ('Salvador Stanton', '251 Integer Road');
INSERT INTO `regularuser2` VALUES ('Aurelia Perry', '833-8314 Litora St.');
INSERT INTO `regularuser2` VALUES ('Lillith Moses', '3979 Cursus, Rd.');
INSERT INTO `regularuser2` VALUES ('Kirsten Franks', 'P.O. Box 536, 3092 Eu St.');
INSERT INTO `regularuser2` VALUES ('Rama Mcgowan', '721-2044 Nisl. Ave');
INSERT INTO `regularuser2` VALUES ('Chloe Sheppard', 'Ap #890-1284 Nulla. St.');
INSERT INTO `regularuser2` VALUES ('Victor Shepherd', '904-8343 Vestibulum Avenue');
INSERT INTO `regularuser2` VALUES ('Britanni Elliott', 'P.O. Box 933, 5156 Cras Av.');
INSERT INTO `regularuser2` VALUES ('Jamalia Holland', '7238 Et, Road');
INSERT INTO `regularuser2` VALUES ('John Wick', '6554 F St, New York City NY');

INSERT INTO `regularuser3` VALUES (2344, 'Amman Zaman');
INSERT INTO `regularuser3` VALUES (4345, 'Divyansh Singhal');
INSERT INTO `regularuser3` VALUES (5645, 'Mourud Ahmed');
INSERT INTO `regularuser3` VALUES (3252, 'Jessica Wang');
INSERT INTO `regularuser3` VALUES (8827, 'Lacota Graves');
INSERT INTO `regularuser3` VALUES (8956, 'Tanek Hurley');
INSERT INTO `regularuser3` VALUES (8388, 'Noel Mcfarland');
INSERT INTO `regularuser3` VALUES (7898, 'Rowan Zimmerman');
INSERT INTO `regularuser3` VALUES (6536, 'Ima Morton');
INSERT INTO `regularuser3` VALUES (7031, 'Plato Beard');
INSERT INTO `regularuser3` VALUES (8973, 'Calvin Riggs');
INSERT INTO `regularuser3` VALUES (9009, 'Leila Savage');
INSERT INTO `regularuser3` VALUES (6970, 'Burke Whitley');
INSERT INTO `regularuser3` VALUES (8148, 'Derek Walls');
INSERT INTO `regularuser3` VALUES (6999, 'Vielka Kirk');
INSERT INTO `regularuser3` VALUES (6050, 'Brandon Charles');
INSERT INTO `regularuser3` VALUES (8864, 'Tanisha Cabrera');
INSERT INTO `regularuser3` VALUES (7604, 'Raya Church');
INSERT INTO `regularuser3` VALUES (7538, 'Priscilla Vance');
INSERT INTO `regularuser3` VALUES (7061, 'Wynne Dudley');
INSERT INTO `regularuser3` VALUES (6015, 'Dolan Holder');
INSERT INTO `regularuser3` VALUES (7888, 'Lara Maddox');
INSERT INTO `regularuser3` VALUES (6248, 'Alec Craig');
INSERT INTO `regularuser3` VALUES (6541, 'Jacqueline Harmon');
INSERT INTO `regularuser3` VALUES (7340, 'Colin Casey');
INSERT INTO `regularuser3` VALUES (9317, 'Alfonso Greene');
INSERT INTO `regularuser3` VALUES (6342, 'Dillon Gilbert');
INSERT INTO `regularuser3` VALUES (9901, 'Cody Stanley');
INSERT INTO `regularuser3` VALUES (9237, 'Levi Morton');
INSERT INTO `regularuser3` VALUES (8191, 'Ila Hughes');
INSERT INTO `regularuser3` VALUES (6940, 'Clayton Shannon');
INSERT INTO `regularuser3` VALUES (9444, 'Quinn Cross');
INSERT INTO `regularuser3` VALUES (8939, 'Berk Brennan');
INSERT INTO `regularuser3` VALUES (7649, 'Inga Padilla');
INSERT INTO `regularuser3` VALUES (9031, 'Serena Serrano');
INSERT INTO `regularuser3` VALUES (9438, 'Colby Vance');
INSERT INTO `regularuser3` VALUES (7695, 'Garrett Mayo');
INSERT INTO `regularuser3` VALUES (6464, 'Candace Lang');
INSERT INTO `regularuser3` VALUES (7188, 'Wylie Burt');
INSERT INTO `regularuser3` VALUES (9402, 'Bruno Carver');
INSERT INTO `regularuser3` VALUES (6238, 'Rana Whitney');
INSERT INTO `regularuser3` VALUES (6980, 'Chloe Gordon');
INSERT INTO `regularuser3` VALUES (8484, 'Robin Bradshaw');
INSERT INTO `regularuser3` VALUES (8772, 'Dahlia Stout');
INSERT INTO `regularuser3` VALUES (9801, 'Samuel Mckay');
INSERT INTO `regularuser3` VALUES (8320, 'Kane Bruce');
INSERT INTO `regularuser3` VALUES (7312, 'Jane Raymond');
INSERT INTO `regularuser3` VALUES (8358, 'Mariam Rosales');
INSERT INTO `regularuser3` VALUES (7086, 'Desiree Salas');
INSERT INTO `regularuser3` VALUES (6927, 'Britanney Dyer');
INSERT INTO `regularuser3` VALUES (6004, 'Nolan Olson');
INSERT INTO `regularuser3` VALUES (6858, 'Eve Kidd');
INSERT INTO `regularuser3` VALUES (7820, 'Lynn English');
INSERT INTO `regularuser3` VALUES (7478, 'Imogene Hodge');
INSERT INTO `regularuser3` VALUES (7591, 'Christen Norris');
INSERT INTO `regularuser3` VALUES (9765, 'Tiger Blair');
INSERT INTO `regularuser3` VALUES (7379, 'Risa Hill');
INSERT INTO `regularuser3` VALUES (8952, 'Aquila Olson');
INSERT INTO `regularuser3` VALUES (7500, 'Claire Brooks');
INSERT INTO `regularuser3` VALUES (6656, 'Russell Duran');
INSERT INTO `regularuser3` VALUES (9369, 'Portia Lane');
INSERT INTO `regularuser3` VALUES (8780, 'Jenette Richard');
INSERT INTO `regularuser3` VALUES (9660, 'Kennan Herrera');
INSERT INTO `regularuser3` VALUES (9029, 'Randall Porter');
INSERT INTO `regularuser3` VALUES (8437, 'Amal Velasquez');
INSERT INTO `regularuser3` VALUES (6017, 'Pearl Wynn');
INSERT INTO `regularuser3` VALUES (8232, 'Daria Ray');
INSERT INTO `regularuser3` VALUES (6865, 'Fredericka Conway');
INSERT INTO `regularuser3` VALUES (7844, 'Gemma Valencia');
INSERT INTO `regularuser3` VALUES (9900, 'Imogene Thomas');
INSERT INTO `regularuser3` VALUES (9936, 'Rina Sears');
INSERT INTO `regularuser3` VALUES (6046, 'Venus Britt');
INSERT INTO `regularuser3` VALUES (8344, 'Malik Pickett');
INSERT INTO `regularuser3` VALUES (9506, 'Austin Robertson');
INSERT INTO `regularuser3` VALUES (9563, 'Heather Pruitt');
INSERT INTO `regularuser3` VALUES (6123, 'Asher Mclean');
INSERT INTO `regularuser3` VALUES (6850, 'Rhoda Parsons');
INSERT INTO `regularuser3` VALUES (7759, 'Roth Donaldson');
INSERT INTO `regularuser3` VALUES (7435, 'Giacomo Ray');
INSERT INTO `regularuser3` VALUES (9876, 'Hayley Hodge');
INSERT INTO `regularuser3` VALUES (8884, 'Hakeem Carney');
INSERT INTO `regularuser3` VALUES (8617, 'Indira Porter');
INSERT INTO `regularuser3` VALUES (8630, 'Madeline Brooks');
INSERT INTO `regularuser3` VALUES (8456, 'Sylvia Mercado');
INSERT INTO `regularuser3` VALUES (9229, 'Tad Aguilar');
INSERT INTO `regularuser3` VALUES (8638, 'Harding Doyle');
INSERT INTO `regularuser3` VALUES (6106, 'Daquan Robertson');
INSERT INTO `regularuser3` VALUES (6951, 'Wallace Mendoza');
INSERT INTO `regularuser3` VALUES (6788, 'Connor Key');
INSERT INTO `regularuser3` VALUES (7999, 'Hermione King');
INSERT INTO `regularuser3` VALUES (9625, 'Anne Guzman');
INSERT INTO `regularuser3` VALUES (7473, 'Quamar Harrell');
INSERT INTO `regularuser3` VALUES (8336, 'Dexter Campos');
INSERT INTO `regularuser3` VALUES (3490, 'Ariana Prince');
INSERT INTO `regularuser3` VALUES (8270, 'Levi Mcbride');
INSERT INTO `regularuser3` VALUES (9095, 'Salvador Stanton');
INSERT INTO `regularuser3` VALUES (9972, 'Aurelia Perry');
INSERT INTO `regularuser3` VALUES (9042, 'Lillith Moses');
INSERT INTO `regularuser3` VALUES (6608, 'Kirsten Franks');
INSERT INTO `regularuser3` VALUES (8766, 'Rama Mcgowan');
INSERT INTO `regularuser3` VALUES (9107, 'Chloe Sheppard');
INSERT INTO `regularuser3` VALUES (9813, 'Victor Shepherd');
INSERT INTO `regularuser3` VALUES (8694, 'Britanni Elliott');
INSERT INTO `regularuser3` VALUES (9606, 'Jamalia Holland');
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


