    drop table if exists cleaned.sentencias2017 cascade;
    CREATE TABLE cleaned.sentencias2017 as (select row_number() over() as offender, a."AMTTOTAL"::int as total_amount, remove_punctuation_marks(LOWER(b.senttot0)) as imprisonment_length, remove_punctuation_marks(LOWER(c.senttot0)) as senttot0, remove_punctuation_marks(LOWER(d.senttot0)) as sensplt, remove_punctuation_marks(LOWER(e.senttot0)) as total_sentence_length, 
    remove_punctuation_marks(LOWER(f.timeservc)) as credited_months, remove_punctuation_marks(LOWER(g.timeserv)) as estimated_prison_time,remove_punctuation_marks(LOWER(h.value)) as  alternative_sentence, remove_punctuation_marks(LOWER(i.altmo)) as alternative_time, 
	remove_punctuation_marks(replace_slash(LOWER(j.citizen))) as citizenship_status, remove_punctuation_marks(replace_slash(LOWER(k.citwhere))) as country_citizenship, remove_punctuation_marks(LOWER(l.value)) as criminal_history, 
    remove_punctuation_marks(LOWER(m.disposit)) as sentence_disposition, remove_punctuation_marks(LOWER(n.district)) as district_sentence, a."DOBMON"::smallint as birth_month, remove_punctuation_marks(LOWER(o.value)) as non_prison_sentence, remove_punctuation_marks(LOWER(p.monsex)) as genre, 
    remove_punctuation_marks(LOWER(q.neweduc)) as education_level, remove_punctuation_marks(replace_slash(LOWER(r.newrace))) as race, remove_punctuation_marks(LOWER(s.numdepen)) as num_dependents, remove_punctuation_marks(LOWER(t.offtypsb)) as offense_type, remove_punctuation_marks(replace_slash(LOWER(u.present))) as presentence_detention_status, remove_punctuation_marks(replace_slash(replace_plus(LOWER(v.sentimp)))) as sentence_type, a."SENTMON"::smallint as sentencing_month, 
    remove_punctuation_marks(LOWER(w.typeoths)) as sentence_type_other, remove_punctuation_marks(replace_less_than(replace_greater_than(LOWER(x.years)))) as age_range, a."DOBYR"::smallint as birth_year, a."SENTYR"::smallint as sentencing_year, make_date("SENTYR"::smallint,"SENTMON"::smallint,01) as sentencing_date,
    case when "SENTTOT"='470' then '2150-01-01'::date When "SENTTOT" is null then null Else make_date("SENTYR"::smallint,"SENTMON"::smallint,01) + interval '1 month'*"SENTTOT"::float end as sentencing_end_date
    FROM raw.sentencias2017 as a
    LEFT JOIN raw.catalogo_senttot0 as b ON b."id"=a."SENTTOT"
    LEFT JOIN raw.catalogo_senttot0 as c ON c."id"=a."SENTTOT0"
    LEFT JOIN raw.catalogo_senttot0 as d ON d."id"=a."SENSPLT"
    LEFT JOIN raw.catalogo_senttot0 as e ON e."id"=a."SENSPLT0"
    LEFT JOIN raw.catalogo_timeservc as f ON f."id"=a."TIMSERVC"
    LEFT JOIN raw.catalogo_timeserv as g ON g."id"=a."TIMESERV"
    LEFT JOIN raw.catalogo_yes_no as h ON h."id"=a."ALTDUM"
    LEFT JOIN raw.catalogo_altmo as i ON i."id"=a."ALTMO"
    LEFT JOIN raw.catalogo_citizen as j ON j."id"=a."CITIZEN"
    LEFT JOIN raw.catalogo_citwhere as k ON k."id"=a."CITWHERE"
    LEFT JOIN raw.catalogo_yes_no as l ON l."id"=a."CRIMHIST"
    LEFT JOIN raw.catalogo_disposit as m ON m."id"=a."DISPOSIT"
    LEFT JOIN raw.catalogo_district as n ON n."id"=a."DISTRICT"
    LEFT JOIN raw.catalogo_yes_no as o ON o."id"=a."INOUT"
    LEFT JOIN raw.catalogo_monsex as p ON p."id"=a."MONSEX"
    LEFT JOIN raw.catalogo_neweduc as q ON q."id"=a."NEWEDUC"
    LEFT JOIN raw.catalogo_newrace as r ON r."id"=a."NEWRACE"
    LEFT JOIN raw.catalogo_numdepen as s ON s."id"=a."NUMDEPEN"
    LEFT JOIN raw.catalogo_offtypsb as t ON t."id"=a."OFFTYPSB"
    LEFT JOIN raw.catalogo_present as u ON u."id"=a."PRESENT"
    LEFT JOIN raw.catalogo_sentimp as v ON v."id"=a."SENTIMP"
    LEFT JOIN raw.catalogo_typeoths as w ON w."id"=a."TYPEOTHS"
    LEFT JOIN raw.catalogo_years as x ON x."id"=a."YEARS");

    
  

    