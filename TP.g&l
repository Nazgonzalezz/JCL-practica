//KC03A48E JOB 1,REGION=0M,CLASS=A,MSGCLASS=A,MSGLEVEL=1,               
//         NOTIFY=KC03A48                                               
//*        TYPRUN=SCAN                                                  
//PASO00   EXEC PGM=IEFBR14                                             
//DELAR    DD DSN=KC03A48.ZOS2023.TARSEQ02,DISP=(MOD,DELETE)            
//         DD DSN=KC03A48.ZOS2023.TARSEQ03,DISP=(MOD,DELETE)            
//         DD DSN=KC03A48.ZOS2023.TARPAR01,DISP=(MOD,DELETE)            
//*--------------------------PUNTO 1------------------------------------
//PASO01   EXEC PGM=IEBGENER                                            
//SYSUT2   DD DSN=KC03A48.ZOS2023.TARSEQ02,                             
//         DISP=(NEW,CATLG,DELETE),                                     
//         RECFM=FB,                                                    
//         DSORG=PS,                                                    
//         DCB=(LRECL=80,BLKSIZE=3120),                                 
//         SPACE=(CYL,(2,1),RLSE)                                       
//SYSUT1   DD DSN=KC03A48.ZOS2023.SEQ01,DISP=SHR                        
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD DUMMY                                                     
//*--------------------------PUNTO 2----------------------------------- 
//PASO1    EXEC PGM=SORT                      UTILITITARIO PARA ORDENAR 
//SYSOUT   DD SYSOUT=*                                                  
//SORTIN   DD DSN=KC03A48.ZOS2023.SEQ01,DISP=SHR                        
//SORTOUT  DD DSN=KC03A48.ZOS2023.TARSEQ03,DISP=(NEW,CATLG,DELETE),     
//         RECFM=FB,DSORG=PS,DCB=(LRECL=80,BLKSIZE=3120),               
//         SPACE=(CYL,(2,1),RLSE)                                       
//SORTWK1  DD UNIT=SYSDA,SPACE=(CYL,(4))                                
//SORTWK2  DD UNIT=SYSDA,SPACE=(CYL,(4))                                
//SORTWK3  DD UNIT=SYSDA,SPACE=(CYL,(4))                                
//SORTWK4  DD UNIT=SYSDA,SPACE=(CYL,(4))                                
//SYSIN    DD *                                                         
 SORT FIELDS=(7,27,CH,A)                                                
//*--------------------------PUNTO 3----------------------------------- 
//PASO02   EXEC PGM=IEBCOPY         COPIO UN PARTICIONADO ENTERO A OTRO 
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT1   DD DSN=(KC03A48.ZOS2023.JCL.EJEM),DISP=SHR                   
//SYSUT2   DD DSN=KC03A48.ZOS2023.TARPAR01,                             
//         DISP=(NEW,CATLG,DELETE),                                     
//         RECFM=FB,DSORG=PO,DCB=(LRECL=80,BLKSIZE=3120),               
//         SPACE=(CYL,(2,1,10),RLSE)                                    
//*--------------------------PUNTO 4----------------------------------- 
//PASO03   EXEC PGM=IEBCOPY                      UTILITARIO PARA COPIAR 
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT11  DD DSN=KC03A48.ZOS2023.JCL.EJEM,DISP=SHR                     
//SYSUT22  DD DSN=KC03A48.ZOS2023.TARPAR01,DISP=OLD                     
//SYSUT3   DD UNIT=SYSDA,SPACE=(CYL,(1))   <-ASIGNAN ESPACIO EN MEMORIA 
//SYSUT4   DD UNIT=SYSDA,SPACE=(CYL,(1))             <-PARA QUE TRABAJE 
//SYSIND   DD *                                                         
  COPY INDD=SYSUT11,AUTDD=SYSUT22                                       
  SELECT M=((ARA,,R))              COPIO UN DS DE UN PARTICIONADO A OTRO
//*--------------------------PUNTO 5----------------------------------- 
//PASO02   EXEC PGM=IEBCOPY         COPIO UN PARTICIONADO ENTERO A OTRO 
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT1   DD DSN=(KC03A48.ZOS2023.JCL.EJEM),DISP=SHR                   
//SYSUT2   DD DSN=KC03A48.ZOS2023.TARPAR01,                             
//         DISP=(NEW,CATLG,DELETE),                                     
//         RECFM=FB,DSORG=PO,DCB=(LRECL=80,BLKSIZE=3120),               
//         SPACE=(CYL,(2,1,10),RLSE)                                    
//*--------------------------PUNTO 4----------------------------------- 
//PASO03   EXEC PGM=IEBCOPY                      UTILITARIO PARA COPIAR 
//SYSPRINT DD SYSOUT=*                                                  
//SYSUT11  DD DSN=KC03A48.ZOS2023.JCL.EJEM,DISP=SHR                     
//SYSUT22  DD DSN=KC03A48.ZOS2023.TARPAR01,DISP=OLD                     
//SYSUT3   DD UNIT=SYSDA,SPACE=(CYL,(1))   <-ASIGNAN ESPACIO EN MEMORIA 
//SYSUT4   DD UNIT=SYSDA,SPACE=(CYL,(1))             <-PARA QUE TRABAJE 
//SYSIND   DD *                                                         
  COPY INDD=SYSUT11,AUTDD=SYSUT22                                       
  SELECT M=((ARA,,R))              COPIO UN DS DE UN PARTICIONADO A OTRO
//*--------------------------PUNTO 5----------------------------------- 
