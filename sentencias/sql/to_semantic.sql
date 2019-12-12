-- Crear tabla de entidades
-- borrar la tabla en caso de que ya exista y crear una nueva
  drop table if exists semantic.entities;
  create table if not exists semantic.entities as (
    select
      "offender",
      "country_citizenship",
      make_date(birth_year, birth_month,01) as birth_date,
      "genre",
      "race"
      from cleaned.sentencias2017 );
-- índices para la tabla de entidades
create index semantic_entities_offender_ix on semantic.entities(offender);
create index semantic_entities_citizenship_ix on semantic.entities(country_citizenship);
create index semantic_entities_birth_ix on semantic.entities(birth_date);
create index semantic_entities_genre_ix on semantic.entities(genre);
create index semantic_entities_race_ix on semantic.entities(race);

---- Tablas de eventos:
-- Evento 1: Se le genera la sentencia al acusado
drop table if exists semantic.event_sentences;
create table if not exists semantic.event_sentences as (
  select "offender", "sentencing_date","sentence_type", "district_sentence",
  case when sentence_type = 'no prison or probation ' then concat('sentenced to',' ',0,' ','months in prison')
  when sentence_type = 'prison only ' and "imprisonment_length" is not null and "imprisonment_length"<>'life' then concat('sentenced to',' ',"imprisonment_length"::float,' ', 'months in prison')
  when sentence_type = 'prison and confinement conditions 'and "sensplt" is not null then concat('sentenced to',' ',"sensplt"::float,' ','months in prison')
  when sentence_type = 'probation and confinement conditions ' and "total_sentence_length" is not null and "imprisonment_length"<>'life' and "imprisonment_length" is not null then concat('sentenced to',' ',"total_sentence_length"::float-"imprisonment_length"::float,' ','months in prison')
  when sentence_type = 'probation only' then concat('sentenced to',' ',0,' ','months in prison')
  else 'not enough information'
  end as attributes
  from cleaned.sentencias2017);
-- índices asociados
create index semantic_sentences_offender_ix on semantic.event_sentences(offender);
create index semantic_sentences_date_ix on semantic.event_sentences(sentencing_date);
create index semantic_sentences_type_ix on semantic.event_sentences(sentence_type);
create index semantic_sentences_district_ix on semantic.event_sentences(district_sentence);

  -- Evento 2: Se le genera la reincidencia
  drop table if exists semantic.event_reincidence;
  create table if not exists semantic.event_reincidence as (
    select "offender", "sentencing_date","sentence_type", "district_sentence", "criminal_history",
    case when criminal_history = 'yes' then 'with previous criminal history'
    when criminal_history = 'no' then 'without previous criminal history'
    else null
    end as attributes
    from cleaned.sentencias2017);
  -- índices asociados
  create index semantic_reincidence_offender_ix on semantic.event_reincidence(offender);
  create index semantic_reincidence_date_ix on semantic.event_reincidence(sentencing_date);
  create index semantic_reincidence_type_ix on semantic.event_reincidence(sentence_type);
  create index semantic_reincidence_district_ix on semantic.event_reincidence(district_sentence);
  create index semantic_reincidence_criminalhist_ix on semantic.event_reincidence(criminal_history);

    -- Evento 3: Se le generó una multa al sentenciado
    drop table if exists semantic.event_fine;
    create table if not exists semantic.event_fine as (
      select "offender", "sentencing_date", "district_sentence", "total_amount",
      concat('the fine amount was', ' ',"total_amount", ' ','USD', ' ', 'for a citizen from', ' ',"country_citizenship") as attributes
      from cleaned.sentencias2017
      where total_amount is not null);
    -- índices asociados
    create index semantic_fine_offender_ix on semantic.event_fine(offender);
    create index semantic_fine_date_ix on semantic.event_fine(sentencing_date);
    create index semantic_fine_amount_ix on semantic.event_fine(total_amount);
    create index semantic_fine_district_ix on semantic.event_fine(district_sentence);
