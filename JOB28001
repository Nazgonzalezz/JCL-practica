//***********************************************************
//*PASOCOMP:Ejecuta el programa IEBCOMPR para comparar ambos*
//*IF: PASOSI: IDCAMS que saca por SYSOUT ‘Son Iguales ‘    *
//*ELSE: PASONO: IDCAMS que saca por SYSOUT ‘Son Distintos ‘*
//***********************************************************
//JOB28001 JOB REGION=0M,CLASS=A,MSGCLASS=A,MSGLEVEL=1,
//         NOTIFY=&SYSUID                                              
//*        ,TYPRUN=SCAN 
//*----------------------------------------------------------
//PASOCOMP EXEC PGM=IEBCOMPR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//*
//SYSUT1   DD DSP=SHR,DSN=ARCHIVO.PARA.DEPOSITOS.DE.LA.S01
//SYSUT2   DD DSP=SHR,DSN=ARCHIVO.PARA.DEPOSITOS.DE.LA.S02
//SYSIN    DD DUMMY
/*
//*---------------------------------
//IF PASOCOMP.RC EQ 0 THEN
//PASOSI   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//*
//SALIDA   DD SYSOUT=*
//ENTRADA  DD *
        Son Iguales
/*
//SYSIN    DD *
    REPRO INFILE(ENTRADA) -
          OUTFILE(SALIDA)
//*---------------------------------
//ELSE 
//PASONO   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//*
//SALIDA   DD SYSOUT=*
//ENTRADA  DD *
        Son distintos
/*
//SYSIN    DD *
    REPRO INFILE(ENTRADA) -
          OUTFILE(SALIDA)
/*
//ENDIF
//
//***********************************************************
//*                     COMENTARIOS                         *
//***********************************************************
//*IEBCOMPR :utilitario para comparar ambos archivos son    *
//*iguales. devuelve 8 si son distintos, y devuelve 0 si    *
//*son iguales                                              * 
//***********************************************************
