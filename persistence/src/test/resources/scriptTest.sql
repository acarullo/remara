CREATE TABLE role (
  id BIGINT PRIMARY KEY NOT NULL,
  description VARCHAR(100));

-- CREATE TABLE user (
--   username VARCHAR(100) PRIMARY KEY NOT NULL,
--   password VARCHAR(255) NOT NULL,
--   name VARCHAR(200),
--   surname VARCHAR(200),
--   email VARCHAR(200),
--   pediatrician BOOLEAN,
--   hospital VARCHAR(255),
--   ward VARCHAR(255),
--   phone VARCHAR(100),
--   fax VARCHAR(100),
--   address VARCHAR(200));

CREATE TABLE region (
  id BIGINT PRIMARY KEY NOT NULL,
  description VARCHAR(100),
  num_occupants INT,
  num_municipalities INT,
  num_provinces INT);

CREATE TABLE province (
  id VARCHAR(255) PRIMARY KEY,
  description VARCHAR(255),
  num_occupants INT,
  num_municipalities INT);

CREATE TABLE nation (
  id BIGINT PRIMARY KEY NOT NULL,
  description_it VARCHAR(255),
  initials VARCHAR(3),
  description_en VARCHAR(255));

CREATE TABLE municipality (
  id BIGINT PRIMARY KEY NOT NULL,
  description VARCHAR(100),
  cadastre VARCHAR(10));

CREATE TABLE illness (
  id BIGINT PRIMARY KEY NOT NULL,
  code VARCHAR(255),
  description VARCHAR(255),
  exempt VARCHAR(255),
  marche BOOLEAN);

CREATE TABLE export (
  id BIGINT PRIMARY KEY NOT NULL,
  comment VARCHAR(100),
  exportdate DATE(13));

CREATE TABLE education (
  id BIGINT PRIMARY KEY NOT NULL,
  description_it VARCHAR(255),
  description_en VARCHAR(255),
  code VARCHAR(255));

CREATE TABLE occupation (
  id BIGINT PRIMARY KEY NOT NULL,
  description_it VARCHAR(255),
  description_en VARCHAR(255),
  code VARCHAR(255));

-- CREATE TABLE exam (
--   id INT PRIMARY KEY NOT NULL,
--   description VARCHAR(255),
--   typeExam VARCHAR(20),
--   dataExam DATE(13),
-- criterion VARCHAR(255),
-- report VARCHAR(255));

-- create sequence IF NOT EXISTS seq_illness START WITH 700 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_export START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_patient START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_file_case START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_exam START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_hospital_ward START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_hospital_organization START WITH 1 INCREMENT BY 1;
-- create sequence IF NOT EXISTS seq_medicine_case START WITH 1 INCREMENT BY 1;

-- INSERT INTO user VALUES ('testone', 'password', 'test', 'test', 'test@test.org', false, 'test hospital', 'test ward one', 
-- '11111', '11111', 'via test');
-- 
-- INSERT INTO user VALUES ('testtwo', 'password', 'test', 'test', 'test@test.org', false, 'test hospital', 'test ward', 
-- '22222', '22222', 'via test');
-- 
-- INSERT INTO user VALUES ('testthree', 'password', 'test', 'test', 'test@test.org', false, 'test hospital', 'test ward', 
-- '33333', '33333', 'via test');

-- INSERT INTO role VALUES ('1', 'primo ruolo prova remara');

INSERT INTO region VALUES ('1', 'prima regione prova remara', '4','4','2');

INSERT INTO province VALUES ('PE', 'prima provincia prova remara', '4','4');

INSERT INTO nation VALUES ('1', 'prima nazione prova remara', 'ITA','first nation');

INSERT INTO municipality VALUES ('1', 'primo municipio prova remara', 'PESCARA');

INSERT INTO illness VALUES ('1', 'illness1', 'illness test', 'exempt1', true);

INSERT INTO illness VALUES ('2', 'illness2', 'illness test 2', 'exempt2', true);

INSERT INTO education VALUES ('1', 'prima educazione prova remara', 'first education','code education 1');

INSERT INTO education VALUES ('2', 'seconda educazione prova remara', 'second education','code education 2');

INSERT INTO occupation VALUES ('1', 'prima occupazione prova remara', 'first occupation','code occupation');

-- INSERT INTO exam VALUES ('100', 'exam 1', null, null, null, null);

COMMIT;
