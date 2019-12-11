create schema if not exists raw;

drop table if exists raw.sentencias2017;

CREATE TABLE raw.sentencias2017(
  "AMTTOTAL" TEXT,
  "SENTTOT" TEXT,
  "SENTTOT0" TEXT,
  "SENSPLT" TEXT,
  "SENSPLT0" TEXT,
  "TIMSERVC" TEXT,
  "TIMESERV" TEXT,
  "ALTDUM" TEXT,
  "ALTMO" TEXT,
  "CITIZEN" TEXT,
  "CITWHERE" TEXT,
  "CRIMHIST" TEXT,
  "DISPOSIT" TEXT,
  "DISTRICT" TEXT,
  "DOBMON" TEXT,
  "EDUCATN" TEXT,
  "ENCRYPT2" TEXT,
  "HISPORIG" TEXT,
  "INOUT" TEXT,
  "MONSEX" TEXT,
  "NEWEDUC" TEXT,
  "NEWRACE" TEXT,
  "NUMDEPEN" TEXT,
  "OFFTYPSB" TEXT,
  "PRESENT" TEXT,
  "SENTIMP" TEXT,
  "SENTMON" TEXT,
  "TYPEOTHS" TEXT,
  "YEARS" TEXT,
  "DOBYR" TEXT,
  "SENTYR" TEXT
);

comment on table raw.sentencias2017 is 'contiene los datos de las sentencias de 2017';


drop table if exists raw.catalogo_altmo;

CREATE TABLE raw.catalogo_altmo(
  "id" TEXT,
  "altmo" TEXT
);

comment on table raw.catalogo_altmo is 'catalogo de valores para la columna altmo';


drop table if exists raw.catalogo_citwhere;

CREATE TABLE raw.catalogo_citwhere(
  "id" TEXT,
  "citwhere" TEXT
);

comment on table raw.catalogo_citwhere is 'catalogo de valores para la columna citwhere';


drop table if exists raw.catalogo_citizen;

CREATE TABLE raw.catalogo_citizen(
  "id" TEXT,
  "citizen" TEXT
);

comment on table raw.catalogo_citizen is 'catalogo de valores para la columna citizen';
  
  
drop table if exists raw.catalogo_disposit;

CREATE TABLE raw.catalogo_disposit(
  "id" TEXT,
  "disposit" TEXT
);

comment on table raw.catalogo_disposit is 'catalogo de valores para la columna disposit';


drop table if exists raw.catalogo_district;

CREATE TABLE raw.catalogo_district(
  "id" TEXT,
  "district" TEXT
);

comment on table raw.catalogo_district is 'catalogo de valores para la columna district';
     
        
drop table if exists raw.catalogo_monsex;

CREATE TABLE raw.catalogo_monsex(
  "id" TEXT,
  "monsex" TEXT
);

comment on table raw.catalogo_monsex is 'catalogo de valores para la columna monsex';
    
    
drop table if exists raw.catalogo_neweduc;

CREATE TABLE raw.catalogo_neweduc(
  "id" TEXT,
  "neweduc" TEXT
);

comment on table raw.catalogo_neweduc is 'catalogo de valores para la columna neweduc';


drop table if exists raw.catalogo_newrace;

CREATE TABLE raw.catalogo_newrace(
  "id" TEXT,
  "newrace" TEXT
);

comment on table raw.catalogo_newrace is 'catalogo de valores para la columna newrace';
   

drop table if exists raw.catalogo_numdepen;

CREATE TABLE raw.catalogo_numdepen(
  "id" TEXT,
  "numdepen" TEXT
);

comment on table raw.catalogo_numdepen is 'catalogo de valores para la columna numdepen';
 


drop table if exists raw.catalogo_offtypsb;

CREATE TABLE raw.catalogo_offtypsb(
  "id" TEXT,
  "offtypsb" TEXT
);

comment on table raw.catalogo_offtypsb is 'catalogo de valores para la columna offtypsb';
 

drop table if exists raw.catalogo_present;

CREATE TABLE raw.catalogo_present(
  "id" TEXT,
  "present" TEXT
);

comment on table raw.catalogo_present is 'catalogo de valores para la columna present';
 
  
drop table if exists raw.catalogo_sentimp;

CREATE TABLE raw.catalogo_sentimp(
  "id" TEXT,
  "sentimp" TEXT
);

comment on table raw.catalogo_sentimp is 'catalogo de valores para la columna sentimp';


drop table if exists raw.catalogo_timeserv;

CREATE TABLE raw.catalogo_timeserv(
  "id" TEXT,
  "timeserv" TEXT
);

comment on table raw.catalogo_timeserv is 'catalogo de valores para la columna timeserv';


drop table if exists raw.catalogo_senttot0;
 
CREATE TABLE raw.catalogo_senttot0(
  "id" TEXT,
  "senttot0" TEXT
);

comment on table raw.catalogo_senttot0 is 'catalogo de valores para la columna senttot0';
   

drop table if exists raw.catalogo_timeservc;

CREATE TABLE raw.catalogo_timeservc(
  "id" TEXT,
  "timeservc" TEXT
);

comment on table raw.catalogo_timeservc is 'catalogo de valores para la columna timeservc';
  

drop table if exists raw.catalogo_typeoths;

CREATE TABLE raw.catalogo_typeoths(
  "id" TEXT,
  "typeoths" TEXT
);

comment on table raw.catalogo_typeoths is 'catalogo de valores para la columna typeoths';
    

drop table if exists raw.catalogo_years;

CREATE TABLE raw.catalogo_years(
  "id" TEXT,
  "years" TEXT
);

comment on table raw.catalogo_years is 'catalogo de valores para la columna years';

   

drop table if exists raw.catalogo_yes_no;

CREATE TABLE raw.catalogo_yes_no(
  "id" TEXT,
  "value" TEXT
);

comment on table raw.catalogo_yes_no is 'catalogo de valores para la columna crimhist';
