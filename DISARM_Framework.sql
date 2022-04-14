CREATE TABLE "frameworks" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "phases" (
  "object_id" varchar PRIMARY KEY,
  "sequence_number" int,
  "name" varchar,
  "description" text,
  "framework" varchar
);

CREATE TABLE "tactics" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "phase_tactics" (
  "phase_id" varchar,
  "tactic_id" varchar
);

CREATE TABLE "techniques" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text,
  "can_produce_narratives" boolean,
  "can_consume_narratives" boolean
);

CREATE TABLE "tactic_techniques" (
  "tech_id" varchar,
  "tactic_id" varchar
);

CREATE TABLE "belongs_to_framework" (
  "framework" varchar,
  "technique" varchar
);

CREATE TABLE "detections" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "detects_technique" (
  "detection_id" varchar,
  "technique_id" varchar
);

CREATE TABLE "counters" (
  "object_id" varchar PRIMARY KEY,
  "technique_id" varchar,
  "countered_by" varchar
);

CREATE TABLE "metatechniques" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "metatechnique_associations" (
  "metatechnique" varchar,
  "technique" varchar
);

CREATE TABLE "actortypes" (
  "object_id" varchar PRIMARY KEY,
  "name" varchar,
  "description" text
);

CREATE TABLE "can_perform" (
  "actortype" varchar,
  "technique" varchar
);

CREATE TABLE "framework_association" (
  "actortype" varchar,
  "framework" varchar
);

CREATE TABLE "actor_capable_detections" (
  "actortype" varchar,
  "detection" varchar
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
  "detection" varchar,
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
  "actor_type_id" varchar
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

ALTER TABLE "phases" ADD FOREIGN KEY ("framework") REFERENCES "frameworks" ("object_id");

ALTER TABLE "phase_tactics" ADD FOREIGN KEY ("phase_id") REFERENCES "phases" ("object_id");

ALTER TABLE "phase_tactics" ADD FOREIGN KEY ("tactic_id") REFERENCES "tactics" ("object_id");

ALTER TABLE "tactic_techniques" ADD FOREIGN KEY ("tech_id") REFERENCES "techniques" ("object_id");

ALTER TABLE "tactic_techniques" ADD FOREIGN KEY ("tactic_id") REFERENCES "tactics" ("object_id");

ALTER TABLE "belongs_to_framework" ADD FOREIGN KEY ("framework") REFERENCES "frameworks" ("object_id");

ALTER TABLE "belongs_to_framework" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("object_id");

ALTER TABLE "detects_technique" ADD FOREIGN KEY ("detection_id") REFERENCES "detections" ("object_id");

ALTER TABLE "detects_technique" ADD FOREIGN KEY ("technique_id") REFERENCES "techniques" ("object_id");

ALTER TABLE "counters" ADD FOREIGN KEY ("technique_id") REFERENCES "techniques" ("object_id");

ALTER TABLE "counters" ADD FOREIGN KEY ("countered_by") REFERENCES "techniques" ("object_id");

ALTER TABLE "metatechnique_associations" ADD FOREIGN KEY ("metatechnique") REFERENCES "metatechniques" ("object_id");

ALTER TABLE "metatechnique_associations" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("object_id");

ALTER TABLE "can_perform" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("object_id");

ALTER TABLE "can_perform" ADD FOREIGN KEY ("technique") REFERENCES "techniques" ("object_id");

ALTER TABLE "framework_association" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("object_id");

ALTER TABLE "framework_association" ADD FOREIGN KEY ("framework") REFERENCES "frameworks" ("object_id");

ALTER TABLE "actor_capable_detections" ADD FOREIGN KEY ("actortype") REFERENCES "actortypes" ("object_id");

ALTER TABLE "actor_capable_detections" ADD FOREIGN KEY ("detection") REFERENCES "detections" ("object_id");

ALTER TABLE "campaign_actors" ADD FOREIGN KEY ("actor") REFERENCES "actors" ("id");

ALTER TABLE "campaign_actors" ADD FOREIGN KEY ("campaign") REFERENCES "campaigns" ("id");

ALTER TABLE "detection_events" ADD FOREIGN KEY ("detection") REFERENCES "detections" ("object_id");

ALTER TABLE "campaign_incidents" ADD FOREIGN KEY ("campaign_id") REFERENCES "campaigns" ("id");

ALTER TABLE "campaign_incidents" ADD FOREIGN KEY ("incident") REFERENCES "incidents" ("id");

ALTER TABLE "incident_detections" ADD FOREIGN KEY ("incident_id") REFERENCES "incidents" ("id");

ALTER TABLE "incident_detections" ADD FOREIGN KEY ("event") REFERENCES "detection_events" ("id");

ALTER TABLE "actors_to_types" ADD FOREIGN KEY ("actor_id") REFERENCES "actors" ("id");

ALTER TABLE "actors_to_types" ADD FOREIGN KEY ("actor_type_id") REFERENCES "actortypes" ("object_id");

ALTER TABLE "narrative_campaign_support" ADD FOREIGN KEY ("narratives_id") REFERENCES "narratives" ("id");

ALTER TABLE "narrative_campaign_support" ADD FOREIGN KEY ("supports_campaign") REFERENCES "campaigns" ("id");

ALTER TABLE "narrative_associated_incident" ADD FOREIGN KEY ("narratives_id") REFERENCES "narratives" ("id");

ALTER TABLE "narrative_associated_incident" ADD FOREIGN KEY ("associated_incident") REFERENCES "incidents" ("id");

ALTER TABLE "related_narratives" ADD FOREIGN KEY ("narrative_a") REFERENCES "narratives" ("id");

ALTER TABLE "related_narratives" ADD FOREIGN KEY ("narrative_b") REFERENCES "narratives" ("id");
