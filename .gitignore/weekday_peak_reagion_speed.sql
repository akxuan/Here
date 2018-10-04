
select region,region_id,peak_hr,day_week,avg(speedcapped) from
( select * from 
(select roadwayid, pointcode,
concat (107,
case
WHEN SUBSTR(roadwayid,4,1)  = '-' 
               THEN 'N'
               ELSE 'P' 
       END , pointcode)as tmc,
roaddescription, speedcapped,
basetimestamp, 
CASE WHEN EXTRACT(hour FROM basetimestamp)  between 6 and 9    THEN 1
     WHEN EXTRACT(hour FROM basetimestamp)    between 10 and 14  THEN 2
	WHEN EXTRACT(hour FROM basetimestamp)  between 15 and 18    THEN 3
             ELSE 0 
end as peak_hr,
CASE WHEN EXTRACT(day FROM basetimestamp)  =1   THEN 1
WHEN EXTRACT(day FROM basetimestamp)  =2   THEN 2
WHEN EXTRACT(day FROM basetimestamp)  =3  THEN 3
WHEN EXTRACT(day FROM basetimestamp)  =4   THEN 4
WHEN EXTRACT(day FROM basetimestamp)  =28   THEN 5
WHEN EXTRACT(day FROM basetimestamp)  =29   THEN 6
WHEN EXTRACT(day FROM basetimestamp)  =30   THEN 7
ELSE 0 
end as day_week
from   public.here_roadway_flow  where basetimestamp > '2018-9-28 0:0:0' and basetimestamp < '2018-10-4 0:0:0' ) tt1
left join 
(select region_id,region,tmc from public.here_tmc_link_region_temp ) tmc_r using (tmc)) tttt
group by region,region_id,peak_hr,day_week
