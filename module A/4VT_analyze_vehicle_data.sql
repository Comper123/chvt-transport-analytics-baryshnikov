CREATE TABLE "camera" (
  "id" uuid PRIMARY KEY,
  "name" varchar(255),
  "description_loc" text,
  "is_active" boolean,
  "place_id" uuid
);

CREATE TABLE "place" (
  "id" uuid PRIMARY KEY,
  "name" varchar(255),
  "line_count" int,
  "direction_label" varchar(255),
  "speed_limit" numeric
);

CREATE TABLE "video_registry" (
  "id" uuid PRIMARY KEY,
  "title" varchar(255),
  "start_time" time,
  "end_time" time,
  "camera_id" uuid
);

CREATE TABLE "detection_event" (
  "id" uuid PRIMARY KEY,
  "title" varchar(255),
  "detection_time" time,
  "x_coord" numeric,
  "y_coord" numeric,
  "width" numeric,
  "height" numeric,
  "speed" numeric,
  "direction" varchar(50),
  "registry_id" uuid,
  "vehicle_type_id" uuid
);

CREATE TABLE "vehicle_type" (
  "id" uuid PRIMARY KEY,
  "group" enum,
  "name" varchar(100)
);

CREATE TABLE "track" (
  "id" uuid PRIMARY KEY,
  "duration" time,
  "start_time" time,
  "end_time" time,
  "avg_speed" numeric,
  "max_speed" numeric,
  "direction" varchar(50),
  "is_valid" boolean,
  "vehicle_type_id" uuid
);

CREATE TABLE "time_slot" (
  "id" uuid PRIMARY KEY,
  "value" varchar(20),
  "descrition" text
);

CREATE TABLE "external_factors" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100),
  "description" text,
  "value" varchar(100)
);

CREATE TABLE "video_registry_factors" (
  "id" uuid PRIMARY KEY,
  "registry_id" uuid,
  "factor_id" uuid
);

ALTER TABLE "camera" ADD FOREIGN KEY ("place_id") REFERENCES "place" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "video_registry" ADD FOREIGN KEY ("camera_id") REFERENCES "camera" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "detection_event" ADD FOREIGN KEY ("registry_id") REFERENCES "video_registry" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "detection_event" ADD FOREIGN KEY ("vehicle_type_id") REFERENCES "vehicle_type" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "track" ADD FOREIGN KEY ("vehicle_type_id") REFERENCES "vehicle_type" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "video_registry_factors" ADD FOREIGN KEY ("registry_id") REFERENCES "video_registry" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "video_registry_factors" ADD FOREIGN KEY ("factor_id") REFERENCES "external_factors" ("id") DEFERRABLE INITIALLY IMMEDIATE;
