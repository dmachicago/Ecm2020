Imports System.IO


''' <summary>
''' This class is used to load and store the application 
''' execution parameters.
''' </summary>
''' <remarks></remarks>
Public Class clsExecParms


Public EmailFolderName AS String  = "" 
Public ArchiveEmails AS String  = "" 
Public RemoveAfterArchive AS String  = "" 
Public SetAsDefaultFolder AS String  = "" 
Public ArchiveAfterXDays AS String  = "" 
Public ArchiveXDays AS String  = "" 
Public RemoveAfterXDays AS String  = "" 
Public RemoveXDays AS String  = "" 
Public UseDefaultDB AS String  = "" 
Public DBID AS String  = "" 


Public FolderName AS String  = "" 
Public Exts AS String  = "" 
Public UseDefaultDBfile AS String  = "" 
Public DBIDFile AS String  = "" 
Public IncludeFileType AS String  = "" 
Public ExcludeFileType AS String  = "" 


Public FileFolderName AS String  = "" 
Public CurrUser AS String  = "" 


    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

Dim fName AS String  = DMA.getEnvVarTempDir + "/ExecParms.txt" 


     Public Sub LoadEmailFolders(ByVal LB As ListBox)
          Try
               LB.Items.Clear()
Dim LinesToKeep  (0) AS String 
               Dim SR As New IO.StreamReader(fName)
               Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                    If A(0).Equals("Folder") Then
Dim tName AS String  = A(1) 
                         LB.Items.Add(S)
                    End If
               Loop
               SR.Close()
          Catch ex As Exception
            messagebox.show("Error 123.23.2 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : LoadEmailFolders : 14 : " + ex.Message)
        End Try
    End Sub
    Public Sub LoadFileFolders(ByVal LB As ListBox)
        Try
            LB.Items.Clear()
Dim LinesToKeep  (0) AS String 
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                If A(0).Equals("File") Then
Dim tName AS String  = A(1) 
                    LB.Items.Add(S)
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            messagebox.show("Error 123.23.2 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : LoadFileFolders : 28 : " + ex.Message)
        End Try
    End Sub
    Public Sub getEmailFolderAttr(ByVal FolderName AS String , ByVal Parms AS String ())
        Try
Dim LinesToKeep  (0) AS String 
Dim A  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
                A = S.Split("|")
                If A(0).Equals("Folder") Then
Dim tName AS String  = A(1) 
                    If UCase(tName).Equals(UCase(FolderName)) Then
                        ArchiveEmails  = A(2)
                        RemoveAfterArchive  = A(3)
                        SetAsDefaultFolder  = A(4)
                        ArchiveAfterXDays  = A(5)
                        ArchiveXDays  = A(6)
                        RemoveAfterXDays  = A(7)
                        RemoveXDays  = A(8)
                        UseDefaultDB  = A(9)
                        DBID  = A(10)
                        FolderFound = True
                        Exit Do
                    End If
                End If
            Loop
            If FolderFound Then
                ReDim Parms (UBound(A))
                For i As Integer = 0 To UBound(A)
                    Parms(i) = A(i)
                Next
            Else
                ReDim Parms(0)
            End If
            SR.Close()
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : getEmailFolderAttr : 62 : " + ex.Message)
        End Try
    End Sub
    Public Sub getFileFolderAttr(ByVal FolderName AS String , ByVal Parms AS String ())
        Try
Dim LinesToKeep  (0) AS String 
Dim A  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
                A = S.Split("|")
                If A(0).Equals("File") Then
Dim FileDir AS String  = A(1) 
                    If UCase(FileDir ).Equals(UCase(FolderName)) Then
Dim FileExts AS String  = A(2) 
Dim SetAsDefault AS String  = A(3) 
Dim DBID AS String  = A(4) 
                        FolderFound = True
                        Exit Do
                    End If
                End If
            Loop
            If FolderFound Then
                ReDim Parms (UBound(A))
                For i As Integer = 0 To UBound(A)
                    Parms(i) = A(i)
                Next
            End If
            SR.Close()
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : getFileFolderAttr : 88 : " + ex.Message)
        End Try
    End Sub
    Public Sub deleteEmailFolder(ByVal FolderName AS String )
        Try
Dim LinesToKeep  (0) AS String 


            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                If A(0).Equals("Folder") Then
Dim tName AS String  = A(1) 
                    If UCase(tName).Equals(UCase(FolderName)) Then
                        '** Do nothing, this is the one to skip
                        '** DO not break out fo the loop, we need the rest of the file.
                    Else
                        AddLine(LinesToKeep , S )
                    End If
                End If
            Loop
            SR.Close()
            WriteArrayToParmFile(LinesToKeep )
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : deleteEmailFolder : 105 : " + ex.Message)
        End Try
    End Sub
    Public Sub addEmailFolder(ByVal FolderName AS String )
        Try
Dim ParmStr AS String  = "" 
            ParmStr  = "Folder" + "|" + FolderName  + "|"
            ParmStr  = ParmStr  + ArchiveEmails  + "|"
            ParmStr  = ParmStr  + RemoveAfterArchive  + "|"
            ParmStr  = ParmStr  + SetAsDefaultFolder  + "|"
            ParmStr  = ParmStr  + ArchiveAfterXDays  + "|"
            ParmStr  = ParmStr  + ArchiveXDays  + "|"
            ParmStr  = ParmStr  + RemoveAfterXDays  + "|"
            ParmStr  = ParmStr  + RemoveXDays  + "|"
            ParmStr  = ParmStr  + UseDefaultDB  + "|"
            ParmStr  = ParmStr  + DBID 


            If Not System.IO.File.Exists(fName) Then
                Me.AppendToParmFile(ParmStr )
                Return
            End If


Dim LinesToKeep  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                Dim B As Boolean = False
                If A(0).Equals("Folder") Then
                    B = True
Dim tName AS String  = A(1) 
                    If UCase(tName).Equals(UCase(FolderName)) Then
                        FolderFound = True
                        AddLine(LinesToKeep , ParmStr )
                    Else
                        AddLine(LinesToKeep , S )
                    End If
                End If
                If Not B Then
                    AddLine(LinesToKeep , S )
                End If


            Loop
            SR.Close()
            If FolderFound = False Then
                If UBound(LinesToKeep ) > 0 Then
                    WriteArrayToParmFile(LinesToKeep )
                End If
                Me.AppendToParmFile(ParmStr )
            End If


        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : addEmailFolder : 149 : " + ex.Message)
        End Try
    End Sub
    Public Sub setRunAtStart(ByVal RunAtStart AS String )
        Try
Dim ParmStr AS String  = "" 
            ParmStr  = "Run@Start" + "|"
            ParmStr  = ParmStr  + RunAtStart 


Dim LinesToKeep  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                If A(0).Equals("Run@Start") Then
                    AddLine(LinesToKeep , ParmStr )
                End If
            Loop
            SR.Close()
            If FolderFound = False Then
                WriteArrayToParmFile(LinesToKeep )
            Else
                ParmStr  = "Run@Start" + "|N"
                Me.AppendToParmFile(ParmStr )
                WriteArrayToParmFile(LinesToKeep )
            End If


        Catch ex As Exception
            messagebox.show("Error 123.23.11 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : setRunAtStart : 172 : " + ex.Message)
        End Try
    End Sub
    Public Sub addFileFolder(ByVal FolderName AS String , ByVal Exts AS String , ByVal UseDefaultDB AS String , ByVal DBID AS String )
        Try
Dim ParmStr AS String  = "" 
            ParmStr  = "File" + "|"
            ParmStr  = ParmStr  + FolderName  + "|"
            ParmStr  = ParmStr  + Exts  + "|"
            ParmStr  = ParmStr  + UseDefaultDB  + "|"
            ParmStr  = ParmStr  + DBID 


            If Not System.IO.File.Exists(fName) Then
                Me.AppendToParmFile(ParmStr )
                Return
            End If


Dim LinesToKeep  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                Dim B As Boolean = False
                If A(0).Equals("File") Then
                    B = True
Dim tName AS String  = A(1) 
                    If UCase(tName).Equals(UCase(FolderName)) Then
                        FolderFound = True
                        AddLine(LinesToKeep , ParmStr )
                    Else
                        AddLine(LinesToKeep , S )
                    End If
                End If
                If B = False Then
                    AddLine(LinesToKeep , S )
                End If
            Loop
            SR.Close()
            If FolderFound = False Then
                If UBound(LinesToKeep ) > 0 Then
                    WriteArrayToParmFile(LinesToKeep )
                End If
                Me.AppendToParmFile(ParmStr )
            End If
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : addFileFolder : 211 : " + ex.Message)
        End Try
    End Sub
    Public Sub addDbConnStr(ByVal DBName AS String , ByVal Connstr AS String )
        Try
Dim ParmStr AS String  = ""
            ParmStr = "DBARCH" + "|"
            ParmStr = ParmStr + DBName + "|"
            ParmStr = ParmStr + Connstr


            If Not System.IO.File.Exists(fName) Then
                Me.AppendToParmFile(ParmStr)
                Return
            End If


            Dim LinesToKeep(0) As String
            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                Dim B As Boolean = False
                If A(0).Equals("DBARCH") Then
                    B = True
                    Dim tName As String = A(1)
                    If UCase(tName).Equals(UCase(DBName)) Then
                        AddLine(LinesToKeep, ParmStr)
                    Else
                        AddLine(LinesToKeep, S)
                    End If
                End If
                If B = False Then
                    AddLine(LinesToKeep, S)
                End If
            Loop
            SR.Close()
            If DbFound = False Then
                If UBound(LinesToKeep) > 0 Then
                    WriteArrayToParmFile(LinesToKeep)
                End If
                Me.AppendToParmFile(ParmStr)
            End If
        Catch ex As Exception
            MessageBox.Show("Error 123.23.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : addDbConnStr : 248 : " + ex.Message)
        Finally



        End Try
    End Sub
    Public Sub addFileExt(ByVal FileExt As String)
        Try
            Dim ParmStr As String = ""
            ParmStr = "EXT" + "|" + FileExt


            If Not System.IO.File.Exists(fName) Then
                Me.AppendToParmFile(ParmStr)
                Return
            End If


            Dim LinesToKeep(0) As String
            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                Dim B As Boolean = False
                If A(0).Equals("EXT") Then
                    B = True
                    Dim tName As String = A(1)
                    If UCase(tName).Equals(UCase(FileExt)) Then
                        AddLine(LinesToKeep, ParmStr)
                    Else
                        AddLine(LinesToKeep, S)
                    End If
                End If
                If B = False Then
                    AddLine(LinesToKeep, S)
                End If
            Loop
            SR.Close()
            If DbFound = False Then
                If UBound(LinesToKeep) > 0 Then
                    WriteArrayToParmFile(LinesToKeep)
                End If
                Me.AppendToParmFile(ParmStr)
            End If
        Catch ex As Exception
            MessageBox.Show("Error 123.23.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : addFileExt : 283 : " + ex.Message)
        Finally


        End Try
    End Sub
    Public Sub LoadDatabases(ByVal LB As ComboBox)
        Try
            LB.Items.Clear()


            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                Dim B As Boolean = False
                If A(0).Equals("DBARCH") Then
                    Dim tName As String = A(1)
                    LB.Items.Add(tName)
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            MessageBox.Show("Error 123.25.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : LoadDatabases : 299 : " + ex.Message)
        Finally


        End Try
    End Sub
    Public Sub LoadFileExt(ByVal LB As ComboBox)
        Try
            LB.Items.Clear()


            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                Dim B As Boolean = False
                If A(0).Equals("EXT") Then
                    Dim tName As String = A(1)
                    LB.Items.Add(tName)
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            MessageBox.Show("Error 123.25.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : LoadFileExt : 315 : " + ex.Message)
        Finally

        End Try
    End Sub
    Public Sub LoadFileExt(ByVal LB As ListBox)
        Try
            LB.Items.Clear()


            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                Dim B As Boolean = False
                If A(0).Equals("EXT") Then
                    Dim tName As String = A(1)
                    LB.Items.Add(tName)
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            MessageBox.Show("Error 123.25.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : LoadFileExt : 331 : " + ex.Message)
        Finally

        End Try
    End Sub
    Public Sub getActiveEmailFolders(ByRef LB As ListBox)
        Try
            LB.Items.Clear()


            Dim LinesToKeep(0) As String
            Dim A(0) As String
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                A = S.Split("|")
                If A(0).Equals("Folder") Then
                    Dim tName As String = A(1)
                    LB.Items.Add(tName)
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            MessageBox.Show("Error 123.23.1 - " + ex.Message)
            LOG.WriteToArchiveLog("clsExecParms : getActiveEmailFolders : 347 : " + ex.Message)
        End Try
    End Sub
    Public Sub deleteDbConnStr(ByVal DBName As String, ByVal Connstr As String)
        Try
            Dim LinesToKeep(0) As String
            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
                Dim S As String = SR.ReadLine
                Dim A As String() = S.Split("|")
                If A(0).Equals("DBARCH") Then
                    Dim tName As String = A(1)
                    If UCase(tName).Equals(UCase(DBName)) Then
                        DbFound = True
                    Else
                        AddLine(LinesToKeep, S)
                    End If
                End If
            Loop
            SR.Close()
            If DbFound = False Then
                WriteArrayToParmFile(LinesToKeep )
            End If
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : deleteDbConnStr : 368 : " + ex.Message)
        End Try
    End Sub
    Public Sub deleteFileExt(ByVal FileExt AS String )
        Try
Dim LinesToKeep  (0) AS String 
            Dim DbFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
Dim A AS String () = S.Split("|") 
                If A(0).Equals("EXT") Then
Dim tName AS String  = A(1) 
                    If UCase(tName).Equals(UCase(FileExt )) Then
                        DbFound = True
                    Else
                        AddLine(LinesToKeep , S )
                    End If
                End If
            Loop
            SR.Close()
            If DbFound = False Then
                WriteArrayToParmFile(LinesToKeep )
            End If
        Catch ex As Exception
            messagebox.show("Error 123.23.1 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : deleteFileExt : 389 : " + ex.Message)
        End Try
    End Sub
    Sub getRunAtStart(ByVal CK As CheckBox)
        Try
            CK.Checked = False
Dim LinesToKeep  (0) AS String 
Dim A  (0) AS String 
            Dim FolderFound As Boolean = False
            Dim SR As New IO.StreamReader(fName)
            Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
                A = S.Split("|")
                If A(0).Equals("Run@Start") Then
                    Dim RunParm = A(1)
                    If UCase(RunParm).Equals("Y") Then
                        CK.Checked = True
                        Exit Do
                    Else
                        CK.Checked = False
                        Exit Do
                    End If
                End If
            Loop
            SR.Close()
        Catch ex As Exception
            messagebox.show("Error 123.23.10 - " + ex.Message)
            log.WriteToArchiveLog("clsExecParms : getRunAtStart : 409 : " + ex.Message)
        End Try
    End Sub
     Public Sub genInitialParmFIle()


     End Sub
     Sub AddLine(ByRef A AS String (), ByVal S AS String )
          Dim I As Integer = 0
          ReDim Preserve A(UBound(A) + 1)
          A(UBound(A)) = S
     End Sub
     Sub WriteArrayToParmFile(ByVal a AS String ())
          Dim SW As New IO.StreamWriter(fName )
          For i As Integer = 0 To UBound(a)
               If a(i) <> Nothing Then
Dim S AS String  = a(i).Trim 
                    If S.Length > 0 Then
                         SW.WriteLine(S)
                    End If
               End If
          Next
          SW.Close()
     End Sub
     Sub DeleteParmFile()
          Kill(fName )
     End Sub
     Sub AppendToParmFile(ByVal S AS String )
          Dim SW As New IO.StreamWriter(fName , True)
          SW.WriteLine(S)
          SW.Close()
     End Sub
End Class
