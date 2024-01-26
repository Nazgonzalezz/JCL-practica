//**************************************************************
//*PASO01: ejecuta el programa IDCAMS que borra los archivos:  *
//*‘ARCH.MOVIM.PERIODO.P032022.PRUEBA1’                        *
//*‘ARCH.MOVIM.PERIODO.P032022.PRUEBA2’                        *
//*‘ARCH.MOVIM.PERIODO.P032022.PRUEBA3’                        *     
//*                                                            *
//*PASO02: ejecuta el programa IDCAMS que copia los primeros   *
//*100 reg del archivo ‘ARCH.MOVIM.PERIODO.P032022’ Al archivo *
//*al ya nuevo ‘ARCH.MOVIM.PERIODO.P032022.PRUEBA1’            *
//*                                                            *
//*PASO03: ejecuta el programa IDCAMS que salta los primeros   * 
//* 100 reg, copia los siguientes 100 reg del archivo          *
//*‘ARCH.MOVIM.PERIODO.P032022’                                *
//*Al archivo ya NUEVO ‘ARCH.MOVIM.PERIODO.P032022.PRUEBA2’    *
//*                                                            *
//*PASO04: ejecuta el programa IDCAMS que salta los primeros   *
//*200 reg, copia los siguientes 100 reg del archivo           *
//*‘ARCH.MOVIM.PERIODO.P032022’                                *
//*Al archivo ya NUEVO ‘ARCH.MOVIM.PERIODO.P032022.PRUEBA3’    *
//**************************************************************
//JOBB110E JOB 1,REGION=0M,CLASS=A,MSGCLASS=A,MSGLEVEL=1,
//         NOTIFY=&SYSUID                                              
//*        ,TYPRUN=SCAN 
//*-------------------------------------------------------------    
//PASO01A  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//*
//SYSIN    DD *
      DELETE (ARCH.MOVIM.PERIODO.P032022.PRUEBA2) PURGE PRUEBA1
      DELETE (ARCH.MOVIM.PERIODO.P032022.PRUEBA2) PURGE PRUEBA2 
      DELETE (ARCH.MOVIM.PERIODO.P032022.PRUEBA2) PURGE PRUEBA3
      IF LASTCC = 8 THEN SET MAXCC = 0
/*
//*-------------------------------------------------------------
//PASO02A  EXEC PGM=IDCAMS
//SYSPRINT DD SYSSOUT=*
//*
//INT01    DD DSN=ARCH.MOVIM.PERIODO.P032022,DISP=SHR
//OUT01    DD DSN=ARCH.MOVIM.PERIODO.P032022.PRUEBA1,
//         DISP=(NEW,CATLG,DELETE),
//         DCB=(RECFM=FB,LRECL=350,BLKSIZE=0,DSORG=PS),
//         SPACE=(TRK,(5,5),RLSE) 
//*
//SYSIN    DD *
    REPRO INFILE(INT01) -
          OUTFILE(OUT01) -
          COUNT(100)
/*
//*------------------------------------------------------------
//PASO03A  EXEC PGM=IDCAMS
//SYSPRINT DD SYSSOUT=*
//*
//INT03    DD DSN=ARCH.MOVIM.PERIODO.P032022,DISP=SHR
//OUT03    DD DSN=ARCH.MOVIM.PERIODO.P032022.PRUEBA2,DISP=SHR
//*
//SYSIN    DD *
    REPRO INFILE(INT03) -
          OUTFILE(OUT03) -
          SKIP(100) -
          COUNT(100)
/*
//*-------------------------------------------------------------
//PASO04A  EXEC PGM=IDCAMS
//SYSPRINT DD SYSSOUT=*
//*
//INT04    DD DSN=ARCH.MOVIM.PERIODO.P032022,DISP=SHR
//OUT04    DD DSN=ARCH.MOVIM.PERIODO.P032022.PRUEBA3,DISP=SHR
//*
//SYSIN    DD *
    REPRO INFILE(INT04) -
          OUTFILE(OUT04) -
          SKIP(200) -
          COUNT(100)
/*
//
//**************************************************************
//*                      COMENTARIOS                           *
//**************************************************************
//* DELETE (ARCH.MOVIM.PERIODO.P032022.PRUEBA2) PURGE PRUEBA3  *
//*IF LASTCC = 8 THEN SET MAXCC = 0: si el archivo no existe   *
//* el jcl no se cancela, pero arroja un codigo de eror        *
//*                                                            *
//* SKIP(X) - COUNT(Y) : se saltea X registros y graba Y       *
//*registros                                                   *                                                         
//**************************************************************
