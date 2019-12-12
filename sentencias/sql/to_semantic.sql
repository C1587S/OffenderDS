--\echo 'Berka(semantic)'
--\echo 'Programación para Ciencia de Datos'
--\echo 'Adolfo De Unánue <unanue@itam.mx>'
--\set VERBOSITY terse
--\set ON_ERROR_STOP true

do language plpgsql $$ declare
    exc_message text;
    exc_context text;
    exc_detail text;
begin

  do $semantic$ begin

  set search_path = semantic, public;

  raise notice 'populating entities';
  drop table if exists entities;
  create table if not exists entities as (
    select
      "offender",
      "country_citizenship",
      make_date(birth_year, birth_month,01) as birth_date,
      "genre",
      "race"
      from cleaned.sentencias2017
    );

  create index semantic_entities_offender_ix on semantic.entities(offender);
  create index semantic_entities_citizenship_ix on semantic.entities(country_citizenship);
  create index semantic_entities_birth_ix on semantic.entities(birth_date);
  create index semantic_entities_genre_ix on semantic.entities(genre);
  create index semantic_entities_race_ix on semantic.entities(race);

---- Tablas de eventos:
-- Evento 1: Se le genera la sentencia al acusado
raise notice 'populating event_sentences';
drop table if exists event_sentences;
create table if not exists event_sentences as (
  select
   "offender",
    "sentencing_date",
    "sentence_type",
    "district_sentence",
  case when sentence_type ='no prison or probation ' then concat('sentenced to',' ',0,' ','months in prison')
  when sentence_type='prison only ' and "imprisonment_length" is not null then concat('sentenced to',' ',"imprisonment_length"::float,' ', 'months in prison')
  when sentence_type='prison and confinement conditions 'and "sensplt" is not null then concat('sentenced to',' ',"sensplt"::float,' ','months in prison')
  when sentence_type='probation and confinement conditions ' and "total_sentence_length" is not null and "imprisonment_length" is not null then concat('sentenced to',' ',"total_sentence_length"::float-"imprisonment_length"::float,' ','months in prison')
  when sentence_type='probation only' then concat('sentenced to',' ',0,' ','months in prison')
  else 'not enough information'
  end as attributes
  from cleaned.sentencias2017;
  );
  create index semantic_sentences_offender_ix on semantic.event_sentences(offender);
  create index semantic_sentences_date_ix on semantic.event_sentences(sentencing_date);
  create index semantic_sentences_type_ix on semantic.event_sentences(sentence_type);
  create index semantic_sentences_district_ix on semantic.event_sentences(district_sentence);

  end $semantic$;

  set search_path = semantic, public;
exception when others then
    get stacked diagnostics exc_message = message_text;
    get stacked diagnostics exc_context = pg_exception_context;
    get stacked diagnostics exc_detail = pg_exception_detail;
    raise exception E'\n------\n%\n%\n------\n\nCONTEXT:\n%\n', exc_message, exc_detail, exc_context;
end $$;
