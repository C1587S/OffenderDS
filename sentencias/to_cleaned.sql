    drop table if exists cleaned.sentencias2017 cascade;
    CREATE TABLE cleaned.sentencias2017 as (select a."AMTTOTAL"::int as total_amount, LOWER(b.senttot0) as imprisonment_length, LOWER(c.senttot0) as senttot0, LOWER(d.senttot0) as sensplt, LOWER(e.senttot0) as total_sentence_length, 
    LOWER(f.timeservc) as credited_months, LOWER(g.timeserv) as estimated_prison_time,LOWER(h.value) as  alternative_sentence, --LOWER(i.altmo) as alternative_time, 
	LOWER(j.citizen) as citizenship_status, LOWER(k.citwhere) as country_citizenship, LOWER(l.value) as criminal_history, 
    LOWER(m.disposit) as sentence_disposition, LOWER(n.district) as district_sentence, a."DOBMON"::smallint as birth_month, LOWER(o.value) as non_prison_sentence, LOWER(p.monsex) as genre, 
    LOWER(q.neweduc) as education_level, LOWER(r.newrace) as race, LOWER(s.numdepen) as num_dependents, LOWER(t.offtypsb) as offense_type, LOWER(u.present) as presentence_detention_status, LOWER(v.sentimp) as sentence_type, a."SENTMON"::smallint as sentencing_month, 
    LOWER(w.typeoths) as sentence_type_other, LOWER(x.years) as age_range, a."DOBYR"::smallint as birth_year, a."SENTYR"::smallint as sentencing_year
    FROM raw.sentencias2017 as a
    LEFT JOIN raw.catalogo_senttot0 as b ON b."id"=a."SENTTOT"
    LEFT JOIN raw.catalogo_senttot0 as c ON c."id"=a."SENTTOT0"
    LEFT JOIN raw.catalogo_senttot0 as d ON d."id"=a."SENSPLT"
    LEFT JOIN raw.catalogo_senttot0 as e ON e."id"=a."SENSPLT0"
    LEFT JOIN raw.catalogo_timeservc as f ON f."id"=a."TIMSERVC"
    LEFT JOIN raw.catalogo_timeserv as g ON g."id"=a."TIMESERV"
    LEFT JOIN raw.catalogo_yes_no as h ON h."id"=a."ALTDUM"
    --LEFT JOIN raw.catalogo_altmo as i ON i."id"=a."ALTMO"
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

    
  

    