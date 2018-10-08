select tmc,zonal_id,peak_hr, weekday,avg(speedcapped) from
(  

select  tmc,zonal_id, speedcapped,  peak_hr, weekday   from 
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
end as peak_hr
,to_char(basetimestamp,'DY')  weekday
from   public.here_roadway_flow  where basetimestamp > '2018-9-7 0:0:0' and basetimestamp < '2018-10-7 0:0:0'  and EXTRACT(hour FROM basetimestamp) >6 and   EXTRACT(hour FROM basetimestamp) <18



) tt1


inner join 
(select tmc, zonal_id,contracc  from public.here_xml_region_zone_8_temp where contracc = 'N'     ) tmc_r using (tmc)

) tttt
group by tmc,zonal_id, peak_hr,speedcapped, weekday
