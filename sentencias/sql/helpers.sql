    
create or replace function remove_punctuation_marks
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\.|,|\(.+\)|\*|-|\s-|;','','g');
$$;

    
create or replace function replace_slash
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\/|\\',' or ','g');
$$;


create or replace function replace_plus
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '\+','and','g');
$$;


create or replace function replace_less_than
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '<','less than','g');
$$;

create or replace function replace_greater_than
  (
    column_text text
  )
returns text
language sql
as $$
select regexp_replace(column_text, '>','over','g');
$$;