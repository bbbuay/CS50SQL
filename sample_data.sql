-- Add Sample data here :)
INSERT INTO "users" ("national_id", "first_name", "last_name", "age")
VALUES
('1111111111111', 'fname-1', 'lname-1', 10),
('1111111111112', 'fname-2', 'lname-2', 12),
('1111111111113', 'fname-3', 'lname-3', 12),
('1111111111114', 'fname-4', 'lname-4', 25),
('1111111111115', 'fname-5', 'lname-5', 25),
('1111111111116', 'fname-6', 'lname-6', 25),
('1111111111117', 'fname-7', 'lname-7', 65),
('1111111111118', 'fname-8', 'lname-8', 25);

INSERT INTO "cards" ("user_id", "number", "type", "money")
VALUES
(1, '01234567', 'student', 100),
(2, '01234568', 'adult', 100),
(3, '01234569', 'senior', 100);

INSERT INTO "lines" ("code") VALUES ('BL'), ('PP');

INSERT INTO "stations" ("line_id", "number", "name")
VALUES
(1, '01', 'Tha Phra'),
(1, '02', 'Fai Chai'),
(1, '03', 'Charun Sanitwong Railway Station'),
(1, '04', 'Bang Khun Non'),
(1, '05', 'Bang Yi Khan'),
(1, '06', 'Sirindhorn'),
(1, '07', 'Bang Phlat'),
(1, '08', 'Bang O'),
(1, '09', 'Bang Pho'),
(1, '10', 'Tao Poon'),
(1, '11', 'Bang Sue'),
(1, '12', 'Kamphaeng Phet'),
(1, '13', 'Chatuchak Park'),
(1, '14', 'Phahon Yothin'),
(1, '15', 'Lat Phrao'),
(1, '16', 'Ratchadaphisek'),
(1, '17', 'Sutthisan'),
(1, '18', 'Huai Khwang'),
(1, '19', 'Thailand Cultural Centre'),
(1, '20', 'Phra Ram 9'),
(1, '21', 'Phetchaburi'),
(1, '22', 'Sukhumvit'),
(1, '23', 'Queen Sirikit National Convention Centre'),
(1, '24', 'Klong Toei'),
(1, '25', 'Lumphini'),
(1, '26', 'Silom'),
(1, '27', 'Sam Yan'),
(1, '28', 'Hua Lamphong'),
(1, '29', 'Wat Mangkon'),
(1, '30', 'Sam Yot'),
(1, '31', 'Sanam Chai'),
(1, '32', 'Itsarahap'),
(1, '33', 'Bang Phai'),
(1, '34', 'Bang Wa'),
(1, '35', 'Phetkasem 48'),
(1, '36', 'Phasi Charoen'),
(1, '37', 'Bang Khae'),
(1, '38', 'Lak Song');

INSERT INTO "trains" ("line_id", "number")
VALUES
(1, 123),
(1, 124);

INSERT INTO "riders" ("train_id", "first_name", "last_name")
VALUES
(1, "rider_fname1", "rider_lname1"),
(1, "rider_fname2", "rider_lname2"),
(2, "rider_fname3", "rider_lname3");

INSERT INTO "trip_timetables" ("from_station_id", "to_station_id", "departure_time", "arrival_time")
VALUES
(1, 2, '08:00:00', '08:00:01'),
(2, 3, '08:00:01', '08:00:02'),
(3, 4, '08:00:02', '08:00:03');

INSERT INTO "staffs" ("work_at_station_id", "first_name", "last_name", "role")
VALUES
(1, 'fname-1', 'lname-1', 'Station Manager'),
(1, 'fname-2', 'lname-2', 'Security Officer'),
(1, 'fname-3', 'lname-3', 'Engineer'),
(2, 'fname-4', 'lname-4', 'Cleaning Staff'),
(2, 'fname-5', 'lname-5', 'Administrative Staff');

INSERT INTO "fares" ("line_id", "number_of_station", "cost")
VALUES
(1, 0, 16),
(1, 1, 16),
(1, 2, 19),
(1, 3, 21),
(1, 4, 23),
(1, 5, 25),
(1, 6, 28),
(1, 7, 30),
(1, 8, 32),
(1, 9, 35),
(1, 10, 37),
(1, 11, 39),
(1, 12, 42);

INSERT INTO "travel_histories" ("card_id" ,"station_id", "action")
VALUES
(1, 1, 'entry'),
(2, 4, 'entry'),
(3, 5, 'exit');
