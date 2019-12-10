    
    drop table if exists cleaned.sentencias2017 cascade;
    CREATE TABLE cleaned.sentencias2017 as (select a.AMTTOTAL::int as amttotal, LOWER(b.senttot) as senttot, LOWER(c.senttot0) as senttot0, LOWER(d.sensplt) as sensplt, LOWER(e.sensplt0) as sensplt0, 
    LOWER(f.timservc) as timservc, LOWER(g.timeserv) as timeserv,LOWER(h.altdum) as altdum, LOWER(i.altmo) as altmo, LOWER(j.citizen) as citizen, LOWER(k.citwhere) as citwhere, LOWER(l.crimhist) as crimhist, 
    LOWER(m.disposit) as disposit, LOWER(n.district) as district, a.DOBMON::smallint as dobmon, LOWER(o.inout) as inout, LOWER(p.monsex) as monsex, 
    LOWER(q.neweduc) as neweduc, LOWER(r.newrace) as newrace, LOWER(s.numdepe) as numdepen, LOWER(t.offtypsb) as offtypsb, LOWER(u.present) as present, LOWER(v.sentimp) as sentimp, a.SENTMON::smallint as sentmon, 
    LOWER(w.typeoths) as typeoths, LOWER(x.years) as years, a.DOBYR::smallint as dobyr, a.SENTYR::smallint as sentyr
    FROM raw.sentencias2017 as a
    LEFT JOIN catalogo_senttot as b ON b.id=a.SENTTOT
    LEFT JOIN catalogo_senttot0 as c ON c.id=a.SENTTOT0
    LEFT JOIN catalogo_sensplt as d ON d.id=a.SENSPLT
    LEFT JOIN catalogo_sensplt0 as e ON e.id=a.SENSPLT0
    LEFT JOIN catalogo_timservc as f ON f.id=a.TIMSERVC
    LEFT JOIN catalogo_timeserv as g ON g.id=a.TIMESERV
    LEFT JOIN catalogo_altdum as h ON h.id=a.ALTDUM
    LEFT JOIN catalogo_altmo as i ON i.id=a.ALTMO
    LEFT JOIN catalogo_citizen as j ON j.id=a.CITIZEN
    LEFT JOIN catalogo_citwhere as k ON k.id=a.CITWHERE
    LEFT JOIN catalogo_crimhist as l ON l.id=a.CRIMHIST
    LEFT JOIN catalogo_disposit as m ON m.id=a.DISPOSIT
    LEFT JOIN catalogo_district as n ON n.id=a.DISTRICT
    LEFT JOIN catalogo_inout as o ON o.id=a.INOUT
    LEFT JOIN catalogo_monsex as p ON p.id=a.MONSEX
    LEFT JOIN catalogo_neweduc as q ON q.id=a.NEWEDUC
    LEFT JOIN catalogo_newrace as r ON r.id=a.NEWRACE
    LEFT JOIN catalogo_numdepen as s ON s.id=a.NUMDEPEN
    LEFT JOIN catalogo_offtypsb as t ON t.id=a.OFFTYPSB
    LEFT JOIN catalogo_present as u ON u.id=a.PRESENT
    LEFT JOIN catalogo_sentimp as v ON v.id=a.SENTIMP
    LEFT JOIN catalogo_typeoths as w ON w.id=a.TYPEOTHS
    LEFT JOIN catalogo_years as x ON x.id=a.YEARS);

    
  

    