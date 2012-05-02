Readme for downloaded Perez/SUNY solar irradiation data plus extrapolated weather data

file name is radwx_YYYYYXXXX_year.csv.gz
where YYYYY is longitude yyy.yy, and XXXX is latitude xx.xx

Example file radwx_118954195_2000.csv (first 11 records):

118954195,41.95,-118.95,1490.37,-8.00,118144,5.1,-118.922,41.991,1664.8
2000,1,1,01,0,0,0,-3.60,-7.30,827.2,355,3.31
2000,1,1,02,0,0,0,-4.00,-7.33,827.8,355,2.90
2000,1,1,03,0,0,0,-4.40,-7.37,828.5,297,2.48
2000,1,1,04,0,0,0,-4.80,-7.40,829.1,297,2.07
2000,1,1,05,0,0,0,-5.10,-7.60,828.6,297,2.68
2000,1,1,06,0,0,0,-5.40,-7.80,828.2,246,3.30
2000,1,1,07,0,0,0,-5.70,-8.00,827.7,246,3.91
2000,1,1,08,1,0,1,-4.40,-7.97,827.6,246,4.65
2000,1,1,09,28,0,28,-3.10,-7.93,827.4,243,5.40
2000,1,1,10,57,0,57,-1.80,-7.90,827.3,243,6.14

Record 1 fields:
1.  RPid - 9 digit ID number
2.  Rlat - Radiation data latitude, degrees (+ is North)
3,  Rlon - Radiation data longitude, degrees (+ is East)
4.  Relev - Radiation data elevation, meters above MSL.
5.  TimeZone - Time zone in hours from GMT (all data are in local standard time).
6.  WXid - weather (NARR) id number.
7.  DDist - distance from center of radiation cell to center of weather cell, in km.
8.  WXlon - Weather data longitude, degrees (+ is East)
9.  WXlat - Weather data latitude, degrees (+ is North)
10.  WXelev - Weather data elevation, meters above MSL.

All other records, fields:
1.  Year
2.  Month
3.  Day
4.  Hour
5.  Global Horizontal (GHI), watts/m2
6.  Direct Normal (DNI), watts/m2
7.  Diffuse, watts/m2
8.  Temperature, degrees C.
9.  Dew Point, degrees C.
10.  Surface pressure, millibars
11.  Wind direction, degrees
12. Wind Speed, meters/second.

For NARR data, the original inputs are every 3 hours in GMT, hours are 00, 03, 06, ..., 21.  For these hourly files, we interpolate linearly for all fields except wind direction.  For wind direction, we duplicate the 3 hourly value for the hours before and after the observation time.
