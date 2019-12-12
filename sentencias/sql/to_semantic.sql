-- Crear tabla de entidades
-- borrar la tabla en caso de que ya exista y crear una nueva

DROP TABLE IF EXISTS semantic.entities;


CREATE TABLE IF NOT EXISTS semantic.entities AS
  (SELECT "offender",
          "country_citizenship",
          make_date(birth_year, birth_month, 01) AS birth_date,
          "genre",
          "race"
   FROM cleaned.sentencias2017);

-- índices asociados a la tabla de eventos

CREATE INDEX semantic_entities_offender_ix ON semantic.entities(offender);
CREATE INDEX semantic_entities_citizenship_ix ON semantic.entities(country_citizenship);
CREATE INDEX semantic_entities_birth_ix ON semantic.entities(birth_date);
CREATE INDEX semantic_entities_genre_ix ON semantic.entities(genre);
CREATE INDEX semantic_entities_race_ix ON semantic.entities(race);

---- Tablas de eventos:
-- Evento 1: Se le genera la sentencia AL ACUSADO
-- para la creación de la sentencia se muestra la fecha, lugar, tipo, y como atributo
-- adicional los meses de condena.


DROP TABLE IF EXISTS semantic.event_sentences;


CREATE TABLE IF NOT EXISTS semantic.event_sentences AS
  (SELECT "offender",
          "sentencing_date",
          "sentence_type",
          "district_sentence",
          CASE
              WHEN sentence_type = 'no prison or probation ' THEN concat('sentenced to', ' ', 0, ' ', 'months in prison')
              WHEN sentence_type = 'prison only '
                   AND "imprisonment_length" IS NOT NULL
                   AND "imprisonment_length"<>'life' THEN concat('sentenced to', ' ', "imprisonment_length"::float, ' ', 'months in prison')
              WHEN sentence_type = 'prison and confinement conditions '
                   AND "sensplt" IS NOT NULL THEN concat('sentenced to', ' ', "sensplt"::float, ' ', 'months in prison')
              WHEN sentence_type = 'probation and confinement conditions '
                   AND "total_sentence_length" IS NOT NULL
                   AND "imprisonment_length"<>'life'
                   AND "imprisonment_length" IS NOT NULL THEN concat('sentenced to', ' ', "total_sentence_length"::float-"imprisonment_length"::float, ' ', 'months in prison')
              WHEN sentence_type = 'probation only' THEN concat('sentenced to', ' ', 0, ' ', 'months in prison')
              ELSE 'not enough information'
          END AS attributes
   FROM cleaned.sentencias2017);

-- índices asociados a la tabla de eventos

CREATE INDEX semantic_sentences_offender_ix ON semantic.event_sentences(offender);
CREATE INDEX semantic_sentences_date_ix ON semantic.event_sentences(sentencing_date);
CREATE INDEX semantic_sentences_type_ix ON semantic.event_sentences(sentence_type);
CREATE INDEX semantic_sentences_district_ix ON semantic.event_sentences(district_sentence);

-- Evento 2: El acusado presenta reincidencia
-- se genera como evento en el que se meustra el acusado, la fecha de sentencia,
-- el tipo de ofensa, el lugar (distrito), y si tenía historia criminal.
-- Esto con la búsqueda de determinar si reincide o es primera vez (atributo).

DROP TABLE IF EXISTS semantic.event_reincidence;


CREATE TABLE IF NOT EXISTS semantic.event_reincidence AS
  (SELECT "offender",
          "sentencing_date",
          "sentence_type",
          "district_sentence",
          "criminal_history",
          CASE
              WHEN criminal_history = 'yes' THEN 'with previous criminal history'
              WHEN criminal_history = 'no' THEN 'without previous criminal history'
              ELSE NULL
          END AS attributes
   FROM cleaned.sentencias2017);

-- índices asociados a la tabla de eventos

CREATE INDEX semantic_reincidence_offender_ix ON semantic.event_reincidence(offender);
CREATE INDEX semantic_reincidence_date_ix ON semantic.event_reincidence(sentencing_date);
CREATE INDEX semantic_reincidence_type_ix ON semantic.event_reincidence(sentence_type);
CREATE INDEX semantic_reincidence_district_ix ON semantic.event_reincidence(district_sentence);
CREATE INDEX semantic_reincidence_criminalhist_ix ON semantic.event_reincidence(criminal_history);

-- Evento 3: Se le generó una multa al sentenciado
-- Se genera un evento en el cual se muestra el acusado, la fecha de la sentencia,
-- el lugar (distrito), y la multa generada. Como descripción del evento se
-- muestra la ciudadanía del acusado.

DROP TABLE IF EXISTS semantic.event_fine;


CREATE TABLE IF NOT EXISTS semantic.event_fine AS
  (SELECT "offender",
          "sentencing_date",
          "district_sentence",
          "total_amount",
          concat('the fine amount was', ' ', "total_amount", ' ', 'USD', ' ', 'for a citizen from', ' ', "country_citizenship") AS attributes
   FROM cleaned.sentencias2017
   WHERE total_amount IS NOT NULL);

-- índices asociados a la tabla de eventos

CREATE INDEX semantic_fine_offender_ix ON semantic.event_fine(offender);
CREATE INDEX semantic_fine_date_ix ON semantic.event_fine(sentencing_date);
CREATE INDEX semantic_fine_amount_ix ON semantic.event_fine(total_amount);
CREATE INDEX semantic_fine_district_ix ON semantic.event_fine(district_sentence);
