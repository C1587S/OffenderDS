/*
Creamos los esquemas raw, cleaned y semantic, eliminándolos previamente en caso de que ya existieran
*/
drop schema if exists raw cascade;
create schema raw;

drop schema if exists cleaned cascade;
create schema cleaned;

drop schema if exists semantic cascade;
create schema semantic;