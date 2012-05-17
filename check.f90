Program CheckTMY23

! Juan Pablo Justiniano
! jpjustiniano@gmail.com
! 26.06.2010 

implicit none 

INTEGER :: n=1, ierror, errorh, sel=1
CHARACTER(len=70) 	:: argument
CHARACTER(len=4) 	:: xxx

!TMY2  Head
 CHARACTER (LEN=5) :: WBAN 
 CHARACTER (LEN=22) :: city
 CHARACTER (LEN=2) ::  state
 INTEGER :: tz
 CHARACTER (LEN=1) ::  latitude
 INTEGER :: LatDeg
 INTEGER :: LatMin
 CHARACTER (LEN=1) ::  longitude
 INTEGER :: LonDeg
 INTEGER :: LonMin 
 INTEGER :: Elevation 
  
!TMY2  Body
   CHARACTER (LEN=1) :: gloflg,dirflg,difflg,gloiflg,diriflg,dififlg,zeniflg,totflg,opqflg,drybflg,dewpflg
   CHARACTER (LEN=1) :: rhumflg,baroflg,wdirflg,wspdflg,visiflg,chgtflg,pwatflg,aodflg,sndpflg,dslsflg
   CHARACTER (LEN=10) :: prwt
   INTEGER :: yr,mo,dy,hr,etr,etrn,glo,glounc,dir,dirunc,dif,difunc,gloi,gloiunc,diri,diriunc,difi
   INTEGER :: difiunc,zeni,zeniunc,tot,totunc,opq, opqunc,dryb,drybunc,dewp,dewpunc,rhum,rhumunc,baro
   INTEGER :: barounc,wdir, wdirunc, wspd, wspdunc, visi,visiunc,chgt,chgtunc,pwat,pwatunc,aod
   INTEGER :: aodunc,sndp,sndpunc,dsls,dslsunc
				
!TMY3  Head
 CHARACTER (LEN=30) :: name
 REAL :: tz3, latitude3, longitude3
 INTEGER ::  USAF, elevation3

!TMY3  Body
 CHARACTER (LEN=10) :: date, yyyyddmm
 character(2) 	:: di,me
 character(4)	:: ano
 CHARACTER (LEN=5) :: time 
 INTEGER ::  Albunc,Lprecip,Lpreciphr,Lprecipunc, mm,dd,yyyy,hh,mi
 CHARACTER (LEN=1) ::  Albflg,Lprecipflg
 REAL :: Alb


1022 FORMAT ( 1X,A5,1X,A22,1X,A2,1X,I3,1X,A1,1X,I2,1X,I2,1X,A1,1X,I3,1X,I2,2X,I4 ) !Header
1002 FORMAT ( (1X, 4I2, 2I4, 7 (I4, A1, I1), 2( I2, A1, I1), 2 (I4, A1, I1), 1(I3, A1, I1),( I4, A1, I1),&
				& 2 (I3, A1, I1), 1(I4, A1, I1), 1(I5, A1, I1), A10, 3 (I3, A1, I1), (I2, A1, I1)) ) !Body
1033 FORMAT ( I7, A, A2,F5.1,2F9.3, I4 ) !Header
1003 FORMAT ( A4,A2,A2,A5,I2,I2,24I4,A1,2I1,2(A1,I1,F3.1),A1,2I2,A1,I1,I4,A1,I1,I3,A1,I1,F4.1,A1,I1,I4,A1,I1,I5,A1,I1,F5.1,&
				 &2(A1,I1,F5.3),A1,I1,2I3,A1,I1)  !Body

call get_command_argument(1, argument)

write (xxx,*) argument(LEN_TRIM(argument) - 2 : LEN_TRIM(argument))

Select case (xxx)	!Selector de formato de archivo
Case (' tm2', ' TM2')
	write(*,*) ' Formato TMY2, File: ',trim(argument)
sel=1 
Case (' csv',' CSV')
	write(*,*) ' Formato Comma Separate per Coma, File: ',trim(argument)
sel=2
Case default
Write(*,*) ' Para verificar TMY2 "1", para verificar TMY3 "2".'
Write(*,*) ' 1: TMY2; 2:TMY3 '
Read (*,*) sel
end select

write (*,*) xxx
write (*,*) argument
write (*,*) sel
read (*,*)

If (sel==1) Then     ! ******** TMY2 ************
 
	open(unit=2,file='23234.tm2')   
	
	READ(2,1022,IOSTAT=errorh)WBAN , city, state, tz, latitude,LatDeg,LatMin, longitude,LonDeg, LonMin, elevation
			Write (*,*) WBAN , city, state, tz   
	IF (errorh/=0)  write (*,*) 'Error en lectura de encabezado.'

	DO 
	    READ (2,1002,IOSTAT=ierror) yr,mo,dy,hr,etr,etrn,glo,gloflg,glounc,dir,dirflg,dirunc,dif,difflg,difunc,gloi,gloiflg,&
					&gloiunc,diri,diriflg,diriunc,difi,dififlg,difiunc,zeni,zeniflg,zeniunc,tot,totflg,totunc,&
					&opq,opqflg, opqunc,dryb,drybflg,drybunc,dewp,dewpflg,dewpunc,rhum,rhumflg,rhumunc,&
					&baro,baroflg,barounc,wdir, wdirflg, wdirunc, wspd, wspdflg, wspdunc, visi, visiflg, visiunc,&
					&chgt,chgtflg,chgtunc,prwt,pwat,pwatflg,pwatunc,aod,aodflg,aodunc,sndp,sndpflg,sndpunc,&
					&dsls, dslsflg, dslsunc
		IF (ierror==-1) then 
			Write (*,*) 'Terminado de leer el archivo.'
			exit
		end if
					
		IF (mo<1 .or. mo>12) write(*,*) 'Error en variable: month, linea:',n
		IF (dy<1 .or. dy>31) write(*,*) 'Error en variable: day, linea:',n
		IF (hr<1 .or. hr>24) write(*,*) 'Error en variable: hour, linea:',n
		IF (etr<0 .or. etr>1415) write(*,*) 'Error en variable: etr, linea:',n
		IF (etrn<0 .or. etrn>1415) write(*,*) 'Error en variable: etrn, linea:',n
		IF (glo<0 .or. glo>1200) write(*,*) 'Error en variable: glo, linea:',n
		IF (glounc<0 .or. glounc>9) write(*,*) 'Error en variable: glounc, linea:',n
	! Se debe continuar con las verificacion del resto de las variables...	
						
	   
	    IF (ierror/=0)  write (*,*) 'Error en linea:',n
	   
	    n=n+1
		print *, mo,dy, hr, glo, dir, dif
	End do
	  
ElseIf (sel==2) Then   ! ******** TMY3 ************

	open(unit=3,file='724940TY.csv')

	READ(3,*,IOSTAT=errorh)USAF, name , state, tz3, latitude3, longitude3, elevation3

	
	
	DO 
		    READ (3,*,IOSTAT=ierror)  di, me,ano,time, etr,etrn,glo,gloflg,glounc,dir,dirflg,dirunc,dif,difflg,difunc,&
		gloi,gloiflg,gloiunc,diri,diriflg,diriunc,difi,dififlg,difiunc,zeni,zeniflg,zeniunc,tot,totflg,totunc,&
		opq,opqflg, opqunc,dryb,drybflg,drybunc,dewp,dewpflg,dewpunc,rhum,rhumflg,rhumunc,&
		baro,baroflg,barounc,wdir, wdirflg, wdirunc, wspd, wspdflg, wspdunc, visi, visiflg, visiunc,&
		chgt,chgtflg,chgtunc,prwt,pwat,pwatflg,pwatunc,aod,aodflg,aodunc,Alb,Albflg,Albunc,Lprecip,Lpreciphr,Lprecipflg,Lprecipunc 
		
		
		IF (ierror==-1) then 
			Write (*,*) 'Terminado de leer el archivo.'
			exit
		end if
		If (ierror /= 0) write (*,*) 'Error en linea:',n
		
		Write (*,*) n, yyyyddmm, time,etr,etrn, glo, dir, dif
		n = n + 1  		    
		    

	End do	    
	
Else if (sel==3)then
open(4,file='etst.txt')
read (4,'(3I3,I2,I2,I4)') glo, dir,yr,mo,dy
!'10,3,12/31/1997,20:00'
print *, glo, dir,yr,mo,dy

Else 
write(*,*) 'Error en el numero de tipo de archivo. 1: TMY2; 2:TMY3'
EndIf
100 FORMAT ( A10,A5,3I4)
!01/04/1999,02:00,0,0,0,2,0,0,2,0,0,2,0,0,2,0,0,2,0,0,2,0,0,2,0,2,E,9,1,E,9,7.8,A,7,6.1,A,7,89,A,7,1026,A,7,0,A,7,0.0,A,7,12800,A,7,9144,A,7,1.3,E,8,0.108,F,8,0.160,F,8,0,1,A,7
		    ! 27 30 34 37 40 43 46 49 52 55 58 61 64 68  
  	
  
End  Program CheckTMY23
