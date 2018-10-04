
select roadwayid, pointcode, roaddescription, speedcapped,
basetimestamp, 
CASE WHEN EXTRACT(hour FROM basetimestamp)  between 6 and 9    THEN 1
     WHEN EXTRACT(hour FROM basetimestamp)    between 10 and 14  THEN 2
	WHEN EXTRACT(hour FROM basetimestamp)  between 15 and 18    THEN 3
             ELSE 0 
end as peak_hr,
CASE WHEN EXTRACT(day FROM basetimestamp)  =1   THEN 1
WHEN EXTRACT(day FROM basetimestamp)  =2   THEN 2
WHEN EXTRACT(day FROM basetimestamp)  =28   THEN 5
WHEN EXTRACT(day FROM basetimestamp)  =29   THEN 6
WHEN EXTRACT(day FROM basetimestamp)  =30   THEN 7
 ELSE 0 
 end as day_week
from   public.here_roadway_flow  where basetimestamp > '2018-9-28 0:0:0' and basetimestamp < '2018-10-2 0:0:0' 
