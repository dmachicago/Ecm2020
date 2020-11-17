CREATE TABLE MPI_WaitTime (RunID nvarchar (75) NOT NULL , 
                           MeasureDate datetime DEFAULT GETDATE () , 
                           RowNbr int IDENTITY (1 , 1) 
                                      NOT NULL) ;

CREATE INDEX PI_MPI_WaitTime ON MPI_WaitTime (RowNbr , RunID) ;
CREATE INDEX PI01_MPI_WaitTime ON MPI_WaitTime (MeasureDate) INCLUDE (RunID) ;