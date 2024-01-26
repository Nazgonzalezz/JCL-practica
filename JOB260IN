//***********************************************************
//*PASOINI Ejecuta el programa IDECAMS para inicializar el  *
//* arhcivo ‘ARCHIVO.PARA.DEPOSITOS.DE.LA.SEMANA’           *
//***********************************************************
//JOB260IN JOB REGION=0M,CLASS=A,MSGCLASS=A,MSGLEVEL=1,
//         NOTIFY=&SYSUID                                              
//*        ,TYPRUN=SCAN 
//*----------------------------------------------------------
//PASOINI  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//*
//INP01    DD DUMMY
//OUT01    DD DSN=ARCHIVO.PARA.DEPOSITOS.DE.LA.SEMANA,
//         DISP=OLD
//*
//SYSIN    DD *
     REPRO INFILE(INP01) -
           OUTFILE(OUT01)
/*
//
//***********************************************************
//*                     COMENTARIOS                         *
//***********************************************************
//*
//***********************************************************
