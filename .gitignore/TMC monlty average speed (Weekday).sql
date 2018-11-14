select TMC, peak_hr, avg(speedcapped) from 
(select  concat (107,case
	WHEN SUBSTR(roadwayid,4,1)  = '-' 
	       THEN 'N'
	       ELSE 'P' 
	END , pointcode)as tmc,
speedcapped,

CASE WHEN EXTRACT(hour FROM basetimestamp)  between 6 and 9    THEN 1
     WHEN EXTRACT(hour FROM basetimestamp)    between 10 and 14  THEN 2
	WHEN EXTRACT(hour FROM basetimestamp)  between 15 and 18    THEN 3
             ELSE 0 
end as peak_hr
from   public.here_roadway_flow  where basetimestamp > '2018-9-24 0:0:0' and basetimestamp < '2018-9-28 0:0:0'  ) ass

where peak_hr > 0 
group by TMC, peak_hr
