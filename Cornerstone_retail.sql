
--------------------------Drop Table/Sequence Section---------------------------
---This section is for dropping all the tables and sequences.                ---
--------------------------------------------------------------------------------

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE venue_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE event_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE event_type_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE booth_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE shift_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE salesperson_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE sales_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE product_id_seq';

  EXECUTE IMMEDIATE 'DROP TABLE Product';
  EXECUTE IMMEDIATE 'DROP TABLE Product_sales_linking';
  EXECUTE IMMEDIATE 'DROP TABLE Sales';
  EXECUTE IMMEDIATE 'DROP TABLE Salesperson';
  EXECUTE IMMEDIATE 'DROP TABLE Shift';
  EXECUTE IMMEDIATE 'DROP TABLE Booth';
  EXECUTE IMMEDIATE 'DROP TABLE Event_type';
  EXECUTE IMMEDIATE 'DROP TABLE Event';
  EXECUTE IMMEDIATE 'DROP TABLE Venue';    
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

--------------------------------------------------------------------------------

---------------------------Create Table/Sequence Section------------------------
---This section is for creating all the sequences, tables and link tables    ---
---and the necessary constraints.                                            ---
--------------------------------------------------------------------------------

-----------------------Sequences for the IDs------------------------------------

CREATE SEQUENCE venue_id_seq
    START WITH 1 INCREMENT BY 1;
    
CREATE SEQUENCE event_id_seq
    START WITH 1 INCREMENT BY 1;   

CREATE SEQUENCE event_type_id_seq
    START WITH 1 INCREMENT BY 1; 

CREATE SEQUENCE booth_id_seq
    START WITH 1 INCREMENT BY 1;
 
CREATE SEQUENCE shift_id_seq
    START WITH 1 INCREMENT BY 1;    

CREATE SEQUENCE salesperson_id_seq
    START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE sales_id_seq
    START WITH 1 INCREMENT BY 1;
    
CREATE SEQUENCE product_id_seq
    START WITH 1 INCREMENT BY 1;
    

-----------------------------------Tables---------------------------------------    
CREATE TABLE Venue ---Create table for Venue
(
    Venue_ID           NUMBER              DEFAULT venue_id_seq.NEXTVAL PRIMARY KEY,
    Venue_Name         VARCHAR(40)         NOT NULL,
    Address_Line_1     VARCHAR(40)         NOT NULL,
    Address_Line_2     VARCHAR(40), 
    City               VARCHAR(20)         NOT NULL,
    State              CHAR(2)             NOT NULL, 
    Zip                CHAR(5)             NOT NULL,
    Venue_description  VARCHAR(40),    
    CONSTRAINT check_vn_zip            CHECK (LENGTH (Zip) = 5),
    CONSTRAINT check_vn_state          CHECK (LENGTH(State) = 2)
);

CREATE TABLE Event_type --Create table for Event type
(
    Event_type_id NUMBER DEFAULT  event_type_id_seq.NEXTVAL PRIMARY KEY,
    Event_type    VARCHAR(40) NOT NULL
);


CREATE TABLE Event ---Create table for Event
(
    Event_ID           NUMBER        DEFAULT event_id_seq.NEXTVAL PRIMARY KEY,
    Venue_ID           NUMBER        NOT NULL,
    Event_type_id      NUMBER        NOT NULL,
    Event_Name         VARCHAR(40)   NOT NULL,
    Event_start_date   DATE          NOT NULL,
    Event_end_date     DATE          NOT NULL, 
    Event_description  VARCHAR(40), 
    CONSTRAINT  event_fk_venue_id FOREIGN KEY (Venue_ID) REFERENCES Venue (Venue_ID),
    CONSTRAINT  event_fk_event_type_id FOREIGN KEY (Event_type_ID) REFERENCES Event_type (Event_type_ID),
    CONSTRAINT check_date          CHECK (Event_end_date >= Event_start_date) 
);


CREATE TABLE Booth ---Create table for Booth
(
    Booth_ID           NUMBER        DEFAULT booth_id_seq.NEXTVAL PRIMARY KEY,
    Event_ID           NUMBER        NOT NULL,
    Booth_location     VARCHAR(40)   NOT NULL,
    CONSTRAINT  booth_fk_event_id FOREIGN KEY (Event_ID) REFERENCES Event (Event_ID)
);

CREATE TABLE Salesperson ---Create table for Salesperson
(
    Salesperson_ID           NUMBER        DEFAULT salesperson_id_seq.NEXTVAL PRIMARY KEY,
    Salesperson_first_name   VARCHAR(40)   NOT NULL,
    Salesperson_last_name    VARCHAR(40)   NOT NULL,
    Address_Line_1           VARCHAR(40)   NOT NULL,
    Address_Line_2           VARCHAR(40), 
    City                     VARCHAR(20)   NOT NULL,
    State                    CHAR(2)       NOT NULL, 
    Zip                      CHAR(5)       NOT NULL,
    CONSTRAINT check_sp_zip            CHECK ( LENGTH (Zip) = 5 ),
    CONSTRAINT check_sp_state          CHECK ( LENGTH(State) = 2 )
);

CREATE TABLE Shift ---Create table for Shift
(
    Shift_ID           NUMBER        DEFAULT shift_id_seq.NEXTVAL PRIMARY KEY,
    Booth_ID           NUMBER        NOT NULL,
    Salesperson_ID     NUMBER        NOT NULL,
    Shift_start_time   TIMESTAMP     NOT NULL,
    Shift_end_time     TIMESTAMP     NOT NULL,
    CONSTRAINT check_time          CHECK (Shift_end_time > Shift_start_time),
    CONSTRAINT  shift_fk_booth_id FOREIGN KEY (Booth_ID) REFERENCES Booth (Booth_ID),
    CONSTRAINT  shift_fk_salesperson_id FOREIGN KEY (Salesperson_ID) REFERENCES Salesperson (Salesperson_ID)
);


CREATE TABLE Product ---Create table for Product
(
    Product_ID                 NUMBER        DEFAULT product_id_seq.NEXTVAL PRIMARY KEY,
    Product_name               VARCHAR(40)   NOT NULL,
    Product_wholesale_price    NUMBER        NOT NULL,
    Product_msp                NUMBER        NOT NULL,
    CONSTRAINT  check_price CHECK(Product_msp>=Product_wholesale_price)
);

CREATE TABLE Sales ---Create table for Sales
(
    Sales_ID          NUMBER        DEFAULT sales_id_seq.NEXTVAL PRIMARY KEY,
    Event_ID          NUMBER        NOT NULL,
    Shift_ID          NUMBER        NOT NULL,
    Sales_date        DATE NOT NULL,
    CONSTRAINT  sales_fk_event_id FOREIGN KEY (Event_ID) REFERENCES Event (Event_ID),
    CONSTRAINT  sales_fk_shift_id FOREIGN KEY (Shift_ID) REFERENCES Shift (Shift_ID)
);

CREATE TABLE Product_sales_linking ---Create table for linking
(
    Sales_ID          NUMBER NOT NULL,
    Product_ID        NUMBER NOT NULL,
    Sales_quantity    NUMBER NOT NULL,
    Sales_price       NUMBER NOT NULL,
    PRIMARY KEY(Sales_ID, Product_ID),
    CONSTRAINT  product_sales_fk_sales_id FOREIGN KEY (Sales_ID) REFERENCES Sales (Sales_ID),
    CONSTRAINT  product_sales_fk_product_id FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID)
);

--------------------------------Section Ends------------------------------------
