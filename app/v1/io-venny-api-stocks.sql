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
ALTER TABLE persons ADD person_name_middle VARCHAR(255)	NULL;
ALTER TABLE persons RENAME COLUMN person_first_name TO person_name_first;
ALTER TABLE persons RENAME COLUMN person_last_name TO person_name_last;
ALTER TABLE persons RENAME COLUMN person_phone_primaary TO person_phone_primary;
ALTER TABLE persons ADD person_phone_secondary VARCHAR(255)	NULL;

CREATE SEQUENCE persons_sequence;		
CREATE SEQUENCE persons_sequence;		
CREATE SEQUENCE person_id_seq;		
ALTER SEQUENCE persons_sequence RESTART WITH 8301;		
ALTER TABLE persons ALTER COLUMN ID SET DEFAULT nextval('persons_sequence');		
select * from persons;
select count(*) from persons;
SELECT last_value FROM persons_sequence;

INSERT INTO persons (person_id,person_attributes,person_first_name,person_last_name,person_email,person_phone,person_entitlements,event_id,process_id) VALUES
(21, 'My grievances... Well, How To Flip The Image', 'http://www.sourcecodester.com/tutorials/htmlcss/10263/how-flip-image.html'),
(22, 'Lady... Hi, How To Count Number Of Vowels And Consonants', 'http://www.sourcecodester.com/tutorials/javascript/10264/how-count-number-vowels-and-consonants.html'),


SELECT
person_id,
person_attributes,
person_first_name,
person_last_name,
person_email,
person_phone,
person_entitlements,
event_id,
process_id
)
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
select * from persons order by id desc limit 100;

person_id
person_attributes
person_name_first
person_name_middle
person_name_last
person_email
person_phone_primary
person_phone_secondary
person_entitlements
event_id
process_id;

INSERT INTO `tbl_tutorials` (`tuts_id`, `tuts_title`, `tuts_link`) VALUES
(1, 'How To Flip The Image', 'http://www.sourcecodester.com/tutorials/htmlcss/10263/how-flip-image.html'),

INSERT INTO persons (person_id,person_attributes,person_name_first,person_name_last,person_email,person_phone_primary,person_entitlements,event_id,process_id,app_id) VALUES
('dabaggFRE','{}','Danny','Baggett','DannyBaggette@dayrep.com','214-442-8529','{"experience":["CA","US","MasterCard","Green"]}','event0220208301','process0220208301','app0220208301');

INSERT INTO persons (person_id,person_attributes,person_name_first,person_name_last,person_email,person_phone_primary,person_entitlements,event_id,process_id,app_id) VALUES
('den2e7dzSCH','{}','Denise','Schillinger','DeniseCSchillinger@fleckens.hu','620-877-6345','{"experience":["KS","US","MasterCard","Purple"]}','event0220208302','process0220208302','app0220208301'),
('elnb379zBED','{}','Eli','Bednar','EliRBednar@jourrapide.com','843-275-2273','{"experience":["SC","US","Visa","Green"]}','event0220208303','process0220208303','app0220208301'),
('trnf81ezNAV','{}','Troy','Navarro','TroyANavarro@fleckens.hu','432-577-9761','{"experience":["TX","US","Visa","Blue"]}','event0220208304','process0220208304','app0220208301'),
('kund6cfzMOR','{}','Kurt','Morse','KurtTMorse@superrito.com','336-884-5638','{"experience":["NC","US","MasterCard","Blue"]}','event0220208305','process0220208305','app0220208301'),
('frn15a0zBEN','{}','Francisco','Bennett','FranciscoJBennett@cuvox.de','770-781-1870','{"experience":["GA","US","Visa","Blue"]}','event0220208306','process0220208306','app0220208301'),
('danfc97zHOF','{}','Dana','Hoffman','DanaJHoffman@fleckens.hu','803-586-5498','{"experience":["SC","US","Visa","Red"]}','event0220208307','process0220208307','app0220208301'),
('lin1014zFUL','{}','Lisa','Fullerton','LisaJFullerton@armyspy.com','773-896-2630','{"experience":["IL","US","MasterCard","Purple"]}','event0220208308','process0220208308','app0220208301'),
('chn25a7zGLE','{}','Christopher','Glenn','ChristopherEGlenn@armyspy.com','714-396-2754','{"experience":["CA","US","MasterCard","Silver"]}','event0220208309','process0220208309','app0220208301'),
('jon20a0zCAR','{}','Joann','Caraway','JoannDCaraway@fleckens.hu','216-396-8185','{"experience":["OH","US","MasterCard","Blue"]}','event0220208310','process0220208310','app0220208301'),
('ren4825zRUI','{}','Rene','Ruiz','ReneCRuiz@fleckens.hu','229-520-5661','{"experience":["GA","US","MasterCard","White"]}','event0220208311','process0220208311','app0220208301'),
('min451ezMAR','{}','Mike','Martin','MikeSMartin@jourrapide.com','409-397-1203','{"experience":["TX","US","Visa","Blue"]}','event0220208312','process0220208312','app0220208301'),
('tin64f4zDAR','{}','Timothy','Darling','TimothyBDarling@teleworm.us','952-909-9870','{"experience":["MN","US","MasterCard","Blue"]}','event0220208313','process0220208313','app0220208301'),
('chnbc22zCOL','{}','Charlie','Cole','CharlieBCole@rhyta.com','785-568-3898','{"experience":["KS","US","Visa","Blue"]}','event0220208314','process0220208314','app0220208301'),
('minff2czKIN','{}','Michelle','King','MichelleJKing@armyspy.com','650-693-5099','{"experience":["CA","US","Visa","Blue"]}','event0220208315','process0220208315','app0220208301'),
('ann9352zVIL','{}','Andrew','Villalpando','AndrewOVillalpando@dayrep.com','631-589-1280','{"experience":["NY","US","MasterCard","Blue"]}','event0220208316','process0220208316','app0220208301'),
('lin3ea2zRIL','{}','Lisa','Riley','LisaSRiley@dayrep.com','256-653-2776','{"experience":["AL","US","Visa","Blue"]}','event0220208317','process0220208317','app0220208301'),
('man38c6zSUL','{}','Mark','Sullivan','MarkBSullivan@einrot.com','601-978-6248','{"experience":["MS","US","Visa","Red"]}','event0220208318','process0220208318','app0220208301'),
('dona88dzDOC','{}','Donald','Dockins','DonaldTDockins@einrot.com','941-762-4410','{"experience":["FL","US","MasterCard","Brown"]}','event0220208319','process0220208319','app0220208301'),
('cin0c2czSTI','{}','Cindy','Stickland','CindyAStickland@superrito.com','919-380-6946','{"experience":["NC","US","MasterCard","Orange"]}','event0220208320','process0220208320','app0220208301'),
('stn439ezWIL','{}','Steven','Williams','StevenMWilliams@fleckens.hu','603-323-1268','{"experience":["NH","US","MasterCard","Blue"]}','event0220208321','process0220208321','app0220208301'),
('mand3c8zBET','{}','Martha','Betts','MarthaJBetts@einrot.com','212-215-9423','{"experience":["NY","US","Visa","Yellow"]}','event0220208322','process0220208322','app0220208301'),
('joncbd9zMOO','{}','Joseph','Moore','JosephEMoore@dayrep.com','310-865-1599','{"experience":["CA","US","Visa","Blue"]}','event0220208323','process0220208323','app0220208301'),
('sane46fzHOB','{}','Saul','Hobdy','SaulEHobdy@rhyta.com','970-245-0175','{"experience":["CO","US","MasterCard","Brown"]}','event0220208324','process0220208324','app0220208301'),
('shn7fbdzBRO','{}','Shane','Brouillard','ShaneWBrouillard@fleckens.hu','773-281-0637','{"experience":["IL","US","MasterCard","Blue"]}','event0220208325','process0220208325','app0220208301'),
('genf1d1zSKI','{}','George','Skinner','GeorgeHSkinner@dayrep.com','323-301-4762','{"experience":["CA","US","Visa","Blue"]}','event0220208326','process0220208326','app0220208301'),
('grn4834zCAR','{}','Gregory','Carter','GregoryBCarter@cuvox.de','978-253-3724','{"experience":["MA","US","Visa","Blue"]}','event0220208327','process0220208327','app0220208301'),
('dondd11zROB','{}','Donald','Robertson','DonaldTRobertson@dayrep.com','910-714-2151','{"experience":["NC","US","Visa","Blue"]}','event0220208328','process0220208328','app0220208301'),
('den6983zHEN','{}','Deborah','Henderson','DeborahJHenderson@armyspy.com','727-868-5993','{"experience":["FL","US","MasterCard","Blue"]}','event0220208329','process0220208329','app0220208301'),
('eln814dzDOM','{}','Eleanor','Domingues','EleanorRDomingues@gustr.com','269-687-4821','{"experience":["MI","US","Visa","Blue"]}','event0220208330','process0220208330','app0220208301'),
('elnafa4zMAY','{}','Ellen','Mayo','EllenSMayo@fleckens.hu','920-794-6701','{"experience":["WI","US","MasterCard","Blue"]}','event0220208331','process0220208331','app0220208301'),
('jon5612zCAR','{}','Jon','Carnahan','JonSCarnahan@einrot.com','626-666-6403','{"experience":["CA","US","MasterCard","Green"]}','event0220208332','process0220208332','app0220208301'),
('stnb455zOLI','{}','Steven','Oliva','StevenAOliva@jourrapide.com','910-358-3867','{"experience":["NC","US","Visa","Blue"]}','event0220208333','process0220208333','app0220208301'),
('don5345zVAR','{}','Dorothy','Varney','DorothyJVarney@gustr.com','267-808-5662','{"experience":["PA","US","Visa","Black"]}','event0220208334','process0220208334','app0220208301'),
('ronba27zBER','{}','Robert','Berndt','RobertPBerndt@armyspy.com','940-403-6143','{"experience":["TX","US","MasterCard","Blue"]}','event0220208335','process0220208335','app0220208301'),
('ken1e96zLOM','{}','Kenneth','Lomax','KennethDLomax@einrot.com','210-667-7979','{"experience":["TX","US","MasterCard","Black"]}','event0220208336','process0220208336','app0220208301'),
('thn067ezAUS','{}','Theodore','Austin','TheodoreJAustin@rhyta.com','928-207-2999','{"experience":["AZ","US","MasterCard","Green"]}','event0220208337','process0220208337','app0220208301'),
('don509ezSCL','{}','Doris','Sclafani','DorisESclafani@gustr.com','831-229-1386','{"experience":["CA","US","Visa","Red"]}','event0220208338','process0220208338','app0220208301'),
('eln66afzCAI','{}','Elaine','Cain','ElaineSCain@superrito.com','650-738-5244','{"experience":["CA","US","Visa","Blue"]}','event0220208339','process0220208339','app0220208301'),
('pan9f06zMOS','{}','Patricia','Moses','PatriciaDMoses@superrito.com','309-367-4519','{"experience":["IL","US","Visa","Blue"]}','event0220208340','process0220208340','app0220208301'),
('man73ebzTHO','{}','Marina','Thompson','MarinaMThompson@cuvox.de','425-953-0984','{"experience":["WA","US","Visa","Purple"]}','event0220208341','process0220208341','app0220208301'),
('man1795zDOZ','{}','Mary','Dozier','MaryMDozier@fleckens.hu','225-273-0218','{"experience":["LA","US","MasterCard","Black"]}','event0220208342','process0220208342','app0220208301'),
('arnf6d3zGAL','{}','Arthur','Galloway','ArthurHGalloway@einrot.com','414-535-0029','{"experience":["WI","US","MasterCard","Blue"]}','event0220208343','process0220208343','app0220208301'),
('winb3fbzGIL','{}','William','Gillette','WilliamJGillette@cuvox.de','313-642-0292','{"experience":["MI","US","Visa","Blue"]}','event0220208344','process0220208344','app0220208301'),
('can4392zMAT','{}','Carmen','Mathews','CarmenHMathews@teleworm.us','937-618-4488','{"experience":["OH","US","Visa","Purple"]}','event0220208345','process0220208345','app0220208301'),
('fenc6e9zPLA','{}','Felicia','Plante','FeliciaDPlante@rhyta.com','631-233-5046','{"experience":["NY","US","MasterCard","Blue"]}','event0220208346','process0220208346','app0220208301'),
('lan39b4zSMI','{}','Latanya','Smith','LatanyaSSmith@fleckens.hu','360-333-2323','{"experience":["WA","US","Visa","Green"]}','event0220208347','process0220208347','app0220208301'),
('jen1bf8zPAY','{}','Jessica','Payne','JessicaKPayne@armyspy.com','432-520-5438','{"experience":["TX","US","MasterCard","Red"]}','event0220208348','process0220208348','app0220208301'),
('kine007zCOO','{}','Kirk','Cooper','KirkCCooper@fleckens.hu','724-490-5520','{"experience":["PA","US","Visa","Green"]}','event0220208349','process0220208349','app0220208301'),
('sane723zBRO','{}','Sammy','Brooks','SammyLBrooks@superrito.com','305-387-5121','{"experience":["FL","US","Visa","Green"]}','event0220208350','process0220208350','app0220208301'),
('can7903zAVI','{}','Carrie','Avila','CarrieTAvila@fleckens.hu','570-229-8147','{"experience":["PA","US","MasterCard","Red"]}','event0220208351','process0220208351','app0220208301'),
('man4ac2zDAM','{}','Marie','Damico','MarieSDamico@dayrep.com','916-256-9925','{"experience":["CA","US","Visa","Red"]}','event0220208352','process0220208352','app0220208301'),
('mana589zSAX','{}','Maxine','Saxton','MaxineMSaxton@superrito.com','928-332-9141','{"experience":["AZ","US","MasterCard","Black"]}','event0220208353','process0220208353','app0220208301'),
('kanfe13zHOB','{}','Karl','Hobbs','KarlRHobbs@dayrep.com','212-410-3644','{"experience":["NY","US","MasterCard","Red"]}','event0220208354','process0220208354','app0220208301'),
('evnb799zGIL','{}','Eva','Gilbert','EvaCGilbert@einrot.com','970-664-2463','{"experience":["CO","US","Visa","Blue"]}','event0220208355','process0220208355','app0220208301'),
('menf6fdzWAG','{}','Megan','Wagner','MeganMWagner@gustr.com','206-484-4205','{"experience":["WA","US","Visa","Purple"]}','event0220208356','process0220208356','app0220208301'),
('eln4cf3zWES','{}','Eleanor','West','EleanorSWest@superrito.com','813-754-4695','{"experience":["FL","US","Visa","White"]}','event0220208357','process0220208357','app0220208301'),
('junc1d3zSNY','{}','June','Snyder','JuneDSnyder@armyspy.com','337-780-8317','{"experience":["LA","US","Visa","Red"]}','event0220208358','process0220208358','app0220208301'),
('don53fczBRO','{}','Donald','Brock','DonaldJBrock@gustr.com','240-545-4121','{"experience":["MD","US","Visa","Blue"]}','event0220208359','process0220208359','app0220208301'),
('jon23f7zFIE','{}','John','Fields','JohnMFields@teleworm.us','301-835-1926','{"experience":["MD","US","MasterCard","Black"]}','event0220208360','process0220208360','app0220208301'),
('lyna26dzALE','{}','Lynette','Alexander','LynetteLAlexander@fleckens.hu','651-688-8232','{"experience":["MN","US","Visa","Purple"]}','event0220208361','process0220208361','app0220208301'),
('evn588fzTYL','{}','Eve','Tyler','EveLTyler@jourrapide.com','917-538-9328','{"experience":["NY","US","Visa","Purple"]}','event0220208362','process0220208362','app0220208301'),
('linaa09zDOU','{}','Lisa','Douglas','LisaSDouglas@rhyta.com','616-380-2808','{"experience":["MI","US","MasterCard","Yellow"]}','event0220208363','process0220208363','app0220208301'),
('man000fzMAC','{}','Manuel','Machado','ManuelAMachado@dayrep.com','205-565-5937','{"experience":["AL","US","MasterCard","Blue"]}','event0220208364','process0220208364','app0220208301'),
('brnadc7zBRA','{}','Brett','Brandon','BrettDBrandon@einrot.com','508-273-2276','{"experience":["MA","US","Visa","Green"]}','event0220208365','process0220208365','app0220208301'),
('eln08f2zLIN','{}','Ella','Linhart','EllaLLinhart@einrot.com','219-938-6379','{"experience":["IN","US","Visa","Purple"]}','event0220208366','process0220208366','app0220208301'),
('kenfd1azFOX','{}','Kenneth','Foxwell','KennethEFoxwell@cuvox.de','212-357-0939','{"experience":["NY","US","MasterCard","Blue"]}','event0220208367','process0220208367','app0220208301'),
('nonab33zWHI','{}','Norma','White','NormaDWhite@armyspy.com','703-909-4808','{"experience":["VA","US","Visa","Blue"]}','event0220208368','process0220208368','app0220208301'),
('con106azSTR','{}','Connie','Strayhorn','ConnieEStrayhorn@gustr.com','714-777-0257','{"experience":["CA","US","MasterCard","Blue"]}','event0220208369','process0220208369','app0220208301'),
('ten5731zADA','{}','Terri','Adams','TerriJAdams@armyspy.com','803-647-2803','{"experience":["SC","US","MasterCard","Red"]}','event0220208370','process0220208370','app0220208301'),
('vinf1c6zFOU','{}','Virginia','Foust','VirginiaJFoust@teleworm.us','718-278-3655','{"experience":["NY","US","MasterCard","Blue"]}','event0220208371','process0220208371','app0220208301'),
('brn839czGON','{}','Brian','Gonzalez','BrianHGonzalez@dayrep.com','714-791-6391','{"experience":["CA","US","Visa","Green"]}','event0220208372','process0220208372','app0220208301'),
('ban12e1zCAR','{}','Barbara','Cartwright','BarbaraDCartwright@superrito.com','307-389-6769','{"experience":["WY","US","MasterCard","Blue"]}','event0220208373','process0220208373','app0220208301'),
('len57eazCOO','{}','Lena','Cooksey','LenaJCooksey@rhyta.com','317-815-7942','{"experience":["IN","US","MasterCard","Red"]}','event0220208374','process0220208374','app0220208301'),
('ken8804zKEL','{}','Kenneth','Kellar','KennethEKellar@rhyta.com','323-510-8896','{"experience":["CA","US","MasterCard","Green"]}','event0220208375','process0220208375','app0220208301'),
('can6077zSAN','{}','Catherine','Santamaria','CatherineHSantamaria@rhyta.com','417-535-1457','{"experience":["MO","US","Visa","Purple"]}','event0220208376','process0220208376','app0220208301'),
('son0010zWAL','{}','Song','Walker','SongCWalker@jourrapide.com','404-209-0114','{"experience":["GA","US","MasterCard","Red"]}','event0220208377','process0220208377','app0220208301'),
('jen033czBUR','{}','Jean','Burke','JeanCBurke@superrito.com','202-927-9958','{"experience":["DC","US","Visa","Black"]}','event0220208378','process0220208378','app0220208301'),
('gan477czBLA','{}','Gary','Black','GaryABlack@fleckens.hu','231-791-4206','{"experience":["MI","US","Visa","Blue"]}','event0220208379','process0220208379','app0220208301'),
('man0a1czNAL','{}','Mary','Nalley','MaryBNalley@superrito.com','919-771-9739','{"experience":["NC","US","Visa","Blue"]}','event0220208380','process0220208380','app0220208301'),
('ron1cbazALT','{}','Robert','Alton','RobertEAlton@einrot.com','615-683-2537','{"experience":["TN","US","Visa","Red"]}','event0220208381','process0220208381','app0220208301'),
('brn02cfzBOW','{}','Brenda','Bowers','BrendaPBowers@jourrapide.com','317-783-3452','{"experience":["IN","US","Visa","Blue"]}','event0220208382','process0220208382','app0220208301'),
('vin6042zBRI','{}','Violet','Britt','VioletABritt@gustr.com','850-516-0654','{"experience":["FL","US","MasterCard","Purple"]}','event0220208383','process0220208383','app0220208301'),
('stn4ba2zROD','{}','Steve','Rodriguez','SteveCRodriguez@teleworm.us','703-637-9195','{"experience":["VA","US","MasterCard","Blue"]}','event0220208384','process0220208384','app0220208301'),
('scne7dczKIL','{}','Scott','Killion','ScottPKillion@cuvox.de','651-976-8536','{"experience":["MN","US","MasterCard","Green"]}','event0220208385','process0220208385','app0220208301'),
('man2c3dzJOH','{}','Maurice','Johnson','MauriceCJohnson@dayrep.com','706-616-2703','{"experience":["GA","US","Visa","Green"]}','event0220208386','process0220208386','app0220208301'),
('jene0ebzLAW','{}','Jessica','Lawrence','JessicaSLawrence@armyspy.com','302-336-1577','{"experience":["DE","US","MasterCard","Blue"]}','event0220208387','process0220208387','app0220208301'),
('emn61fdzCAR','{}','Emma','Carter','EmmaOCarter@superrito.com','718-501-9557','{"experience":["NY","US","MasterCard","Purple"]}','event0220208388','process0220208388','app0220208301'),
('pan1378zLUC','{}','Patsy','Lucas','PatsyBLucas@einrot.com','301-731-2731','{"experience":["MD","US","MasterCard","Purple"]}','event0220208389','process0220208389','app0220208301'),
('ten6611zMEE','{}','Teresa','Meeks','TeresaGMeeks@armyspy.com','972-992-4336','{"experience":["TX","US","MasterCard","Purple"]}','event0220208390','process0220208390','app0220208301'),
('ren877fzWOO','{}','Regina','Woodford','ReginaKWoodford@armyspy.com','570-729-6253','{"experience":["PA","US","Visa","Purple"]}','event0220208391','process0220208391','app0220208301'),
('sunc96czLAM','{}','Suzanne','Lambert','SuzanneLLambert@gustr.com','808-644-0503','{"experience":["HI","US","Visa","Blue"]}','event0220208392','process0220208392','app0220208301'),
('jon98ebzCRA','{}','Joseph','Cranford','JosephACranford@gustr.com','404-303-7223','{"experience":["GA","US","Visa","Black"]}','event0220208393','process0220208393','app0220208301'),
('clnbdb0zMOO','{}','Clifton','Moore','CliftonTMoore@gustr.com','325-379-3876','{"experience":["TX","US","MasterCard","Blue"]}','event0220208394','process0220208394','app0220208301'),
('ron4d95zSWE','{}','Ronald','Sweatman','RonaldDSweatman@fleckens.hu','207-262-5744','{"experience":["ME","US","Visa","Blue"]}','event0220208395','process0220208395','app0220208301'),
('jon3171zOWE','{}','Jorge','Owens','JorgeLOwens@superrito.com','757-622-2916','{"experience":["VA","US","Visa","Blue"]}','event0220208396','process0220208396','app0220208301'),
('dan13b3zPOH','{}','Daniel','Pohlman','DanielAPohlman@rhyta.com','320-734-9145','{"experience":["MN","US","MasterCard","Silver"]}','event0220208397','process0220208397','app0220208301'),
('ann4d1czALL','{}','Anthony','Allison','AnthonyRAllison@rhyta.com','202-352-0858','{"experience":["DC","US","Visa","Blue"]}','event0220208398','process0220208398','app0220208301'),
('amn4188zGOR','{}','Amalia','Gorman','AmaliaRGorman@jourrapide.com','708-601-4647','{"experience":["IL","US","MasterCard","Purple"]}','event0220208399','process0220208399','app0220208301'),
('nen40e2zSMI','{}','Nellie','Smith','NellieDSmith@superrito.com','417-836-1372','{"experience":["MO","US","MasterCard","Red"]}','event0220208400','process0220208400','app0220208301'),
('lun9872zHUN','{}','Lucille','Hunt','LucilleRHunt@jourrapide.com','703-523-7993','{"experience":["VA","US","MasterCard","Red"]}','event0220208401','process0220208401','app0220208301'),
('pan42e9zWAL','{}','Pamela','Walker','PamelaBWalker@einrot.com','937-947-5935','{"experience":["OH","US","Visa","Purple"]}','event0220208402','process0220208402','app0220208301'),
('jun5265zSIL','{}','Justin','Silvernail','JustinASilvernail@gustr.com','603-663-9765','{"experience":["NH","US","Visa","Blue"]}','event0220208403','process0220208403','app0220208301'),
('cunbe56zGON','{}','Curtis','Gonzalez','CurtisKGonzalez@teleworm.us','816-502-4687','{"experience":["MO","US","MasterCard","Blue"]}','event0220208404','process0220208404','app0220208301'),
('ben6e45zSMI','{}','Beatrice','Smith','BeatriceJSmith@fleckens.hu','607-634-8504','{"experience":["NY","US","Visa","Purple"]}','event0220208405','process0220208405','app0220208301'),
('myn8d22zGOL','{}','Myron','Goldberg','MyronJGoldberg@armyspy.com','630-433-2504','{"experience":["IL","US","MasterCard","Black"]}','event0220208406','process0220208406','app0220208301'),
('can7991zSCH','{}','Cassandra','Schneider','CassandraDSchneider@rhyta.com','610-537-5004','{"experience":["PA","US","MasterCard","Green"]}','event0220208407','process0220208407','app0220208301'),
('thnbcbczTHO','{}','Thomas','Thompson','ThomasPThompson@teleworm.us','406-424-3198','{"experience":["MT","US","Visa","Blue"]}','event0220208408','process0220208408','app0220208301'),
('ren2f20zHEI','{}','Rebecca','Heiser','RebeccaRHeiser@cuvox.de','256-751-9877','{"experience":["AL","US","MasterCard","Blue"]}','event0220208409','process0220208409','app0220208301'),
('rane01fzHIL','{}','Ramona','Hill','RamonaJHill@dayrep.com','212-626-9266','{"experience":["NY","US","Visa","Purple"]}','event0220208410','process0220208410','app0220208301'),
('non86c8zLEW','{}','Norma','Lewis','NormaDLewis@teleworm.us','765-779-5322','{"experience":["IN","US","MasterCard","Purple"]}','event0220208411','process0220208411','app0220208301'),
('lin2011zDAV','{}','Linda','Davis','LindaTDavis@rhyta.com','301-813-5495','{"experience":["MD","US","Visa","Purple"]}','event0220208412','process0220208412','app0220208301'),
('ken9fcezCOS','{}','Kesha','Cosey','KeshaRCosey@fleckens.hu','719-266-5728','{"experience":["CO","US","MasterCard","Blue"]}','event0220208413','process0220208413','app0220208301'),
('dan04f1zBON','{}','Damon','Boner','DamonEBoner@fleckens.hu','678-378-0863','{"experience":["GA","US","MasterCard","Blue"]}','event0220208414','process0220208414','app0220208301'),
('ren4809zLOG','{}','Rebecca','Loggins','RebeccaBLoggins@cuvox.de','609-304-8039','{"experience":["NJ","US","Visa","Red"]}','event0220208415','process0220208415','app0220208301'),
('joncf75zMCK','{}','Joseph','McKenzie','JosephPMcKenzie@dayrep.com','773-393-9263','{"experience":["IL","US","Visa","Blue"]}','event0220208416','process0220208416','app0220208301'),
('rin14b7zWOO','{}','Richard','Woosley','RichardLWoosley@gustr.com','954-755-9924','{"experience":["FL","US","MasterCard","Blue"]}','event0220208417','process0220208417','app0220208301'),
('asnb2aezKAN','{}','Ashleigh','Kane','AshleighHKane@cuvox.de','240-327-7975','{"experience":["MD","US","MasterCard","Blue"]}','event0220208418','process0220208418','app0220208301'),
('rand6bazMCQ','{}','Rachel','McQueen','RachelRMcQueen@armyspy.com','715-707-5059','{"experience":["WI","US","MasterCard","Red"]}','event0220208419','process0220208419','app0220208301'),
('jon6493zEVA','{}','John','Evans','JohnVEvans@gustr.com','773-361-1771','{"experience":["IL","US","MasterCard","Blue"]}','event0220208420','process0220208420','app0220208301'),
('denf879zDAV','{}','Dennis','Davis','DennisGDavis@teleworm.us','509-553-3116','{"experience":["WA","US","MasterCard","Orange"]}','event0220208421','process0220208421','app0220208301'),
('tan79d4zCRU','{}','Tamika','Crump','TamikaPCrump@dayrep.com','603-268-4112','{"experience":["NH","US","Visa","Purple"]}','event0220208422','process0220208422','app0220208301'),
('cln8750zTHO','{}','Clifford','Thompson','CliffordEThompson@gustr.com','801-482-0788','{"experience":["UT","US","MasterCard","Blue"]}','event0220208423','process0220208423','app0220208301'),
('krn711dzTHO','{}','Kristy','Thompson','KristyAThompson@teleworm.us','301-713-8208','{"experience":["MD","US","Visa","Purple"]}','event0220208424','process0220208424','app0220208301'),
('kan9e5bzBIL','{}','Karen','Bilderback','KarenJBilderback@rhyta.com','404-932-1630','{"experience":["GA","US","Visa","Purple"]}','event0220208425','process0220208425','app0220208301'),
('phn12cbzCUB','{}','Phillip','Cubbage','PhillipJCubbage@einrot.com','541-736-3219','{"experience":["OR","US","Visa","Blue"]}','event0220208426','process0220208426','app0220208301'),
('jon1f8dzODO','{}','John','ODonnell','JohnLODonnell@jourrapide.com','440-599-1837','{"experience":["OH","US","MasterCard","Blue"]}','event0220208427','process0220208427','app0220208301'),
('mina8c5zKNE','{}','Michael','Knecht','MichaelAKnecht@gustr.com','518-625-3583','{"experience":["NY","US","Visa","White"]}','event0220208428','process0220208428','app0220208301'),
('trn3ffazBRI','{}','Tresa','Britt','TresaJBritt@rhyta.com','713-812-5175','{"experience":["TX","US","MasterCard","Green"]}','event0220208429','process0220208429','app0220208301'),
('jonc986zMCC','{}','Joseph','McCoy','JosephAMcCoy@armyspy.com','831-653-9848','{"experience":["CA","US","MasterCard","Black"]}','event0220208430','process0220208430','app0220208301'),
('jon5469zDAN','{}','John','Dant','JohnLDant@jourrapide.com','864-290-9408','{"experience":["SC","US","MasterCard","Blue"]}','event0220208431','process0220208431','app0220208301'),
('min6730zCUO','{}','Miguel','Cuomo','MiguelSCuomo@dayrep.com','308-652-8339','{"experience":["NE","US","MasterCard","Green"]}','event0220208432','process0220208432','app0220208301'),
('can1519zHAR','{}','Carl','Hardy','CarlAHardy@gustr.com','775-290-7902','{"experience":["NV","US","MasterCard","Blue"]}','event0220208433','process0220208433','app0220208301'),
('tinb83czCON','{}','Timothy','Conn','TimothyNConn@superrito.com','518-833-7994','{"experience":["NY","US","MasterCard","Red"]}','event0220208434','process0220208434','app0220208301'),
('chn4e3dzBUS','{}','Christopher','Bush','ChristopherJBush@cuvox.de','509-581-7296','{"experience":["WA","US","Visa","Red"]}','event0220208435','process0220208435','app0220208301'),
('fen4444zMEN','{}','Felipe','Mendoza','FelipeMMendoza@dayrep.com','847-553-8100','{"experience":["IL","US","Visa","White"]}','event0220208436','process0220208436','app0220208301'),
('ann5be6zTOY','{}','Andrea','Toy','AndreaCToy@jourrapide.com','951-283-9676','{"experience":["CA","US","Visa","Green"]}','event0220208437','process0220208437','app0220208301'),
('jin1311zHOP','{}','Jimmy','Hopkins','JimmyDHopkins@superrito.com','330-524-1810','{"experience":["OH","US","MasterCard","Blue"]}','event0220208438','process0220208438','app0220208301'),
('grnc4bfzEMA','{}','Grace','Emanuel','GraceCEmanuel@rhyta.com','830-239-8993','{"experience":["TX","US","MasterCard","Black"]}','event0220208439','process0220208439','app0220208301'),
('ran8a13zBEA','{}','Ramon','Beazley','RamonJBeazley@einrot.com','256-963-6559','{"experience":["AL","US","MasterCard","Blue"]}','event0220208440','process0220208440','app0220208301'),
('mind050zMUR','{}','Michael','Murphy','MichaelDMurphy@dayrep.com','702-340-3863','{"experience":["NV","US","Visa","Green"]}','event0220208441','process0220208441','app0220208301'),
('ern56fbzGAR','{}','Erwin','Garcia','ErwinMGarcia@einrot.com','714-235-3257','{"experience":["CA","US","Visa","Blue"]}','event0220208442','process0220208442','app0220208301'),
('jonac6ezPOM','{}','John','Pomeroy','JohnRPomeroy@fleckens.hu','978-866-7613','{"experience":["MA","US","MasterCard","Blue"]}','event0220208443','process0220208443','app0220208301'),
('bance05zSMI','{}','Barbara','Smith','BarbaraBSmith@jourrapide.com','928-707-4205','{"experience":["AZ","US","Visa","White"]}','event0220208444','process0220208444','app0220208301'),
('lonbcbazCOR','{}','Lonna','Cortes','LonnaWCortes@rhyta.com','248-606-0121','{"experience":["MI","US","Visa","Purple"]}','event0220208445','process0220208445','app0220208301'),
('dan155czWAL','{}','David','Walker','DavidJWalker@superrito.com','267-275-3465','{"experience":["PA","US","MasterCard","Silver"]}','event0220208446','process0220208446','app0220208301'),
('jen3db4zTUC','{}','Jeff','Tucker','JeffETucker@cuvox.de','601-829-0504','{"experience":["MS","US","MasterCard","Blue"]}','event0220208447','process0220208447','app0220208301'),
('nan373ezCRO','{}','Nancy','Cross','NancyACross@dayrep.com','802-722-1454','{"experience":["VT","US","MasterCard","Blue"]}','event0220208448','process0220208448','app0220208301'),
('lan09e3zLUC','{}','Lauren','Lucas','LaurenSLucas@gustr.com','708-870-1103','{"experience":["IL","US","MasterCard","Blue"]}','event0220208449','process0220208449','app0220208301'),
('juneb50zAUS','{}','Juan','Austin','JuanSAustin@cuvox.de','276-531-6704','{"experience":["VA","US","Visa","Blue"]}','event0220208450','process0220208450','app0220208301'),
('dan00aazLOP','{}','Danny','Lopez','DannyTLopez@superrito.com','573-304-8941','{"experience":["MO","US","MasterCard","Silver"]}','event0220208451','process0220208451','app0220208301'),
('aln0e14zTAY','{}','Alice','Taylor','AliceDTaylor@dayrep.com','336-316-3519','{"experience":["NC","US","Visa","Blue"]}','event0220208452','process0220208452','app0220208301'),
('ran1c3bzNUN','{}','Ralph','Nunez','RalphMNunez@fleckens.hu','805-798-9704','{"experience":["CA","US","MasterCard","Orange"]}','event0220208453','process0220208453','app0220208301'),
('byn9db8zSET','{}','Byron','Setzer','ByronJSetzer@armyspy.com','719-288-4294','{"experience":["CO","US","MasterCard","Blue"]}','event0220208454','process0220208454','app0220208301'),
('tan89ddzGON','{}','Tamie','Gonzalez','TamieMGonzalez@dayrep.com','413-612-3083','{"experience":["MA","US","Visa","Purple"]}','event0220208455','process0220208455','app0220208301'),
('venc367zORT','{}','Verna','Ortiz','VernaMOrtiz@teleworm.us','401-314-4477','{"experience":["RI","US","MasterCard","Blue"]}','event0220208456','process0220208456','app0220208301'),
('can1edbzPET','{}','Carol','Peterson','CarolRPeterson@jourrapide.com','661-948-5342','{"experience":["CA","US","Visa","Blue"]}','event0220208457','process0220208457','app0220208301'),
('aln575bzWAR','{}','Alma','Ward','AlmaCWard@jourrapide.com','330-444-2684','{"experience":["OH","US","Visa","Purple"]}','event0220208458','process0220208458','app0220208301'),
('dinef65zCOL','{}','Diane','Colunga','DianeJColunga@armyspy.com','513-277-4940','{"experience":["OH","US","Visa","Purple"]}','event0220208459','process0220208459','app0220208301'),
('inn38e3zIBA','{}','Ingrid','Ibarra','IngridKIbarra@fleckens.hu','919-801-6127','{"experience":["NC","US","MasterCard","Black"]}','event0220208460','process0220208460','app0220208301'),
('pen3c60zROG','{}','Pedro','Rogers','PedroRRogers@teleworm.us','775-245-8486','{"experience":["NV","US","Visa","Orange"]}','event0220208461','process0220208461','app0220208301'),
('jan1fdczSTA','{}','James','Starks','JamesMStarks@einrot.com','731-669-4892','{"experience":["TN","US","MasterCard","Silver"]}','event0220208462','process0220208462','app0220208301'),
('agnaa57zMON','{}','Agustina','Montgomery','AgustinaJMontgomery@einrot.com','765-760-5113','{"experience":["IN","US","Visa","Black"]}','event0220208463','process0220208463','app0220208301'),
('henb97czLEE','{}','Heidy','Lee','HeidyLLee@fleckens.hu','214-261-6998','{"experience":["TX","US","Visa","Blue"]}','event0220208464','process0220208464','app0220208301'),
('len7119zGIL','{}','Leslie','Gillis','LeslieKGillis@dayrep.com','214-202-4612','{"experience":["TX","US","Visa","Silver"]}','event0220208465','process0220208465','app0220208301'),
('jon3030zWAL','{}','John','Wallace','JohnCWallace@armyspy.com','806-722-3666','{"experience":["TX","US","MasterCard","Blue"]}','event0220208466','process0220208466','app0220208301'),
('chn0f60zSMI','{}','Charlie','Smith','CharlieSSmith@superrito.com','701-642-6699','{"experience":["ND","US","Visa","Blue"]}','event0220208467','process0220208467','app0220208301'),
('man611fzKIR','{}','Margaret','Kirk','MargaretJKirk@armyspy.com','586-986-7453','{"experience":["MI","US","Visa","Blue"]}','event0220208468','process0220208468','app0220208301'),
('mine8afzBEA','{}','Michael','Beal','MichaelBBeal@teleworm.us','518-377-5420','{"experience":["NY","US","Visa","Blue"]}','event0220208469','process0220208469','app0220208301'),
('shnb63fzJOH','{}','Sharyn','Johnson','SharynMJohnson@rhyta.com','785-949-0046','{"experience":["KS","US","Visa","Blue"]}','event0220208470','process0220208470','app0220208301'),
('jona248zSHE','{}','Joe','Sheats','JoeRSheats@armyspy.com','619-282-7534','{"experience":["CA","US","MasterCard","Red"]}','event0220208471','process0220208471','app0220208301'),
('bond58dzMOR','{}','Bonnie','Moreno','BonnieNMoreno@armyspy.com','304-283-4151','{"experience":["WV","US","MasterCard","Green"]}','event0220208472','process0220208472','app0220208301'),
('edn5ed2zTHO','{}','Edna','Thompson','EdnaMThompson@superrito.com','309-768-6406','{"experience":["IL","US","MasterCard","Green"]}','event0220208473','process0220208473','app0220208301'),
('runbf53zHIR','{}','Russell','Hirth','RussellDHirth@dayrep.com','207-825-2832','{"experience":["ME","US","Visa","Blue"]}','event0220208474','process0220208474','app0220208301'),
('san9871zSHI','{}','Sandra','Shimer','SandraTShimer@cuvox.de','314-445-9646','{"experience":["MO","US","Visa","Blue"]}','event0220208475','process0220208475','app0220208301'),
('jen772fzBUN','{}','Jessica','Bunch','JessicaSBunch@gustr.com','863-655-1333','{"experience":["FL","US","Visa","Red"]}','event0220208476','process0220208476','app0220208301'),
('pan9d79zGAU','{}','Pamela','Gault','PamelaRGault@superrito.com','303-662-9238','{"experience":["CO","US","MasterCard","Green"]}','event0220208477','process0220208477','app0220208301'),
('jon1447zMAT','{}','John','Mathews','JohnJMathews@superrito.com','806-925-2218','{"experience":["TX","US","Visa","Silver"]}','event0220208478','process0220208478','app0220208301'),
('adne66ezWAR','{}','Adam','Ward','AdamOWard@armyspy.com','951-431-6675','{"experience":["CA","US","MasterCard","Blue"]}','event0220208479','process0220208479','app0220208301'),
('don3d92zMCD','{}','Dorothy','McDonald','DorothyRMcDonald@cuvox.de','765-475-3630','{"experience":["IN","US","MasterCard","Green"]}','event0220208480','process0220208480','app0220208301'),
('rin4dabzKEN','{}','Rick','Kenny','RickSKenny@einrot.com','507-744-1561','{"experience":["MN","US","Visa","Blue"]}','event0220208481','process0220208481','app0220208301'),
('penc363zROW','{}','Pearly','Rowe','PearlyGRowe@dayrep.com','219-224-9847','{"experience":["IN","US","Visa","Blue"]}','event0220208482','process0220208482','app0220208301'),
('can719czTHO','{}','Carolyn','Thomas','CarolynAThomas@cuvox.de','512-517-0710','{"experience":["TX","US","Visa","Blue"]}','event0220208483','process0220208483','app0220208301'),
('roncdbbzARN','{}','Rosa','Arnold','RosaCArnold@einrot.com','702-422-1868','{"experience":["NV","US","MasterCard","Brown"]}','event0220208484','process0220208484','app0220208301'),
('edndf1dzBAN','{}','Edna','Bannister','EdnaTBannister@einrot.com','573-351-1381','{"experience":["MO","US","MasterCard","Blue"]}','event0220208485','process0220208485','app0220208301'),
('ronf4ddzMON','{}','Robert','Monroe','RobertBMonroe@fleckens.hu','507-263-7399','{"experience":["MN","US","Visa","Black"]}','event0220208486','process0220208486','app0220208301'),
('jen136azSTE','{}','Jean','Stewart','JeanGStewart@armyspy.com','320-216-3544','{"experience":["MN","US","MasterCard","Blue"]}','event0220208487','process0220208487','app0220208301'),
('pancba0zSHI','{}','Pamela','Shields','PamelaGShields@dayrep.com','845-620-1135','{"experience":["NY","US","MasterCard","Blue"]}','event0220208488','process0220208488','app0220208301'),
('jan0c94zMEN','{}','James','Mendes','JamesJMendes@teleworm.us','309-695-7061','{"experience":["IL","US","MasterCard","Orange"]}','event0220208489','process0220208489','app0220208301'),
('kan6ba2zSMI','{}','Kathleen','Smith','KathleenTSmith@rhyta.com','601-946-4559','{"experience":["MS","US","MasterCard","Blue"]}','event0220208490','process0220208490','app0220208301'),
('jon0282zSMI','{}','Johnny','Smith','JohnnyKSmith@cuvox.de','415-434-7331','{"experience":["CA","US","Visa","Red"]}','event0220208491','process0220208491','app0220208301'),
('jan517czRIS','{}','Jack','Rister','JackJRister@cuvox.de','207-482-5613','{"experience":["ME","US","Visa","Blue"]}','event0220208492','process0220208492','app0220208301'),
('bena275zMYE','{}','Betty','Myers','BettyRMyers@armyspy.com','302-428-0979','{"experience":["DE","US","MasterCard","Green"]}','event0220208493','process0220208493','app0220208301'),
('mande68zLAN','{}','Marc','Langston','MarcCLangston@rhyta.com','586-832-5364','{"experience":["MI","US","Visa","Blue"]}','event0220208494','process0220208494','app0220208301'),
('vin9b3fzCER','{}','Virginia','Cerda','VirginiaRCerda@armyspy.com','312-444-6685','{"experience":["IL","US","Visa","Red"]}','event0220208495','process0220208495','app0220208301'),
('kan02dbzBEE','{}','Kathrin','Beene','KathrinDBeene@cuvox.de','708-278-9590','{"experience":["IL","US","MasterCard","Blue"]}','event0220208496','process0220208496','app0220208301'),
('tenfc8ezNEI','{}','Terrence','Neill','TerrenceVNeill@superrito.com','505-638-8906','{"experience":["NM","US","MasterCard","Blue"]}','event0220208497','process0220208497','app0220208301'),
('cln1a7azCHE','{}','Claudia','Chew','ClaudiaRChew@cuvox.de','931-328-2243','{"experience":["TN","US","Visa","Blue"]}','event0220208498','process0220208498','app0220208301'),
('frn3334zBOW','{}','Frank','Bowles','FrankJBowles@cuvox.de','919-373-2675','{"experience":["NC","US","Visa","Blue"]}','event0220208499','process0220208499','app0220208301'),
('ron7a81zBOH','{}','Rose','Bohn','RoseLBohn@jourrapide.com','205-347-3940','{"experience":["AL","US","MasterCard","Red"]}','event0220208500','process0220208500','app0220208301'),
('rona543zMAY','{}','Rosa','Maynard','RosaWMaynard@gustr.com','786-985-8336','{"experience":["FL","US","MasterCard","Purple"]}','event0220208501','process0220208501','app0220208301'),
('dan4b7bzBAR','{}','David','Barr','DavidPBarr@armyspy.com','559-200-2381','{"experience":["CA","US","Visa","Blue"]}','event0220208502','process0220208502','app0220208301'),
('thn09f5zJEN','{}','Thomas','Jenkins','ThomasJJenkins@teleworm.us','567-232-3239','{"experience":["OH","US","Visa","Blue"]}','event0220208503','process0220208503','app0220208301'),
('gan8754zGUY','{}','Gary','Guy','GaryKGuy@jourrapide.com','248-895-1513','{"experience":["MI","US","Visa","Blue"]}','event0220208504','process0220208504','app0220208301'),
('janc3dczCLA','{}','James','Clark','JamesAClark@einrot.com','614-729-7363','{"experience":["OH","US","MasterCard","Blue"]}','event0220208505','process0220208505','app0220208301'),
('jen97a5zWEB','{}','Jesse','Webb','JesseCWebb@cuvox.de','218-893-2737','{"experience":["MN","US","MasterCard","Blue"]}','event0220208506','process0220208506','app0220208301'),
('gen22bczROR','{}','George','Rorie','GeorgeVRorie@superrito.com','973-432-1630','{"experience":["NJ","US","MasterCard","Blue"]}','event0220208507','process0220208507','app0220208301'),
('ken99fbzLEN','{}','Kevin','Lenz','KevinALenz@gustr.com','218-665-2919','{"experience":["MN","US","MasterCard","Brown"]}','event0220208508','process0220208508','app0220208301'),
('min74efzSIT','{}','Miranda','Sitz','MirandaJSitz@einrot.com','774-488-7889','{"experience":["MA","US","MasterCard","White"]}','event0220208509','process0220208509','app0220208301'),
('ninae83zEIL','{}','Nicole','Eiler','NicoleDEiler@superrito.com','989-741-2951','{"experience":["MI","US","Visa","Black"]}','event0220208510','process0220208510','app0220208301'),
('don6170zSCH','{}','Donald','Schrum','DonaldCSchrum@gustr.com','847-562-8319','{"experience":["IL","US","MasterCard","Brown"]}','event0220208511','process0220208511','app0220208301'),
('panf347zALE','{}','Patricia','Alexander','PatriciaJAlexander@rhyta.com','814-489-3673','{"experience":["PA","US","Visa","Black"]}','event0220208512','process0220208512','app0220208301'),
('kan560fzWAS','{}','Kathy','Wasson','KathyNWasson@teleworm.us','949-622-5415','{"experience":["CA","US","MasterCard","Green"]}','event0220208513','process0220208513','app0220208301'),
('donfd55zSHA','{}','Don','Shaw','DonNShaw@gustr.com','440-843-0572','{"experience":["OH","US","Visa","Red"]}','event0220208514','process0220208514','app0220208301'),
('ben75dazMOS','{}','Bernard','Mosley','BernardSMosley@dayrep.com','503-835-0415','{"experience":["OR","US","Visa","Black"]}','event0220208515','process0220208515','app0220208301'),
('ken09dazMON','{}','Kelly','Monroe','KellyNMonroe@rhyta.com','915-594-4965','{"experience":["TX","US","Visa","Blue"]}','event0220208516','process0220208516','app0220208301'),
('renc4b9zBON','{}','Rebekah','Bonelli','RebekahRBonelli@dayrep.com','541-616-3167','{"experience":["OR","US","Visa","Red"]}','event0220208517','process0220208517','app0220208301'),
('londc90zGIL','{}','Loretta','Gilkey','LorettaEGilkey@superrito.com','817-726-2595','{"experience":["TX","US","MasterCard","Black"]}','event0220208518','process0220208518','app0220208301'),
('don2ed7zMCC','{}','Dorothy','McCall','DorothyJMcCall@rhyta.com','920-234-9049','{"experience":["WI","US","Visa","Yellow"]}','event0220208519','process0220208519','app0220208301'),
('sun691czSAE','{}','Susan','Saenz','SusanJSaenz@rhyta.com','641-533-2108','{"experience":["IA","US","Visa","Blue"]}','event0220208520','process0220208520','app0220208301'),
('wane1abzHAR','{}','Wanda','Harvey','WandaRHarvey@rhyta.com','650-538-1457','{"experience":["CA","US","MasterCard","Blue"]}','event0220208521','process0220208521','app0220208301'),
('jan7387zCAR','{}','Janet','Carrington','JanetMCarrington@jourrapide.com','937-223-7820','{"experience":["OH","US","Visa","Blue"]}','event0220208522','process0220208522','app0220208301'),
('erne7c5zALL','{}','Erik','Allen','ErikMAllen@einrot.com','313-917-1858','{"experience":["MI","US","Visa","Blue"]}','event0220208523','process0220208523','app0220208301'),
('lenae13zARM','{}','Leroy','Armstrong','LeroyDArmstrong@teleworm.us','267-479-3727','{"experience":["PA","US","Visa","Blue"]}','event0220208524','process0220208524','app0220208301'),
('rin06bbzSTO','{}','Rico','Stowe','RicoCStowe@fleckens.hu','715-314-3308','{"experience":["WI","US","MasterCard","Blue"]}','event0220208525','process0220208525','app0220208301'),
('hene120zCOR','{}','Helen','Corbin','HelenKCorbin@cuvox.de','301-567-2832','{"experience":["MD","US","MasterCard","Green"]}','event0220208526','process0220208526','app0220208301'),
('asnb301zDEA','{}','Ashley','Deaton','AshleyJDeaton@armyspy.com','602-476-4269','{"experience":["AZ","US","MasterCard","Purple"]}','event0220208527','process0220208527','app0220208301'),
('san7ea8zVAL','{}','Sara','Valencia','SaraJValencia@cuvox.de','989-479-7224','{"experience":["MI","US","Visa","Red"]}','event0220208528','process0220208528','app0220208301'),
('isnc0a0zCOO','{}','Israel','Coons','IsraelMCoons@armyspy.com','505-223-8796','{"experience":["NM","US","Visa","Green"]}','event0220208529','process0220208529','app0220208301'),
('win768ezTAS','{}','William','Tassone','WilliamDTassone@jourrapide.com','212-370-1712','{"experience":["NY","US","MasterCard","Green"]}','event0220208530','process0220208530','app0220208301'),
('alnfb37zMUR','{}','Alicia','Murray','AliciaVMurray@einrot.com','925-899-1735','{"experience":["CA","US","MasterCard","Brown"]}','event0220208531','process0220208531','app0220208301'),
('cln2148zWEB','{}','Clyde','Webb','ClydeCWebb@teleworm.us','972-203-6984','{"experience":["TX","US","MasterCard","Black"]}','event0220208532','process0220208532','app0220208301'),
('nanad74zWEA','{}','Naomi','Weaver','NaomiSWeaver@teleworm.us','760-590-0482','{"experience":["CA","US","MasterCard","Green"]}','event0220208533','process0220208533','app0220208301'),
('cyn4877zNOR','{}','Cynthia','Norman','CynthiaJNorman@superrito.com','650-749-7559','{"experience":["CA","US","MasterCard","Blue"]}','event0220208534','process0220208534','app0220208301'),
('dan52f9zSWA','{}','David','Swann','DavidMSwann@dayrep.com','908-668-5926','{"experience":["NJ","US","Visa","Red"]}','event0220208535','process0220208535','app0220208301'),
('elnbbcazSTE','{}','Eleanor','Stephens','EleanorLStephens@cuvox.de','804-234-3156','{"experience":["VA","US","Visa","Blue"]}','event0220208536','process0220208536','app0220208301'),
('dona9b2zCLA','{}','Donald','Clayton','DonaldAClayton@jourrapide.com','602-901-6460','{"experience":["AZ","US","Visa","Red"]}','event0220208537','process0220208537','app0220208301'),
('chnd4f4zWAG','{}','Christina','Waggoner','ChristinaEWaggoner@superrito.com','770-879-2108','{"experience":["GA","US","Visa","Blue"]}','event0220208538','process0220208538','app0220208301'),
('stn2bb3zROB','{}','Stephanie','Robinson','StephanieHRobinson@gustr.com','910-378-0187','{"experience":["NC","US","MasterCard","Purple"]}','event0220208539','process0220208539','app0220208301'),
('wan9213zNOR','{}','Walter','Norwood','WalterJNorwood@cuvox.de','864-234-6009','{"experience":["SC","US","MasterCard","Blue"]}','event0220208540','process0220208540','app0220208301'),
('nanc373zBRO','{}','Nathan','Brown','NathanJBrown@einrot.com','303-486-4417','{"experience":["CO","US","MasterCard","Blue"]}','event0220208541','process0220208541','app0220208301'),
('tin8b90zGIL','{}','Tiana','Gil','TianaJGil@rhyta.com','443-203-7347','{"experience":["MD","US","MasterCard","Blue"]}','event0220208542','process0220208542','app0220208301'),
('chn5d02zMCC','{}','Christopher','McClintock','ChristopherPMcClintock@armyspy.com','402-838-9992','{"experience":["NE","US","MasterCard","Green"]}','event0220208543','process0220208543','app0220208301'),
('vin1b6bzPAU','{}','Viola','Pauline','ViolaTPauline@fleckens.hu','562-274-6413','{"experience":["CA","US","MasterCard","Purple"]}','event0220208544','process0220208544','app0220208301'),
('jon0ff2zBOY','{}','Jose','Boyd','JosePBoyd@jourrapide.com','336-886-2437','{"experience":["NC","US","Visa","Blue"]}','event0220208545','process0220208545','app0220208301'),
('jana81azHEL','{}','Jack','Helton','JackMHelton@jourrapide.com','828-272-4409','{"experience":["NC","US","Visa","Blue"]}','event0220208546','process0220208546','app0220208301'),
('pen3554zGAR','{}','Peter','Garlow','PeterFGarlow@jourrapide.com','816-443-8412','{"experience":["MO","US","Visa","Brown"]}','event0220208547','process0220208547','app0220208301'),
('junbf29zMOR','{}','Julie','Morris','JulieTMorris@superrito.com','239-344-8012','{"experience":["FL","US","MasterCard","Blue"]}','event0220208548','process0220208548','app0220208301'),
('cancf3fzMOR','{}','Carolyn','Morris','CarolynKMorris@jourrapide.com','703-400-3309','{"experience":["VA","US","MasterCard","Blue"]}','event0220208549','process0220208549','app0220208301'),
('vin4e98zCAS','{}','Vincent','Cash','VincentRCash@jourrapide.com','606-669-4583','{"experience":["KY","US","MasterCard","Red"]}','event0220208550','process0220208550','app0220208301'),
('win1d9ezMUR','{}','William','Murchison','WilliamMMurchison@superrito.com','605-473-2224','{"experience":["SD","US","MasterCard","Blue"]}','event0220208551','process0220208551','app0220208301'),
('man98f1zCRU','{}','Mary','Crumb','MaryDCrumb@armyspy.com','712-574-9318','{"experience":["IA","US","MasterCard","Green"]}','event0220208552','process0220208552','app0220208301'),
('cln43cbzGRU','{}','Clark','Grundy','ClarkPGrundy@jourrapide.com','815-336-4671','{"experience":["IL","US","MasterCard","Green"]}','event0220208553','process0220208553','app0220208301'),
('manfee2zAAS','{}','Marisa','Aasen','MarisaAAasen@jourrapide.com','507-287-2713','{"experience":["MN","US","MasterCard","Blue"]}','event0220208554','process0220208554','app0220208301'),
('stnaf6ezGLA','{}','Stephanie','Glasco','StephanieJGlasco@einrot.com','971-205-3477','{"experience":["OR","US","MasterCard","Green"]}','event0220208555','process0220208555','app0220208301'),
('dand4cczHAN','{}','Dana','Hansen','DanaLHansen@jourrapide.com','251-676-7465','{"experience":["AL","US","Visa","Blue"]}','event0220208556','process0220208556','app0220208301'),
('thnc94azCOW','{}','Thomas','Cowgill','ThomasDCowgill@jourrapide.com','701-846-6572','{"experience":["ND","US","MasterCard","Orange"]}','event0220208557','process0220208557','app0220208301'),
('chn2df1zBAB','{}','Christie','Baber','ChristieWBaber@armyspy.com','541-881-3685','{"experience":["OR","US","Visa","Orange"]}','event0220208558','process0220208558','app0220208301'),
('ronc5b5zUND','{}','Robert','Underwood','RobertEUnderwood@teleworm.us','248-375-4618','{"experience":["MI","US","MasterCard","Green"]}','event0220208559','process0220208559','app0220208301'),
('aunf519zBEL','{}','Autumn','Bell','AutumnJBell@armyspy.com','415-737-6134','{"experience":["CA","US","MasterCard","Red"]}','event0220208560','process0220208560','app0220208301'),
('gwn355ezWIL','{}','Gwen','Wilson','GwenRWilson@armyspy.com','315-457-8945','{"experience":["NY","US","MasterCard","Purple"]}','event0220208561','process0220208561','app0220208301'),
('winb8b6zWAL','{}','William','Wallace','WilliamTWallace@einrot.com','252-473-0111','{"experience":["NC","US","MasterCard","Black"]}','event0220208562','process0220208562','app0220208301'),
('jen1aefzMCC','{}','Jessica','McCormick','JessicaRMcCormick@superrito.com','760-896-3463','{"experience":["CA","US","MasterCard","Black"]}','event0220208563','process0220208563','app0220208301'),
('can043czKUH','{}','Carroll','Kuhns','CarrollLKuhns@dayrep.com','609-404-2548','{"experience":["NJ","US","Visa","Purple"]}','event0220208564','process0220208564','app0220208301'),
('denacddzMAR','{}','Dennis','Marlowe','DennisDMarlowe@einrot.com','270-355-5022','{"experience":["KY","US","Visa","Blue"]}','event0220208565','process0220208565','app0220208301'),
('manc237zECK','{}','Maria','Eckart','MariaREckart@dayrep.com','410-647-1466','{"experience":["MD","US","MasterCard","Green"]}','event0220208566','process0220208566','app0220208301'),
('sanb868zHUN','{}','Sam','Hunt','SamEHunt@teleworm.us','715-238-1699','{"experience":["WI","US","MasterCard","Silver"]}','event0220208567','process0220208567','app0220208301'),
('dona0d1zSCH','{}','Dorothy','Schwartz','DorothyFSchwartz@rhyta.com','757-200-4072','{"experience":["VA","US","Visa","Orange"]}','event0220208568','process0220208568','app0220208301'),
('man3fdezELI','{}','Mark','Elia','MarkDElia@superrito.com','815-587-2570','{"experience":["IL","US","Visa","Blue"]}','event0220208569','process0220208569','app0220208301'),
('man71b5zWEB','{}','Mabel','Webb','MabelCWebb@dayrep.com','559-565-5885','{"experience":["CA","US","Visa","Green"]}','event0220208570','process0220208570','app0220208301'),
('ben9913zSMI','{}','Bettye','Smith','BettyeMSmith@einrot.com','541-212-0609','{"experience":["OR","US","Visa","Purple"]}','event0220208571','process0220208571','app0220208301'),
('yvn8264zWIN','{}','Yvonne','Wing','YvonneGWing@jourrapide.com','320-308-7214','{"experience":["MN","US","Visa","Purple"]}','event0220208572','process0220208572','app0220208301'),
('lynf956zMIL','{}','Lynn','Miller','LynnKMiller@einrot.com','978-253-1123','{"experience":["MA","US","MasterCard","Red"]}','event0220208573','process0220208573','app0220208301'),
('aan7772zSHO','{}','Aaron','Shores','AaronEShores@dayrep.com','206-986-9076','{"experience":["WA","US","Visa","Blue"]}','event0220208574','process0220208574','app0220208301'),
('ben4538zCAR','{}','Betty','Carrasco','BettyJCarrasco@superrito.com','252-944-8425','{"experience":["NC","US","MasterCard","Blue"]}','event0220208575','process0220208575','app0220208301'),
('jon0a12zNEV','{}','Jose','Nevarez','JoseSNevarez@einrot.com','973-902-3797','{"experience":["NJ","US","Visa","Blue"]}','event0220208576','process0220208576','app0220208301'),
('dan76c7zVAL','{}','David','Valentino','DavidNValentino@gustr.com','636-459-7057','{"experience":["MO","US","MasterCard","Blue"]}','event0220208577','process0220208577','app0220208301'),
('ernbbbdzKIM','{}','Eric','Kime','EricDKime@jourrapide.com','774-221-0327','{"experience":["MA","US","Visa","Black"]}','event0220208578','process0220208578','app0220208301'),
('gen1597zLAR','{}','Genevieve','Larson','GenevieveCLarson@einrot.com','706-832-0813','{"experience":["GA","US","MasterCard","Red"]}','event0220208579','process0220208579','app0220208301'),
('nan8107zMCK','{}','Nancy','McKinnon','NancyMMcKinnon@rhyta.com','919-884-2921','{"experience":["NC","US","MasterCard","Blue"]}','event0220208580','process0220208580','app0220208301'),
('janc632zHAL','{}','Jason','Hall','JasonMHall@teleworm.us','267-378-0529','{"experience":["PA","US","Visa","White"]}','event0220208581','process0220208581','app0220208301'),
('den3b72zBAT','{}','Deborah','Battle','DeborahJBattle@cuvox.de','231-755-2663','{"experience":["MI","US","Visa","Blue"]}','event0220208582','process0220208582','app0220208301'),
('thnad32zMOR','{}','Thomas','Moreau','ThomasFMoreau@cuvox.de','901-448-1301','{"experience":["TN","US","MasterCard","Blue"]}','event0220208583','process0220208583','app0220208301'),
('man1eb3zORM','{}','Marcia','Orme','MarciaJOrme@jourrapide.com','401-678-4095','{"experience":["RI","US","MasterCard","Blue"]}','event0220208584','process0220208584','app0220208301'),
('genc672zHUR','{}','Gerald','Hurtado','GeraldJHurtado@fleckens.hu','336-515-1731','{"experience":["NC","US","Visa","Blue"]}','event0220208585','process0220208585','app0220208301'),
('ron378azDEA','{}','Ronda','Dean','RondaRDean@jourrapide.com','509-561-6634','{"experience":["WA","US","Visa","Blue"]}','event0220208586','process0220208586','app0220208301'),
('jen393dzBUT','{}','Jennifer','Butler','JenniferNButler@cuvox.de','812-341-2246','{"experience":["IN","US","MasterCard","Yellow"]}','event0220208587','process0220208587','app0220208301'),
('ron8effzHUG','{}','Ronald','Hughes','RonaldMHughes@gustr.com','480-443-8870','{"experience":["AZ","US","Visa","Blue"]}','event0220208588','process0220208588','app0220208301'),
('arn8276zRAM','{}','Art','Ramsey','ArtARamsey@jourrapide.com','601-530-9396','{"experience":["MS","US","MasterCard","Black"]}','event0220208589','process0220208589','app0220208301'),
('ron2570zGON','{}','Robert','Gonzalez','RobertTGonzalez@fleckens.hu','832-446-8455','{"experience":["TX","US","MasterCard","Blue"]}','event0220208590','process0220208590','app0220208301'),
('pan4bb1zMOO','{}','Paula','Moore','PaulaEMoore@rhyta.com','903-838-7796','{"experience":["TX","US","MasterCard","Green"]}','event0220208591','process0220208591','app0220208301'),
('ern16fdzSAC','{}','Erin','Sacks','ErinRSacks@armyspy.com','281-582-8459','{"experience":["TX","US","MasterCard","Purple"]}','event0220208592','process0220208592','app0220208301'),
('gane1d9zHAR','{}','Garry','Hartung','GarryEHartung@jourrapide.com','417-722-9391','{"experience":["MO","US","MasterCard","Blue"]}','event0220208593','process0220208593','app0220208301'),
('chn95ddzAME','{}','Charles','Ames','CharlesLAmes@fleckens.hu','410-860-9704','{"experience":["MD","US","MasterCard","Blue"]}','event0220208594','process0220208594','app0220208301'),
('chn2f18zSHE','{}','Christine','Shea','ChristineRShea@einrot.com','919-448-0881','{"experience":["NC","US","Visa","Blue"]}','event0220208595','process0220208595','app0220208301'),
('tin4fb1zWOR','{}','Timothy','Worsham','TimothyPWorsham@cuvox.de','309-748-6948','{"experience":["IL","US","MasterCard","Blue"]}','event0220208596','process0220208596','app0220208301'),
('thn9bb9zGIL','{}','Thomas','Gill','ThomasDGill@jourrapide.com','760-960-3428','{"experience":["CA","US","Visa","Green"]}','event0220208597','process0220208597','app0220208301'),
('lan211azKEL','{}','Latasha','Kelley','LatashaLKelley@gustr.com','212-664-3587','{"experience":["NY","US","MasterCard","Purple"]}','event0220208598','process0220208598','app0220208301'),
('lan8dbdzKEN','{}','Lakesha','Kennedy','LakeshaJKennedy@rhyta.com','205-742-1724','{"experience":["AL","US","Visa","Blue"]}','event0220208599','process0220208599','app0220208301'),
('amn6d9bzPIN','{}','Amanda','Pinegar','AmandaPPinegar@dayrep.com','715-581-6403','{"experience":["WI","US","Visa","Blue"]}','event0220208600','process0220208600','app0220208301'),
('man1650zBUR','{}','Martin','Burden','MartinABurden@fleckens.hu','402-254-9264','{"experience":["NE","US","MasterCard","Blue"]}','event0220208601','process0220208601','app0220208301'),
('nanc46czTAY','{}','Nancy','Taylor','NancyTTaylor@teleworm.us','586-860-1605','{"experience":["MI","US","MasterCard","Red"]}','event0220208602','process0220208602','app0220208301'),
('den39dazWIL','{}','Dennis','Williams','DennisCWilliams@teleworm.us','207-725-0925','{"experience":["ME","US","MasterCard","Green"]}','event0220208603','process0220208603','app0220208301'),
('can9e2fzWEA','{}','Candace','Weaver','CandacePWeaver@jourrapide.com','972-601-8704','{"experience":["TX","US","Visa","Purple"]}','event0220208604','process0220208604','app0220208301'),
('han52b4zBON','{}','Harold','Bond','HaroldSBond@teleworm.us','314-616-6951','{"experience":["MO","US","Visa","Blue"]}','event0220208605','process0220208605','app0220208301'),
('chn733czKNU','{}','Charles','Knuckles','CharlesJKnuckles@armyspy.com','904-657-0470','{"experience":["FL","US","MasterCard","Green"]}','event0220208606','process0220208606','app0220208301'),
('lune635zGOL','{}','Lula','Goldstein','LulaEGoldstein@einrot.com','202-306-9594','{"experience":["DC","US","Visa","Blue"]}','event0220208607','process0220208607','app0220208301'),
('man283fzSWA','{}','Maurice','Swan','MauriceJSwan@fleckens.hu','414-672-3956','{"experience":["WI","US","MasterCard","Blue"]}','event0220208608','process0220208608','app0220208301'),
('ten81ebzFUL','{}','Terry','Fuller','TerryEFuller@jourrapide.com','262-644-7732','{"experience":["WI","US","Visa","Brown"]}','event0220208609','process0220208609','app0220208301'),
('evn443fzMOO','{}','Evelyn','Moon','EvelynJMoon@armyspy.com','713-472-9828','{"experience":["TX","US","Visa","Blue"]}','event0220208610','process0220208610','app0220208301'),
('brn9449zTAY','{}','Brenda','Taylor','BrendaDTaylor@einrot.com','410-735-7532','{"experience":["MD","US","MasterCard","Purple"]}','event0220208611','process0220208611','app0220208301'),
('sanb984zCAS','{}','Sarah','Casey','SarahCCasey@einrot.com','973-489-7059','{"experience":["NJ","US","MasterCard","Blue"]}','event0220208612','process0220208612','app0220208301'),
('hondd83zHER','{}','Hosea','Hernandez','HoseaJHernandez@einrot.com','425-401-7050','{"experience":["WA","US","Visa","Black"]}','event0220208613','process0220208613','app0220208301'),
('jon6406zPET','{}','John','Peterson','JohnSPeterson@teleworm.us','727-449-1028','{"experience":["FL","US","MasterCard","Blue"]}','event0220208614','process0220208614','app0220208301'),
('den790czMET','{}','Deborah','Metcalf','DeborahJMetcalf@gustr.com','937-692-8525','{"experience":["OH","US","MasterCard","Green"]}','event0220208615','process0220208615','app0220208301'),
('min805bzPRE','{}','Mildred','Preston','MildredBPreston@dayrep.com','478-776-6529','{"experience":["GA","US","MasterCard","Blue"]}','event0220208616','process0220208616','app0220208301'),
('min25d1zSMI','{}','Michael','Smith','MichaelESmith@einrot.com','252-345-4788','{"experience":["NC","US","Visa","Black"]}','event0220208617','process0220208617','app0220208301'),
('jonaa6azSEA','{}','Joyce','Seamons','JoyceRSeamons@einrot.com','509-310-3213','{"experience":["WA","US","Visa","Red"]}','event0220208618','process0220208618','app0220208301'),
('jen86a4zCAS','{}','Jeffery','Cason','JefferyDCason@gustr.com','561-506-8614','{"experience":["FL","US","Visa","Blue"]}','event0220208619','process0220208619','app0220208301'),
('ran623fzAND','{}','Raymundo','Anderson','RaymundoMAnderson@teleworm.us','918-536-8845','{"experience":["OK","US","MasterCard","Green"]}','event0220208620','process0220208620','app0220208301'),
('run5b54zLIL','{}','Ruth','Liles','RuthJLiles@armyspy.com','301-476-3100','{"experience":["MD","US","MasterCard","Blue"]}','event0220208621','process0220208621','app0220208301'),
('win318fzSMI','{}','William','Smith','WilliamNSmith@cuvox.de','601-851-1414','{"experience":["MS","US","Visa","Green"]}','event0220208622','process0220208622','app0220208301'),
('rin8f4ezHAN','{}','Rick','Hancock','RickKHancock@gustr.com','334-434-9342','{"experience":["AL","US","MasterCard","Blue"]}','event0220208623','process0220208623','app0220208301'),
('ann1afdzMIN','{}','Antonio','Mincey','AntonioMMincey@armyspy.com','626-357-2096','{"experience":["CA","US","MasterCard","Blue"]}','event0220208624','process0220208624','app0220208301'),
('dancb6czEVA','{}','David','Evans','DavidPEvans@jourrapide.com','781-340-8654','{"experience":["MA","US","Visa","Blue"]}','event0220208625','process0220208625','app0220208301'),
('kind11bzCOR','{}','Kimberly','Corum','KimberlyMCorum@rhyta.com','574-204-5292','{"experience":["IN","US","Visa","Green"]}','event0220208626','process0220208626','app0220208301'),
('gene546zWIL','{}','George','Williams','GeorgeBWilliams@fleckens.hu','567-523-8569','{"experience":["OH","US","Visa","Blue"]}','event0220208627','process0220208627','app0220208301'),
('don8749zFOO','{}','Douglas','Foos','DouglasSFoos@fleckens.hu','407-249-1790','{"experience":["FL","US","Visa","Blue"]}','event0220208628','process0220208628','app0220208301'),
('doneedazJON','{}','Dorothy','Jones','DorothyJJones@dayrep.com','520-533-7382','{"experience":["AZ","US","Visa","Yellow"]}','event0220208629','process0220208629','app0220208301'),
('din58b3zSPR','{}','Dianne','Spradlin','DianneHSpradlin@rhyta.com','615-351-8500','{"experience":["TN","US","Visa","Blue"]}','event0220208630','process0220208630','app0220208301'),
('shn2c42zSTA','{}','Sharon','Starr','SharonAStarr@jourrapide.com','952-261-4555','{"experience":["MN","US","MasterCard","Purple"]}','event0220208631','process0220208631','app0220208301'),
('sandd3ezPUT','{}','Sarah','Putman','SarahFPutman@armyspy.com','765-284-5957','{"experience":["IN","US","Visa","Blue"]}','event0220208632','process0220208632','app0220208301'),
('vin0f20zTAY','{}','Vicki','Taylor','VickiOTaylor@armyspy.com','623-399-8543','{"experience":["AZ","US","MasterCard","Blue"]}','event0220208633','process0220208633','app0220208301'),
('grnb6edzKIN','{}','Grace','King','GraceDKing@gustr.com','540-223-8947','{"experience":["VA","US","MasterCard","Red"]}','event0220208634','process0220208634','app0220208301'),
('don1ec3zKIN','{}','Dona','King','DonaFKing@gustr.com','479-225-9183','{"experience":["AR","US","MasterCard","Purple"]}','event0220208635','process0220208635','app0220208301'),
('can7b3czLAN','{}','Carlos','Lane','CarlosPLane@teleworm.us','740-303-9330','{"experience":["OH","US","Visa","Blue"]}','event0220208636','process0220208636','app0220208301'),
('arn5c56zLON','{}','Arnold','Long','ArnoldCLong@armyspy.com','815-827-3225','{"experience":["IL","US","MasterCard","Orange"]}','event0220208637','process0220208637','app0220208301'),
('jon25d0zCHA','{}','John','Charlton','JohnMCharlton@dayrep.com','307-352-3619','{"experience":["WY","US","Visa","Blue"]}','event0220208638','process0220208638','app0220208301'),
('erna473zCOO','{}','Erica','Cook','EricaJCook@armyspy.com','414-856-6710','{"experience":["WI","US","MasterCard","Blue"]}','event0220208639','process0220208639','app0220208301'),
('han994czKLI','{}','Harry','Kline','HarrySKline@jourrapide.com','276-638-1890','{"experience":["VA","US","Visa","Blue"]}','event0220208640','process0220208640','app0220208301'),
('sun20dbzWEL','{}','Suzanne','Welch','SuzanneMWelch@cuvox.de','202-464-7044','{"experience":["DC","US","MasterCard","Blue"]}','event0220208641','process0220208641','app0220208301'),
('inn91e3zBON','{}','Ingrid','Bongiorno','IngridTBongiorno@rhyta.com','724-987-1871','{"experience":["PA","US","Visa","Green"]}','event0220208642','process0220208642','app0220208301'),
('jene8dezCRO','{}','Jessica','Crockett','JessicaRCrockett@einrot.com','419-571-2697','{"experience":["OH","US","MasterCard","Blue"]}','event0220208643','process0220208643','app0220208301'),
('jon63a9zCRU','{}','John','Crum','JohnCCrum@teleworm.us','520-519-7389','{"experience":["AZ","US","Visa","Blue"]}','event0220208644','process0220208644','app0220208301'),
('man1a41zSAN','{}','Margaret','Santos','MargaretASantos@armyspy.com','323-348-2773','{"experience":["CA","US","Visa","Green"]}','event0220208645','process0220208645','app0220208301'),
('ven9e5bzHUB','{}','Verna','Hubbert','VernaKHubbert@armyspy.com','928-521-5585','{"experience":["AZ","US","MasterCard","Black"]}','event0220208646','process0220208646','app0220208301'),
('thn954bzCAS','{}','Theresa','Casares','TheresaACasares@jourrapide.com','256-876-9702','{"experience":["AL","US","Visa","Blue"]}','event0220208647','process0220208647','app0220208301'),
('manabd0zFRI','{}','Margie','Frith','MargieRFrith@cuvox.de','312-715-9233','{"experience":["IL","US","MasterCard","Purple"]}','event0220208648','process0220208648','app0220208301'),
('ten6e9ezBAR','{}','Ted','Barnhill','TedJBarnhill@einrot.com','337-335-4731','{"experience":["LA","US","Visa","Blue"]}','event0220208649','process0220208649','app0220208301'),
('jene1dczMAY','{}','Jessica','Mayes','JessicaAMayes@jourrapide.com','219-663-1673','{"experience":["IN","US","Visa","Blue"]}','event0220208650','process0220208650','app0220208301'),
('denc5b4zMCA','{}','Deborah','McAdams','DeborahOMcAdams@fleckens.hu','601-412-6576','{"experience":["MS","US","Visa","Purple"]}','event0220208651','process0220208651','app0220208301'),
('sanf8ddzBRA','{}','Sal','Bradley','SalHBradley@einrot.com','772-696-5162','{"experience":["FL","US","Visa","Green"]}','event0220208652','process0220208652','app0220208301'),
('san0af7zTHO','{}','Samuel','Thompson','SamuelPThompson@fleckens.hu','347-468-7772','{"experience":["NY","US","Visa","Orange"]}','event0220208653','process0220208653','app0220208301'),
('ban640fzGAG','{}','Barbara','Gagnier','BarbaraRGagnier@gustr.com','660-728-0046','{"experience":["MO","US","Visa","Red"]}','event0220208654','process0220208654','app0220208301'),
('tencca2zTUC','{}','Terry','Tucker','TerryMTucker@einrot.com','239-264-4822','{"experience":["FL","US","Visa","Green"]}','event0220208655','process0220208655','app0220208301'),
('kynd8fezBAR','{}','Kyle','Barboza','KyleDBarboza@gustr.com','419-258-8085','{"experience":["OH","US","Visa","Green"]}','event0220208656','process0220208656','app0220208301'),
('rond56bzPAC','{}','Ronnie','Pace','RonnieBPace@cuvox.de','252-295-4779','{"experience":["NC","US","MasterCard","Orange"]}','event0220208657','process0220208657','app0220208301'),
('jonccdczPER','{}','Jose','Perez','JoseSPerez@dayrep.com','256-371-3412','{"experience":["AL","US","MasterCard","Blue"]}','event0220208658','process0220208658','app0220208301'),
('ron4142zMON','{}','Robert','Montgomery','RobertKMontgomery@einrot.com','718-939-6809','{"experience":["NY","US","MasterCard","Green"]}','event0220208659','process0220208659','app0220208301'),
('annd993zSTA','{}','Anna','Stage','AnnaRStage@jourrapide.com','703-681-3234','{"experience":["VA","US","Visa","Green"]}','event0220208660','process0220208660','app0220208301'),
('frn062ezSWE','{}','Freda','Sweeney','FredaDSweeney@cuvox.de','618-297-3057','{"experience":["IL","US","MasterCard","Blue"]}','event0220208661','process0220208661','app0220208301'),
('can4261zTHO','{}','Cary','Thomas','CaryBThomas@jourrapide.com','864-205-7915','{"experience":["SC","US","Visa","Black"]}','event0220208662','process0220208662','app0220208301'),
('wena2dfzWIL','{}','Wendy','Williams','WendyDWilliams@superrito.com','803-819-8519','{"experience":["SC","US","Visa","Blue"]}','event0220208663','process0220208663','app0220208301'),
('san9acczCHA','{}','Samuel','Chapman','SamuelCChapman@superrito.com','419-470-5330','{"experience":["OH","US","Visa","Blue"]}','event0220208664','process0220208664','app0220208301'),
('hen0a60zMEN','{}','Helen','Mendez','HelenRMendez@gustr.com','573-361-1510','{"experience":["MO","US","MasterCard","Red"]}','event0220208665','process0220208665','app0220208301'),
('kanc881zBON','{}','Katie','Bonneau','KatieWBonneau@einrot.com','828-453-3636','{"experience":["NC","US","MasterCard","Black"]}','event0220208666','process0220208666','app0220208301'),
('hencd62zWAT','{}','Herbert','Watson','HerbertSWatson@einrot.com','908-238-4579','{"experience":["NJ","US","MasterCard","Red"]}','event0220208667','process0220208667','app0220208301'),
('dondddazSUG','{}','Dorothy','Suggs','DorothyFSuggs@cuvox.de','386-627-2713','{"experience":["FL","US","Visa","Blue"]}','event0220208668','process0220208668','app0220208301'),
('ran2bb6zPHI','{}','Ray','Phillips','RayKPhillips@dayrep.com','573-872-8957','{"experience":["MO","US","Visa","Green"]}','event0220208669','process0220208669','app0220208301'),
('grne2a5zKAC','{}','Gregory','Kaczmarek','GregoryEKaczmarek@cuvox.de','636-795-8108','{"experience":["MO","US","MasterCard","Green"]}','event0220208670','process0220208670','app0220208301'),
('kendb46zFAR','{}','Kelly','Farish','KellyJFarish@teleworm.us','401-355-5495','{"experience":["RI","US","MasterCard","Black"]}','event0220208671','process0220208671','app0220208301'),
('shn1103zBAC','{}','Shelly','Bacon','ShellyDBacon@rhyta.com','256-906-4874','{"experience":["AL","US","Visa","Black"]}','event0220208672','process0220208672','app0220208301'),
('kan05d9zGON','{}','Karen','Gonzalez','KarenGGonzalez@rhyta.com','678-309-3195','{"experience":["GA","US","MasterCard","Brown"]}','event0220208673','process0220208673','app0220208301'),
('brn7d93zEGA','{}','Brenda','Egan','BrendaKEgan@dayrep.com','702-891-7669','{"experience":["NV","US","MasterCard","Green"]}','event0220208674','process0220208674','app0220208301'),
('anne7fazPOR','{}','Ana','Porterfield','AnaMPorterfield@cuvox.de','248-591-1813','{"experience":["MI","US","Visa","Orange"]}','event0220208675','process0220208675','app0220208301'),
('den307fzCLE','{}','Derek','Clement','DerekMClement@fleckens.hu','720-351-3395','{"experience":["CO","US","MasterCard","White"]}','event0220208676','process0220208676','app0220208301'),
('man8ea3zSPA','{}','Martha','Sparks','MarthaASparks@teleworm.us','308-468-5348','{"experience":["NE","US","MasterCard","Blue"]}','event0220208677','process0220208677','app0220208301'),
('can4789zFOX','{}','Carrie','Fox','CarrieCFox@dayrep.com','402-952-7040','{"experience":["NE","US","MasterCard","Brown"]}','event0220208678','process0220208678','app0220208301'),
('den22e8zKAR','{}','Deborah','Karr','DeborahDKarr@fleckens.hu','828-317-4809','{"experience":["NC","US","MasterCard","Black"]}','event0220208679','process0220208679','app0220208301'),
('janf70azWIL','{}','James','Williams','JamesDWilliams@gustr.com','212-494-0522','{"experience":["NY","US","MasterCard","Orange"]}','event0220208680','process0220208680','app0220208301'),
('evnb738zFEE','{}','Evelia','Fee','EveliaMFee@jourrapide.com','323-259-9275','{"experience":["CA","US","Visa","Green"]}','event0220208681','process0220208681','app0220208301'),
('benf99azGRA','{}','Bethanie','Grayson','BethanieDGrayson@jourrapide.com','973-861-8204','{"experience":["NJ","US","MasterCard","Blue"]}','event0220208682','process0220208682','app0220208301'),
('jon352fzRIC','{}','John','Richards','JohnJRichards@rhyta.com','617-698-6066','{"experience":["MA","US","Visa","Blue"]}','event0220208683','process0220208683','app0220208301'),
('chn513czDIX','{}','Charles','Dixon','CharlesRDixon@rhyta.com','717-641-1161','{"experience":["PA","US","MasterCard","Blue"]}','event0220208684','process0220208684','app0220208301'),
('jene521zLAN','{}','Jeffrey','Land','JeffreyDLand@armyspy.com','815-595-6218','{"experience":["IL","US","MasterCard","Blue"]}','event0220208685','process0220208685','app0220208301'),
('lan412ezLEV','{}','Laurie','Levi','LaurieMLevi@gustr.com','305-453-0778','{"experience":["FL","US","Visa","Red"]}','event0220208686','process0220208686','app0220208301'),
('run3b3czPIT','{}','Ruth','Pitts','RuthCPitts@fleckens.hu','631-737-9281','{"experience":["NY","US","MasterCard","Brown"]}','event0220208687','process0220208687','app0220208301'),
('stn53e6zROU','{}','Steve','Rouse','SteveERouse@superrito.com','407-383-0632','{"experience":["FL","US","Visa","Red"]}','event0220208688','process0220208688','app0220208301'),
('jonb033zROJ','{}','Joyce','Rojo','JoyceERojo@cuvox.de','913-573-1453','{"experience":["KS","US","MasterCard","Black"]}','event0220208689','process0220208689','app0220208301'),
('ten2a51zSTA','{}','Teresa','Stamey','TeresaJStamey@armyspy.com','786-200-8939','{"experience":["FL","US","MasterCard","Blue"]}','event0220208690','process0220208690','app0220208301'),
('dan81b0zDAN','{}','David','Daniels','DavidEDaniels@gustr.com','360-654-5609','{"experience":["WA","US","Visa","Blue"]}','event0220208691','process0220208691','app0220208301'),
('mana449zDRI','{}','Marsha','Driscoll','MarshaTDriscoll@jourrapide.com','419-899-4833','{"experience":["OH","US","Visa","Green"]}','event0220208692','process0220208692','app0220208301'),
('sinf2abzRUN','{}','Sidney','Runnels','SidneyJRunnels@cuvox.de','561-682-6230','{"experience":["FL","US","MasterCard","Silver"]}','event0220208693','process0220208693','app0220208301'),
('jen01d3zMAX','{}','Jeff','Maxwell','JeffGMaxwell@dayrep.com','360-797-2741','{"experience":["WA","US","MasterCard","Blue"]}','event0220208694','process0220208694','app0220208301'),
('urnaa6ezCON','{}','Ursula','Contreras','UrsulaTContreras@rhyta.com','512-805-4882','{"experience":["TX","US","MasterCard","Blue"]}','event0220208695','process0220208695','app0220208301'),
('rindfa0zLEE','{}','Richard','Leeman','RichardSLeeman@gustr.com','602-470-8795','{"experience":["AZ","US","Visa","Red"]}','event0220208696','process0220208696','app0220208301'),
('min4bc9zWRI','{}','Michelle','Wright','MichelleFWright@armyspy.com','901-358-8760','{"experience":["TN","US","MasterCard","Green"]}','event0220208697','process0220208697','app0220208301'),
('lyn6deczCUR','{}','Lynda','Curtis','LyndaECurtis@superrito.com','864-964-3491','{"experience":["SC","US","MasterCard","Yellow"]}','event0220208698','process0220208698','app0220208301'),
('thn9c30zPOO','{}','Thomas','Pooler','ThomasCPooler@cuvox.de','972-620-0145','{"experience":["TX","US","Visa","Green"]}','event0220208699','process0220208699','app0220208301'),
('brnb96ezJOH','{}','Brian','Johns','BrianAJohns@jourrapide.com','347-232-8499','{"experience":["NY","US","Visa","Blue"]}','event0220208700','process0220208700','app0220208301'),
('elneb84zHAN','{}','Eleanor','Hannah','EleanorLHannah@einrot.com','580-486-8027','{"experience":["OK","US","Visa","Orange"]}','event0220208701','process0220208701','app0220208301'),
('hend35dzNEL','{}','Heather','Nelson','HeatherMNelson@jourrapide.com','574-255-1377','{"experience":["IN","US","Visa","Purple"]}','event0220208702','process0220208702','app0220208301'),
('ran0cedzMUE','{}','Rachel','Mueller','RachelRMueller@gustr.com','208-434-6737','{"experience":["ID","US","MasterCard","Green"]}','event0220208703','process0220208703','app0220208301'),
('cin0fbdzSTE','{}','Cindy','Stephenson','CindyTStephenson@einrot.com','713-395-8773','{"experience":["TX","US","MasterCard","Blue"]}','event0220208704','process0220208704','app0220208301'),
('can17eazSMI','{}','Candice','Smith','CandiceKSmith@rhyta.com','269-674-7805','{"experience":["MI","US","Visa","Green"]}','event0220208705','process0220208705','app0220208301'),
('pen9fd4zGON','{}','Peter','Gonzalez','PeterIGonzalez@armyspy.com','860-722-5183','{"experience":["CT","US","Visa","Black"]}','event0220208706','process0220208706','app0220208301'),
('pan574czMAY','{}','Paulette','Mayfield','PauletteJMayfield@superrito.com','313-628-1650','{"experience":["MI","US","Visa","Brown"]}','event0220208707','process0220208707','app0220208301'),
('adndeafzPER','{}','Adam','Perez','AdamLPerez@teleworm.us','931-307-8370','{"experience":["TN","US","MasterCard","Green"]}','event0220208708','process0220208708','app0220208301'),
('rine6e9zCOO','{}','Richard','Cooper','RichardFCooper@jourrapide.com','610-609-9812','{"experience":["PA","US","Visa","Blue"]}','event0220208709','process0220208709','app0220208301'),
('panec32zGIB','{}','Patricia','Gibson','PatriciaJGibson@rhyta.com','956-971-9471','{"experience":["TX","US","MasterCard","Blue"]}','event0220208710','process0220208710','app0220208301'),
('stn143azOLI','{}','Steven','Oliver','StevenGOliver@rhyta.com','636-433-6237','{"experience":["MO","US","Visa","White"]}','event0220208711','process0220208711','app0220208301'),
('kana07ezBRA','{}','Kari','Bradley','KariMBradley@superrito.com','215-343-2043','{"experience":["PA","US","MasterCard","Orange"]}','event0220208712','process0220208712','app0220208301'),
('linae89zFIE','{}','Linda','Fields','LindaSFields@einrot.com','212-580-3144','{"experience":["NY","US","MasterCard","Purple"]}','event0220208713','process0220208713','app0220208301'),
('man57a2zMOR','{}','Margaret','Morales','MargaretJMorales@jourrapide.com','508-653-8910','{"experience":["MA","US","Visa","Black"]}','event0220208714','process0220208714','app0220208301'),
('ren7ddazMIL','{}','Rebecca','Miller','RebeccaCMiller@armyspy.com','410-992-6119','{"experience":["MD","US","MasterCard","Green"]}','event0220208715','process0220208715','app0220208301'),
('amn16e0zDIL','{}','Amelia','Dillon','AmeliaJDillon@cuvox.de','229-292-6495','{"experience":["GA","US","MasterCard","Yellow"]}','event0220208716','process0220208716','app0220208301'),
('shnd425zHUD','{}','Sherman','Hudson','ShermanTHudson@gustr.com','563-676-6040','{"experience":["IA","US","Visa","Yellow"]}','event0220208717','process0220208717','app0220208301'),
('hen2996zCOO','{}','Henry','Cooke','HenryECooke@einrot.com','919-679-5536','{"experience":["NC","US","Visa","Blue"]}','event0220208718','process0220208718','app0220208301'),
('kan38aezBAS','{}','Kandy','Bass','KandyFBass@cuvox.de','401-393-7776','{"experience":["RI","US","MasterCard","Blue"]}','event0220208719','process0220208719','app0220208301'),
('jon1cf9zWIL','{}','Joyce','Williams','JoyceBWilliams@fleckens.hu','520-703-4056','{"experience":["AZ","US","MasterCard","Purple"]}','event0220208720','process0220208720','app0220208301'),
('winedeazWIL','{}','William','Williams','WilliamCWilliams@rhyta.com','850-948-0666','{"experience":["FL","US","MasterCard","Orange"]}','event0220208721','process0220208721','app0220208301'),
('pana8afzEDW','{}','Pamela','Edwards','PamelaJEdwards@superrito.com','317-679-7851','{"experience":["IN","US","Visa","Yellow"]}','event0220208722','process0220208722','app0220208301'),
('stn10cbzMAG','{}','Steven','Magruder','StevenSMagruder@teleworm.us','901-347-7691','{"experience":["TN","US","Visa","Red"]}','event0220208723','process0220208723','app0220208301'),
('ron084bzHOW','{}','Robert','Howe','RobertRHowe@superrito.com','610-204-1722','{"experience":["PA","US","MasterCard","Blue"]}','event0220208724','process0220208724','app0220208301'),
('aln6b90zSCH','{}','Alex','Schexnayder','AlexASchexnayder@jourrapide.com','618-963-3295','{"experience":["IL","US","MasterCard","Blue"]}','event0220208725','process0220208725','app0220208301'),
('elna9b9zMAR','{}','Elisha','Maranto','ElishaEMaranto@dayrep.com','734-394-5091','{"experience":["MI","US","MasterCard","Blue"]}','event0220208726','process0220208726','app0220208301'),
('lin1666zMOO','{}','Linda','Moorhouse','LindaBMoorhouse@fleckens.hu','618-406-4825','{"experience":["IL","US","Visa","Blue"]}','event0220208727','process0220208727','app0220208301'),
('ten2ad8zCOL','{}','Teresa','Collins','TeresaCCollins@rhyta.com','607-588-5859','{"experience":["NY","US","Visa","Black"]}','event0220208728','process0220208728','app0220208301'),
('jond94bzVAL','{}','John','Valentine','JohnVValentine@teleworm.us','812-888-5699','{"experience":["IN","US","MasterCard","Orange"]}','event0220208729','process0220208729','app0220208301'),
('amn0576zSMA','{}','Amanda','Small','AmandaDSmall@jourrapide.com','248-281-3093','{"experience":["MI","US","MasterCard","Green"]}','event0220208730','process0220208730','app0220208301'),
('eln8cc5zRIC','{}','Elizabeth','Richardson','ElizabethCRichardson@dayrep.com','714-856-4030','{"experience":["CA","US","Visa","Silver"]}','event0220208731','process0220208731','app0220208301'),
('dene181zKUS','{}','Deborah','Kuss','DeborahRKuss@jourrapide.com','315-632-3953','{"experience":["NY","US","MasterCard","Blue"]}','event0220208732','process0220208732','app0220208301'),
('win10a9zDEG','{}','William','Deguzman','WilliamCDeguzman@jourrapide.com','252-393-7840','{"experience":["NC","US","MasterCard","Blue"]}','event0220208733','process0220208733','app0220208301'),
('lun3cadzLAY','{}','Lucie','Lay','LucieJLay@jourrapide.com','559-249-3571','{"experience":["CA","US","Visa","Red"]}','event0220208734','process0220208734','app0220208301'),
('idn062fzHUR','{}','Ida','Hurst','IdaDHurst@gustr.com','408-925-0923','{"experience":["CA","US","MasterCard","Blue"]}','event0220208735','process0220208735','app0220208301'),
('okna781zCHR','{}','Ok','Christensen','OkAChristensen@armyspy.com','616-347-2637','{"experience":["MI","US","MasterCard","Purple"]}','event0220208736','process0220208736','app0220208301'),
('ken0df9zGRE','{}','Keri','Green','KeriJGreen@einrot.com','313-328-9890','{"experience":["MI","US","MasterCard","Blue"]}','event0220208737','process0220208737','app0220208301'),
('man7194zMAR','{}','Mary','Martinez','MaryRMartinez@cuvox.de','410-374-4790','{"experience":["MD","US","Visa","Green"]}','event0220208738','process0220208738','app0220208301'),
('gen5c61zLAW','{}','Geraldine','Lawson','GeraldineWLawson@gustr.com','765-405-6197','{"experience":["IN","US","Visa","Purple"]}','event0220208739','process0220208739','app0220208301'),
('wen9de1zTHO','{}','Wendell','Thomas','WendellCThomas@armyspy.com','530-788-7636','{"experience":["CA","US","MasterCard","Black"]}','event0220208740','process0220208740','app0220208301'),
('ern0cbczBEV','{}','Eric','Beverage','EricMBeverage@jourrapide.com','601-695-7710','{"experience":["MS","US","MasterCard","Blue"]}','event0220208741','process0220208741','app0220208301'),
('jan09bezBUL','{}','James','Bullard','JamesMBullard@jourrapide.com','484-621-0737','{"experience":["PA","US","MasterCard","Black"]}','event0220208742','process0220208742','app0220208301'),
('brn6e71zECK','{}','Bradley','Eckert','BradleySEckert@superrito.com','574-389-2789','{"experience":["IN","US","MasterCard","Green"]}','event0220208743','process0220208743','app0220208301'),
('shn0e5bzABE','{}','Shirley','Abeyta','ShirleyRAbeyta@rhyta.com','404-316-0759','{"experience":["GA","US","Visa","Blue"]}','event0220208744','process0220208744','app0220208301'),
('tanc2fbzMAR','{}','Tanya','Martin','TanyaTMartin@rhyta.com','724-517-9082','{"experience":["PA","US","MasterCard","Blue"]}','event0220208745','process0220208745','app0220208301'),
('henb579zPAT','{}','Henrietta','Patterson','HenriettaWPatterson@superrito.com','206-653-9676','{"experience":["WA","US","MasterCard","Orange"]}','event0220208746','process0220208746','app0220208301'),
('aan13a0zBUR','{}','Aaron','Burpo','AaronEBurpo@gustr.com','562-655-6145','{"experience":["CA","US","Visa","Blue"]}','event0220208747','process0220208747','app0220208301'),
('janfd46zMCC','{}','Jane','McClain','JaneDMcClain@teleworm.us','740-226-1885','{"experience":["OH","US","Visa","Purple"]}','event0220208748','process0220208748','app0220208301'),
('pane0c3zJOH','{}','Patsy','Johnson','PatsyJJohnson@fleckens.hu','432-358-1764','{"experience":["TX","US","MasterCard","Silver"]}','event0220208749','process0220208749','app0220208301'),
('jun65dfzAGU','{}','Judy','Aguirre','JudyGAguirre@gustr.com','832-521-1875','{"experience":["TX","US","Visa","Black"]}','event0220208750','process0220208750','app0220208301'),
('benbfd1zTHO','{}','Becky','Thompson','BeckyAThompson@dayrep.com','806-717-7108','{"experience":["TX","US","MasterCard","Blue"]}','event0220208751','process0220208751','app0220208301'),
('wan8039zDIE','{}','Wallace','Dierking','WallaceBDierking@einrot.com','443-716-9351','{"experience":["MD","US","MasterCard","Green"]}','event0220208752','process0220208752','app0220208301'),
('sanbf27zMAR','{}','Sally','Markowitz','SallyVMarkowitz@teleworm.us','573-836-9167','{"experience":["MO","US","Visa","Blue"]}','event0220208753','process0220208753','app0220208301'),
('can21e5zCLA','{}','Catherine','Clark','CatherineSClark@einrot.com','989-654-8375','{"experience":["MI","US","Visa","Purple"]}','event0220208754','process0220208754','app0220208301'),
('cln4a95zGOM','{}','Clarence','Gomes','ClarenceBGomes@einrot.com','212-517-8266','{"experience":["NY","US","Visa","Blue"]}','event0220208755','process0220208755','app0220208301'),
('rone788zHOG','{}','Rose','Hogan','RoseDHogan@fleckens.hu','651-605-4698','{"experience":["MN","US","MasterCard","Blue"]}','event0220208756','process0220208756','app0220208301'),
('stn4498zBOY','{}','Steven','Boyd','StevenABoyd@armyspy.com','650-838-7590','{"experience":["CA","US","Visa","Blue"]}','event0220208757','process0220208757','app0220208301'),
('han6a62zWEI','{}','Harold','Weisberg','HaroldMWeisberg@teleworm.us','708-274-7791','{"experience":["IL","US","MasterCard","Blue"]}','event0220208758','process0220208758','app0220208301'),
('min8836zMIT','{}','Michael','Mitchell','MichaelDMitchell@rhyta.com','256-466-0424','{"experience":["AL","US","MasterCard","Green"]}','event0220208759','process0220208759','app0220208301'),
('doneb06zBOR','{}','Doris','Borges','DorisFBorges@rhyta.com','562-500-3216','{"experience":["CA","US","Visa","Blue"]}','event0220208760','process0220208760','app0220208301'),
('evn1431zQUI','{}','Eva','Quintana','EvaSQuintana@teleworm.us','224-420-0780','{"experience":["IL","US","MasterCard","Blue"]}','event0220208761','process0220208761','app0220208301'),
('ann614bzDEL','{}','Antonio','Delacruz','AntonioRDelacruz@einrot.com','614-213-9132','{"experience":["OH","US","Visa","Blue"]}','event0220208762','process0220208762','app0220208301'),
('junb081zRIV','{}','Julius','Rivera','JuliusMRivera@cuvox.de','480-540-8347','{"experience":["AZ","US","Visa","Blue"]}','event0220208763','process0220208763','app0220208301'),
('ednf571zALE','{}','Edgardo','Alexander','EdgardoDAlexander@einrot.com','909-910-7574','{"experience":["CA","US","MasterCard","Blue"]}','event0220208764','process0220208764','app0220208301'),
('don3659zEDW','{}','Doreen','Edwards','DoreenREdwards@teleworm.us','410-985-8864','{"experience":["MD","US","Visa","Blue"]}','event0220208765','process0220208765','app0220208301'),
('esnf1a9zTAY','{}','Estella','Taylor','EstellaBTaylor@gustr.com','817-527-7781','{"experience":["TX","US","Visa","Green"]}','event0220208766','process0220208766','app0220208301'),
('pan7130zMER','{}','Patricia','Mercer','PatriciaAMercer@dayrep.com','717-315-8711','{"experience":["PA","US","Visa","Blue"]}','event0220208767','process0220208767','app0220208301'),
('ben694fzMAY','{}','Benjamin','Mayo','BenjaminEMayo@dayrep.com','740-680-5324','{"experience":["OH","US","MasterCard","Blue"]}','event0220208768','process0220208768','app0220208301'),
('chn5cedzCEB','{}','Chuck','Ceballos','ChuckACeballos@armyspy.com','339-368-6076','{"experience":["MA","US","Visa","Blue"]}','event0220208769','process0220208769','app0220208301'),
('jen2197zSPA','{}','Jerry','Spangler','JerryCSpangler@dayrep.com','484-690-6243','{"experience":["PA","US","Visa","Blue"]}','event0220208770','process0220208770','app0220208301'),
('lanc705zMOR','{}','Latasha','Morris','LatashaBMorris@gustr.com','412-591-8245','{"experience":["PA","US","MasterCard","Red"]}','event0220208771','process0220208771','app0220208301'),
('dwnccf5zGRA','{}','Dwayne','Grady','DwayneCGrady@gustr.com','775-321-9144','{"experience":["NV","US","Visa","Green"]}','event0220208772','process0220208772','app0220208301'),
('jun145azGRE','{}','Judson','Green','JudsonJGreen@dayrep.com','305-975-8054','{"experience":["FL","US","MasterCard","Silver"]}','event0220208773','process0220208773','app0220208301'),
('vin36e0zBAC','{}','Virginia','Bachman','VirginiaTBachman@gustr.com','337-376-2368','{"experience":["LA","US","Visa","Blue"]}','event0220208774','process0220208774','app0220208301'),
('jon41e0zPAR','{}','Joseph','Parks','JosephPParks@cuvox.de','404-975-7047','{"experience":["GA","US","MasterCard","Green"]}','event0220208775','process0220208775','app0220208301'),
('cen5b7czPAU','{}','Cecilia','Paul','CeciliaRPaul@einrot.com','502-321-5673','{"experience":["KY","US","Visa","Yellow"]}','event0220208776','process0220208776','app0220208301'),
('nanc979zHAR','{}','Nancy','Harper','NancyCHarper@dayrep.com','801-828-7548','{"experience":["UT","US","MasterCard","Brown"]}','event0220208777','process0220208777','app0220208301'),
('lenb170zPAG','{}','Leola','Page','LeolaJPage@dayrep.com','305-233-3810','{"experience":["FL","US","Visa","Blue"]}','event0220208778','process0220208778','app0220208301'),
('jon12e8zRIV','{}','Jose','Rivera','JoseMRivera@armyspy.com','410-236-5999','{"experience":["MD","US","MasterCard","Green"]}','event0220208779','process0220208779','app0220208301'),
('wanf4e1zLOV','{}','Walter','Love','WalterHLove@einrot.com','717-258-9198','{"experience":["PA","US","Visa","Blue"]}','event0220208780','process0220208780','app0220208301'),
('thn27f0zMUR','{}','Thomas','Murphy','ThomasMMurphy@superrito.com','859-358-9295','{"experience":["KY","US","MasterCard","Orange"]}','event0220208781','process0220208781','app0220208301'),
('jan9065zMUR','{}','Jacqueline','Murray','JacquelineAMurray@fleckens.hu','954-597-5931','{"experience":["FL","US","Visa","Blue"]}','event0220208782','process0220208782','app0220208301'),
('hen416fzHUR','{}','Heather','Hurst','HeatherAHurst@dayrep.com','828-550-8558','{"experience":["NC","US","Visa","Purple"]}','event0220208783','process0220208783','app0220208301'),
('gen0425zSMI','{}','Georgia','Smith','GeorgiaSSmith@einrot.com','818-996-7564','{"experience":["CA","US","MasterCard","Blue"]}','event0220208784','process0220208784','app0220208301'),
('jend96azLAB','{}','Jennifer','Labelle','JenniferKLabelle@superrito.com','509-262-6689','{"experience":["WA","US","Visa","Brown"]}','event0220208785','process0220208785','app0220208301'),
('lin2407zNET','{}','Linda','Neth','LindaHNeth@armyspy.com','616-640-4590','{"experience":["MI","US","Visa","Red"]}','event0220208786','process0220208786','app0220208301'),
('cancbe5zMCK','{}','Carmen','McKnight','CarmenNMcKnight@rhyta.com','803-306-8978','{"experience":["SC","US","MasterCard","Purple"]}','event0220208787','process0220208787','app0220208301'),
('lanb56azBUC','{}','Lauren','Buckley','LaurenRBuckley@gustr.com','757-665-3515','{"experience":["VA","US","MasterCard","Purple"]}','event0220208788','process0220208788','app0220208301'),
('ann0b6czJOH','{}','Ann','Johnson','AnnPJohnson@rhyta.com','256-392-4814','{"experience":["AL","US","Visa","Yellow"]}','event0220208789','process0220208789','app0220208301'),
('clne761zHER','{}','Clifford','Hering','CliffordDHering@rhyta.com','949-202-6098','{"experience":["CA","US","Visa","Red"]}','event0220208790','process0220208790','app0220208301'),
('men523bzEST','{}','Merle','Estrada','MerleHEstrada@dayrep.com','336-403-9396','{"experience":["NC","US","Visa","Blue"]}','event0220208791','process0220208791','app0220208301'),
('aan141ezBER','{}','Aaron','Berry','AaronPBerry@dayrep.com','360-487-0621','{"experience":["WA","US","MasterCard","Blue"]}','event0220208792','process0220208792','app0220208301'),
('aln1e42zHEL','{}','Allen','Heller','AllenRHeller@rhyta.com','213-873-9385','{"experience":["CA","US","Visa","Blue"]}','event0220208793','process0220208793','app0220208301'),
('rin185bzAYE','{}','Richard','Ayers','RichardJAyers@einrot.com','607-759-6532','{"experience":["NY","US","MasterCard","Blue"]}','event0220208794','process0220208794','app0220208301'),
('vince21zREE','{}','Victoria','Reed','VictoriaJReed@teleworm.us','928-336-4525','{"experience":["AZ","US","MasterCard","Blue"]}','event0220208795','process0220208795','app0220208301'),
('don04cczBEL','{}','Donald','Bell','DonaldMBell@dayrep.com','781-259-5395','{"experience":["MA","US","MasterCard","Blue"]}','event0220208796','process0220208796','app0220208301'),
('chn6fa9zSMI','{}','Charles','Smith','CharlesNSmith@jourrapide.com','810-455-1660','{"experience":["MI","US","Visa","Blue"]}','event0220208797','process0220208797','app0220208301'),
('thn6eeezHAN','{}','Thomas','Hanks','ThomasBHanks@gustr.com','614-415-5943','{"experience":["OH","US","Visa","Orange"]}','event0220208798','process0220208798','app0220208301'),
('lun4f5dzCOL','{}','Luz','Coleman','LuzMColeman@rhyta.com','765-339-8780','{"experience":["IN","US","MasterCard","White"]}','event0220208799','process0220208799','app0220208301'),
('den5e8azJAC','{}','Derrick','Jackson','DerrickCJackson@teleworm.us','256-723-7994','{"experience":["AL","US","MasterCard","Blue"]}','event0220208800','process0220208800','app0220208301'),
('anna80dzHAY','{}','Andrew','Haynes','AndrewCHaynes@superrito.com','610-546-0178','{"experience":["PA","US","Visa","Black"]}','event0220208801','process0220208801','app0220208301'),
('sanfbe4zSUL','{}','Sarah','Sullivan','SarahDSullivan@gustr.com','727-507-1172','{"experience":["FL","US","Visa","Yellow"]}','event0220208802','process0220208802','app0220208301'),
('syn66e9zSQU','{}','Sylvester','Squire','SylvesterPSquire@einrot.com','757-431-6969','{"experience":["VA","US","Visa","Blue"]}','event0220208803','process0220208803','app0220208301'),
('anna287zWIN','{}','Anthony','Winters','AnthonyGWinters@armyspy.com','847-327-3311','{"experience":["IL","US","MasterCard","Green"]}','event0220208804','process0220208804','app0220208301'),
('line8d1zTOR','{}','Liliana','Torres','LilianaJTorres@teleworm.us','940-328-9616','{"experience":["TX","US","MasterCard","Orange"]}','event0220208805','process0220208805','app0220208301'),
('min27ffzMAH','{}','Michelle','Mahon','MichelleSMahon@armyspy.com','407-828-2135','{"experience":["FL","US","MasterCard","Blue"]}','event0220208806','process0220208806','app0220208301'),
('jonf165zFAU','{}','Joelle','Faulkner','JoelleAFaulkner@teleworm.us','321-785-2175','{"experience":["FL","US","MasterCard","Red"]}','event0220208807','process0220208807','app0220208301'),
('man7b04zSCR','{}','Matthew','Scroggins','MatthewLScroggins@jourrapide.com','217-480-3085','{"experience":["IL","US","Visa","Blue"]}','event0220208808','process0220208808','app0220208301'),
('jan41e6zRUN','{}','Jack','Runion','JackARunion@jourrapide.com','510-952-9621','{"experience":["CA","US","Visa","Black"]}','event0220208809','process0220208809','app0220208301'),
('ron1442zCAN','{}','Robert','Cantrell','RobertCCantrell@einrot.com','401-599-8091','{"experience":["RI","US","Visa","Black"]}','event0220208810','process0220208810','app0220208301'),
('aln2ddfzTAY','{}','Alan','Taylor','AlanBTaylor@fleckens.hu','781-270-0653','{"experience":["MA","US","Visa","White"]}','event0220208811','process0220208811','app0220208301'),
('can18b5zIVE','{}','Carolyn','Ives','CarolynDIves@armyspy.com','978-826-9917','{"experience":["MA","US","MasterCard","Orange"]}','event0220208812','process0220208812','app0220208301'),
('ron4d4bzSMI','{}','Ronald','Smith','RonaldPSmith@gustr.com','260-455-1444','{"experience":["IN","US","MasterCard","Blue"]}','event0220208813','process0220208813','app0220208301'),
('ron95b7zMEY','{}','Robert','Meyers','RobertPMeyers@dayrep.com','312-739-9804','{"experience":["IL","US","Visa","Blue"]}','event0220208814','process0220208814','app0220208301'),
('pan16cdzWIL','{}','Paul','Williams','PaulJWilliams@teleworm.us','323-362-5046','{"experience":["CA","US","MasterCard","Blue"]}','event0220208815','process0220208815','app0220208301'),
('tin6a98zTOW','{}','Tiana','Townsend','TianaCTownsend@rhyta.com','412-485-7385','{"experience":["PA","US","Visa","Purple"]}','event0220208816','process0220208816','app0220208301'),
('run2073zBAR','{}','Ruth','Bartlett','RuthRBartlett@gustr.com','517-653-9616','{"experience":["MI","US","MasterCard","Purple"]}','event0220208817','process0220208817','app0220208301'),
('rincfffzCHI','{}','Richard','Chisholm','RichardNChisholm@gustr.com','201-210-2171','{"experience":["NJ","US","Visa","Blue"]}','event0220208818','process0220208818','app0220208301'),
('jen9610zGOM','{}','Jeffrey','Gomez','JeffreyKGomez@gustr.com','901-320-9586','{"experience":["TN","US","MasterCard","Red"]}','event0220208819','process0220208819','app0220208301'),
('olnab58zMIL','{}','Olevia','Milburn','OleviaHMilburn@dayrep.com','607-731-7623','{"experience":["NY","US","MasterCard","Blue"]}','event0220208820','process0220208820','app0220208301'),
('kine932zLOY','{}','Kirsten','Loyd','KirstenRLoyd@dayrep.com','607-264-1403','{"experience":["NY","US","Visa","Orange"]}','event0220208821','process0220208821','app0220208301'),
('hen9790zFON','{}','Henry','Font','HenryIFont@gustr.com','217-498-0222','{"experience":["IL","US","MasterCard","Blue"]}','event0220208822','process0220208822','app0220208301'),
('dan0f34zSWA','{}','David','Swatzell','DavidASwatzell@armyspy.com','503-357-3074','{"experience":["OR","US","Visa","Blue"]}','event0220208823','process0220208823','app0220208301'),
('syn1fa0zROB','{}','Sylvia','Robinson','SylviaRRobinson@superrito.com','262-829-8738','{"experience":["WI","US","MasterCard","Blue"]}','event0220208824','process0220208824','app0220208301'),
('lona6e2zSHE','{}','Lora','Shell','LoraLShell@teleworm.us','254-541-3240','{"experience":["TX","US","MasterCard","Blue"]}','event0220208825','process0220208825','app0220208301'),
('den4bb0zMOO','{}','Desiree','Moore','DesireeRMoore@superrito.com','432-200-0621','{"experience":["TX","US","Visa","Purple"]}','event0220208826','process0220208826','app0220208301'),
('hen60a0zMAR','{}','Heather','Marshall','HeatherGMarshall@einrot.com','308-263-7788','{"experience":["NE","US","MasterCard","Blue"]}','event0220208827','process0220208827','app0220208301'),
('jen01c4zPER','{}','Jerry','Pereira','JerryJPereira@einrot.com','210-576-1872','{"experience":["TX","US","MasterCard","Blue"]}','event0220208828','process0220208828','app0220208301'),
('mone16fzGOM','{}','Mohammed','Gomez','MohammedSGomez@jourrapide.com','443-226-1075','{"experience":["MD","US","MasterCard","Black"]}','event0220208829','process0220208829','app0220208301'),
('grne43dzSMI','{}','Greta','Smith','GretaSSmith@superrito.com','626-465-0474','{"experience":["CA","US","MasterCard","Orange"]}','event0220208830','process0220208830','app0220208301'),
('send484zLAS','{}','Sergio','Lashley','SergioPLashley@gustr.com','415-441-6863','{"experience":["CA","US","MasterCard","Red"]}','event0220208831','process0220208831','app0220208301'),
('edn9e3fzLEO','{}','Edgar','Leonardo','EdgarNLeonardo@armyspy.com','989-484-3618','{"experience":["MI","US","Visa","Blue"]}','event0220208832','process0220208832','app0220208301'),
('chn140dzCAS','{}','Christian','Castillo','ChristianMCastillo@superrito.com','417-535-6072','{"experience":["MO","US","Visa","Blue"]}','event0220208833','process0220208833','app0220208301'),
('don9f1ezLOW','{}','Douglas','Lowrance','DouglasLLowrance@dayrep.com','541-443-2725','{"experience":["OR","US","Visa","Blue"]}','event0220208834','process0220208834','app0220208301'),
('min253bzSTE','{}','Michael','Stewart','MichaelZStewart@teleworm.us','512-469-5961','{"experience":["TX","US","Visa","Blue"]}','event0220208835','process0220208835','app0220208301'),
('qunce4bzWHI','{}','Quinton','White','QuintonAWhite@rhyta.com','307-765-7598','{"experience":["WY","US","Visa","Black"]}','event0220208836','process0220208836','app0220208301'),
('man6d5ezODO','{}','Manuela','Odom','ManuelaHOdom@jourrapide.com','225-422-0632','{"experience":["LA","US","MasterCard","Orange"]}','event0220208837','process0220208837','app0220208301'),
('minb175zSTR','{}','Miguel','Strom','MiguelWStrom@cuvox.de','727-237-3697','{"experience":["FL","US","Visa","Green"]}','event0220208838','process0220208838','app0220208301'),
('manabfbzMAN','{}','Mario','Maness','MarioAManess@jourrapide.com','830-778-4840','{"experience":["TX","US","Visa","Black"]}','event0220208839','process0220208839','app0220208301'),
('zand76ezNOB','{}','Zachary','Noblitt','ZacharyLNoblitt@jourrapide.com','956-561-0757','{"experience":["TX","US","MasterCard","Green"]}','event0220208840','process0220208840','app0220208301'),
('ban473bzORT','{}','Barbara','Ortiz','BarbaraFOrtiz@fleckens.hu','507-553-6038','{"experience":["MN","US","MasterCard","Purple"]}','event0220208841','process0220208841','app0220208301'),
('annd606zHAR','{}','Annette','Harkins','AnnetteRHarkins@armyspy.com','772-781-6699','{"experience":["FL","US","Visa","Green"]}','event0220208842','process0220208842','app0220208301'),
('jancbfezBAN','{}','James','Banks','JamesGBanks@armyspy.com','415-403-0970','{"experience":["CA","US","Visa","Red"]}','event0220208843','process0220208843','app0220208301'),
('dan8491zMOO','{}','David','Moon','DavidJMoon@cuvox.de','631-955-8377','{"experience":["NY","US","Visa","Blue"]}','event0220208844','process0220208844','app0220208301'),
('bon7f5azNIS','{}','Bobby','Nishida','BobbyKNishida@armyspy.com','973-382-3890','{"experience":["NJ","US","MasterCard","Green"]}','event0220208845','process0220208845','app0220208301'),
('han8cd2zREA','{}','Harry','Real','HarryHReal@gustr.com','803-829-3972','{"experience":["SC","US","MasterCard","Blue"]}','event0220208846','process0220208846','app0220208301'),
('lan528fzCAS','{}','Lara','Castaneda','LaraJCastaneda@teleworm.us','810-678-0948','{"experience":["MI","US","Visa","Purple"]}','event0220208847','process0220208847','app0220208301'),
('ninf512zWIL','{}','Nilda','Wills','NildaAWills@fleckens.hu','443-575-5337','{"experience":["MD","US","MasterCard","Blue"]}','event0220208848','process0220208848','app0220208301'),
('hon664czCHA','{}','Howard','Chavez','HowardBChavez@einrot.com','816-920-5002','{"experience":["MO","US","Visa","Blue"]}','event0220208849','process0220208849','app0220208301'),
('jena90azPAR','{}','Jeremy','Parker','JeremyNParker@gustr.com','785-871-1460','{"experience":["KS","US","MasterCard","Green"]}','event0220208850','process0220208850','app0220208301'),
('ron74b6zWHA','{}','Rosa','Whatley','RosaDWhatley@teleworm.us','410-939-3293','{"experience":["MD","US","MasterCard","Brown"]}','event0220208851','process0220208851','app0220208301'),
('rin3f06zLYN','{}','Richard','Lynn','RichardVLynn@jourrapide.com','870-577-0123','{"experience":["AR","US","Visa","Blue"]}','event0220208852','process0220208852','app0220208301'),
('hon34f7zDAV','{}','Houston','Davis','HoustonADavis@cuvox.de','904-918-2149','{"experience":["FL","US","Visa","Blue"]}','event0220208853','process0220208853','app0220208301'),
('ginb06czANA','{}','Ginger','Anaya','GingerJAnaya@jourrapide.com','828-361-3638','{"experience":["NC","US","MasterCard","Blue"]}','event0220208854','process0220208854','app0220208301'),
('ain724ezJAM','{}','Aida','James','AidaBJames@dayrep.com','678-708-5913','{"experience":["GA","US","MasterCard","Blue"]}','event0220208855','process0220208855','app0220208301'),
('jenc161zNOL','{}','Jeffrey','Noles','JeffreyCNoles@rhyta.com','704-722-0751','{"experience":["NC","US","Visa","Blue"]}','event0220208856','process0220208856','app0220208301'),
('den2cd5zREI','{}','Deborah','Reiber','DeborahEReiber@einrot.com','618-327-4717','{"experience":["IL","US","MasterCard","Blue"]}','event0220208857','process0220208857','app0220208301'),
('thnc4abzGAV','{}','Thomas','Gavin','ThomasLGavin@gustr.com','870-589-8954','{"experience":["AR","US","MasterCard","Blue"]}','event0220208858','process0220208858','app0220208301'),
('ten366czCHA','{}','Teresa','Chandler','TeresaBChandler@rhyta.com','214-863-6936','{"experience":["TX","US","Visa","Blue"]}','event0220208859','process0220208859','app0220208301'),
('run13b8zEDW','{}','Ruth','Edwards','RuthSEdwards@dayrep.com','949-303-0173','{"experience":["CA","US","Visa","Green"]}','event0220208860','process0220208860','app0220208301'),
('man5a65zBER','{}','Mabel','Berning','MabelJBerning@teleworm.us','714-928-3762','{"experience":["CA","US","MasterCard","Blue"]}','event0220208861','process0220208861','app0220208301'),
('jen5cdfzLEM','{}','Jean','Lemons','JeanHLemons@superrito.com','810-744-2052','{"experience":["MI","US","MasterCard","Blue"]}','event0220208862','process0220208862','app0220208301'),
('jan6752zPAR','{}','James','Parker','JamesJParker@einrot.com','610-653-1669','{"experience":["PA","US","Visa","Red"]}','event0220208863','process0220208863','app0220208301'),
('trn017bzTEA','{}','Trina','Teal','TrinaBTeal@jourrapide.com','480-834-9970','{"experience":["AZ","US","Visa","Yellow"]}','event0220208864','process0220208864','app0220208301'),
('jend91fzBLA','{}','Jeanne','Black','JeanneGBlack@cuvox.de','630-251-0750','{"experience":["IL","US","Visa","Green"]}','event0220208865','process0220208865','app0220208301'),
('mand4f8zKIT','{}','Mark','Kitchens','MarkRKitchens@gustr.com','843-484-2319','{"experience":["SC","US","Visa","Blue"]}','event0220208866','process0220208866','app0220208301'),
('jenb3d0zCLA','{}','Jeremiah','Clark','JeremiahAClark@armyspy.com','607-327-7169','{"experience":["NY","US","Visa","Black"]}','event0220208867','process0220208867','app0220208301'),
('nan4cb1zPRE','{}','Nancy','Preston','NancyRPreston@superrito.com','620-338-6974','{"experience":["KS","US","MasterCard","Blue"]}','event0220208868','process0220208868','app0220208301'),
('sund503zTHO','{}','Sunny','Thomas','SunnyJThomas@cuvox.de','541-575-5528','{"experience":["OR","US","MasterCard","Blue"]}','event0220208869','process0220208869','app0220208301'),
('den56d8zGIB','{}','Debra','Gibbens','DebraSGibbens@armyspy.com','919-583-5460','{"experience":["NC","US","MasterCard","Blue"]}','event0220208870','process0220208870','app0220208301'),
('ron9ee1zPEN','{}','Roberto','Pennington','RobertoEPennington@armyspy.com','505-397-6765','{"experience":["NM","US","Visa","Silver"]}','event0220208871','process0220208871','app0220208301'),
('hen7fabzHUR','{}','Henry','Hurt','HenryAHurt@jourrapide.com','303-979-2784','{"experience":["CO","US","Visa","Blue"]}','event0220208872','process0220208872','app0220208301'),
('elnc2cbzMOR','{}','Eloy','Morley','EloyEMorley@teleworm.us','305-698-3653','{"experience":["FL","US","MasterCard","Black"]}','event0220208873','process0220208873','app0220208301'),
('jan93b4zPAY','{}','James','Payson','JamesMPayson@teleworm.us','201-708-2371','{"experience":["NJ","US","Visa","Green"]}','event0220208874','process0220208874','app0220208301'),
('loneb63zTUR','{}','Louis','Turco','LouisKTurco@rhyta.com','312-730-7587','{"experience":["IL","US","MasterCard","Green"]}','event0220208875','process0220208875','app0220208301'),
('ban56cdzMIL','{}','Barbara','Million','BarbaraHMillion@superrito.com','260-856-4149','{"experience":["IN","US","MasterCard","Red"]}','event0220208876','process0220208876','app0220208301'),
('nan4d37zMIL','{}','Nathan','Miller','NathanMMiller@teleworm.us','830-555-2543','{"experience":["TX","US","Visa","Blue"]}','event0220208877','process0220208877','app0220208301'),
('shnb827zBER','{}','Shelley','Bergeron','ShelleyEBergeron@rhyta.com','417-347-7420','{"experience":["MO","US","MasterCard","Green"]}','event0220208878','process0220208878','app0220208301'),
('jon22cczCAR','{}','John','Carter','JohnHCarter@fleckens.hu','505-404-7010','{"experience":["NM","US","MasterCard","Green"]}','event0220208879','process0220208879','app0220208301'),
('cana3cfzTUC','{}','Carol','Tucker','CarolLTucker@einrot.com','281-371-2030','{"experience":["TX","US","MasterCard","Blue"]}','event0220208880','process0220208880','app0220208301'),
('chn49d0zCHA','{}','Charlotte','Charity','CharlotteECharity@dayrep.com','563-742-2270','{"experience":["IA","US","MasterCard","Black"]}','event0220208881','process0220208881','app0220208301'),
('aln124azTOR','{}','Alice','Torres','AliceRTorres@dayrep.com','601-409-6091','{"experience":["MS","US","Visa","Blue"]}','event0220208882','process0220208882','app0220208301'),
('ganc9fazAPO','{}','Garland','Aponte','GarlandEAponte@teleworm.us','805-965-0956','{"experience":["CA","US","MasterCard","Black"]}','event0220208883','process0220208883','app0220208301'),
('bin1ff9zRHE','{}','Bill','Rhea','BillRRhea@teleworm.us','732-916-7571','{"experience":["NJ","US","Visa","White"]}','event0220208884','process0220208884','app0220208301'),
('henc23ezBRO','{}','Heather','Bronson','HeatherDBronson@armyspy.com','937-987-0877','{"experience":["OH","US","MasterCard","Blue"]}','event0220208885','process0220208885','app0220208301'),
('ven13e4zLOZ','{}','Verna','Lozano','VernaMLozano@teleworm.us','561-383-0381','{"experience":["FL","US","MasterCard","Green"]}','event0220208886','process0220208886','app0220208301'),
('cin402ezFRE','{}','Cindy','Fredrickson','CindyDFredrickson@cuvox.de','413-248-2568','{"experience":["MA","US","Visa","Blue"]}','event0220208887','process0220208887','app0220208301'),
('man942dzHAY','{}','Mae','Haynes','MaeJHaynes@armyspy.com','573-565-1877','{"experience":["MO","US","Visa","Purple"]}','event0220208888','process0220208888','app0220208301'),
('chn6baczRAD','{}','Cheryl','Radtke','CherylJRadtke@superrito.com','213-747-9890','{"experience":["CA","US","Visa","Blue"]}','event0220208889','process0220208889','app0220208301'),
('jon77f0zTUN','{}','John','Tunney','JohnJTunney@armyspy.com','478-442-6505','{"experience":["GA","US","Visa","Black"]}','event0220208890','process0220208890','app0220208301'),
('mana2ddzFIS','{}','Marvin','Fischer','MarvinCFischer@einrot.com','402-576-6344','{"experience":["NE","US","MasterCard","Black"]}','event0220208891','process0220208891','app0220208301'),
('donb31dzHOR','{}','Douglas','Horvath','DouglasLHorvath@jourrapide.com','907-722-2787','{"experience":["AK","US","Visa","Blue"]}','event0220208892','process0220208892','app0220208301'),
('alnda70zWIL','{}','Albert','Wilkinson','AlbertAWilkinson@jourrapide.com','703-761-4270','{"experience":["VA","US","MasterCard","Blue"]}','event0220208893','process0220208893','app0220208301'),
('win6957zCOU','{}','Willie','Cousins','WillieGCousins@einrot.com','713-862-7707','{"experience":["TX","US","MasterCard","Purple"]}','event0220208894','process0220208894','app0220208301'),
('grn5118zGRA','{}','Gregory','Granger','GregoryMGranger@armyspy.com','256-850-4313','{"experience":["AL","US","Visa","Black"]}','event0220208895','process0220208895','app0220208301'),
('frn8671zKEE','{}','Fred','Keen','FredTKeen@einrot.com','805-361-2723','{"experience":["CA","US","Visa","Blue"]}','event0220208896','process0220208896','app0220208301'),
('fana2e4zTIN','{}','Fay','Tinker','FayRTinker@teleworm.us','832-738-6950','{"experience":["TX","US","Visa","Blue"]}','event0220208897','process0220208897','app0220208301'),
('manbeb5zESP','{}','Mark','Espinosa','MarkSEspinosa@teleworm.us','509-660-4281','{"experience":["WA","US","Visa","Blue"]}','event0220208898','process0220208898','app0220208301'),
('alnd163zSCH','{}','Alton','Schlosser','AltonGSchlosser@einrot.com','212-314-9420','{"experience":["NY","US","MasterCard","Green"]}','event0220208899','process0220208899','app0220208301'),
('stn813fzSMI','{}','Steve','Smith','SteveCSmith@superrito.com','760-252-3188','{"experience":["CA","US","Visa","Green"]}','event0220208900','process0220208900','app0220208301'),
('jen9340zALL','{}','Jerry','Allen','JerryAAllen@einrot.com','213-342-3877','{"experience":["CA","US","Visa","Green"]}','event0220208901','process0220208901','app0220208301'),
('jonf9fdzLIN','{}','Joseph','Lindsey','JosephJLindsey@superrito.com','313-206-5926','{"experience":["MI","US","MasterCard","Blue"]}','event0220208902','process0220208902','app0220208301'),
('gan1edfzSMI','{}','Gary','Smith','GaryGSmith@einrot.com','707-285-4557','{"experience":["CA","US","Visa","Blue"]}','event0220208903','process0220208903','app0220208301'),
('ren1773zLOP','{}','Reginald','Lopez','ReginaldMLopez@rhyta.com','239-463-2390','{"experience":["FL","US","MasterCard","Blue"]}','event0220208904','process0220208904','app0220208301'),
('jon3891zLAM','{}','Joshua','Lamb','JoshuaLLamb@superrito.com','620-724-4301','{"experience":["KS","US","Visa","Green"]}','event0220208905','process0220208905','app0220208301'),
('tinc7e8zMYE','{}','Tim','Myers','TimDMyers@teleworm.us','863-314-7937','{"experience":["FL","US","MasterCard","Blue"]}','event0220208906','process0220208906','app0220208301'),
('panac43zHEL','{}','Paul','Hellman','PaulCHellman@rhyta.com','323-270-9579','{"experience":["CA","US","MasterCard","Blue"]}','event0220208907','process0220208907','app0220208301'),
('hene7cezDIC','{}','Henry','Dickerson','HenryRDickerson@dayrep.com','305-227-7508','{"experience":["FL","US","Visa","Orange"]}','event0220208908','process0220208908','app0220208301'),
('pan6228zWIL','{}','Paul','Wilson','PaulRWilson@teleworm.us','503-575-3163','{"experience":["OR","US","MasterCard","Blue"]}','event0220208909','process0220208909','app0220208301'),
('lona54bzRIL','{}','Loretta','Riley','LorettaMRiley@armyspy.com','501-454-6040','{"experience":["AR","US","MasterCard","Purple"]}','event0220208910','process0220208910','app0220208301'),
('jonb186zCHA','{}','Jonathan','Chavez','JonathanNChavez@superrito.com','845-875-5491','{"experience":["NY","US","Visa","Silver"]}','event0220208911','process0220208911','app0220208301'),
('ern051fzLEM','{}','Erica','Leming','EricaBLeming@gustr.com','815-738-1959','{"experience":["IL","US","MasterCard","Blue"]}','event0220208912','process0220208912','app0220208301'),
('danedc3zPER','{}','Danny','Perez','DannyEPerez@dayrep.com','740-686-3225','{"experience":["OH","US","MasterCard","Red"]}','event0220208913','process0220208913','app0220208301'),
('lin6c2czBAR','{}','Lillian','Barco','LillianIBarco@gustr.com','219-912-6492','{"experience":["IN","US","MasterCard","Purple"]}','event0220208914','process0220208914','app0220208301'),
('mine50bzBIG','{}','Michael','Biggs','MichaelLBiggs@einrot.com','630-576-1432','{"experience":["IL","US","MasterCard","Green"]}','event0220208915','process0220208915','app0220208301'),
('mon2d8czWEY','{}','Monique','Weymouth','MoniqueTWeymouth@teleworm.us','925-667-7678','{"experience":["CA","US","MasterCard","Black"]}','event0220208916','process0220208916','app0220208301'),
('min2e81zBUR','{}','Michael','Burke','MichaelKBurke@rhyta.com','618-294-5803','{"experience":["IL","US","MasterCard","Blue"]}','event0220208917','process0220208917','app0220208301'),
('ron7795zPAR','{}','Roger','Parrott','RogerEParrott@armyspy.com','510-952-1977','{"experience":["CA","US","MasterCard","Blue"]}','event0220208918','process0220208918','app0220208301'),
('fande67zKOC','{}','Fannie','Koch','FannieTKoch@rhyta.com','626-850-1754','{"experience":["CA","US","MasterCard","Black"]}','event0220208919','process0220208919','app0220208301'),
('can0daazDOW','{}','Carolyn','Downing','CarolynBDowning@jourrapide.com','404-582-0468','{"experience":["GA","US","MasterCard","Blue"]}','event0220208920','process0220208920','app0220208301'),
('ivnde73zPIE','{}','Ivan','Pieper','IvanCPieper@rhyta.com','979-753-9684','{"experience":["TX","US","Visa","Green"]}','event0220208921','process0220208921','app0220208301'),
('isnfcb3zJAY','{}','Isaac','Jaynes','IsaacKJaynes@superrito.com','601-981-4287','{"experience":["MS","US","MasterCard","Blue"]}','event0220208922','process0220208922','app0220208301'),
('renc717zWHI','{}','Renee','White','ReneeJWhite@teleworm.us','815-346-6905','{"experience":["IL","US","Visa","Purple"]}','event0220208923','process0220208923','app0220208301'),
('nin900bzTHI','{}','Nicole','Thibodeau','NicoleJThibodeau@superrito.com','760-355-0522','{"experience":["CA","US","Visa","Purple"]}','event0220208924','process0220208924','app0220208301'),
('linc37dzLET','{}','Linda','Leto','LindaMLeto@einrot.com','781-850-8424','{"experience":["MA","US","MasterCard","Green"]}','event0220208925','process0220208925','app0220208301'),
('man042fzMAR','{}','Mary','Marcellus','MaryPMarcellus@jourrapide.com','843-231-4442','{"experience":["SC","US","MasterCard","Purple"]}','event0220208926','process0220208926','app0220208301'),
('jon2edczGOU','{}','John','Gourdine','JohnKGourdine@jourrapide.com','804-204-4743','{"experience":["VA","US","MasterCard","Red"]}','event0220208927','process0220208927','app0220208301'),
('men4549zHEP','{}','Melissa','Hepp','MelissaJHepp@jourrapide.com','319-854-1340','{"experience":["IA","US","Visa","Black"]}','event0220208928','process0220208928','app0220208301'),
('tona0e2zMOS','{}','Tonya','Moses','TonyaPMoses@fleckens.hu','615-743-5575','{"experience":["TN","US","MasterCard","Red"]}','event0220208929','process0220208929','app0220208301'),
('jund2fczGON','{}','Justin','Gonzalez','JustinMGonzalez@fleckens.hu','720-851-1232','{"experience":["CO","US","Visa","Red"]}','event0220208930','process0220208930','app0220208301'),
('hun9489zDAV','{}','Hugh','Davis','HughCDavis@armyspy.com','989-578-1996','{"experience":["MI","US","MasterCard","Red"]}','event0220208931','process0220208931','app0220208301'),
('chn77a1zMIN','{}','Chadwick','Minton','ChadwickCMinton@dayrep.com','608-842-7895','{"experience":["WI","US","Visa","Orange"]}','event0220208932','process0220208932','app0220208301'),
('frna299zCRA','{}','Frank','Crawford','FrankMCrawford@jourrapide.com','410-722-3371','{"experience":["MD","US","Visa","Blue"]}','event0220208933','process0220208933','app0220208301'),
('annce4bzSHO','{}','Antoinette','Shook','AntoinetteRShook@jourrapide.com','731-209-6046','{"experience":["TN","US","Visa","Purple"]}','event0220208934','process0220208934','app0220208301'),
('myn0990zFOR','{}','Myrtle','Ford','MyrtleNFord@rhyta.com','773-584-4466','{"experience":["IL","US","Visa","Red"]}','event0220208935','process0220208935','app0220208301'),
('thn20b0zHOU','{}','Thomas','Houston','ThomasRHouston@fleckens.hu','205-901-1726','{"experience":["AL","US","MasterCard","Green"]}','event0220208936','process0220208936','app0220208301'),
('chn0c54zWOL','{}','Christopher','Wolfe','ChristopherMWolfe@teleworm.us','425-407-4739','{"experience":["WA","US","MasterCard","Red"]}','event0220208937','process0220208937','app0220208301'),
('pan6c66zWIL','{}','Patricia','Williams','PatriciaPWilliams@einrot.com','804-277-9176','{"experience":["VA","US","MasterCard","Blue"]}','event0220208938','process0220208938','app0220208301'),
('panb1cazEID','{}','Patricia','Eide','PatriciaJEide@fleckens.hu','903-749-5452','{"experience":["TX","US","MasterCard","Blue"]}','event0220208939','process0220208939','app0220208301'),
('pen2485zFOX','{}','Peggy','Fox','PeggyEFox@einrot.com','325-277-2668','{"experience":["TX","US","MasterCard","Purple"]}','event0220208940','process0220208940','app0220208301'),
('amn385azEWI','{}','Amelia','Ewing','AmeliaCEwing@teleworm.us','402-364-2750','{"experience":["NE","US","MasterCard","Blue"]}','event0220208941','process0220208941','app0220208301'),
('brna5d6zLUC','{}','Brenda','Luckett','BrendaWLuckett@jourrapide.com','828-324-4330','{"experience":["NC","US","MasterCard","Purple"]}','event0220208942','process0220208942','app0220208301'),
('mane5a3zJEF','{}','Max','Jefcoat','MaxAJefcoat@armyspy.com','805-565-4372','{"experience":["CA","US","MasterCard","Black"]}','event0220208943','process0220208943','app0220208301'),
('lenb8fdzGOL','{}','Levi','Golson','LeviNGolson@einrot.com','505-747-5941','{"experience":["NM","US","Visa","Blue"]}','event0220208944','process0220208944','app0220208301'),
('monb518zBAR','{}','Mohammad','Barnett','MohammadLBarnett@superrito.com','925-807-8121','{"experience":["CA","US","MasterCard","Blue"]}','event0220208945','process0220208945','app0220208301'),
('anncd9fzSCH','{}','Angela','Schmidt','AngelaBSchmidt@einrot.com','770-493-6065','{"experience":["GA","US","Visa","Brown"]}','event0220208946','process0220208946','app0220208301'),
('ronb142zOUE','{}','Robert','Ouellette','RobertMOuellette@superrito.com','646-361-7928','{"experience":["NY","US","Visa","Red"]}','event0220208947','process0220208947','app0220208301'),
('jane02czHOR','{}','James','Horne','JamesAHorne@fleckens.hu','740-585-9916','{"experience":["OH","US","MasterCard","Black"]}','event0220208948','process0220208948','app0220208301'),
('juna22ezROS','{}','Judith','Rosen','JudithJRosen@gustr.com','614-249-2647','{"experience":["OH","US","MasterCard","Brown"]}','event0220208949','process0220208949','app0220208301'),
('eln9affzSCH','{}','Elizabeth','Schaffer','ElizabethGSchaffer@jourrapide.com','520-921-0062','{"experience":["AZ","US","Visa","Blue"]}','event0220208950','process0220208950','app0220208301'),
('gan685dzRAS','{}','Gary','Rasberry','GaryCRasberry@einrot.com','775-468-2942','{"experience":["NV","US","Visa","Blue"]}','event0220208951','process0220208951','app0220208301'),
('ran6f84zCOX','{}','Ralph','Cox','RalphCCox@teleworm.us','770-452-1275','{"experience":["GA","US","Visa","Blue"]}','event0220208952','process0220208952','app0220208301'),
('ron823azBOY','{}','Robert','Boyd','RobertJBoyd@teleworm.us','734-972-4415','{"experience":["MI","US","MasterCard","Blue"]}','event0220208953','process0220208953','app0220208301'),
('len9313zCRA','{}','Lena','Cranford','LenaJCranford@jourrapide.com','814-487-1438','{"experience":["PA","US","Visa","Red"]}','event0220208954','process0220208954','app0220208301'),
('mincec4zKNU','{}','Michele','Knudsen','MicheleBKnudsen@cuvox.de','253-893-7515','{"experience":["WA","US","MasterCard","Blue"]}','event0220208955','process0220208955','app0220208301'),
('linba83zHOD','{}','Lisa','Hodgson','LisaDHodgson@superrito.com','734-573-8421','{"experience":["MI","US","MasterCard","Purple"]}','event0220208956','process0220208956','app0220208301'),
('ronaa0dzSTE','{}','Robert','Stecker','RobertRStecker@superrito.com','757-484-4985','{"experience":["VA","US","MasterCard","Black"]}','event0220208957','process0220208957','app0220208301'),
('adnc22ezMAS','{}','Adam','Masten','AdamSMasten@rhyta.com','857-366-8833','{"experience":["MA","US","MasterCard","Blue"]}','event0220208958','process0220208958','app0220208301'),
('brne8cfzSAW','{}','Brenda','Sawyer','BrendaCSawyer@fleckens.hu','815-227-8678','{"experience":["IL","US","MasterCard","Blue"]}','event0220208959','process0220208959','app0220208301'),
('jon425czHAM','{}','Joann','Hamilton','JoannFHamilton@rhyta.com','320-833-0565','{"experience":["MN","US","MasterCard","Purple"]}','event0220208960','process0220208960','app0220208301'),
('man0a36zRAC','{}','Margaret','Rackers','MargaretTRackers@dayrep.com','775-347-8142','{"experience":["NV","US","MasterCard","Purple"]}','event0220208961','process0220208961','app0220208301'),
('chne0f6zDOD','{}','Christopher','Dodson','ChristopherLDodson@dayrep.com','301-362-4018','{"experience":["MD","US","Visa","Blue"]}','event0220208962','process0220208962','app0220208301'),
('kandb96zDEL','{}','Kathleen','Delafuente','KathleenMDelafuente@superrito.com','516-328-3712','{"experience":["NY","US","Visa","Blue"]}','event0220208963','process0220208963','app0220208301'),
('edn4063zMCD','{}','Edward','McDaniels','EdwardQMcDaniels@armyspy.com','646-704-1708','{"experience":["NY","US","MasterCard","Red"]}','event0220208964','process0220208964','app0220208301'),
('lunc33ezART','{}','Lucien','Arthur','LucienLArthur@superrito.com','765-358-8148','{"experience":["IN","US","Visa","Black"]}','event0220208965','process0220208965','app0220208301'),
('lin5bbezLYN','{}','Linda','Lynn','LindaRLynn@armyspy.com','217-831-5579','{"experience":["IL","US","Visa","Purple"]}','event0220208966','process0220208966','app0220208301'),
('win7779zODL','{}','William','Odle','WilliamBOdle@dayrep.com','562-941-4141','{"experience":["CA","US","MasterCard","Blue"]}','event0220208967','process0220208967','app0220208301'),
('phnef96zGOD','{}','Phyllis','Goddard','PhyllisJGoddard@fleckens.hu','631-445-8316','{"experience":["NY","US","Visa","Blue"]}','event0220208968','process0220208968','app0220208301'),
('canc142zMAR','{}','Casey','Marks','CaseyDMarks@jourrapide.com','734-281-1876','{"experience":["MI","US","MasterCard","Blue"]}','event0220208969','process0220208969','app0220208301'),
('stn5404zBAL','{}','Steven','Ballard','StevenPBallard@cuvox.de','336-922-0498','{"experience":["NC","US","MasterCard","Blue"]}','event0220208970','process0220208970','app0220208301'),
('aln26cdzGOM','{}','Allen','Gomez','AllenAGomez@cuvox.de','954-516-3926','{"experience":["FL","US","MasterCard","Blue"]}','event0220208971','process0220208971','app0220208301'),
('edn4d81zWIL','{}','Edwin','Williams','EdwinJWilliams@superrito.com','408-866-9968','{"experience":["CA","US","MasterCard","Silver"]}','event0220208972','process0220208972','app0220208301'),
('aln419bzCLA','{}','Allison','Clarkson','AllisonDClarkson@superrito.com','906-369-9664','{"experience":["MI","US","Visa","Blue"]}','event0220208973','process0220208973','app0220208301'),
('ronf031zCAS','{}','Ronald','Cash','RonaldMCash@jourrapide.com','910-949-9797','{"experience":["NC","US","Visa","Black"]}','event0220208974','process0220208974','app0220208301'),
('lenc70ezLUN','{}','Leon','Luna','LeonRLuna@einrot.com','914-500-7170','{"experience":["NY","US","MasterCard","Blue"]}','event0220208975','process0220208975','app0220208301'),
('rin5210zMON','{}','Richard','Montez','RichardAMontez@teleworm.us','956-467-7389','{"experience":["TX","US","MasterCard","Blue"]}','event0220208976','process0220208976','app0220208301'),
('jon5184zOLD','{}','Joan','Oldaker','JoanKOldaker@gustr.com','850-410-0007','{"experience":["FL","US","MasterCard","Silver"]}','event0220208977','process0220208977','app0220208301'),
('frnbd00zTAB','{}','Francis','Tabor','FrancisVTabor@armyspy.com','732-692-1070','{"experience":["NJ","US","Visa","White"]}','event0220208978','process0220208978','app0220208301'),
('cen9a9fzJOY','{}','Cecelia','Joyce','CeceliaPJoyce@superrito.com','503-384-5363','{"experience":["OR","US","Visa","Purple"]}','event0220208979','process0220208979','app0220208301'),
('chn8314zNOR','{}','Charlene','Norris','CharleneSNorris@fleckens.hu','724-371-7030','{"experience":["PA","US","Visa","Blue"]}','event0220208980','process0220208980','app0220208301'),
('scn9fe0zMAC','{}','Scott','Macmillan','ScottVMacmillan@cuvox.de','336-424-2880','{"experience":["NC","US","Visa","Blue"]}','event0220208981','process0220208981','app0220208301'),
('sunfc0dzSNE','{}','Susan','Snell','SusanESnell@rhyta.com','618-978-2364','{"experience":["IL","US","Visa","Green"]}','event0220208982','process0220208982','app0220208301'),
('jon4a0bzAND','{}','John','Anderson','JohnTAnderson@armyspy.com','870-654-7605','{"experience":["AR","US","Visa","Silver"]}','event0220208983','process0220208983','app0220208301'),
('jonc56fzWAL','{}','Jonathan','Walters','JonathanPWalters@jourrapide.com','765-963-5271','{"experience":["IN","US","Visa","Orange"]}','event0220208984','process0220208984','app0220208301'),
('janccd5zLAT','{}','Jacqueline','Lathrop','JacquelineMLathrop@rhyta.com','423-772-8492','{"experience":["TN","US","MasterCard","Blue"]}','event0220208985','process0220208985','app0220208301'),
('etn429bzELM','{}','Ethel','Elmore','EthelDElmore@superrito.com','678-323-3119','{"experience":["GA","US","Visa","Blue"]}','event0220208986','process0220208986','app0220208301'),
('frn4b58zCOL','{}','Frederick','Cole','FrederickJCole@superrito.com','512-470-5135','{"experience":["TX","US","Visa","Black"]}','event0220208987','process0220208987','app0220208301'),
('genb962zTAY','{}','Gerald','Taylor','GeraldRTaylor@cuvox.de','206-548-7452','{"experience":["WA","US","Visa","Blue"]}','event0220208988','process0220208988','app0220208301'),
('lanbdbdzMAU','{}','Lazaro','Maule','LazaroEMaule@dayrep.com','410-871-9143','{"experience":["MD","US","MasterCard","Blue"]}','event0220208989','process0220208989','app0220208301'),
('can43edzHAR','{}','Carmen','Harris','CarmenJHarris@fleckens.hu','740-663-6243','{"experience":["OH","US","Visa","Blue"]}','event0220208990','process0220208990','app0220208301'),
('lon9ce4zDEA','{}','Louise','Dean','LouiseTDean@gustr.com','847-975-4976','{"experience":["IL","US","Visa","Purple"]}','event0220208991','process0220208991','app0220208301'),
('jan942bzNOG','{}','James','Noguera','JamesENoguera@einrot.com','706-286-0668','{"experience":["GA","US","MasterCard","Silver"]}','event0220208992','process0220208992','app0220208301'),
('san718ezBRA','{}','Sandra','Braswell','SandraEBraswell@dayrep.com','856-792-0661','{"experience":["NJ","US","MasterCard","Blue"]}','event0220208993','process0220208993','app0220208301'),
('manbfc3zCAR','{}','Marjorie','Carrier','MarjorieDCarrier@einrot.com','540-579-3833','{"experience":["VA","US","MasterCard","Yellow"]}','event0220208994','process0220208994','app0220208301'),
('hynd160zHAL','{}','Hyon','Hall','HyonKHall@cuvox.de','336-886-5216','{"experience":["NC","US","Visa","Green"]}','event0220208995','process0220208995','app0220208301'),
('kynb1c5zLEE','{}','Kyle','Lee','KyleJLee@dayrep.com','559-392-1504','{"experience":["CA","US","MasterCard","White"]}','event0220208996','process0220208996','app0220208301'),
('genddbazJAC','{}','Geraldine','Jackson','GeraldineGJackson@gustr.com','615-795-3733','{"experience":["TN","US","MasterCard","Purple"]}','event0220208997','process0220208997','app0220208301'),
('rane69dzPER','{}','Ralph','Perez','RalphTPerez@superrito.com','615-985-1295','{"experience":["TN","US","Visa","Green"]}','event0220208998','process0220208998','app0220208301'),
('ronea76zWAL','{}','Robin','Walcott','RobinKWalcott@jourrapide.com','407-701-9371','{"experience":["FL","US","Visa","Green"]}','event0220208999','process0220208999','app0220208301'),
('kin7addzHOL','{}','Kirk','Holton','KirkBHolton@fleckens.hu','970-477-5538','{"experience":["CO","US","Visa","Green"]}','event0220209000','process0220209000','app0220208301'),
('jondf9dzDOD','{}','Joseph','Dodson','JosephBDodson@jourrapide.com','573-757-7759','{"experience":["MO","US","MasterCard","Blue"]}','event0220209001','process0220209001','app0220208301'),
('run372ezCOL','{}','Rudy','Coleman','RudyMColeman@jourrapide.com','609-668-9360','{"experience":["NJ","US","MasterCard","Blue"]}','event0220209002','process0220209002','app0220208301'),
('jan0625zVAN','{}','Jamie','Vandyke','JamieKVandyke@rhyta.com','309-828-4995','{"experience":["IL","US","Visa","Purple"]}','event0220209003','process0220209003','app0220208301'),
('nanb178zBRO','{}','Nancy','Brown','NancyHBrown@armyspy.com','203-630-2432','{"experience":["CT","US","Visa","Blue"]}','event0220209004','process0220209004','app0220208301'),
('elnf496zPRE','{}','Eliza','Prewitt','ElizaCPrewitt@jourrapide.com','321-506-3731','{"experience":["FL","US","MasterCard","Purple"]}','event0220209005','process0220209005','app0220208301'),
('brn094bzBRO','{}','Bruce','Brooks','BruceMBrooks@armyspy.com','580-544-9838','{"experience":["OK","US","MasterCard","Blue"]}','event0220209006','process0220209006','app0220208301'),
('dinf14dzCAH','{}','Diane','Cahill','DianeMCahill@rhyta.com','513-369-9618','{"experience":["OH","US","MasterCard","Blue"]}','event0220209007','process0220209007','app0220208301'),
('jon91bdzFRA','{}','Joseph','Frazier','JosephAFrazier@dayrep.com','608-758-2427','{"experience":["WI","US","Visa","White"]}','event0220209008','process0220209008','app0220208301'),
('canaef9zTHO','{}','Carol','Thompson','CarolEThompson@rhyta.com','662-644-2295','{"experience":["MS","US","Visa","Blue"]}','event0220209009','process0220209009','app0220208301'),
('rynd77dzDAV','{}','Ryan','Davis','RyanCDavis@armyspy.com','662-627-2511','{"experience":["MS","US","MasterCard","Green"]}','event0220209010','process0220209010','app0220208301'),
('lenfbfazBUC','{}','Lena','Buckley','LenaWBuckley@superrito.com','925-677-7150','{"experience":["CA","US","MasterCard","Blue"]}','event0220209011','process0220209011','app0220208301'),
('man2586zHUL','{}','Mary','Hull','MaryRHull@superrito.com','818-738-3294','{"experience":["CA","US","Visa","Black"]}','event0220209012','process0220209012','app0220208301'),
('annf87fzBOW','{}','Angela','Bowman','AngelaTBowman@gustr.com','517-675-6546','{"experience":["MI","US","Visa","Purple"]}','event0220209013','process0220209013','app0220208301'),
('jon83e2zDEX','{}','Joan','Dexter','JoanDDexter@cuvox.de','478-224-9936','{"experience":["GA","US","MasterCard","Black"]}','event0220209014','process0220209014','app0220208301'),
('cane67azFOX','{}','Catherine','Fox','CatherinePFox@rhyta.com','903-256-8112','{"experience":["TX","US","MasterCard","Blue"]}','event0220209015','process0220209015','app0220208301'),
('ann94ffzGUN','{}','Anne','Gunter','AnneMGunter@einrot.com','262-504-5124','{"experience":["WI","US","MasterCard","Purple"]}','event0220209016','process0220209016','app0220208301'),
('rin4c44zRIV','{}','Richard','Rivera','RichardBRivera@gustr.com','817-670-6770','{"experience":["TX","US","MasterCard","Black"]}','event0220209017','process0220209017','app0220208301'),
('phn8570zJON','{}','Phillip','Jones','PhillipLJones@armyspy.com','479-721-6136','{"experience":["AR","US","MasterCard","Blue"]}','event0220209018','process0220209018','app0220208301'),
('don5e36zBUR','{}','Dorothy','Burnett','DorothyJBurnett@armyspy.com','910-679-7937','{"experience":["NC","US","MasterCard","Yellow"]}','event0220209019','process0220209019','app0220208301'),
('brncf7bzAND','{}','Brent','Anderson','BrentKAnderson@armyspy.com','773-276-3833','{"experience":["IL","US","Visa","Orange"]}','event0220209020','process0220209020','app0220208301'),
('mon68c3zBLE','{}','Mozell','Blevins','MozellCBlevins@gustr.com','832-565-8364','{"experience":["TX","US","MasterCard","Blue"]}','event0220209021','process0220209021','app0220208301'),
('raneecfzFRO','{}','Rachel','Frost','RachelAFrost@fleckens.hu','928-201-2616','{"experience":["AZ","US","MasterCard","Red"]}','event0220209022','process0220209022','app0220208301'),
('alna85dzDON','{}','Alison','Donovan','AlisonRDonovan@jourrapide.com','651-345-9720','{"experience":["MN","US","MasterCard","Green"]}','event0220209023','process0220209023','app0220208301'),
('min7f60zFER','{}','Michelle','Ferguson','MichelleGFerguson@fleckens.hu','360-824-8103','{"experience":["WA","US","Visa","Blue"]}','event0220209024','process0220209024','app0220208301'),
('don1700zOWE','{}','Donald','Owens','DonaldSOwens@dayrep.com','215-643-5830','{"experience":["PA","US","MasterCard","White"]}','event0220209025','process0220209025','app0220208301'),
('gen7f2czMIL','{}','Gene','Miller','GeneKMiller@jourrapide.com','631-506-6204','{"experience":["NY","US","Visa","Red"]}','event0220209026','process0220209026','app0220208301'),
('lance25zALL','{}','Larry','Allen','LarryNAllen@cuvox.de','308-539-5290','{"experience":["NE","US","MasterCard","Green"]}','event0220209027','process0220209027','app0220208301'),
('thn9bafzCOB','{}','Thomas','Cobb','ThomasRCobb@superrito.com','618-673-1747','{"experience":["IL","US","MasterCard","Blue"]}','event0220209028','process0220209028','app0220208301'),
('chn40f2zBON','{}','Christina','Bonilla','ChristinaMBonilla@einrot.com','509-565-6994','{"experience":["WA","US","MasterCard","Green"]}','event0220209029','process0220209029','app0220208301'),
('gun9ec3zPRI','{}','Gustavo','Pritchard','GustavoDPritchard@cuvox.de','858-449-5256','{"experience":["CA","US","Visa","Green"]}','event0220209030','process0220209030','app0220208301'),
('sanfeafzKES','{}','Sarah','Kestner','SarahEKestner@gustr.com','309-492-1412','{"experience":["IL","US","MasterCard","Blue"]}','event0220209031','process0220209031','app0220208301'),
('genf405zBOS','{}','George','Boswell','GeorgeHBoswell@armyspy.com','716-485-2389','{"experience":["NY","US","MasterCard","Blue"]}','event0220209032','process0220209032','app0220208301'),
('vine987zLEW','{}','Vicki','Lewis','VickiWLewis@cuvox.de','212-447-4796','{"experience":["NY","US","MasterCard","Orange"]}','event0220209033','process0220209033','app0220208301'),
('ren84f4zSTU','{}','Reynalda','Stubbs','ReynaldaRStubbs@einrot.com','856-205-1657','{"experience":["NJ","US","MasterCard","Blue"]}','event0220209034','process0220209034','app0220208301'),
('mince6azPEA','{}','Michael','Pearson','MichaelMPearson@einrot.com','443-391-2505','{"experience":["MD","US","MasterCard","Red"]}','event0220209035','process0220209035','app0220208301'),
('sun4718zMAR','{}','Susan','Marin','SusanAMarin@rhyta.com','860-525-2135','{"experience":["CT","US","MasterCard","Blue"]}','event0220209036','process0220209036','app0220208301'),
('man3b33zHAN','{}','Marlene','Haney','MarlenePHaney@dayrep.com','702-588-8639','{"experience":["NV","US","MasterCard","Green"]}','event0220209037','process0220209037','app0220208301'),
('ernab1ezRYB','{}','Eric','Rybicki','EricJRybicki@fleckens.hu','202-882-9489','{"experience":["DC","US","Visa","Blue"]}','event0220209038','process0220209038','app0220208301'),
('seneb23zACO','{}','Sergio','Acosta','SergioEAcosta@fleckens.hu','256-291-2620','{"experience":["AL","US","MasterCard","Black"]}','event0220209039','process0220209039','app0220208301'),
('jon6e54zPOR','{}','John','Porter','JohnAPorter@fleckens.hu','606-231-5740','{"experience":["KY","US","MasterCard","White"]}','event0220209040','process0220209040','app0220208301'),
('van2c40zKIN','{}','Valerie','Kinney','ValerieMKinney@cuvox.de','954-920-8891','{"experience":["FL","US","MasterCard","Purple"]}','event0220209041','process0220209041','app0220208301'),
('jan7ec4zLEO','{}','Jacob','Leonard','JacobMLeonard@superrito.com','518-693-5547','{"experience":["NY","US","Visa","Green"]}','event0220209042','process0220209042','app0220208301'),
('ben79c6zGOL','{}','Benjamin','Goldberg','BenjaminJGoldberg@armyspy.com','305-879-0205','{"experience":["FL","US","MasterCard","Black"]}','event0220209043','process0220209043','app0220208301'),
('lin3c2bzDYE','{}','Linda','Dyer','LindaJDyer@einrot.com','212-459-1236','{"experience":["NY","US","MasterCard","Blue"]}','event0220209044','process0220209044','app0220208301'),
('ron1f9azCAL','{}','Robert','Calvillo','RobertCCalvillo@gustr.com','412-402-2122','{"experience":["PA","US","MasterCard","Red"]}','event0220209045','process0220209045','app0220208301'),
('thne8eezWON','{}','Theresa','Wong','TheresaDWong@armyspy.com','937-746-3656','{"experience":["OH","US","Visa","Purple"]}','event0220209046','process0220209046','app0220208301'),
('chn44abzMCC','{}','Christal','McCoy','ChristalJMcCoy@rhyta.com','610-625-1249','{"experience":["PA","US","Visa","Black"]}','event0220209047','process0220209047','app0220208301'),
('grnbdd9zPEC','{}','Gregory','Peck','GregoryVPeck@gustr.com','812-462-0338','{"experience":["IN","US","Visa","Blue"]}','event0220209048','process0220209048','app0220208301'),
('frn0270zJON','{}','Frank','Jones','FrankGJones@gustr.com','415-622-0138','{"experience":["CA","US","MasterCard","Green"]}','event0220209049','process0220209049','app0220208301'),
('thn91a8zTOR','{}','Thomas','Torres','ThomasDTorres@fleckens.hu','210-321-0050','{"experience":["TX","US","MasterCard","Blue"]}','event0220209050','process0220209050','app0220208301'),
('ronff98zMAR','{}','Robert','Marshall','RobertRMarshall@armyspy.com','619-407-6158','{"experience":["CA","US","MasterCard","White"]}','event0220209051','process0220209051','app0220208301'),
('gln6703zCHO','{}','Glen','Chow','GlenBChow@superrito.com','314-968-4758','{"experience":["MO","US","MasterCard","Blue"]}','event0220209052','process0220209052','app0220208301'),
('jon5445zADA','{}','Joshua','Adair','JoshuaCAdair@cuvox.de','405-358-2337','{"experience":["OK","US","MasterCard","Blue"]}','event0220209053','process0220209053','app0220208301'),
('winf030zMCC','{}','Willie','McCoy','WillieJMcCoy@dayrep.com','808-688-2104','{"experience":["HI","US","MasterCard","Orange"]}','event0220209054','process0220209054','app0220208301'),
('glnb7efzFRY','{}','Gloria','Frye','GloriaAFrye@teleworm.us','205-242-5686','{"experience":["AL","US","MasterCard","Green"]}','event0220209055','process0220209055','app0220208301'),
('myn3ac4zGAU','{}','Myron','Gault','MyronCGault@dayrep.com','412-303-2799','{"experience":["PA","US","Visa","Green"]}','event0220209056','process0220209056','app0220208301'),
('jand0c4zBOO','{}','Jack','Booker','JackKBooker@einrot.com','812-445-0149','{"experience":["IN","US","Visa","Red"]}','event0220209057','process0220209057','app0220208301'),
('jon5089zCAL','{}','Jonathan','Callahan','JonathanDCallahan@gustr.com','610-353-2763','{"experience":["PA","US","MasterCard","Green"]}','event0220209058','process0220209058','app0220208301'),
('ron68cazFIS','{}','Robert','Fisk','RobertAFisk@teleworm.us','937-478-5968','{"experience":["OH","US","Visa","Blue"]}','event0220209059','process0220209059','app0220208301'),
('eln0575zDAN','{}','Elizabeth','Danna','ElizabethJDanna@teleworm.us','678-409-5567','{"experience":["GA","US","Visa","Purple"]}','event0220209060','process0220209060','app0220208301'),
('jon0bc9zBAG','{}','Joshua','Bagley','JoshuaRBagley@jourrapide.com','815-594-8132','{"experience":["IL","US","Visa","Black"]}','event0220209061','process0220209061','app0220208301'),
('man2b9dzWIL','{}','Matt','Wilkins','MattMWilkins@superrito.com','814-927-7323','{"experience":["PA","US","MasterCard","Blue"]}','event0220209062','process0220209062','app0220208301'),
('ann3cbbzWIL','{}','Angela','Williams','AngelaDWilliams@einrot.com','212-818-1549','{"experience":["NY","US","Visa","Purple"]}','event0220209063','process0220209063','app0220208301'),
('danf04bzMEN','{}','David','Mendez','DavidEMendez@gustr.com','785-845-7832','{"experience":["KS","US","Visa","Blue"]}','event0220209064','process0220209064','app0220208301'),
('stn41f1zGRE','{}','Stephen','Green','StephenEGreen@dayrep.com','585-349-0120','{"experience":["NY","US","MasterCard","Red"]}','event0220209065','process0220209065','app0220208301'),
('elna198zBAK','{}','Eleanor','Baker','EleanorWBaker@cuvox.de','989-438-8827','{"experience":["MI","US","MasterCard","Purple"]}','event0220209066','process0220209066','app0220208301'),
('pane536zMOR','{}','Patrick','Morrone','PatrickRMorrone@dayrep.com','734-687-4050','{"experience":["MI","US","Visa","Silver"]}','event0220209067','process0220209067','app0220208301'),
('brn1196zARB','{}','Brent','Arbogast','BrentRArbogast@teleworm.us','931-563-8854','{"experience":["TN","US","MasterCard","Blue"]}','event0220209068','process0220209068','app0220208301'),
('manbfd3zWES','{}','Marc','Westbrook','MarcVWestbrook@rhyta.com','541-793-7390','{"experience":["OR","US","MasterCard","Blue"]}','event0220209069','process0220209069','app0220208301'),
('len9662zHEA','{}','Lesley','Heaton','LesleyRHeaton@gustr.com','865-300-4522','{"experience":["TN","US","MasterCard","Green"]}','event0220209070','process0220209070','app0220208301'),
('jan6337zCHO','{}','Jacqueline','Cho','JacquelineTCho@dayrep.com','323-540-1765','{"experience":["CA","US","MasterCard","Purple"]}','event0220209071','process0220209071','app0220208301'),
('elnc01ezHOL','{}','Elsie','Holman','ElsieTHolman@superrito.com','801-501-6284','{"experience":["UT","US","MasterCard","Purple"]}','event0220209072','process0220209072','app0220208301'),
('phn0337zLIZ','{}','Phillip','Lizotte','PhillipBLizotte@jourrapide.com','989-493-1882','{"experience":["MI","US","Visa","Red"]}','event0220209073','process0220209073','app0220208301'),
('frna561zJAC','{}','Frances','Jacobson','FrancesSJacobson@einrot.com','260-729-8492','{"experience":["IN","US","MasterCard","Blue"]}','event0220209074','process0220209074','app0220208301'),
('han4006zACE','{}','Harold','Acevedo','HaroldBAcevedo@jourrapide.com','203-346-9632','{"experience":["CT","US","Visa","Blue"]}','event0220209075','process0220209075','app0220208301'),
('shn07f6zOSB','{}','Shelby','Osborn','ShelbyCOsborn@einrot.com','816-992-8519','{"experience":["MO","US","Visa","Blue"]}','event0220209076','process0220209076','app0220208301'),
('ron8619zMUR','{}','Robert','Murphy','RobertEMurphy@superrito.com','573-213-1577','{"experience":["MO","US","Visa","Blue"]}','event0220209077','process0220209077','app0220208301'),
('aan3093zYAN','{}','Aaron','Yang','AaronKYang@gustr.com','972-484-2211','{"experience":["TX","US","Visa","Black"]}','event0220209078','process0220209078','app0220208301'),
('man4f2dzMOR','{}','Mary','Morris','MaryJMorris@dayrep.com','630-276-6322','{"experience":["IL","US","MasterCard","Purple"]}','event0220209079','process0220209079','app0220208301'),
('linf190zWAT','{}','Linda','Waters','LindaJWaters@cuvox.de','305-815-2876','{"experience":["FL","US","MasterCard","Green"]}','event0220209080','process0220209080','app0220208301'),
('cln5bf5zJOH','{}','Clifford','Johnson','CliffordRJohnson@dayrep.com','607-219-3366','{"experience":["NY","US","MasterCard","Blue"]}','event0220209081','process0220209081','app0220208301'),
('men394azEDW','{}','Melvin','Edwards','MelvinKEdwards@jourrapide.com','262-893-2122','{"experience":["WI","US","MasterCard","Green"]}','event0220209082','process0220209082','app0220208301'),
('ben613bzBRO','{}','Betty','Brooks','BettyCBrooks@rhyta.com','504-538-4338','{"experience":["LA","US","MasterCard","Blue"]}','event0220209083','process0220209083','app0220208301'),
('bon9269zSPR','{}','Bobbie','Sproul','BobbieMSproul@teleworm.us','828-538-5885','{"experience":["NC","US","Visa","Orange"]}','event0220209084','process0220209084','app0220208301'),
('ken6297zTIB','{}','Kendall','Tibbitts','KendallDTibbitts@superrito.com','606-528-8403','{"experience":["KY","US","MasterCard","Red"]}','event0220209085','process0220209085','app0220208301'),
('donfd86zLOE','{}','Doris','Loewen','DorisRLoewen@cuvox.de','831-796-4507','{"experience":["CA","US","MasterCard","Green"]}','event0220209086','process0220209086','app0220208301'),
('ken91c2zELL','{}','Kevin','Elliott','KevinLElliott@dayrep.com','626-690-9965','{"experience":["CA","US","MasterCard","Blue"]}','event0220209087','process0220209087','app0220208301'),
('trnf891zJOH','{}','Troy','Johnson','TroyLJohnson@einrot.com','773-947-8185','{"experience":["IL","US","Visa","Blue"]}','event0220209088','process0220209088','app0220208301'),
('man6c18zJOH','{}','Mary','Johnson','MaryLJohnson@dayrep.com','845-928-3862','{"experience":["NY","US","Visa","Purple"]}','event0220209089','process0220209089','app0220208301'),
('eln8f4czDOR','{}','Elva','Dorsey','ElvaLDorsey@dayrep.com','559-452-0779','{"experience":["CA","US","Visa","Blue"]}','event0220209090','process0220209090','app0220208301'),
('wana652zDOT','{}','Wayne','Dotson','WayneIDotson@dayrep.com','847-549-3635','{"experience":["IL","US","MasterCard","Blue"]}','event0220209091','process0220209091','app0220208301'),
('menb789zLAM','{}','Melissa','Lamp','MelissaFLamp@superrito.com','816-278-5338','{"experience":["MO","US","Visa","Blue"]}','event0220209092','process0220209092','app0220208301'),
('jonc166zRIC','{}','John','Richards','JohnARichards@cuvox.de','715-704-9250','{"experience":["WI","US","Visa","Blue"]}','event0220209093','process0220209093','app0220208301'),
('danba82zMAD','{}','Daniel','Madison','DanielNMadison@cuvox.de','325-719-0503','{"experience":["TX","US","Visa","Blue"]}','event0220209094','process0220209094','app0220208301'),
('crnabb0zCOR','{}','Craig','Cornelius','CraigJCornelius@fleckens.hu','412-960-6954','{"experience":["PA","US","Visa","Blue"]}','event0220209095','process0220209095','app0220208301'),
('donf81czDAV','{}','Douglas','Davis','DouglasEDavis@superrito.com','630-524-4072','{"experience":["IL","US","MasterCard","Blue"]}','event0220209096','process0220209096','app0220208301'),
('wan8b8fzBEL','{}','Walter','Bellows','WalterTBellows@cuvox.de','919-532-7805','{"experience":["NC","US","MasterCard","Red"]}','event0220209097','process0220209097','app0220208301'),
('eln021dzBLA','{}','Eleanor','Blankenship','EleanorPBlankenship@dayrep.com','412-276-5117','{"experience":["PA","US","Visa","Purple"]}','event0220209098','process0220209098','app0220208301'),
('chnb31bzROB','{}','Charles','Robinson','CharlesDRobinson@gustr.com','248-560-8029','{"experience":["MI","US","MasterCard","Black"]}','event0220209099','process0220209099','app0220208301'),
('lyna9dczBAR','{}','Lynn','Barton','LynnTBarton@fleckens.hu','917-966-8900','{"experience":["NY","US","MasterCard","Purple"]}','event0220209100','process0220209100','app0220208301'),
('jen2118zDOV','{}','Jeff','Dover','JeffEDover@teleworm.us','281-629-3912','{"experience":["TX","US","MasterCard","Green"]}','event0220209101','process0220209101','app0220208301'),
('con51bczFOR','{}','Corene','Force','CoreneSForce@cuvox.de','251-689-8543','{"experience":["AL","US","Visa","Brown"]}','event0220209102','process0220209102','app0220208301'),
('sancfc1zANG','{}','Salvador','Angelo','SalvadorNAngelo@rhyta.com','757-328-0369','{"experience":["VA","US","Visa","Blue"]}','event0220209103','process0220209103','app0220208301'),
('dan803czSIL','{}','David','Sills','DavidMSills@einrot.com','216-242-5932','{"experience":["OH","US","Visa","Black"]}','event0220209104','process0220209104','app0220208301'),
('junbd0azKIL','{}','Justin','Killen','JustinAKillen@rhyta.com','216-392-8438','{"experience":["OH","US","Visa","Blue"]}','event0220209105','process0220209105','app0220208301'),
('non7f59zCAR','{}','Norman','Carothers','NormanGCarothers@dayrep.com','850-246-4985','{"experience":["FL","US","MasterCard","Blue"]}','event0220209106','process0220209106','app0220208301'),
('eln4e21zHUM','{}','Elmer','Humiston','ElmerRHumiston@gustr.com','801-365-7585','{"experience":["UT","US","MasterCard","Blue"]}','event0220209107','process0220209107','app0220208301'),
('hen2f3fzSTA','{}','Helen','Staff','HelenOStaff@armyspy.com','315-218-9375','{"experience":["NY","US","Visa","Black"]}','event0220209108','process0220209108','app0220208301'),
('jon956ezQUI','{}','Joe','Quigley','JoeAQuigley@jourrapide.com','765-576-7910','{"experience":["IN","US","MasterCard","Blue"]}','event0220209109','process0220209109','app0220208301'),
('eln2ef4zBEL','{}','Elizabeth','Bell','ElizabethDBell@einrot.com','985-890-5419','{"experience":["LA","US","MasterCard","Purple"]}','event0220209110','process0220209110','app0220208301'),
('panc28ezWAS','{}','Patricia','Washington','PatriciaSWashington@fleckens.hu','317-877-9447','{"experience":["IN","US","Visa","Blue"]}','event0220209111','process0220209111','app0220208301'),
('kenad07zGRA','{}','Kenneth','Graff','KennethPGraff@cuvox.de','515-290-2766','{"experience":["IA","US","MasterCard","Blue"]}','event0220209112','process0220209112','app0220208301'),
('jon3582zCAR','{}','Joyce','Carpenter','JoyceRCarpenter@gustr.com','212-657-9961','{"experience":["NY","US","MasterCard","Purple"]}','event0220209113','process0220209113','app0220208301'),
('stn8124zDER','{}','Stephen','Dermody','StephenJDermody@superrito.com','313-849-4095','{"experience":["MI","US","Visa","Blue"]}','event0220209114','process0220209114','app0220208301'),
('min5fdczDOL','{}','Mirian','Dolphin','MirianJDolphin@jourrapide.com','907-344-2591','{"experience":["AK","US","MasterCard","Blue"]}','event0220209115','process0220209115','app0220208301'),
('sand8a7zDEL','{}','Samantha','Delacerda','SamanthaSDelacerda@cuvox.de','443-403-7401','{"experience":["MD","US","Visa","Purple"]}','event0220209116','process0220209116','app0220208301'),
('manc469zNOR','{}','Margaret','Norris','MargaretENorris@cuvox.de','660-329-7819','{"experience":["MO","US","Visa","Blue"]}','event0220209117','process0220209117','app0220208301'),
('brn8741zGLE','{}','Brandon','Gleaves','BrandonMGleaves@fleckens.hu','912-651-4662','{"experience":["GA","US","Visa","Blue"]}','event0220209118','process0220209118','app0220208301'),
('jon8b46zSIE','{}','Joe','Siewert','JoeBSiewert@cuvox.de','847-686-2342','{"experience":["IL","US","MasterCard","Blue"]}','event0220209119','process0220209119','app0220208301'),
('minc8d3zTAB','{}','Michael','Tabor','MichaelCTabor@dayrep.com','408-634-4989','{"experience":["CA","US","Visa","Blue"]}','event0220209120','process0220209120','app0220208301'),
('kan6104zHER','{}','Karen','Hernandez','KarenTHernandez@gustr.com','315-551-0904','{"experience":["NY","US","Visa","Blue"]}','event0220209121','process0220209121','app0220208301'),
('hon8ba9zSCA','{}','Howard','Scanlon','HowardTScanlon@teleworm.us','903-393-9291','{"experience":["TX","US","Visa","Blue"]}','event0220209122','process0220209122','app0220208301'),
('man1aaezHAR','{}','Mary','Hardin','MaryJHardin@superrito.com','317-874-1194','{"experience":["IN","US","Visa","Blue"]}','event0220209123','process0220209123','app0220208301'),
('dene574zSIM','{}','Deborah','Sims','DeborahLSims@dayrep.com','804-756-9899','{"experience":["VA","US","Visa","Green"]}','event0220209124','process0220209124','app0220208301'),
('aln0eb4zLOV','{}','Alice','Lovely','AliceJLovely@rhyta.com','530-589-2487','{"experience":["CA","US","Visa","Purple"]}','event0220209125','process0220209125','app0220208301'),
('ron7512zAIN','{}','Robin','Ainsworth','RobinJAinsworth@teleworm.us','281-259-6596','{"experience":["TX","US","Visa","Green"]}','event0220209126','process0220209126','app0220208301'),
('san7a6bzMCF','{}','Sam','McFarland','SamRMcFarland@armyspy.com','661-840-0557','{"experience":["CA","US","MasterCard","Blue"]}','event0220209127','process0220209127','app0220208301'),
('jen8fd6zFIL','{}','Jeremy','Fillmore','JeremyCFillmore@cuvox.de','405-254-0810','{"experience":["OK","US","Visa","White"]}','event0220209128','process0220209128','app0220208301'),
('stncd1azLOG','{}','Steven','Logan','StevenLLogan@armyspy.com','918-755-9828','{"experience":["OK","US","MasterCard","Blue"]}','event0220209129','process0220209129','app0220208301'),
('thndc14zKET','{}','Thomas','Kettner','ThomasTKettner@einrot.com','323-397-4589','{"experience":["CA","US","MasterCard","Blue"]}','event0220209130','process0220209130','app0220208301'),
('ron2d79zWAI','{}','Robert','Waite','RobertBWaite@fleckens.hu','509-250-8418','{"experience":["WA","US","MasterCard","Green"]}','event0220209131','process0220209131','app0220208301'),
('jon7e9czSES','{}','Joyce','Sessions','JoyceJSessions@dayrep.com','816-228-9848','{"experience":["MO","US","Visa","Blue"]}','event0220209132','process0220209132','app0220208301'),
('edn1532zRAB','{}','Edith','Rabb','EdithRRabb@superrito.com','626-250-7029','{"experience":["CA","US","MasterCard","Yellow"]}','event0220209133','process0220209133','app0220208301'),
('rin72b4zSHA','{}','Richard','Shapiro','RichardSShapiro@jourrapide.com','631-995-4703','{"experience":["NY","US","MasterCard","Blue"]}','event0220209134','process0220209134','app0220208301'),
('jen24c5zGIL','{}','Jerome','Gilbert','JeromePGilbert@fleckens.hu','203-757-8566','{"experience":["CT","US","Visa","Blue"]}','event0220209135','process0220209135','app0220208301'),
('danbddfzSHI','{}','Daniel','Shives','DanielCShives@teleworm.us','319-961-1171','{"experience":["IA","US","MasterCard","Blue"]}','event0220209136','process0220209136','app0220208301'),
('dan6c28zJAC','{}','David','Jackson','DavidGJackson@rhyta.com','937-519-0131','{"experience":["OH","US","Visa","Blue"]}','event0220209137','process0220209137','app0220208301'),
('vin25b6zGAR','{}','Victor','Garcia','VictorVGarcia@dayrep.com','307-278-2972','{"experience":["WY","US","MasterCard","Blue"]}','event0220209138','process0220209138','app0220208301'),
('idn378bzKIN','{}','Ida','Kinard','IdaRKinard@superrito.com','620-246-8580','{"experience":["KS","US","MasterCard","Purple"]}','event0220209139','process0220209139','app0220208301'),
('jan8ff4zTYS','{}','James','Tyson','JamesMTyson@teleworm.us','312-575-3343','{"experience":["IL","US","Visa","Black"]}','event0220209140','process0220209140','app0220208301'),
('len3aeczADA','{}','Leslie','Adams','LeslieMAdams@gustr.com','972-204-7166','{"experience":["TX","US","MasterCard","Red"]}','event0220209141','process0220209141','app0220208301'),
('jen04edzGRE','{}','Jewell','Greer','JewellDGreer@teleworm.us','713-791-3207','{"experience":["TX","US","Visa","White"]}','event0220209142','process0220209142','app0220208301'),
('leneb0azYAM','{}','Leann','Yamamoto','LeannWYamamoto@teleworm.us','309-531-6616','{"experience":["IL","US","MasterCard","Black"]}','event0220209143','process0220209143','app0220208301'),
('thn5b1fzSNY','{}','Thomas','Snyder','ThomasRSnyder@jourrapide.com','305-849-6512','{"experience":["FL","US","Visa","Green"]}','event0220209144','process0220209144','app0220208301'),
('can0a6dzWAR','{}','Carol','Ward','CarolJWard@einrot.com','704-324-5290','{"experience":["NC","US","MasterCard","Yellow"]}','event0220209145','process0220209145','app0220208301'),
('rinad7azSMI','{}','Richard','Smith','RichardGSmith@armyspy.com','601-547-3643','{"experience":["MS","US","MasterCard","Blue"]}','event0220209146','process0220209146','app0220208301'),
('panab29zLEB','{}','Paul','Lebel','PaulSLebel@superrito.com','612-321-9060','{"experience":["MN","US","Visa","Black"]}','event0220209147','process0220209147','app0220208301'),
('rand869zGAB','{}','Randy','Gabriel','RandyHGabriel@rhyta.com','516-290-0330','{"experience":["NY","US","Visa","Blue"]}','event0220209148','process0220209148','app0220208301'),
('jona21ezWIL','{}','Johnnie','Willems','JohnnieVWillems@einrot.com','281-933-3398','{"experience":["TX","US","MasterCard","Black"]}','event0220209149','process0220209149','app0220208301'),
('jenf267zGAR','{}','Jerry','Garcia','JerryDGarcia@armyspy.com','989-821-1399','{"experience":["MI","US","MasterCard","Blue"]}','event0220209150','process0220209150','app0220208301'),
('tin377ezMOO','{}','Timothy','Moore','TimothyJMoore@fleckens.hu','626-356-5944','{"experience":["CA","US","Visa","Yellow"]}','event0220209151','process0220209151','app0220208301'),
('hen6c6azDEL','{}','Herman','Delossantos','HermanFDelossantos@rhyta.com','256-241-9869','{"experience":["AL","US","MasterCard","Orange"]}','event0220209152','process0220209152','app0220208301'),
('kan3eb2zCLA','{}','Kathryn','Clark','KathrynRClark@superrito.com','559-595-4122','{"experience":["CA","US","MasterCard","Green"]}','event0220209153','process0220209153','app0220208301'),
('janb044zCOL','{}','James','Colon','JamesEColon@rhyta.com','206-252-7544','{"experience":["WA","US","MasterCard","Blue"]}','event0220209154','process0220209154','app0220208301'),
('danb5b7zLEE','{}','Daniel','Lee','DanielMLee@cuvox.de','910-797-3987','{"experience":["NC","US","MasterCard","Blue"]}','event0220209155','process0220209155','app0220208301'),
('joncd0czWAN','{}','Jose','Wannamaker','JoseLWannamaker@jourrapide.com','239-495-3418','{"experience":["FL","US","MasterCard","Green"]}','event0220209156','process0220209156','app0220208301'),
('rin49e4zHER','{}','Richard','Hernandez','RichardAHernandez@armyspy.com','608-313-9829','{"experience":["WI","US","MasterCard","Green"]}','event0220209157','process0220209157','app0220208301'),
('vin1d0czTUR','{}','Virgil','Turner','VirgilJTurner@fleckens.hu','207-748-9311','{"experience":["ME","US","Visa","Blue"]}','event0220209158','process0220209158','app0220208301'),
('ann2070zGAL','{}','Annamarie','Galyon','AnnamarieBGalyon@jourrapide.com','701-933-3575','{"experience":["ND","US","Visa","White"]}','event0220209159','process0220209159','app0220208301'),
('mancee7zMOB','{}','Matthew','Mobley','MatthewSMobley@fleckens.hu','248-236-5911','{"experience":["MI","US","MasterCard","Orange"]}','event0220209160','process0220209160','app0220208301'),
('ton94dfzMAI','{}','Tommy','Maisonet','TommyBMaisonet@cuvox.de','404-608-8303','{"experience":["GA","US","Visa","Green"]}','event0220209161','process0220209161','app0220208301'),
('hen56c0zGLA','{}','Heather','Glasco','HeatherBGlasco@gustr.com','805-773-2971','{"experience":["CA","US","MasterCard","Blue"]}','event0220209162','process0220209162','app0220208301'),
('lin9786zDAV','{}','Lisa','Davis','LisaCDavis@rhyta.com','406-359-5676','{"experience":["MT","US","MasterCard","Blue"]}','event0220209163','process0220209163','app0220208301'),
('janf96fzDIC','{}','Jay','Dickson','JayMDickson@einrot.com','562-257-0579','{"experience":["CA","US","MasterCard","Blue"]}','event0220209164','process0220209164','app0220208301'),
('minc0b7zMAT','{}','Mike','Mathis','MikeCMathis@superrito.com','515-671-3224','{"experience":["IA","US","MasterCard","Silver"]}','event0220209165','process0220209165','app0220208301'),
('ron7c69zBAR','{}','Robert','Barr','RobertLBarr@rhyta.com','217-966-4325','{"experience":["IL","US","MasterCard","Blue"]}','event0220209166','process0220209166','app0220208301'),
('wina505zSEA','{}','Willie','Seal','WillieMSeal@gustr.com','423-442-0132','{"experience":["TN","US","MasterCard","Green"]}','event0220209167','process0220209167','app0220208301'),
('hen9bcczPOR','{}','Henry','Porter','HenryKPorter@teleworm.us','276-724-2324','{"experience":["VA","US","Visa","Red"]}','event0220209168','process0220209168','app0220208301'),
('nan75d2zJEF','{}','Nancy','Jeffrey','NancyPJeffrey@teleworm.us','602-321-7444','{"experience":["AZ","US","Visa","Purple"]}','event0220209169','process0220209169','app0220208301'),
('rindb0bzZAN','{}','Ricardo','Zang','RicardoEZang@jourrapide.com','202-777-6237','{"experience":["DC","US","MasterCard","Blue"]}','event0220209170','process0220209170','app0220208301'),
('min5345zSCO','{}','Misty','Scott','MistyDScott@jourrapide.com','207-713-6527','{"experience":["ME","US","Visa","Green"]}','event0220209171','process0220209171','app0220208301'),
('lin2a7dzBOB','{}','Liz','Bob','LizABob@einrot.com','404-544-6550','{"experience":["GA","US","MasterCard","Green"]}','event0220209172','process0220209172','app0220208301'),
('jan271ezOAK','{}','James','Oakes','JamesDOakes@dayrep.com','216-441-9024','{"experience":["OH","US","Visa","Blue"]}','event0220209173','process0220209173','app0220208301'),
('june0ddzHEA','{}','Juana','Head','JuanaJHead@teleworm.us','903-274-1550','{"experience":["TX","US","Visa","Blue"]}','event0220209174','process0220209174','app0220208301'),
('ven78d7zMIL','{}','Veronica','Millard','VeronicaDMillard@cuvox.de','910-641-5003','{"experience":["NC","US","MasterCard","Blue"]}','event0220209175','process0220209175','app0220208301'),
('chn02a1zHOR','{}','Christina','Horn','ChristinaPHorn@gustr.com','626-657-2850','{"experience":["CA","US","Visa","Blue"]}','event0220209176','process0220209176','app0220208301'),
('pana11dzSTO','{}','Patricia','Stout','PatriciaJStout@superrito.com','620-628-5517','{"experience":["KS","US","MasterCard","Red"]}','event0220209177','process0220209177','app0220208301'),
('jonedb3zHUN','{}','Jon','Hunter','JonJHunter@gustr.com','517-627-5905','{"experience":["MI","US","MasterCard","Silver"]}','event0220209178','process0220209178','app0220208301'),
('donca75zSCH','{}','Douglas','Scholl','DouglasTScholl@gustr.com','956-235-2051','{"experience":["TX","US","Visa","Red"]}','event0220209179','process0220209179','app0220208301'),
('pen55a6zFOU','{}','Peggy','Foulk','PeggyDFoulk@teleworm.us','423-432-2899','{"experience":["TN","US","Visa","Green"]}','event0220209180','process0220209180','app0220208301'),
('frn9e1ezJON','{}','Fred','Jones','FredRJones@jourrapide.com','847-600-2555','{"experience":["IL","US","MasterCard","Red"]}','event0220209181','process0220209181','app0220208301'),
('mancd98zLAY','{}','Marcelo','Lay','MarceloELay@einrot.com','770-475-2452','{"experience":["GA","US","MasterCard","Black"]}','event0220209182','process0220209182','app0220208301'),
('ednb886zJAM','{}','Edna','Jamison','EdnaRJamison@dayrep.com','713-705-0786','{"experience":["TX","US","Visa","Purple"]}','event0220209183','process0220209183','app0220208301'),
('brnd921zMAR','{}','Bradley','Mark','BradleyMMark@jourrapide.com','973-376-3100','{"experience":["NJ","US","Visa","Black"]}','event0220209184','process0220209184','app0220208301'),
('jonb793zTHO','{}','Joann','Thompson','JoannCThompson@teleworm.us','773-673-6405','{"experience":["IL","US","MasterCard","Red"]}','event0220209185','process0220209185','app0220208301'),
('ann0924zSHE','{}','Angela','Shepard','AngelaAShepard@armyspy.com','316-944-4093','{"experience":["KS","US","MasterCard","Blue"]}','event0220209186','process0220209186','app0220208301'),
('annd54czRIN','{}','Andrew','Ringler','AndrewKRingler@teleworm.us','202-806-7384','{"experience":["DC","US","MasterCard","Red"]}','event0220209187','process0220209187','app0220208301'),
('jon4f32zBRI','{}','John','Britton','JohnTBritton@fleckens.hu','410-735-4705','{"experience":["MD","US","MasterCard","Black"]}','event0220209188','process0220209188','app0220208301'),
('gen05cazPLO','{}','George','Ploof','GeorgeTPloof@superrito.com','865-622-4846','{"experience":["TN","US","Visa","Blue"]}','event0220209189','process0220209189','app0220208301'),
('kan838czNEW','{}','Kathryn','Newman','KathrynRNewman@gustr.com','704-727-9346','{"experience":["NC","US","Visa","Orange"]}','event0220209190','process0220209190','app0220208301'),
('suncd27zCRE','{}','Sue','Cree','SueDCree@armyspy.com','719-640-8509','{"experience":["CO","US","MasterCard","Purple"]}','event0220209191','process0220209191','app0220208301'),
('manef15zCON','{}','Mary','Considine','MaryHConsidine@armyspy.com','209-688-2608','{"experience":["CA","US","MasterCard","Blue"]}','event0220209192','process0220209192','app0220208301'),
('jan5965zSTR','{}','James','Stroud','JamesAStroud@superrito.com','662-235-4285','{"experience":["MS","US","Visa","Blue"]}','event0220209193','process0220209193','app0220208301'),
('jen047ezPRI','{}','Jennifer','Price','JenniferRPrice@dayrep.com','518-207-7483','{"experience":["NY","US","Visa","Green"]}','event0220209194','process0220209194','app0220208301'),
('ron2ecezHET','{}','Robert','Hetrick','RobertAHetrick@armyspy.com','559-859-7134','{"experience":["CA","US","MasterCard","Blue"]}','event0220209195','process0220209195','app0220208301'),
('win15d0zHED','{}','William','Hedin','WilliamCHedin@fleckens.hu','925-735-1616','{"experience":["CA","US","MasterCard","Green"]}','event0220209196','process0220209196','app0220208301'),
('kana6f0zISA','{}','Kathryn','Isaac','KathrynBIsaac@gustr.com','763-464-2416','{"experience":["MN","US","Visa","Red"]}','event0220209197','process0220209197','app0220208301'),
('vinaa2bzHOU','{}','Vivian','Hou','VivianDHou@teleworm.us','202-305-0762','{"experience":["DC","US","Visa","Green"]}','event0220209198','process0220209198','app0220208301'),
('kanee50zHAR','{}','Kathie','Hardrick','KathieRHardrick@dayrep.com','812-796-1162','{"experience":["IN","US","MasterCard","Purple"]}','event0220209199','process0220209199','app0220208301'),
('trn55c5zESP','{}','Trenton','Esposito','TrentonMEsposito@fleckens.hu','646-701-3512','{"experience":["NY","US","Visa","Blue"]}','event0220209200','process0220209200','app0220208301'),
('dan68abzWOR','{}','Daniel','Worrell','DanielLWorrell@fleckens.hu','202-898-8147','{"experience":["DC","US","MasterCard","Black"]}','event0220209201','process0220209201','app0220208301'),
('shna283zGRI','{}','Shane','Griffis','ShaneMGriffis@einrot.com','318-775-5415','{"experience":["LA","US","Visa","Blue"]}','event0220209202','process0220209202','app0220208301'),
('jond4e9zCLA','{}','Joy','Clark','JoyDClark@teleworm.us','812-883-7222','{"experience":["IN","US","MasterCard","Brown"]}','event0220209203','process0220209203','app0220208301'),
('jon1990zSCH','{}','John','Scheerer','JohnMScheerer@gustr.com','503-685-1807','{"experience":["OR","US","Visa","Blue"]}','event0220209204','process0220209204','app0220208301'),
('gun7cdbzBYR','{}','Guadalupe','Byrnes','GuadalupeCByrnes@cuvox.de','404-338-2300','{"experience":["GA","US","MasterCard","Red"]}','event0220209205','process0220209205','app0220208301'),
('jen9a1czJOH','{}','Jennifer','Johnson','JenniferFJohnson@superrito.com','423-533-4900','{"experience":["TN","US","Visa","Blue"]}','event0220209206','process0220209206','app0220208301'),
('adna786zPFE','{}','Adele','Pfeil','AdeleNPfeil@superrito.com','816-821-1347','{"experience":["MO","US","Visa","Purple"]}','event0220209207','process0220209207','app0220208301'),
('ron485azBOE','{}','Robin','Boettcher','RobinRBoettcher@dayrep.com','270-671-9990','{"experience":["KY","US","Visa","Orange"]}','event0220209208','process0220209208','app0220208301'),
('chn9c4fzTIB','{}','Christopher','Tibbs','ChristopherMTibbs@rhyta.com','760-900-9719','{"experience":["CA","US","Visa","Blue"]}','event0220209209','process0220209209','app0220208301'),
('chn3e0dzFAR','{}','Christopher','Farrel','ChristopherAFarrel@dayrep.com','205-912-6997','{"experience":["AL","US","MasterCard","Blue"]}','event0220209210','process0220209210','app0220208301'),
('ikne1bezLEE','{}','Ike','Lee','IkeGLee@rhyta.com','608-738-6406','{"experience":["WI","US","MasterCard","Black"]}','event0220209211','process0220209211','app0220208301'),
('chnef30zGRA','{}','Charles','Graham','CharlesRGraham@superrito.com','512-622-6463','{"experience":["TX","US","MasterCard","Blue"]}','event0220209212','process0220209212','app0220208301'),
('rond43bzMAR','{}','Ronnie','Martinez','RonnieNMartinez@cuvox.de','484-553-7614','{"experience":["PA","US","Visa","Blue"]}','event0220209213','process0220209213','app0220208301'),
('ran4b0czVIC','{}','Rachel','Vickers','RachelDVickers@dayrep.com','859-264-5399','{"experience":["KY","US","Visa","Blue"]}','event0220209214','process0220209214','app0220208301'),
('ren17dfzMAL','{}','Renee','Malloy','ReneeLMalloy@dayrep.com','310-868-6366','{"experience":["CA","US","Visa","Blue"]}','event0220209215','process0220209215','app0220208301'),
('aln1bbczLIT','{}','Alex','Little','AlexSLittle@gustr.com','615-214-9112','{"experience":["TN","US","Visa","Blue"]}','event0220209216','process0220209216','app0220208301'),
('pen5522zDUR','{}','Peggy','Duran','PeggyHDuran@rhyta.com','614-221-8865','{"experience":["OH","US","MasterCard","Purple"]}','event0220209217','process0220209217','app0220208301'),
('sind8a6zCOF','{}','Siobhan','Coffey','SiobhanPCoffey@armyspy.com','570-863-0901','{"experience":["PA","US","Visa","Blue"]}','event0220209218','process0220209218','app0220208301'),
('can5dedzNEL','{}','Carol','Nelson','CarolRNelson@armyspy.com','860-669-5570','{"experience":["CT","US","Visa","Green"]}','event0220209219','process0220209219','app0220208301'),
('annbeffzBAR','{}','Annie','Barrera','AnnieRBarrera@armyspy.com','305-621-6899','{"experience":["FL","US","MasterCard","Green"]}','event0220209220','process0220209220','app0220208301'),
('hon4c36zHAR','{}','Holly','Harvey','HollyJHarvey@einrot.com','727-622-7360','{"experience":["FL","US","Visa","Purple"]}','event0220209221','process0220209221','app0220208301'),
('ann0045zSMI','{}','Andrew','Smith','AndrewCSmith@superrito.com','909-523-2391','{"experience":["CA","US","MasterCard","Blue"]}','event0220209222','process0220209222','app0220208301'),
('man2a3dzHIN','{}','Mary','Hinton','MaryRHinton@dayrep.com','716-645-7709','{"experience":["NY","US","Visa","Blue"]}','event0220209223','process0220209223','app0220208301'),
('run5bc2zLOW','{}','Ruth','Lowe','RuthJLowe@teleworm.us','786-262-1791','{"experience":["FL","US","Visa","Purple"]}','event0220209224','process0220209224','app0220208301'),
('pan4f41zGUS','{}','Pamela','Gustafson','PamelaEGustafson@superrito.com','706-772-0598','{"experience":["GA","US","Visa","Brown"]}','event0220209225','process0220209225','app0220208301'),
('aln2bcczREA','{}','Alice','Reaves','AliceRReaves@armyspy.com','419-233-2404','{"experience":["OH","US","Visa","Black"]}','event0220209226','process0220209226','app0220208301'),
('jon563azCAM','{}','Jose','Camacho','JoseHCamacho@rhyta.com','240-272-6424','{"experience":["MD","US","MasterCard","Blue"]}','event0220209227','process0220209227','app0220208301'),
('lyn3b2czWAN','{}','Lynette','Wansley','LynetteSWansley@dayrep.com','707-797-5921','{"experience":["CA","US","MasterCard","Black"]}','event0220209228','process0220209228','app0220208301'),
('jene064zBUR','{}','Jerry','Burress','JerryJBurress@teleworm.us','951-787-4418','{"experience":["CA","US","Visa","Blue"]}','event0220209229','process0220209229','app0220208301'),
('edn181bzGRA','{}','Edward','Graves','EdwardHGraves@superrito.com','336-538-1329','{"experience":["NC","US","MasterCard","Green"]}','event0220209230','process0220209230','app0220208301'),
('con0caazSHE','{}','Corey','Shepard','CoreyDShepard@superrito.com','412-476-3416','{"experience":["PA","US","Visa","Orange"]}','event0220209231','process0220209231','app0220208301'),
('can0416zDOD','{}','Cathy','Dodson','CathyDDodson@teleworm.us','646-460-0740','{"experience":["NY","US","MasterCard","Blue"]}','event0220209232','process0220209232','app0220208301'),
('ben1a84zMOO','{}','Benjamin','Moore','BenjaminAMoore@dayrep.com','309-497-1912','{"experience":["IL","US","Visa","Black"]}','event0220209233','process0220209233','app0220208301'),
('pand6fczANT','{}','Paula','Anthony','PaulaPAnthony@fleckens.hu','903-961-5844','{"experience":["TX","US","MasterCard","Purple"]}','event0220209234','process0220209234','app0220208301'),
('jan7220zHAR','{}','James','Harrison','JamesCHarrison@superrito.com','248-546-3302','{"experience":["MI","US","MasterCard","Green"]}','event0220209235','process0220209235','app0220208301'),
('rene459zPEN','{}','Reginald','Pennell','ReginaldVPennell@einrot.com','513-691-5748','{"experience":["OH","US","MasterCard","Blue"]}','event0220209236','process0220209236','app0220208301'),
('stnb097zCRA','{}','Steve','Crawley','SteveJCrawley@cuvox.de','401-556-6609','{"experience":["RI","US","Visa","Orange"]}','event0220209237','process0220209237','app0220208301'),
('jan11b9zNUN','{}','James','Nunes','JamesKNunes@jourrapide.com','231-792-9130','{"experience":["MI","US","MasterCard","Black"]}','event0220209238','process0220209238','app0220208301'),
('maneef1zSHE','{}','Marilynn','Sheriff','MarilynnJSheriff@fleckens.hu','817-367-2355','{"experience":["TX","US","Visa","Red"]}','event0220209239','process0220209239','app0220208301'),
('san9f97zBAI','{}','Samuel','Bailey','SamuelBBailey@teleworm.us','631-468-7815','{"experience":["NY","US","MasterCard","Blue"]}','event0220209240','process0220209240','app0220208301'),
('tonf5dezESC','{}','Tony','Escamilla','TonyJEscamilla@armyspy.com','330-638-9008','{"experience":["OH","US","Visa","Red"]}','event0220209241','process0220209241','app0220208301'),
('wind1a5zBRE','{}','William','Brewer','WilliamMBrewer@teleworm.us','205-477-2323','{"experience":["AL","US","Visa","Blue"]}','event0220209242','process0220209242','app0220208301'),
('man5c52zYAR','{}','Mary','Yarbrough','MaryDYarbrough@gustr.com','936-436-0732','{"experience":["TX","US","Visa","Brown"]}','event0220209243','process0220209243','app0220208301'),
('tin90e6zJOH','{}','Timothy','Johnson','TimothyEJohnson@einrot.com','305-956-3862','{"experience":["FL","US","Visa","Silver"]}','event0220209244','process0220209244','app0220208301'),
('nanfc2dzLEO','{}','Nancy','Leon','NancyDLeon@superrito.com','205-423-3803','{"experience":["AL","US","Visa","Blue"]}','event0220209245','process0220209245','app0220208301'),
('ran7e88zLOP','{}','Rafael','Lopez','RafaelRLopez@dayrep.com','870-386-1177','{"experience":["AR","US","Visa","Red"]}','event0220209246','process0220209246','app0220208301'),
('lon8b7czLAM','{}','Lorri','Lamont','LorriMLamont@armyspy.com','214-648-0093','{"experience":["TX","US","Visa","Red"]}','event0220209247','process0220209247','app0220208301'),
('kenabbdzALB','{}','Kenneth','Albers','KennethLAlbers@fleckens.hu','507-786-5826','{"experience":["MN","US","Visa","Orange"]}','event0220209248','process0220209248','app0220208301'),
('brn2557zWAS','{}','Bryan','Washington','BryanLWashington@teleworm.us','419-860-2874','{"experience":["OH","US","Visa","Blue"]}','event0220209249','process0220209249','app0220208301'),
('benacc7zREY','{}','Betsy','Reyes','BetsyPReyes@jourrapide.com','972-301-6697','{"experience":["TX","US","Visa","Brown"]}','event0220209250','process0220209250','app0220208301'),
('irn8656zMIN','{}','Irvin','Minor','IrvinSMinor@cuvox.de','484-971-2602','{"experience":["PA","US","MasterCard","Blue"]}','event0220209251','process0220209251','app0220208301'),
('jonde2dzHEC','{}','Josefina','Heckman','JosefinaNHeckman@teleworm.us','716-887-9179','{"experience":["NY","US","MasterCard","Yellow"]}','event0220209252','process0220209252','app0220208301'),
('erndfa8zHAR','{}','Eric','Harlow','EricJHarlow@gustr.com','231-610-1924','{"experience":["MI","US","Visa","Blue"]}','event0220209253','process0220209253','app0220208301'),
('ton1a42zCER','{}','Tommy','Cervantes','TommyKCervantes@superrito.com','601-617-7703','{"experience":["MS","US","MasterCard","Red"]}','event0220209254','process0220209254','app0220208301'),
('thnf49fzPIT','{}','Thomas','Pitts','ThomasBPitts@rhyta.com','914-779-0419','{"experience":["NY","US","MasterCard","Blue"]}','event0220209255','process0220209255','app0220208301'),
('mand0adzLAN','{}','Matthew','Landis','MatthewBLandis@gustr.com','713-834-7493','{"experience":["TX","US","MasterCard","Blue"]}','event0220209256','process0220209256','app0220208301'),
('don27dfzCOO','{}','Donald','Cook','DonaldHCook@einrot.com','770-684-4156','{"experience":["GA","US","MasterCard","Blue"]}','event0220209257','process0220209257','app0220208301'),
('man810azHAW','{}','Marcus','Hawkins','MarcusIHawkins@gustr.com','804-899-1820','{"experience":["VA","US","MasterCard","Orange"]}','event0220209258','process0220209258','app0220208301'),
('min2802zNIL','{}','Michael','Nilsson','MichaelCNilsson@gustr.com','781-867-0493','{"experience":["MA","US","Visa","Blue"]}','event0220209259','process0220209259','app0220208301'),
('jan0424zSMI','{}','Janice','Smith','JaniceASmith@cuvox.de','918-928-1232','{"experience":["OK","US","MasterCard","Silver"]}','event0220209260','process0220209260','app0220208301'),
('jun482dzOCH','{}','Julie','Ochoa','JulieGOchoa@teleworm.us','972-641-9301','{"experience":["TX","US","Visa","Black"]}','event0220209261','process0220209261','app0220208301'),
('blna9e9zSAN','{}','Blanca','Sanders','BlancaJSanders@einrot.com','440-853-4111','{"experience":["OH","US","Visa","Green"]}','event0220209262','process0220209262','app0220208301'),
('jun8039zENG','{}','Julie','England','JulieTEngland@cuvox.de','713-309-4827','{"experience":["TX","US","MasterCard","Purple"]}','event0220209263','process0220209263','app0220208301'),
('men4cf7zBRO','{}','Melissa','Brown','MelissaRBrown@teleworm.us','802-846-3698','{"experience":["VT","US","Visa","Yellow"]}','event0220209264','process0220209264','app0220208301'),
('jonc0f4zCOS','{}','John','Costa','JohnCCosta@rhyta.com','585-356-1423','{"experience":["NY","US","Visa","Blue"]}','event0220209265','process0220209265','app0220208301'),
('don059czMAR','{}','Donovan','Martinez','DonovanEMartinez@rhyta.com','281-226-7479','{"experience":["TX","US","Visa","Blue"]}','event0220209266','process0220209266','app0220208301'),
('gen7e5dzORL','{}','George','Orlandi','GeorgeTOrlandi@teleworm.us','646-372-3181','{"experience":["NY","US","Visa","Black"]}','event0220209267','process0220209267','app0220208301'),
('junccb5zROS','{}','Judy','Rose','JudyNRose@dayrep.com','978-660-3979','{"experience":["MA","US","MasterCard","Blue"]}','event0220209268','process0220209268','app0220208301'),
('min76f8zMUR','{}','Michael','Murray','MichaelKMurray@teleworm.us','989-685-5712','{"experience":["MI","US","Visa","Blue"]}','event0220209269','process0220209269','app0220208301'),
('man3346zSAW','{}','Mark','Sawyer','MarkPSawyer@armyspy.com','623-556-9693','{"experience":["AZ","US","Visa","Blue"]}','event0220209270','process0220209270','app0220208301'),
('pan8187zGRA','{}','Paul','Gratton','PaulGGratton@teleworm.us','215-705-2122','{"experience":["PA","US","MasterCard","Blue"]}','event0220209271','process0220209271','app0220208301'),
('son96ddzEPP','{}','Sonia','Epperly','SoniaREpperly@armyspy.com','864-360-1073','{"experience":["SC","US","MasterCard","Orange"]}','event0220209272','process0220209272','app0220208301'),
('ten44a5zHUR','{}','Terry','Hurst','TerrySHurst@rhyta.com','770-457-1091','{"experience":["GA","US","Visa","Blue"]}','event0220209273','process0220209273','app0220208301'),
('crnf706zBUR','{}','Crystal','Burrows','CrystalJBurrows@rhyta.com','201-619-3486','{"experience":["NJ","US","Visa","Red"]}','event0220209274','process0220209274','app0220208301'),
('scn3919zHOU','{}','Scott','Hough','ScottCHough@einrot.com','660-285-0324','{"experience":["MO","US","MasterCard","Blue"]}','event0220209275','process0220209275','app0220208301'),
('chn463azWAL','{}','Christopher','Wall','ChristopherLWall@teleworm.us','831-244-7026','{"experience":["CA","US","Visa","Green"]}','event0220209276','process0220209276','app0220208301'),
('gen1550zPEA','{}','Gerardo','Pearl','GerardoBPearl@einrot.com','508-439-4792','{"experience":["MA","US","Visa","Black"]}','event0220209277','process0220209277','app0220208301'),
('shnab80zLIT','{}','Shelly','Little','ShellyDLittle@superrito.com','845-229-5874','{"experience":["NY","US","Visa","Blue"]}','event0220209278','process0220209278','app0220208301'),
('vinaaebzMAS','{}','Vickie','Massey','VickieDMassey@rhyta.com','850-692-5480','{"experience":["FL","US","Visa","Blue"]}','event0220209279','process0220209279','app0220208301'),
('chnd450zCOO','{}','Chi','Cooper','ChiCCooper@cuvox.de','703-532-2081','{"experience":["VA","US","Visa","Blue"]}','event0220209280','process0220209280','app0220208301'),
('minf06fzCAM','{}','Michael','Cameron','MichaelSCameron@cuvox.de','715-612-3855','{"experience":["WI","US","MasterCard","Blue"]}','event0220209281','process0220209281','app0220208301'),
('len7a93zTOW','{}','Leigh','Townsend','LeighDTownsend@jourrapide.com','985-693-7327','{"experience":["LA","US","MasterCard","Green"]}','event0220209282','process0220209282','app0220208301'),
('henedd7zCOT','{}','Helena','Cottrill','HelenaDCottrill@armyspy.com','562-481-6734','{"experience":["CA","US","Visa","Brown"]}','event0220209283','process0220209283','app0220208301'),
('jen14afzGOS','{}','Jeannetta','Gossman','JeannettaTGossman@dayrep.com','802-812-9748','{"experience":["VT","US","MasterCard","Blue"]}','event0220209284','process0220209284','app0220208301'),
('eln7475zROS','{}','Ellen','Rosinski','EllenARosinski@armyspy.com','610-842-4291','{"experience":["PA","US","Visa","Red"]}','event0220209285','process0220209285','app0220208301'),
('chn32eczRIC','{}','Christopher','Richmond','ChristopherLRichmond@armyspy.com','781-716-5052','{"experience":["MA","US","Visa","Blue"]}','event0220209286','process0220209286','app0220208301'),
('jonf70fzKIM','{}','John','Kim','JohnDKim@fleckens.hu','801-278-9268','{"experience":["UT","US","MasterCard","Green"]}','event0220209287','process0220209287','app0220208301'),
('jonb5d9zHAR','{}','John','Harrison','JohnJHarrison@teleworm.us','724-777-8486','{"experience":["PA","US","MasterCard","Blue"]}','event0220209288','process0220209288','app0220208301'),
('minaa04zBOY','{}','Michaela','Boyd','MichaelaMBoyd@superrito.com','405-301-9814','{"experience":["OK","US","Visa","Blue"]}','event0220209289','process0220209289','app0220208301'),
('henf96dzMAR','{}','Henry','Martinez','HenrySMartinez@cuvox.de','503-640-7756','{"experience":["OR","US","Visa","Red"]}','event0220209290','process0220209290','app0220208301'),
('linba40zKRA','{}','Lisa','Krause','LisaRKrause@dayrep.com','512-228-2653','{"experience":["TX","US","Visa","Purple"]}','event0220209291','process0220209291','app0220208301'),
('bend3fczNEI','{}','Betty','Neil','BettyTNeil@fleckens.hu','218-979-2204','{"experience":["MN","US","Visa","Blue"]}','event0220209292','process0220209292','app0220208301'),
('lyn1e3czWHI','{}','Lynda','White','LyndaAWhite@dayrep.com','307-340-8856','{"experience":["WY","US","Visa","Red"]}','event0220209293','process0220209293','app0220208301'),
('ron1129zARG','{}','Robert','Argueta','RobertAArgueta@armyspy.com','319-640-3036','{"experience":["IA","US","Visa","Blue"]}','event0220209294','process0220209294','app0220208301'),
('win1696zJOH','{}','William','Johnson','WilliamGJohnson@dayrep.com','605-865-7990','{"experience":["SD","US","Visa","Green"]}','event0220209295','process0220209295','app0220208301'),
('line1bczHOL','{}','Lisa','Holiday','LisaWHoliday@rhyta.com','336-849-9536','{"experience":["NC","US","Visa","Brown"]}','event0220209296','process0220209296','app0220208301'),
('arnb2fbzJET','{}','Arthur','Jeter','ArthurMJeter@jourrapide.com','707-998-3039','{"experience":["CA","US","MasterCard","Blue"]}','event0220209297','process0220209297','app0220208301'),
('banf5aczLEO','{}','Barbara','Leonard','BarbaraALeonard@armyspy.com','228-270-1204','{"experience":["MS","US","Visa","Blue"]}','event0220209298','process0220209298','app0220208301'),
('ranf0cazROB','{}','Raymond','Robinson','RaymondVRobinson@fleckens.hu','216-704-6179','{"experience":["OH","US","Visa","Blue"]}','event0220209299','process0220209299','app0220208301');

INSERT INTO persons ( person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements, app_id, event_id, process_id ) VALUES ( 'person_8309_hanna', '{}', 'Hana', '', 'Boones', 'Hanaboones@gmail.com', '7185644281', '', '{"environment":["silver","lebronze"]}', 'app_83838383', 'event_0916', 'process_8302324' ) RETURNING person_id;

select * from persons order by id desc;

update persons set person_name_first = 'Juanita' where person_id = 'jen14afzGOS';
select * from persons where person_id = '8301_02132020_0430';

UPDATE persons SET  person_name_first = 'roddy'  person_name_last = 'piper'  person_email = 'rowdyrod@gmail.com'  WHERE person_id = '8301_022320_1428';

/* UPDATE WITH RETURNING */
update persons
set
	person_email = 'line1bczHOL@gmail.com'
where
	person_id = 'line1bczHOL'
returning
	person_id;
/* */

UPDATE persons SET person_name_first = 'art',person_name_last = 'J.'  WHERE person_id = 'arnb2fbzJET' RETURNING person_id;

select * from persons where person_id = 'jan9065zMUR';
select * from persons where person_id = '8301_022520_1420';

SELECT person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements FROM persons WHERE person_id = 'line1bczHOL' AND active = 1 ORDER BY time_finished DESC LIMIT 1;

COMMENT ON TABLE persons IS 'Persons records are used as the bedrock for all user data and communications.';
COMMENT ON COLUMN persons.person_entitlements IS 'Person entitlements in JSON data format (guest,user,profile,partner)';

select
	person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements
from
	persons
where
	person_name_first ILIKE '%ad%' or
	person_name_last ILIKE '%ad%' and 
	active = 1
ORDER by
	time_finished desc
;

select
	person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements
from
	persons
where
	active = 1
ORDER by
	time_finished desc
OFFSET 
	0
limit
	2000;

SELECT person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements FROM persons WHERE person_name_first ilike '%j%' AND active = 1 ORDER BY time_finished DESC OFFSET 0 LIMIT 1000;
SELECT person_id, person_attributes, person_name_first, person_name_middle, person_name_last, person_email, person_phone_primary, person_phone_secondary, person_entitlements FROM persons WHERE person_name_first ILIKE '%a%' AND person_name_last ILIKE '%l%' AND person_email ILIKE '%@%' AND active = 1 ORDER BY time_finished DESC OFFSET 0 LIMIT 100;

CREATE TABLE IF NOT EXISTS	users	(
ID	SERIAL	,
user_ID	VARCHAR(30)	NOT NULL UNIQUE,
user_attributes	JSON	NULL,
user_alias	VARCHAR(255)	NOT NULL UNIQUE,
user_access	TEXT	NOT NULL,
user_lastlogin	VARCHAR(255)	NULL,
user_status	VARCHAR(30)	NULL,
user_validation	VARCHAR(255)	NULL,
user_welcome	JSON	NULL,
person_id	VARCHAR(30)	NOT NULL,
app_id	VARCHAR(30)	NOT NULL,
event_id	VARCHAR(30)	NOT NULL,
process_id	VARCHAR(30)	NOT NULL,
time_started	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_updated	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_finished	TIMESTAMP	NOT NULL DEFAULT NOW(),
active	INT	NOT NULL DEFAULT 1
);

CREATE SEQUENCE users_sequence;		
ALTER SEQUENCE users_sequence RESTART WITH 8301;		
ALTER TABLE users ALTER COLUMN ID SET DEFAULT nextval('users_sequence');		
ALTER TABLE users ADD FOREIGN KEY (person_id) REFERENCES persons(person_id);		
ALTER TABLE users ADD FOREIGN KEY (app_id) REFERENCES apps(app_id);		
SELECT * FROM users;
DROP TABLE users;
INSERT INTO users (user_ID,user_attributes,user_alias,user_password,user_lastlogin,user_status,user_validation,user_salt,user_welcome,person_id,app_id,event_ID,process_ID)		
 VALUES ('30 characters','{}','255 characters','255 characters','255 characters','30 characters','255 characters',E'\xDE\xAD\xBE\xEF','{}','30 characters','30 characters','30 characters','30 characters');
SELECT * FROM users;
select * from persons where person_name_first ilike '%adolphus%';

CREATE TABLE IF NOT EXISTS	bytea	(
user_alias	VARCHAR(255)	NULL,
user_password	VARCHAR(255)	NULL,
user_salt	BYTEA	null
);
drop table bytea;
select * from bytea;

select user_salt from bytea;
select decode(E'\x7f\x7f', 'bytea');

insert into bytea (user_alias,user_password,user_salt) values ('sonofadolphus','B1@thering!',E'\x7f\x7f');

/* https://x-team.com/blog/storing-secure-passwords-with-postgresql/ */

CREATE EXTENSION pgcrypto;

CREATE TABLE folks (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);

INSERT INTO folks (email, password) VALUES (
  'johndoe@mail.com',
  crypt('johnspassword', gen_salt('bf'))
);

select * from folks;

SELECT id 
  FROM folks
 WHERE email = 'johndoe@mail.com' 
   AND password = crypt('johnspassword', password);
  
SELECT id 
  FROM users
 WHERE email = 'johndoe@mail.com' 
   AND password = crypt('wrongpassword', password);


ALTER TABLE users 
RENAME user_access TO user_authorize;

/* USERS */
 SELECT user_id
  FROM users
 WHERE user_alias = 'sonofadolphus' 
   AND user_authorize = crypt('B1@thering!', user_authorize);

drop table users;
CREATE TABLE IF NOT EXISTS	users	(
ID	SERIAL	,
user_ID	VARCHAR(30)	NOT NULL UNIQUE,
user_attributes	JSON	NULL,
user_alias	VARCHAR(255)	NOT NULL UNIQUE,
user_access	TEXT	NOT NULL,
user_lastlogin	TIMESTAMP	NULL,
user_status	INT	NULL,
user_validation	VARCHAR(255)	NULL,
user_welcome	JSON	NULL,
person_id	VARCHAR(30)	NOT NULL,
app_id	VARCHAR(30)	NOT NULL,
event_id	VARCHAR(30)	NOT NULL,
process_id	VARCHAR(30)	NOT NULL,
time_started	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_updated	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_finished	TIMESTAMP	NOT NULL DEFAULT NOW(),
active	INT	NOT NULL DEFAULT 1
);
CREATE SEQUENCE users_sequence;	
ALTER SEQUENCE users_sequence RESTART WITH 8301;		
ALTER TABLE users ALTER COLUMN ID SET DEFAULT nextval('users_sequence');		
ALTER TABLE users MODIFY COLUMN user_status SET DEFAULT nextval('users_sequence');		
ALTER TABLE users ALTER COLUMN user_status TYPE VARCHAR(30);
ALTER TABLE users ADD FOREIGN KEY (person_id) REFERENCES persons(person_id);
select * from users;
/* https://x-team.com/blog/storing-secure-passwords-with-postgresql/ */

CREATE EXTENSION pgcrypto;

INSERT INTO folks (email, password) VALUES (
  'johndoe@mail.com',
  crypt('johnspassword', gen_salt('bf'))
);

/* USERS */
 SELECT user_id
  FROM users
 WHERE user_alias = 'sonofadolphus' 
   AND user_access = crypt('B1@thering!', user_access);
   
 select * from users;

/* PROFILES */
CREATE TABLE IF NOT EXISTS	profiles	(
ID	SERIAL	,
profile_ID	VARCHAR(30)	NOT NULL UNIQUE,
profile_attributes	JSON	NULL,
profile_images	JSON	NULL,
profile_bio	VARCHAR(255)	NULL,
profile_headline	VARCHAR(255)	NULL,
profile_access	VARCHAR(30)	NOT null default 'public',
profile_status	VARCHAR(30)	NOT null default 'active',
user_id	VARCHAR(30)	NOT null,
app_id	VARCHAR(30)	NOT null,
event_id	VARCHAR(30)	NOT null,
process_id	VARCHAR(30)	NOT null,
time_started	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_updated	TIMESTAMP	NOT NULL DEFAULT NOW(),
time_finished	TIMESTAMP	NOT NULL DEFAULT NOW(),
active	INT	NOT NULL DEFAULT 1
);

ALTER TABLE profiles alter COLUMN profile_access type VARCHAR(30);
ALTER TABLE profiles alter COLUMN profile_status type VARCHAR(30);
alter table profiles modify profile_access varchar(30) not null default 'public';

CREATE SEQUENCE profiles_sequence;		
ALTER SEQUENCE profiles_sequence RESTART WITH 8301;		
ALTER TABLE profiles ALTER COLUMN ID SET DEFAULT nextval('profiles_sequence');		
ALTER TABLE profiles ADD FOREIGN KEY (user_id) REFERENCES users(user_id);		
ALTER TABLE profiles ADD FOREIGN KEY (app_id) REFERENCES apps(app_id);		
SELECT * FROM profiles;
DROP TABLE profiles;
INSERT INTO profiles (profile_ID,profile_attributes,profile_images,profile_bio,profile_headline,profile_access,user_id,app_id,event_ID,process_ID)		
 VALUES ('30 characters','{}','{}','255 characters','255 characters','1','30 characters','30 characters','30 characters','30 characters');		
SELECT * FROM profiles;	

select * from persons order by time_finished desc limit 11;
select * from users order by time_finished desc limit 11;
select * from profiles order by time_finished desc limit 11;

/* USERS */
 SELECT user_id
  FROM users
 WHERE user_alias = 'teamd' 
   AND user_authorize = crypt('B1@thering!', user_authorize);
  
select person_id from persons where person_email = 'teamf@thentrl.ccom.uk';
  
SELECT user_id,	user_attributes, user_alias,	user_authorize,	user_lastlogin,	user_status, user_validation,	user_welcome, person_id	
FROM users 
WHERE person_id = '77ecc0c212be1' AND user_authorize = crypt('B1@thering!', user_authorize) AND active = 1 LIMIT 1;

SELECT user_id,	user_attributes,	user_alias,	user_authorize,	user_lastlogin,	user_status, user_validation,	user_welcome, person_id	
FROM users 
WHERE person_id = '77ecc0c212be1' 
AND user_authorize = crypt('B1@thering!', user_authorize) 
AND active = 1 
LIMIT 1;

{"app":"app_eRdsWAqgHNcRi","domain":"signin","token":"tok_NrydxsCvffPgD","email":"teamf@thentrl.ccom.uk","authorize":"B1@thering!","person":"7831227668cce","per":20,"page":1,"limit":100}


select person_email from persons;
UPDATE persons SET person_email = '0306200952@gmail.com' WHERE person_email = 'sonofadolphus@gmail.com' RETURNING person_id;
UPDATE users SET user_alias = '0306200952' WHERE user_alias = 'sonofadolphus' RETURNING user_id;
UPDATE profiles SET person_email = '0306200941@gmail.com' WHERE person_id = 'sonofadolphus@gmail.com' RETURNING person_id;



