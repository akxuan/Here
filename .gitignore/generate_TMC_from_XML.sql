
select concat (107,
case
WHEN SUBSTR(roadwayid,4,1)  = '-' 
               THEN 'N'
               ELSE 'P' 
       END , pointcode)as TMC, speedcapped 


from
(

select distinct roadwayid, 

--pointcode,
 case
WHEN pointcode < 10000
               THEN '0'||CAST(pointcode AS varchar(10))
               ELSE CAST(pointcode AS varchar(10))
       END   as pointcode


, speedcapped   from public.here_roadway_flow 
where  --pointcode = 18822 and   
basetimestamp >'2018-10-1 8:0:0' 
and basetimestamp <'2018-10-1 10:0:2' 

) tt

