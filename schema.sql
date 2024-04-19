-- All Tables
CREATE TABLE IF NOT EXISTS "users"(
    "id" INTEGER,
    "national_id" TEXT NOT NULL UNIQUE CHECK(length("national_id") == 13),
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL CHECK("age" > 0),
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "cards" (
    "id" INTEGER,
    "user_id" INTEGER,
    "number" TEXT NOT NULL UNIQUE CHECK(length("number") == 8),
    "type" TEXT NOT NULL CHECK("type" IN ('adult', 'student', 'senior')) DEFAULT 'adult',
    "money" INTEGER NOT NULL CHECK("money" >= 0) DEFAULT 0,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS "lines"(
    "id" INTEGER,
    "code" TEXT NOT NULL UNIQUE CHECK(length("code") == 2),
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "stations"(
    "id" INTEGER,
    "line_id" INTEGER,
    "number" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("line_id") REFERENCES "lines"("id") ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "travel_histories"(
    "id" INTEGER,
    "card_id" INTEGER,
    "station_id" INTEGER,
    "action" TEXT NOT NULL CHECK("action" in ('entry', 'exit')),
    "timestamp" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("card_id") REFERENCES "cards"("id") ON DELETE CASCADE,
    FOREIGN KEY("station_id") REFERENCES "stations"("id") ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "trains" (
    "id" INTEGER,
    "line_id" INTEGER,
    "number" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id"),
    FOREIGN KEY("line_id") REFERENCES "lines"("id") ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS "riders" (
    "id" INTEGER,
    "train_id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("train_id") REFERENCES "trains"("id") ON DELETE SET NULL
);


CREATE TABLE IF NOT EXISTS "trip_timetables" (
    "id" INTEGER,
    "from_station_id" INTEGER,
    "to_station_id" INTEGER,
    "departure_time" TEXT NOT NULL CHECK("departure_time" LIKE '__:__:__'),
    "arrival_time" TEXT NOT NULL CHECK("arrival_time" LIKE '__:__:__'),
    PRIMARY KEY("id"),
    FOREIGN KEY("from_station_id") REFERENCES "stations"("id") ON DELETE RESTRICT,
    FOREIGN KEY("to_station_id") REFERENCES "stations"("id") ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "staffs" (
    "id" INTEGER,
    "work_at_station_id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "role" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("work_at_station_id") REFERENCES "stations"("id") ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "fares" (
    "id" INTEGER,
    "line_id" INTEGER,
    "number_of_station" INTEGER,
    "cost" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("line_id") REFERENCES "lines"("id") ON DELETE CASCADE
);

-- All Views

-- 1. View to display all MRT Staffs
CREATE VIEW "mrt_staffs" AS
SELECT "id", "first_name", "last_name", 'Rider' AS "role" FROM "riders"
UNION
SELECT "id", "first_name", "last_name", "role" FROM "staffs";

-- 2. View to display MRT cards
CREATE VIEW "mrt_cards" AS
SELECT "number" AS "card_number", "type" AS "card_type", "first_name" || ' ' || "last_name" AS "owner"
FROM "cards" INNER JOIN "users"
ON "cards"."user_id" = "users"."id";

-- ALL Indexs
CREATE INDEX "user_index" ON "users"("national_id");
CREATE INDEX "card_number_index" ON "cards"("number");
CREATE INDEX "line_code_index" ON "lines"("code");
CREATE INDEX "train_number_index" ON "trains"("number");
CREATE INDEX "staff_fname_index" ON "staffs"("first_name");
CREATE INDEX "staff_lname_index" ON "staffs"("last_name");
CREATE INDEX "rider_fname_index" ON "riders"("first_name");
CREATE INDEX "rider_lname_index" ON "riders"("last_name");
