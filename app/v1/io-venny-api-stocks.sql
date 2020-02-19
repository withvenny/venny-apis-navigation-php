select * from stocks;
select * from stock_valuations;

INSERT INTO stocks(symbol,company) VALUES(:symbol,:company);
INSERT INTO stocks(symbol,company) VALUES('NTRZ','Notearise');
INSERT INTO stock_valuations(stock_id,value_on,price) VALUES(1,'12/12/2019',37);

CREATE TABLE accounts(
   id SERIAL PRIMARY KEY,
   first_name CHARACTER VARYING(100),
   last_name CHARACTER VARYING(100)
);
select * from accounts;
 
CREATE TABLE plans(
   id SERIAL PRIMARY KEY,
   plan CHARACTER VARYING(10) NOT NULL
);
select * from plans;
 
CREATE TABLE account_plans(
   account_id INTEGER NOT NULL,
   plan_id INTEGER NOT NULL,
   effective_date DATE NOT NULL,
   PRIMARY KEY (account_id,plan_id),
   FOREIGN KEY(account_id) REFERENCES accounts(id),
   FOREIGN KEY(plan_id) REFERENCES plans(id)
);
select * from account_plans;

INSERT INTO plans(plan) VALUES('SILVER'),('GOLD'),('PLATINUM');

CREATE OR REPLACE FUNCTION add(
    a INTEGER,
    b INTEGER)
  RETURNS integer AS $$
BEGIN
return a + b;
END; $$
  LANGUAGE 'plpgsql';
  
CREATE OR REPLACE FUNCTION get_accounts()
  RETURNS TABLE(id integer, 
                first_name character varying, 
                last_name character varying, 
                plan character varying, 
                effective_date date) AS
$$
BEGIN
 RETURN QUERY 
 
 SELECT a.id,a.first_name,a.last_name, p.plan, ap.effective_date
 FROM accounts a
 INNER JOIN account_plans ap on a.id = account_id
 INNER JOIN plans p on p.id = plan_id
 ORDER BY a.id, ap.effective_date;
END; $$
 
LANGUAGE plpgsql;




/* PostgreSQL PHP: Working with BLOB */

CREATE TABLE company_files (
     id        SERIAL PRIMARY KEY,
     stock_id  INTEGER NOT NULL,
     mime_type CHARACTER VARYING(255) NOT NULL,
     file_name CHARACTER VARYING(255) NOT NULL,
     file_data BYTEA NOT NULL,
     FOREIGN KEY(stock_id) REFERENCES stocks(id)
);

select * from company_files;
SELECT * FROM company_files;

SELECT id, file_data, mime_type FROM company_files WHERE id=5;

/* PostgreSQL PHP: Delete Data From a Table */
SELECT * FROM stocks ORDER BY id;

/* Playing around with Stored Procedures */

CREATE TABLE IF NOT EXISTS	persons	(
ID	SERIAL	,
person_ID	VARCHAR(30)	NOT NULL UNIQUE,
person_attributes	JSON	NULL,
person_name_first	VARCHAR(255)	NOT NULL,
person_name_middle	VARCHAR(255)	NOT NULL,
person_name_last	VARCHAR(255)	NULL,
person_email	VARCHAR(255)	NOT NULL UNIQUE,
person_phone_primary	VARCHAR(255)	NULL,
person_phone_secondary	VARCHAR(255)	NULL,
person_entitlements	JSON	NULL,
app_id	VARCHAR(30)	NOT NULL,
event_id	VARCHAR(30)	NOT NULL,
process_id	VARCHAR(30)	NOT NULL,
time_started	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_updated	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_finished	TIMESTAMP	NOT NULL DEFAULT NOW(),
active	INT	NOT NULL DEFAULT 1
);
CREATE SEQUENCE persons_sequence;		
CREATE SEQUENCE persons_sequence;		
CREATE SEQUENCE person_id_seq;		
ALTER SEQUENCE persons_sequence RESTART WITH 8301;		
ALTER TABLE persons ALTER COLUMN ID SET DEFAULT nextval('persons_sequence');		
select * from persons;
select count(*) from persons;
SELECT last_value FROM persons_sequence;

SELECT
person_id,
person_attributes,
person_first_name,
person_last_name,
person_email,
person_phone,
person_entitlements
FROM persons
ORDER BY time_finished;

SELECT
person_id,
person_attributes,
person_first_name,
person_last_name,
person_email,
person_phone,
person_entitlements
FROM persons ORDER BY time_finished

SELECT
                            person_id,
                            person_attributes,
                            person_first_name,
                            person_last_name,
                            person_email,
                            person_phone,
                            person_entitlements
                      FROM persons 
                       WHERE person_id = '8301_02132020_0430'
                       LIMIT 1;
                       
SELECT
                            person_id,
                            person_attributes,
                            person_first_name,
                            person_last_name,
                            person_email,
                            person_phone,
                            person_entitlements
                            FROM persons
                            ORDER BY time_finished DESC
                            limit 8;
                            
SELECT person_id,
                person_attributes,
                person_first_name,
                person_last_name,
                person_email,
                person_phone,
                person_entitlements FROM persons WHERE person_id = '8301_02132020_0430'  LIMIT 1;
                
SELECT person_id, person_attributes, person_first_name, person_last_name, person_email, person_phone, person_entitlements FROM persons WHERE person_id = '8301_02132020_0430' AND active = 1 ORDER BY time_finished DESC LIMIT 1;

SELECT person_id, person_attributes, person_first_name, person_last_name, person_email, person_phone, person_entitlements FROM persons WHERE person_id = '8301_02132020_0430' AND active = 1 ORDER BY time_finished DESC LIMIT 1;

CREATE TABLE IF NOT EXISTS	tokens	(
ID	SERIAL	,
token_ID	VARCHAR(30)	NOT NULL UNIQUE,
token_attributes	JSON	NULL,
token_key	VARCHAR(255)	NOT NULL UNIQUE,
token_secret	VARCHAR(255)	NOT NULL UNIQUE,
token_expires	TIMESTAMP	NULL,
token_limit	INT	NULL,
token_balance	INT	NULL,
token_status	VARCHAR(255)	NULL,
app_id	VARCHAR(30)	NOT NULL,
event_id	VARCHAR(30)	NOT NULL,
process_id	VARCHAR(30)	NOT NULL,
time_started	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_updated	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_finished	TIMESTAMP	NOT NULL DEFAULT NOW(),
active	INT	NOT NULL DEFAULT 1
);
CREATE SEQUENCE tokens_sequence;		
ALTER SEQUENCE tokens_sequence RESTART WITH 8301;		
ALTER TABLE tokens ALTER COLUMN ID SET DEFAULT nextval('tokens_sequence');

INSERT INTO tokens(token_id,token_attributes,token_key,token_secret,token_expires,token_limit,token_balance,token_status,app_id,event_id,process_id) values ('token_83838383','{"app":"83838383"}','token_SDW4ReFR345E','token_SDW4ReFR345E','12/31/2020 11:59:59',9999,9999,'active','app_83838383','event_83838383','process_83838383');
select * from tokens;
             




