create schema if not exists raw;

drop table if exists raw.sentencias2017;

CREATE TABLE raw.sentencias2017(
  "SENTTOT" TEXT,
  "SENTTOT0" TEXT,
  "CITIZEN" TEXT,
  "CITWHERE" TEXT,
  "CRIMHIST" TEXT,
  "DISTRICT" TEXT,
  "DOBMON" TEXT,
  "EDUCATN" TEXT,
  "ENCRYPT2" TEXT,
  "HISPORIG" TEXT,
  "INOUT" TEXT,
  "NEWRACE" TEXT,
  "OFFTYPSB" TEXT,
  "SENTIMP" TEXT,
  "SENTMON" TEXT,
  "DOBYR" TEXT,
  "SENTYR" TEXT
);

comment on table raw.sentencias2017 is 'contiene los datos de las sentencias de 2017';

