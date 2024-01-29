//XA550808 JOB 'CTA0001',MSGCLASS=X,CLASS=A,
//*        RESTART=PASO0110,
//*        TYPRUN=SCAN,
//         NOTIFY=&&USERID,
//         MSGLEVEL=(1,1),COND=(4,LT),REGION=128M
//*--------------------------------------------------------------------*
//*                       CLIENTES ALTAMIRA                            *
//*                       -----------------                            *
//*--------------------------------------------------------------------*
//JOBLIB   DD DSN=CMN.ABASE.BAT,DISP=SHR
//         DD DSN=CMN.ABASE.RUT,DISP=SHR
//*--------------------------------------------------------------------*
//* SE BORRAN LOS ARCHIVOS A GENERAR EN EL PASO SIGUIENTE              *
//*--------------------------------------------------------------------*
//PASO0010 EXEC PGM=IEFBR14
//A2       DD DSN=GDES.XA00627.CLIENTES.PARAM,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//A3       DD DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//A4       DD DSN=GDES.XA00627.CLIENTES.PARAM.RFD.ACT,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//*
//*--------------------------------------------------------------------*
//* FILTRA SOLO PARAMETROS DE ACREDITACION DE KMS
//*--------------------------------------------------------------------*
//PASO0030 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//SORTIN   DD DSN=GDES.XA00627.CLIENTES.TC.REFER.ACT,DISP=SHR
//SORTOUT  DD DSN=GDES.XA00627.CLIENTES.PARAM,
//         DISP=(,CATLG),SPACE=(CYL,(100,50),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=249,BLKSIZE=0,RECFM=FB)
//*
//SYSIN    DD *
    SORT FIELDS=(65,9,CH,A,63,1,CH,D,6,5,CH,A)
    INCLUDE COND=(64,01,CH,EQ,C'A',AND,           
                 (63,01,CH,EQ,C'K',OR,            
                  63,01,CH,EQ,C'C'))              
    OUTREC FIELDS=(1,233,
                   65,9,PD,TO=ZD,LENGTH=16)    - Paket a Num simple   
//*--------------------------------------------------------------------*
//* SE CRUZAN LAS CAMPAñAS EN VISUALIZACION CONTRA LOS PARAMETROS DE   *
//* ACREDITACION DE KMS                                                *
//*--------------------------------------------------------------------*
//PASO0040 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//CAMPVIS  DD DSN=GDES.XA00627.CLIENTES.CAMPANIA,
//            DISP=SHR
//PARAM    DD DSN=GDES.XA00627.CLIENTES.PARAM,
//            DISP=SHR
//PARAMRFT DD DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT,
//         DISP=(,CATLG),SPACE=(CYL,(50,100),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=249,BLKSIZE=0,RECFM=FB)
//*
//PARAMRFD DD DSN=GDES.XA00627.CLIENTES.PARAM.RFD.ACT,
//         DISP=(,CATLG),SPACE=(CYL,(50,100),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=249,BLKSIZE=0,RECFM=FB)
//*
//SYSIN    DD *
 OPTION COPY

 OUTFIL FNAMES=PARAMRFT,
          INCLUDE=(92,06,PD,EQ,0),        --Num paket (COMP-3) EQ 0
          OUTREC=(1,249)
 OUTFIL FNAMES=PARAMRFD,
          INCLUDE=(92,06,PD,EQ,1),        --Num paket (COMP-3) EQ 1
          OUTREC=(1,249)
//*--------------------------------------------------------------------*
//* SE BORRAN LOS ARCHIVOS A GENERAR EN EL PASO SIGUIENTE              *
//*--------------------------------------------------------------------*
//PASO0050 EXEC PGM=IEFBR14
//A1       DD DSN=GDES.XA00627.CLIENTES.SINBENEF.SORT,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//A2       DD DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT.UNI,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//A3       DD DSN=GDES.XA00627.CLIENTES.AL..REFERKMS,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//*
//*--------------------------------------------------------------------*
//* FILTRA TCL712 SOLO REFERIDOS FORMALIZADOS(CODEVAL=1) Y SIN BENEFICIO
//*  OBTENIDO
//*--------------------------------------------------------------------*
//PASO0060 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//SORTIN   DD DSN=GDES.XA00627.CLIENTES.REFERIDOS,DISP=SHR
//SORTOUT  DD DSN=GDES.XA00627.CLIENTES.SINBENEF.SORT,
//         DISP=(,CATLG),SPACE=(CYL,(100,50),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=173,BLKSIZE=0,RECFM=FB)
//*
//SYSIN    DD *
    SORT FIELDS=(24,4,BI,A)                  --Num Binario (COMP)   
    INCLUDE COND=(32,01,CH,EQ,C'N',AND,
                  33,04,CH,EQ,X'0001')
    OUTREC FIELDS=(1,159,
                   24,4,BI,TO=ZD,LENGTH=14)  -Binario a Num simple
//*--------------------------------------------------------------------*
//* SE DEJA UN SOLO PARAMETRO DE ACREDITACION POR CAMPAñA
//*--------------------------------------------------------------------*
//PASO0070 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//SORTIN   DD DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT,DISP=SHR
//SORTOUT  DD DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT.UNI,
//         DISP=(,CATLG),SPACE=(CYL,(100,50),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=249,BLKSIZE=0,RECFM=FB)
//SYSIN    DD *
    SORT FIELDS=(65,9,PD,A)
/*
//*--------------------------------------------------------------------*
//* SE BORRAN LOS ARCHIVOS A GENERAR EN EL PASO SIGUIENTE              *
//*--------------------------------------------------------------------*
//PASO0090 EXEC PGM=IEFBR14
//A1       DD DSN=GDES.XA00627.CLIENTES.AL.REFERKMS.SORT,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//A2       DD DSN=GDES.XA00627.CLIENTES.AL.S1DQSAL0,
//         UNIT=SYSDA,SPACE=(TRK,0),DISP=(MOD,DELETE)
//*
//*--------------------------------------------------------------------*
//* ORDENA BASE DE RELACIONES A ACREDITAR POR NUMCLIEN-CAMPAñA
//*--------------------------------------------------------------------*
//PASO0100 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//*
//SORTIN   DD DSN=GDES.XA00627.CLIENTES.AL.REFERKMS,DISP=SHR
//SORTOUT  DD DSN=GDES.XA00627.CLIENTES.AL.REFERKMS.SORT,
//         DISP=(,CATLG),SPACE=(CYL,(100,50),RLSE),
//         UNIT=SYSDA,DCB=(LRECL=159,BLKSIZE=0,RECFM=FB)
//*
//SYSIN    DD *
    SORT FIELDS=(16,8,CH,A,24,4,BI,A)
    OUTREC FIELDS=(1,159)
//*
//*--------------------------------------------------------------------*
//* PROGRAMA: PCLE271                                                  *
//PASO0110 EXEC PGM=PCLE271,DYNAMNBR=20
//STEPLIB  DD  DSN=DAL.DESA.PGMLIB.BATCH,DISP=SHR
//         DD  DSN=DAL.DESA.PGMLIB.RUT,DISP=SHR
//SYSTSPRT DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//SYSABOUT DD  SYSOUT=*
//SYSDBOUT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//E1DQ7120 DD  DSN=GDES.XA00627.CLIENTES.AL.REFERKMS.SORT,DISP=SHR
//E2DQCAM0 DD  DSN=GDES.XA55080.AL.SECU.TCL711.VISUAL,DISP=SHR
//E3DQACR0 DD  DSN=GDES.XA00627.CLIENTES.PARAM.RFT.ACT,DISP=SHR
//S1DQSAL0 DD  DSN=GDES.XA00627.CLIENTES.AL.S1DQSAL0.TEM,
//             DISP=(,CATLG),
//             SPACE=(CYL,(200,200),RLSE),
//             DCB=(LRECL=101,RECFM=FB),
//             UNIT=SYSDA
//

