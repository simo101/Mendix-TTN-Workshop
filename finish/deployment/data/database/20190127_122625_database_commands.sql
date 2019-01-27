CREATE TABLE "myfirstmodule$alert" (
	"id" BIGINT NOT NULL,
	"createddate" TIMESTAMP NULL,
	"message" VARCHAR_IGNORECASE(200) NULL,
	"title" VARCHAR_IGNORECASE(200) NULL,
	PRIMARY KEY("id"));
INSERT INTO "mendixsystem$entity" ("id", 
"entity_name", 
"table_name")
 VALUES ('a82ccc53-c328-41a7-b201-22897bdc139e', 
'MyFirstModule.Alert', 
'myfirstmodule$alert');
INSERT INTO "mendixsystem$attribute" ("id", 
"entity_id", 
"attribute_name", 
"column_name", 
"type", 
"length", 
"default_value", 
"is_auto_number")
 VALUES ('ce751edd-e0c9-399b-8ae5-a8e0c8efdcfa', 
'a82ccc53-c328-41a7-b201-22897bdc139e', 
'createdDate', 
'createddate', 
20, 
0, 
'', 
false);
INSERT INTO "mendixsystem$attribute" ("id", 
"entity_id", 
"attribute_name", 
"column_name", 
"type", 
"length", 
"default_value", 
"is_auto_number")
 VALUES ('6c67b414-282a-4f02-b22a-d247c4beb5a3', 
'a82ccc53-c328-41a7-b201-22897bdc139e', 
'Message', 
'message', 
30, 
200, 
'', 
false);
INSERT INTO "mendixsystem$attribute" ("id", 
"entity_id", 
"attribute_name", 
"column_name", 
"type", 
"length", 
"default_value", 
"is_auto_number")
 VALUES ('09b1f229-284f-4325-a1cb-6271813ce70d', 
'a82ccc53-c328-41a7-b201-22897bdc139e', 
'Title', 
'title', 
30, 
200, 
'', 
false);
UPDATE "mendixsystem$version"
 SET "versionnumber" = '4.2', 
"lastsyncdate" = '20190127 12:26:23';
