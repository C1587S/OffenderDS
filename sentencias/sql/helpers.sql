/*Funciones auxiliares para limpiar los datos*/

create or replace function remove_punctuation_marks
-- Función para eliminar símbolos y signos de puntuación  
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\.|,|\(.+\)|\*|-|\s-|;','','g');
$$;

    
create or replace function replace_slash
-- Función para sustituir diagonales por " or "
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\/|\\',' or ','g');
$$;


create or replace function replace_plus
-- Función para sustituir el signo + por "and"
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\+','and','g');
$$;


create or replace function replace_less_than
-- Función para sustituir el símbolo < por "less than"
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '<','less than','g');
$$;

create or replace function replace_greater_than
-- Función para sustituir el símbolo > por "over"
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '>','over','g');
$$;