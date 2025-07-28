//***********************************************************
//*PASO01:utilizo el utilitario sort para separar los       *
//*registros que comienzan con 101 de los demas, y genero   *
//*dos archivos                                             *
/*                                                          *
//*PASO02:escribo en el ultimo caracter del archivo filtrado*
//*por 101 una letra 'N'                                    *
//*                                                         *
//*PASO03:copio los dos archivos concatenados a un tercer   *
//*archivo                                                  *
//***********************************************************
//JOB00304 JOB REGION=0M,CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*        ,TYPRUN=SCAN
//*----------------------------------------------------------
//PASO01   EXEC PGM=SORT
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=* 
//*
//SORTIN   DD DSN=MOVI.POR.SUCURSAL,DISP=SHR
//OUTPUT1  DD DSN=FILE1.DEPOSITO.101,DISP=(NEW,CATLG,DELETE),
//         DCB=(RECFM=FB,LRECL=11,BLKSIZE=0,DSORG=PS),
//         SPACE=(TRK,(1,1),RLSE) 
//*
//OUTPUT2  DD DSN=FILE1.DEPOSITO.XXX,DISP=(NEW,CATLG,DELETE),
//         DCB=(RECFM=FB,LRECL=11,BLKSIZE=0,DSORG=PS),
//         SPACE=(TRK,(1,1),RLSE)
//*
//SYSIN    DD *
      SORT FIELDS=COPY
      OUTFIL FNAMES=OUTPUT1,
      INCLUDE=(1,3,CH,EQ,C'101',AND,4,1,CH,EQ,C'D')
      OUTFIL FNAMES=OUTPUT2,
      INCLUDE=(1,3,CH,NE,C'101',AND,4,1,CH,NE,C'D')
      END
/*
//*------------------------------------------------------------- 
//PASO02   EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//SORTIN   DD DSN=FILE1.DEPOSITO.101,DISP=SHR
//SORTOUT  DD DSN=FILE1.DEPOSITO.101,DISP=SHR
//*
//SYSIN    DD *
      SORT FIELDS=COPY
      OUTREC FIELDS=(1,10,C'N')
      END
/*
//*-------------------------------------------------------------
//PASO03   EXEC PGM=IDECAMS
//SYSPRINT DD SYSSOUT=*
//*
//INTPUT   DD DSN=FILE1.DEPOSITO.101,DISP=SHR
//         DD DSN=FILE1.DEPOSITO.XXX,DISP=SHR
//OUTPUT   DD DSN=FILE3.DEPOSITO.XXX,DISP=(NEW,CATLG,DELETE),
//         DCB=(RECFM=FB,LRECL=22,BLKSIZE=0,DSORG=PS),
//         SPACE=(TRK,(1,1),RLSE)
//*
//*
//SYSIN    DD *
    REPRO INFILE(INTPUT) -
          OUTFILE(OUTPUT) -
/*
//
//**************************************************************
//*                      COMENTARIOS                           *
//**************************************************************
//*CONCATENAR DD:para concatenar DD tengo que escribir otra DD *
//*a continuacion de la primera pero no le tengo que poner     *
//*nombre. El sistema asume que los ficheros descritos en las  *
//*DD sin nombre son continuación del descrito en la DD con    *
//*nombre                                                      *
//*                                                            *
//*OUTREC FIELDS=(1,10,C'N'): dede la posicion 1; diez         *
//*elementos,despues de estos diez elementos copio un 'N' al   *
//*final                                                       *
//*                                                            *
//*OUTREC FIELDS:Nos van a permitir "diseñar" el registro de   *
//*salida                                                      *
//**************************************************************
