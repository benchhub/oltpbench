-- TODO: C_SINCE ON UPDATE CURRENT_TIMESTAMP,

-- woonhak, turn off foreign key check, reference tpcc-mysql and tpcc specification
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS DISTRICT;
DROP TABLE IF EXISTS HISTORY;
DROP TABLE IF EXISTS ITEM;
DROP TABLE IF EXISTS NEW_ORDER;
DROP TABLE IF EXISTS OORDER;
DROP TABLE IF EXISTS ORDER_LINE;
DROP TABLE IF EXISTS STOCK;
DROP TABLE IF EXISTS WAREHOUSE;

CREATE TABLE CUSTOMER (
  C_W_ID INT NOT NULL,
  C_D_ID INT NOT NULL,
  C_ID INT NOT NULL,
  C_DISCOUNT DECIMAL(4,4) NOT NULL,
  C_CREDIT CHAR(2) NOT NULL,
  C_LAST VARCHAR(16) NOT NULL,
  C_FIRST VARCHAR(16) NOT NULL,
  C_CREDIT_LIM DECIMAL(12,2) NOT NULL,
  C_BALANCE DECIMAL(12,2) NOT NULL,
  C_YTD_PAYMENT FLOAT NOT NULL,
  C_PAYMENT_CNT INT NOT NULL,
  C_DELIVERY_CNT INT NOT NULL,
  C_STREET_1 VARCHAR(20) NOT NULL,
  C_STREET_2 VARCHAR(20) NOT NULL,
  C_CITY VARCHAR(20) NOT NULL,
  C_STATE CHAR(2) NOT NULL,
  C_ZIP CHAR(9) NOT NULL,
  C_PHONE CHAR(16) NOT NULL,
  C_SINCE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  C_MIDDLE CHAR(2) NOT NULL,
  C_DATA VARCHAR(500) NOT NULL,
  PRIMARY KEY (C_W_ID,C_D_ID,C_ID)
);


CREATE TABLE DISTRICT (
  D_W_ID INT NOT NULL,
  D_ID INT NOT NULL,
  D_YTD DECIMAL(12,2) NOT NULL,
  D_TAX DECIMAL(4,4) NOT NULL,
  D_NEXT_O_ID INT NOT NULL,
  D_NAME VARCHAR(10) NOT NULL,
  D_STREET_1 VARCHAR(20) NOT NULL,
  D_STREET_2 VARCHAR(20) NOT NULL,
  D_CITY VARCHAR(20) NOT NULL,
  D_STATE CHAR(2) NOT NULL,
  D_ZIP CHAR(9) NOT NULL,
  PRIMARY KEY (D_W_ID,D_ID)
);

-- TODO: H_DATE ON UPDATE CURRENT_TIMESTAMP

CREATE TABLE HISTORY (
  H_C_ID INT NOT NULL,
  H_C_D_ID INT NOT NULL,
  H_C_W_ID INT NOT NULL,
  H_D_ID INT NOT NULL,
  H_W_ID INT NOT NULL,
  H_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  H_AMOUNT DECIMAL(6,2) NOT NULL,
  H_DATA VARCHAR(24) NOT NULL
);


CREATE TABLE ITEM (
  I_ID INT NOT NULL,
  I_NAME VARCHAR(24) NOT NULL,
  I_PRICE DECIMAL(5,2) NOT NULL,
  I_DATA VARCHAR(50) NOT NULL,
  I_IM_ID INT NOT NULL,
  PRIMARY KEY (I_ID)
);


CREATE TABLE NEW_ORDER (
  NO_W_ID INT NOT NULL,
  NO_D_ID INT NOT NULL,
  NO_O_ID INT NOT NULL,
  PRIMARY KEY (NO_W_ID,NO_D_ID,NO_O_ID)
);

-- TODO: O_ENTRY_D  ON UPDATE CURRENT_TIMESTAMP

CREATE TABLE OORDER (
  O_W_ID INT NOT NULL,
  O_D_ID INT NOT NULL,
  O_ID INT NOT NULL,
  O_C_ID INT NOT NULL,
  O_CARRIER_ID INT DEFAULT NULL,
  O_OL_CNT DECIMAL(2,0) NOT NULL,
  O_ALL_LOCAL DECIMAL(1,0) NOT NULL,
  O_ENTRY_D TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (O_W_ID,O_D_ID,O_ID),
  UNIQUE (O_W_ID,O_D_ID,O_C_ID,O_ID)
);


CREATE TABLE ORDER_LINE (
  OL_W_ID INT NOT NULL,
  OL_D_ID INT NOT NULL,
  OL_O_ID INT NOT NULL,
  OL_NUMBER INT NOT NULL,
  OL_I_ID INT NOT NULL,
  OL_DELIVERY_D TIMESTAMP NULL DEFAULT NULL,
  OL_AMOUNT DECIMAL(6,2) NOT NULL,
  OL_SUPPLY_W_ID INT NOT NULL,
  OL_QUANTITY DECIMAL(2,0) NOT NULL,
  OL_DIST_INFO CHAR(24) NOT NULL,
  PRIMARY KEY (OL_W_ID,OL_D_ID,OL_O_ID,OL_NUMBER)
);

CREATE TABLE STOCK (
  S_W_ID INT NOT NULL,
  S_I_ID INT NOT NULL,
  S_QUANTITY DECIMAL(4,0) NOT NULL,
  S_YTD DECIMAL(8,2) NOT NULL,
  S_ORDER_CNT INT NOT NULL,
  S_REMOTE_CNT INT NOT NULL,
  S_DATA VARCHAR(50) NOT NULL,
  S_DIST_01 CHAR(24) NOT NULL,
  S_DIST_02 CHAR(24) NOT NULL,
  S_DIST_03 CHAR(24) NOT NULL,
  S_DIST_04 CHAR(24) NOT NULL,
  S_DIST_05 CHAR(24) NOT NULL,
  S_DIST_06 CHAR(24) NOT NULL,
  S_DIST_07 CHAR(24) NOT NULL,
  S_DIST_08 CHAR(24) NOT NULL,
  S_DIST_09 CHAR(24) NOT NULL,
  S_DIST_10 CHAR(24) NOT NULL,
  PRIMARY KEY (S_W_ID,S_I_ID)
);

CREATE TABLE WAREHOUSE (
  W_ID INT NOT NULL,
  W_YTD DECIMAL(12,2) NOT NULL,
  W_TAX DECIMAL(4,4) NOT NULL,
  W_NAME VARCHAR(10) NOT NULL,
  W_STREET_1 VARCHAR(20) NOT NULL,
  W_STREET_2 VARCHAR(20) NOT NULL,
  W_CITY VARCHAR(20) NOT NULL,
  W_STATE CHAR(2) NOT NULL,
  W_ZIP CHAR(9) NOT NULL,
  PRIMARY KEY (W_ID)
);

-- INDEXES
CREATE INDEX IDX_CUSTOMER_NAME ON CUSTOMER (C_W_ID,C_D_ID,C_LAST,C_FIRST);

-- woohak, add constraints. MySQL/InnoDB storage engine is kind of IoT.
-- and add constraints and make indexes later aretoo slow when running a single thread.
-- so I just add create index and foreign key constraints before loading data.

-- already created
-- CREATE INDEX IDX_CUSTOMER ON CUSTOMER (C_W_ID,C_D_ID,C_LAST,C_FIRST);
CREATE INDEX IDX_ORDER ON OORDER (O_W_ID,O_D_ID,O_C_ID,O_ID);
-- tpcc-mysql create two indexes for the foreign key constraints, Is it really necessary?
-- CREATE INDEX FKEY_STOCK_2 ON STOCK (S_I_ID);
-- CREATE INDEX FKEY_ORDER_LINE_2 ON ORDER_LINE (OL_SUPPLY_W_ID,OL_I_ID);

-- add 'ON DELETE CASCADE'  to clear table work correctly

-- Feature 'REFERENTIAL ACTIONS' is not supported by MemSQL
-- ALTER TABLE DISTRICT  ADD CONSTRAINT FKEY_DISTRICT_1 FOREIGN KEY(D_W_ID) REFERENCES WAREHOUSE(W_ID) ON DELETE CASCADE;
-- ALTER TABLE CUSTOMER ADD CONSTRAINT FKEY_CUSTOMER_1 FOREIGN KEY(C_W_ID,C_D_ID) REFERENCES DISTRICT(D_W_ID,D_ID)  ON DELETE CASCADE ;
-- ALTER TABLE HISTORY  ADD CONSTRAINT FKEY_HISTORY_1 FOREIGN KEY(H_C_W_ID,H_C_D_ID,H_C_ID) REFERENCES CUSTOMER(C_W_ID,C_D_ID,C_ID) ON DELETE CASCADE;
-- ALTER TABLE HISTORY  ADD CONSTRAINT FKEY_HISTORY_2 FOREIGN KEY(H_W_ID,H_D_ID) REFERENCES DISTRICT(D_W_ID,D_ID) ON DELETE CASCADE;
-- ALTER TABLE NEW_ORDER ADD CONSTRAINT FKEY_NEW_ORDER_1 FOREIGN KEY(NO_W_ID,NO_D_ID,NO_O_ID) REFERENCES OORDER(O_W_ID,O_D_ID,O_ID) ON DELETE CASCADE;
-- ALTER TABLE OORDER ADD CONSTRAINT FKEY_ORDER_1 FOREIGN KEY(O_W_ID,O_D_ID,O_C_ID) REFERENCES CUSTOMER(C_W_ID,C_D_ID,C_ID) ON DELETE CASCADE;
-- ALTER TABLE ORDER_LINE ADD CONSTRAINT FKEY_ORDER_LINE_1 FOREIGN KEY(OL_W_ID,OL_D_ID,OL_O_ID) REFERENCES OORDER(O_W_ID,O_D_ID,O_ID) ON DELETE CASCADE;
-- ALTER TABLE ORDER_LINE ADD CONSTRAINT FKEY_ORDER_LINE_2 FOREIGN KEY(OL_SUPPLY_W_ID,OL_I_ID) REFERENCES STOCK(S_W_ID,S_I_ID) ON DELETE CASCADE;
-- ALTER TABLE STOCK ADD CONSTRAINT FKEY_STOCK_1 FOREIGN KEY(S_W_ID) REFERENCES WAREHOUSE(W_ID) ON DELETE CASCADE;
-- ALTER TABLE STOCK ADD CONSTRAINT FKEY_STOCK_2 FOREIGN KEY(S_I_ID) REFERENCES ITEM(I_ID) ON DELETE CASCADE;


SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

