-- 1. Users

-- List all users
SELECT "fist_name", "last_name", "age" FROM "users" ORDER BY "first_name", "last_name";

-- Display the number of users group by age
SELECT "age", COUNT(*) AS "number_of_users" FROM "users" GROUP BY "age" ORDER BY "number_of_users";
SELECT "age", COUNT(*) AS "number_of_users" FROM "users" GROUP BY "age" ORDER BY "age";

-- Retrieve user details
SELECT * FROM "users" WHERE "national_id" = '1111111111111'; -- national_id

-- Create a new user
INSERT INTO "users" ("national_id", "first_name", "last_name", "age")
VALUES ('1111111111119', 'fname-9', 'lname-9', 33);

-- Update user information
UPDATE "users"
SET "first_name" = 'new_first_name'
WHERE "national_id" = '1111111111111'; -- national_id

UPDATE "users"
SET "age" = 11
WHERE "national_id" = '1111111111111'; -- national_id

-- Delete a user
DELETE FROM "users"
WHERE national_id = '1111111111111'; -- national_id

-- 2. Cards

-- List all MRT cards
SELECT "card_number", "card_type", "owner" FROM "mrt_cards";

-- Retrieve MRT card details
SELECT "id", "number" AS "card_number", "type" AS "card_type", "money"
FROM "cards"
WHERE "number" = '01234567'; -- card_number

-- Create a new MRT card for a user
INSERT INTO "cards" ("user_id", "number", "type")
VALUES (
    (SELECT "id" FROM "users" WHERE "national_id" = '1111111111113'), -- user_id
    '11111124',
    'adult'
);

-- Update MRT card details (e.g. balance)

-- ex. user add money to the card
UPDATE "cards"
SET "money" = (
    SELECT "money"
    FROM "cards"
    WHERE "number" = '01234567' -- card_numver
) + 100
WHERE "number" = '01234567';

-- ex. user pay for the mrt trip
UPDATE "cards"
SET "money"  = (
    SELECT "money"
    FROM "cards"
    WHERE "number" = '01234567' -- card_number
) - (
    SELECT "cost"
    FROM "fares"
    WHERE "number_of_station" = 7 -- number_of_stations
    AND "line_id" = (
        SELECT "line_id" FROM "lines" WHERE "code" = 'PP' -- line_code
    )
)
WHERE "number" = '01234567'; -- card_number

-- Delete an MRT card
DELETE FROM "cards"
WHERE "number" = '11111124'; -- card_number

-- 3. Travel Histories

-- List all travel histories for MRT cards
SELECT "action", "timestamp", "name" AS "station_name"
FROM "travel_histories"
INNER JOIN "stations"
ON "travel_histories"."station_id" = "stations"."id"
WHERE "travel_histories"."card_id" = (
    SELECT "id" FROM "cards" WHERE "number" = '01234567' -- card_number
);

-- Add a travel history to an MRT card
INSERT INTO "travel_histories" ("card_id", "station_id", "action")
VALUES (1, 1, 'entry'); -- card_id = 1

INSERT INTO "travel_histories" ("card_id", "station_id", "action")
VALUES (1, 2, 'exit'); -- card_id = 1

-- 4. Stations

-- List all stations on a specific line (e.g. BL line)
SELECT "name", "number", "code"
FROM "stations"
INNER JOIN "lines"
ON "stations"."line_id" = "lines"."id"
WHERE "lines"."code" = 'BL'; -- line_code

-- Add new stations
INSERT INTO "stations" ("line_id", "number", "name") -- line_id = 2
VALUES
(2, '01', 'Khlong Bang Phai'),
(2, '02', 'Talad Bang Yai'),
(2, '03', 'Sam Yaek Bang Yai'),
(2, '04', 'Bang Phlu'),
(2, '05', 'Bang Rak Yai'),
(2, '06', 'Bang Rak Noi Tha It'),
(2, '07', 'Sai Ma'),
(2, '08', 'Phra Nangklao Bridge'),
(2, '09', 'Yaek Nonthaburi 1'),
(2, '10', 'Bang Krasor'),
(2, '11', 'Nonthaburi Civic Center'),
(2, '12', 'Ministry of Public Health'),
(2, '13', 'Yaek Tiwanon'),
(2, '14', 'Wong Sawang'),
(2, '15', 'Bang Son'),
(2, '16', 'Tao Poon');

-- Update station details (e.g., station name)
UPDATE "stations"
SET "name" = 'New Station Name'
WHERE "name" = "Tha Phra";

-- Delete a station
DELETE FROM "stations"
WHERE "number" = '02' AND "line_id" = (
    SELECT "id" FROM "lines" WHERE "code" = 'BL'
);

-- 5. Lines

-- List all lines
SELECT "code" FROM "lines";

-- Add a new line
INSERT INTO "lines" ("code") VALUES ('AB');

-- Delete a line
DELETE FROM "lines"
WHERE "code" = 'AB';

-- 6. Trip Timetables
-- List all schedule timetables
SELECT "departure_time", "arrival_time",
"from_stations"."name" AS "from_station",
"to_stations"."name" AS "to_station"
FROM "trip_timetables"
INNER JOIN "stations" AS "from_stations"
ON "trip_timetables"."from_station_id" = "from_stations"."id"
INNER JOIN "stations" AS "to_stations"
ON "trip_timetables"."to_station_id" = "to_stations"."id"
ORDER BY "departure_time", "arrival_time";

-- Create new schedule timetables
INSERT INTO "trip_timetables" ("from_station_id", "to_station_id", "departure_time", "arrival_time")
VALUES
(4, 5, '09:00:00', '09:00:01'),
(5, 6, '09:00:01', '09:00:02');


-- 7. Trains
-- List all trains on a specific line
SELECT "number"
FROM "trains"
WHERE "line_id" = (
    SELECT "id"
    FROM "lines"
    WHERE "code" = 'BL' -- line_code
)
ORDER BY "number";

-- Create a new trains
INSERT INTO "trains" ("line_id", "number")
VALUES
(2, '211'), -- line_id = 2
(2, '212');

-- Delete a train based on its number
DELETE FROM "trains"
WHERE "number" = '212';


-- 8. Riders
-- List all riders for a given train number
SELECT "first_name", "last_name" FROM "riders"
WHERE "train_id" = (
    SELECT "id"
    FROM "trains"
    WHERE "number" = '123' -- train number
)
ORDER BY "first_name", "last_name";

-- Create a new rider
INSERT INTO "riders" ("train_id", "first_name", "last_name")
VALUES (1, "rider_fname", "rider_lname");

-- Update rider details
UPDATE "riders"
SET "first_name" = 'new_first_name'
WHERE "first_name" = 'rider_fname1' AND "last_name" = 'rider_lname1';

-- Delete a rider
DELETE FROM "riders"
WHERE "first_name" = 'new_first_name' AND "last_name" = 'rider_lname1';

-- 9. Staffs
-- List all staff (including riders)
SELECT "first_name", "last_name", "role" FROM "mrt_staffs" ORDER BY "first_name", "last_name";
SELECT "first_name", "last_name", "role" FROM "mrt_staffs" ORDER BY "role";

-- Display the number of individuals working in specific roles
SELECT "role", COUNT(*) AS "number_of_staffs" FROM "mrt_staffs" GROUP BY "role" ORDER BY "number_of_staffs" DESC;
SELECT "role", COUNT(*) AS "number_of_staffs" FROM "mrt_staffs" GROUP BY "role" ORDER BY "role";

-- Create new staff
INSERT INTO "staffs" ("work_at_station_id", "first_name", "last_name", "role")
VALUES (3, 'staff-fname', 'staff-lname', 'Customer Service');

-- Update staff details (e.g., staff role)
UPDATE "staffs"
SET "role" = 'Senior Engineer'
WHERE "first_name" = 'fname-3' AND "last_name" = 'lname-3';

-- Delete staff
DELETE FROM "staffs"
WHERE "first_name" = 'fname-1' AND "last_name" = 'lname-1';


-- 10. Fares
-- List all fare prices ordered by the number of stations
SELECT "number_of_station", "cost"
FROM "fares"
WHERE "line_id" = (
    SELECT "id"
    FROM "lines"
    WHERE "code" = 'PP'
)
ORDER BY "number_of_station";

-- Retrieve the fare price for a given number of stations
SELECT "cost"
FROM "fares"
WHERE "number_of_station" = 5  -- number of stations
AND "line_id" = (
    SELECT "id"
    FROM "lines"
    WHERE "code" = 'BL' -- line_code
);

-- Create new fare prices for specific lines
INSERT INTO "fares" ("line_id", "number_of_station", "cost")-- line_id = 2
VALUES
(2, 0, 14),
(2, 1, 17),
(2, 2, 20),
(2, 3, 23),
(2, 4, 25),
(2, 5, 27),
(2, 6, 30),
(2, 7, 33),
(2, 8, 36),
(2, 9, 38),
(2, 10, 40),
(2, 11, 42);

-- Update fare prices for a specific line and number of stations
UPDATE "fares"
SET "cost" = 18 -- new fare rate
WHERE "number_of_station" = 1 -- number_of_station
AND "line_id" = (
    SELECT "id"
    FROM "lines"
    WHERE "code" = 'BL' -- line_code
);
