CREATE TABLE "frameworks" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "phases" (
  "id" SERIAL PRIMARY KEY,
  "sequence_number" int,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "tactics" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "techniques" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text,
  "can_produce_narratives" boolean,
  "can_consume_narratives" boolean,
  "object_id" varchar
);

CREATE TABLE "belongs_to_framework" (
  "framework" int,
  "technique" int
);

CREATE TABLE "detections" (
  "id" int PRIMARY KEY,
  "detects_technique" int,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "counters" (
  "technique_id" int,
  "countered_by" int,
  "object_id" varchar
);

CREATE TABLE "metatechniques" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "metatechnique_associations" (
  "metatechnique" int,
  "technique" int
);

CREATE TABLE "actortypes" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text,
  "object_id" varchar
);

CREATE TABLE "can_perform" (
  "actortype" int,
  "technique" int
);

CREATE TABLE "framework_association" (
  "actortype" int,
  "framework" int
);

CREATE TABLE "actor_capable_detections" (
  "actortype" int,
  "detection" int
);

CREATE TABLE "actors" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "campaigns" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "campaign_actors" (
  "actor" int,
  "campaign" int
);

CREATE TABLE "detection_events" (
  "id" int PRIMARY KEY,
  "detection" int,
  "event_data" text
);

CREATE TABLE "incidents" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "summary" text
);

CREATE TABLE "campaign_incidents" (
  "campaign_id" int,
  "incident" int
);

CREATE TABLE "incident_detections" (
  "incident_id" int,
  "event" int
);

CREATE TABLE "actors_to_types" (
  "actor_id" int,
  "actor_type_id" int
);

CREATE TABLE "narratives" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "narrative_campaign_support" (
  "narratives_id" int,
  "supports_campaign" int
);

CREATE TABLE "narrative_associated_incident" (
  "narratives_id" int,
  "associated_incident" int
);

CREATE TABLE "related_narratives" (
  "narrative_a" int,
  "narrative_b" int,
  "relationship" varchar
);

ALTER TABLE "phases" ADD FOREIGN KEY ("id") REFERENCES "frameworks" ("id");

ALTER TABLE "tactics" ADD FOREIGN KEY ("id") REFERENCES "phases" ("id");

ALTER TABLE "techniques" ADD FOREIGN KEY ("id") REFERENCES "tactics" ("id");

ALTER TABLE "frameworks" ADD FOREIGN KEY ("id") REFERENCES "techniques" ("id");

ALTER TABLE "frameworks" ADD FOREIGN KEY ("id") REFERENCES "belongs_to_framework" ("framework");

ALTER TABLE "belongs_to_framework" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("id");

ALTER TABLE "detections" ADD FOREIGN KEY ("detects_technique") REFERENCES "techniques" ("id");

ALTER TABLE "counters" ADD FOREIGN KEY ("technique_id") REFERENCES "techniques" ("id");

ALTER TABLE "counters" ADD FOREIGN KEY ("countered_by") REFERENCES "techniques" ("id");

ALTER TABLE "metatechnique_associations" ADD FOREIGN KEY ("metatechnique") REFERENCES "metatechniques" ("id");

ALTER TABLE "metatechnique_associations" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("id");

ALTER TABLE "can_perform" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("id");

ALTER TABLE "can_perform" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("id");

ALTER TABLE "framework_association" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("id");

ALTER TABLE "framework_association" ADD FOREIGN KEY ("framework") REFERENCES "frameworks" ("id");

ALTER TABLE "actor_capable_detections" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("id");

ALTER TABLE "actor_capable_detections" ADD FOREIGN KEY ("detection") REFERENCES "detections" ("id");

ALTER TABLE "campaign_actors" ADD FOREIGN KEY ("actor") REFERENCES "actors" ("id");

ALTER TABLE "campaign_actors" ADD FOREIGN KEY ("campaign") REFERENCES "campaigns" ("id");

ALTER TABLE "detection_events" ADD FOREIGN KEY ("detection") REFERENCES "detections" ("id");

ALTER TABLE "campaign_incidents" ADD FOREIGN KEY ("campaign_id") REFERENCES "campaigns" ("id");

ALTER TABLE "incidents" ADD FOREIGN KEY ("id") REFERENCES "campaign_incidents" ("incident");

ALTER TABLE "incident_detections" ADD FOREIGN KEY ("incident_id") REFERENCES "incidents" ("id");

ALTER TABLE "detection_events" ADD FOREIGN KEY ("id") REFERENCES "incident_detections" ("event");

ALTER TABLE "actors_to_types" ADD FOREIGN KEY ("actor_id") REFERENCES "actors" ("id");

ALTER TABLE "actortypes" ADD FOREIGN KEY ("id") REFERENCES "actors_to_types" ("actor_type_id");

ALTER TABLE "narrative_campaign_support" ADD FOREIGN KEY ("narratives_id") REFERENCES "narratives" ("id");

ALTER TABLE "narrative_campaign_support" ADD FOREIGN KEY ("supports_campaign") REFERENCES "campaigns" ("id");

ALTER TABLE "narrative_associated_incident" ADD FOREIGN KEY ("narratives_id") REFERENCES "narratives" ("id");

ALTER TABLE "narrative_associated_incident" ADD FOREIGN KEY ("associated_incident") REFERENCES "incidents" ("id");

ALTER TABLE "related_narratives" ADD FOREIGN KEY ("narrative_a") REFERENCES "narratives" ("id");

ALTER TABLE "related_narratives" ADD FOREIGN KEY ("narrative_b") REFERENCES "narratives" ("id");
