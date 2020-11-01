Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.IO
Imports System.Configuration
Imports System.Object
Imports System.Configuration.ConfigurationManager
Imports ECMEncryption

Public Class frmAppConfigEdit

    Dim FormLoaded As Boolean = False
    Dim MasterLoaded As Boolean = False
    Dim ConnStr As String = ""
    Dim ConnstrThesaurus As String = ""
    Dim ConnstrRepository As String = ""
    Dim bRestart As Boolean = False
    Public AutoRestore As Boolean = False

    Dim bLoadingCB As Boolean = False
    Dim bConnTested As Boolean = False

    Dim ENC As new ECMEncrypt
    Dim MasterConnstr As String = ""

    Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

        Button2_Click(Nothing, Nothing)

        txtLoginName.Text = ""
        txtLoginName.Enabled = False
        txtLoginName.ReadOnly = False

        txtPw1.Text = ""
        txtPw1.Enabled = False
        txtPw1.ReadOnly = False

        txtPw2.Text = ""
        txtPw2.Enabled = False
        txtPw2.ReadOnly = False

        If MasterLoaded Then
            btnLoadCombo_Click(Nothing, Nothing)
        End If


        FormLoaded = True

    End Sub

    
    Public Sub App_Path()
        Dim S As String = System.AppDomain.CurrentDomain.BaseDirectory()
        Clipboard.Clear()
        Clipboard.SetText(S)
    End Sub

    Function ReadFile(ByVal fName AS String ) As String
        Dim SR As New IO.StreamReader(fName)
Dim FullText AS String  = "" 
        Do While Not SR.EndOfStream
Dim S AS String  = SR.ReadLine 
            FullText  = FullText  + S  + vbCrLf
        Loop
        SR.Close()
        Return FullText 
    End Function
    Sub WriteFile(ByVal FQN AS String , ByVal sText AS String )

        Dim SW As New IO.StreamWriter(FQN)
Dim S AS String  = sText.Trim 

        If S.Length > 0 Then
            SW.WriteLine(S)
        End If
        SW.Close()
        SB.Text = "File saved..."
    End Sub

    Private Sub btnTestConnection_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTestConnection.Click
        Dim B As Boolean = False
        SB.Text = ""
        SB.Text = "Attempting to connect"
        SB.Refresh()
        Dim CS As String = BuildConnstr()
        Dim CONN As New SqlConnection(CS)
        Try
            CONN.Open()
            SB.Text = "Connection successful for " + txtRepositoryName.Text
            ConnstrRepository = ConnStr
            B = True
        Catch ex As Exception
            SB.Text = "Connection Failed  to " + txtRepositoryName.Text
        Finally
            CONN.Dispose()
            GC.Collect()
        End Try
        Application.DoEvents()

        If B Then
            'If rbRepository.Checked Then
            '    MasterConnstr = CS
            'End If
            btnSaveConn.Enabled = True
            Button1.Enabled = True
            bConnTested = True
            LicenseToolStripMenuItem.Visible = True
        Else
            'MasterConnstr = ""
            btnSaveConn.Enabled = False
            Button1.Enabled = False
            bConnTested = False
        End If

    End Sub

    Private Sub ckWindowsAuthentication_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckWindowsAuthentication.CheckedChanged
        If ckWindowsAuthentication.Checked Then
            txtLoginName.Text = ""
            txtLoginName.Enabled = False
            txtLoginName.ReadOnly = False

            txtPw1.Text = ""
            txtPw1.Enabled = False

            txtPw2.Text = ""
            txtPw2.Enabled = False
        Else
            txtLoginName.Text = ""
            txtLoginName.Enabled = True
            txtLoginName.ReadOnly = False

            txtPw1.Text = ""
            txtPw1.Enabled = True
            txtPw1.ReadOnly = False

            txtPw2.Text = ""
            txtPw2.Enabled = True
            txtPw2.ReadOnly = False
        End If
    End Sub

    Private Sub Button7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button7.Click
        Dim DirName As String = ""
        FolderBrowserDialog1.ShowDialog()
        DirName = FolderBrowserDialog1.SelectedPath
        txtGlobalFileDirectory.Text = DirName
    End Sub

    Function GetScreenParms() As String
        Dim S As String = ""
        S += "txtGlobalFileDirectory" + "|" + txtGlobalFileDirectory.Text + Chr(127)
        S += "txtDBName" + "|" + txtDBName.Text + Chr(127)
        S += "txtRepositoryName" + "|" + txtRepositoryName.Text + Chr(127)
        S += "txtServerInstance" + "|" + txtServerInstance.Text + Chr(127)
        S += "ckWindowsAuthentication" + "|" + ckWindowsAuthentication.Checked.ToString + Chr(127)
        S += "ckRepository" + "|" + rbRepository.Checked.ToString + Chr(127)
        S += "ckThesaurus" + "|" + rbThesaurus.Checked.ToString + Chr(127)
        S += "txtLoginName" + "|" + txtLoginName.Text + Chr(127)
        S += "txtPw1" + "|" + txtPw1.Text + Chr(127)
        S += "cbSavedDefinitions" + "|" + cbSavedDefinitions.Text + Chr(127)
        S += "ckHive" + "|" + ckHive.Checked.ToString + Chr(127)
        Return S
    End Function

    Function ResetScreenParms() As String
        Dim S As String = ""

        txtDBName.Text = ""
        txtRepositoryName.Text = ""
        txtServerInstance.Text = ""
        ckWindowsAuthentication.Checked = True
        'rbRepository.Checked = True
        'rbThesaurus.Checked = False
        txtLoginName.Text = ""
        txtPw1.Text = ""
        txtPw2.Text = ""
        cbSavedDefinitions.Text = ""
        ckHive.Checked = False
        Return S
    End Function

    Private Sub btnSaveConn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveConn.Click

        If MasterConnstr.Trim.Length = 0 Then
            MessageBox.Show("ERROR: the master setup has not been set, returning.")
            Return
        End If

        If Not bConnTested Then
            MessageBox.Show("This connection has not been tested, please test the connection first.")
        End If

        If Not ckWindowsAuthentication.Checked Then
            If Not txtPw1.Text.Equals(txtPw2.Text) Then
                MessageBox.Show("The passwords do not match, returning.")
                Return
            End If
        End If

        Dim ProfileName As String = cbSavedDefinitions.Text
        Dim S As String = GetScreenParms()
        Dim InsertSql As String = ""

        S = ENC.AES256EncryptString(S)
        ProfileName = ProfileName.Replace("'", "")

        Dim icnt As Integer = iCount("Select count(*) from Repository where ConnectionName = '" + ProfileName + "'")
        If icnt = 0 Then
            If rbRepository.Checked Then
                Dim CS As String = MasterConnstr

                InsertSql = ""
                InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionData])" + vbCrLf
                InsertSql = InsertSql + "VALUES" + vbCrLf
                InsertSql = InsertSql + "('" + ProfileName + "'" + vbCrLf
                InsertSql = InsertSql + ",'" + S + "')" + vbCrLf
            Else
                InsertSql = ""
                InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionDataThesaurus])" + vbCrLf
                InsertSql = InsertSql + "VALUES" + vbCrLf
                InsertSql = InsertSql + "('" + ProfileName + "'" + vbCrLf
                InsertSql = InsertSql + ",'" + S + "')" + vbCrLf
            End If

        Else
            If rbRepository.Checked Then
                Dim CS As String = MasterConnstr
                InsertSql = "UPDATE [Repository] SET [ConnectionData] = '" + S + "' WHERE [ConnectionName] = '" + ProfileName + "'"
            Else
                InsertSql = "UPDATE [Repository] SET [ConnectionDataThesaurus] = '" + S + "' WHERE [ConnectionName] = '" + ProfileName + "'"
            End If

        End If


        Dim B As Boolean = ExecuteSqlNewConn(InsertSql)
        If B Then
            SB.Text = "Profile '" + ProfileName + "' saved to Master Repository"
        Else
            SB.Text = "ERROR: Profile '" + ProfileName + "' did not save."
        End If


    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        If Not bConnTested Then
            MessageBox.Show("This connection has not been tested, please test the connection first.")
        End If

        If Not ckWindowsAuthentication.Checked Then
            If Not txtPw1.Text.Equals(txtPw2.Text) Then
                MessageBox.Show("The passwords do not match, returning.")
                Return
            End If
        End If

        Dim GlobalFileDirectory As String = txtGlobalFileDirectory.Text.Trim
        Dim ProfileName As String = cbSavedDefinitions.Text
        Dim S As String = GetScreenParms

        If Not Directory.Exists(GlobalFileDirectory) Then
            Try
                Directory.CreateDirectory(GlobalFileDirectory)
            Catch ex As Exception
                MessageBox.Show("ERROR: Failed to create directory, choose another or contact an administrator, aborting setup." + vbCrLf + ex.Message)
                Return
            End Try
        End If

        Dim FQN As String = GlobalFileDirectory + GetGlobalFileName()

        Dim BB As Boolean = SaveGlobalParms(S, FQN)
        If BB Then
            SB.Text = "Global installation parameters saved."
        Else
            SB.Text = "ERROR: Global installation parameters failed to save."
        End If

    End Sub
    Public Function GetGlobalParms(ByVal FQN As String) As String

        If Not File.Exists(FQN) Then
            MessageBox.Show("File '" + FQN + "', does not exist, aborting.")
            Return ""
        End If

        Dim B As Boolean = True
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            Return strContents
        Catch Ex As Exception
            B = False
            MessageBox.Show("ERROR: could not read global configuration file:" + vbCrLf + Ex.Message)
        End Try
        Return B
    End Function

    Public Function SaveGlobalParms(ByVal strData As String, ByVal FQN As String) As Boolean

        strData = ENC.AES256EncryptString(strData)

        Dim bAns As Boolean = False
        Dim objReader As StreamWriter
        Try
            objReader = New StreamWriter(FQN, False)
            objReader.Write(strData)
            objReader.Close()
            bAns = True
        Catch Ex As Exception
            MessageBox.Show("ERROR: did not save global configuration file:" + vbCrLf + Ex.Message)
        End Try
        Return bAns
    End Function

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click

        If Not bConnTested Then
            If FormLoaded Then
                MessageBox.Show("This connection has not been validated, please test the connection.")
            End If
        End If

        ResetScreenParms()

        Dim GlobalFileDirectory As String = txtGlobalFileDirectory.Text.Trim
        Dim ProfileName As String = cbSavedDefinitions.Text
        Dim S As String = ""
        Dim FQN As String = txtGlobalFileDirectory.Text.Trim + GetGlobalFileName()
        FQN = FQN.Replace("\\", "\")

        If Not File.Exists(FQN) Then
            If FormLoaded Then
                MessageBox.Show("ERROR: Cannot find global parameter file '" + FQN + "', aborting load.")
            End If
            Return
        End If

        Dim GlobalParms As String = GetGlobalParms(FQN)

        Dim DecryptedParms As String = ENC.AES256DecryptString(GlobalParms)

        Dim A() As String = DecryptedParms.Split(Chr(127))

        For Each S In A
            Dim Parm() As String = S.Split("|")
            Dim ParmName As String = Parm(0)

            If ParmName.Trim.Length > 0 Then
                Dim ParmVal As String = Parm(1)
                If ParmName.Equals("txtGlobalFileDirectory") Then
                    txtGlobalFileDirectory.Text = ParmVal
                ElseIf ParmName.Equals("txtRepositoryName") Then
                    txtRepositoryName.Text = ParmVal
                ElseIf ParmName.Equals("txtServerInstance") Then
                    txtServerInstance.Text = ParmVal
                ElseIf ParmName.Equals("ckWindowsAuthentication") Then
                    If ParmVal.Equals("True") Then
                        ckWindowsAuthentication.Checked = True
                    Else
                        ckWindowsAuthentication.Checked = False
                    End If
                ElseIf ParmName.Equals("ckRepository") Then
                    If ParmVal.Equals("True") Then
                        rbRepository.Checked = True
                    Else
                        rbRepository.Checked = False
                    End If
                ElseIf ParmName.Equals("ckThesaurus") Then
                    If ParmVal.Equals("True") Then
                        rbThesaurus.Checked = True
                    Else
                        rbThesaurus.Checked = False
                    End If
                ElseIf ParmName.Equals("txtLoginName") Then
                    txtLoginName.Text = ParmVal
                ElseIf ParmName.Equals("txtPw1") Then
                    txtPw1.Text = ParmVal
                    txtPw2.Text = ParmVal
                ElseIf ParmName.Equals("cbSavedDefinitions") Then
                    cbSavedDefinitions.Text = ParmVal
                ElseIf ParmName.Equals("ckHive") Then
                    If ParmVal.Equals("True") Then
                        ckHive.Checked = True
                    Else
                        ckHive.Checked = False
                    End If
                ElseIf ParmName.Equals("txtDBName") Then
                    txtDBName.Text = ParmVal
                End If
            End If
        Next
        MasterLoaded = True
        SB.Text = "Global setup parms loaded."
        MasterConnstr = BuildConnstr()
        txtMstr.Text = MasterConnstr
    End Sub

    Function BuildConnstr() as string
        Dim S As String = ""

        If Not ckWindowsAuthentication.Checked Then
            S = "Data Source=" + txtServerInstance.Text.Trim + ";Initial Catalog=" + txtRepositoryName.Text.Trim + ";Persist Security Info=True;User ID='" + txtLoginName.Text.Trim + "';Password='" + txtPw1.Text.Trim + "'"
        Else
            S = "Data Source='" + txtServerInstance.Text.Trim + "';Initial Catalog='" + txtRepositoryName.Text.Trim + "';Integrated Security=True"
        End If

        Return S
    End Function

    Private Function getConnStr() As String
        Dim CS As String = BuildConnstr()
        Return CS
    End Function

    Public Function ExecuteSqlNewConn(ByVal sql As String) As Boolean

        If MasterConnstr.Trim.Length = 0 Then
            MessageBox.Show("Please, you must define and save the repository first, execution cancelled - returning.")
            Return False
        End If

        Dim rc As Boolean = False
        Dim CN As New SqlConnection(MasterConnstr)
        CN.Open()
        Dim dbCmd As SqlCommand = CN.CreateCommand()
        Dim BB As Boolean = True
        Try
            Using CN
                dbCmd.Connection = CN
                Try
                    dbCmd.CommandText = sql
                    dbCmd.ExecuteNonQuery()
                    BB = True
                Catch ex As Exception
                    rc = False
                    MessageBox.Show("ERROR SQL Execution: " + vbCrLf + vbCrLf + sql + vbCrLf + vbCrLf + ex.Message)
                End Try
            End Using
        Catch ex As Exception
        Finally
            If CN.State = ConnectionState.Open Then
                CN.Close()
            End If

            CN = Nothing
            dbCmd = Nothing
            GC.Collect()
            GC.WaitForFullGCComplete()
        End Try

        Return BB
    End Function

    Public Function iCount(ByVal S AS String ) As Integer

        If MasterConnstr.Trim.Length = 0 Then
            MessageBox.Show("You must define and save the Respoitory before defining the Thesaurus.")
            Return -1
        End If

        Dim Cnt As Integer = -1
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        Dim CS As String = MasterConnstr
        Dim CONN As New SqlConnection(CS)

        Try
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            rsData = command.ExecuteReader()
            rsData.Read()
            Cnt = rsData.GetInt32(0)
            rsData.Close()
            rsData = Nothing
            Return Cnt
        Catch ex As Exception
            MessageBox.Show("clsDatabaseARCH : iCount : 2054 : " + ex.Message)
            Return -1
        Finally
            If rsData IsNot Nothing Then
                If Not rsData.IsClosed Then
                    rsData.Close()
                End If
                rsData = Nothing
                CONN.Dispose()
            End If
            GC.Collect()
            GC.WaitForFullGCComplete()
        End Try
        Return Cnt
    End Function

    Private Sub cbSavedDefinitions_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbSavedDefinitions.TextChanged
        cbSavedDefinitions.Text = cbSavedDefinitions.Text.Replace("'", "")
    End Sub

    Function GetGlobalFileName() As String
        Dim FN As String = ""
        If rbThesaurus.Checked Then
            FN = "\Thesaurus.EcmAutoInstall.dat"
        Else
            FN = "\Repository.EcmAutoInstall.dat"
        End If
        Return FN
    End Function

    Private Sub btnResetGlobalLocationToDefault_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnResetGlobalLocationToDefault.Click
        txtGlobalFileDirectory.Text = "C:\EcmLibrary\Global"
    End Sub

    
    Private Sub btnLoadCombo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoadCombo.Click

        If MasterConnstr.Trim.Length = 0 Then
            MessageBox.Show("ERROR: the master setup has not been set, returning.")
            Return
        End If

        bLoadingCB = True
        Dim PID As Integer = 0
        Dim s As String = "SELECT [ConnectionName] FROM [Repository] order by [ConnectionName]"
        Dim rsData As SqlDataReader = Nothing
        Dim CS As String = MasterConnstr
        Dim CONN As New SqlConnection(CS)

        cbSavedDefinitions.Items.Clear()

        CONN.Open()
        Dim command As New SqlCommand(s, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                Dim ConnectionName As String = rsData.GetValue(0).ToString
                cbSavedDefinitions.Items.Add(ConnectionName)
            Loop
        End If
        If rsData IsNot Nothing Then
            If Not rsData.IsClosed Then
                rsData.Close()
            End If
            rsData = Nothing
        End If
        CONN.Dispose()
        GC.Collect()
        bLoadingCB = False
    End Sub

    Private Sub btnLoadData_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoadData.Click
        If MasterConnstr.Trim.Length = 0 Then
            MessageBox.Show("ERROR: the master setup has not been set, returning.")
            Return
        End If

        If bLoadingCB Then
            Return
        End If
        '** Get the database data

        Dim tgtName As String = cbSavedDefinitions.Text.Trim
        Dim CS As String = MasterConnstr
        Dim S As String = "SELECT [ConnectionName] ,[ConnectionData] ,[ConnectionDataThesaurus] FROM [ECM.Library].[dbo].[Repository] where [ConnectionName] = '" + tgtName + "'"

        Dim ConnectionName As String = ""
        Dim ConnectionData As String = ""
        Dim ConnectionDataThesaurus As String = ""

        Dim rsData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(CS)

        CONN.Open()
        Dim command As New SqlCommand(S, CONN)
        rsData = command.ExecuteReader()

        If rsData.HasRows Then
            Do While rsData.Read()
                ConnectionName = rsData.GetValue(0).ToString
                ConnectionData = rsData.GetValue(1).ToString
                ConnectionDataThesaurus = rsData.GetValue(2).ToString
            Loop
        End If
        If rsData IsNot Nothing Then
            If Not rsData.IsClosed Then
                rsData.Close()
            End If
            rsData = Nothing
        End If
        CONN.Dispose()
        GC.Collect()

        If rbRepository.Checked Then
            DecryptParmsAndApply(ConnectionData)
        Else
            If ConnectionDataThesaurus.Length = 0 Then
                MessageBox.Show("The thesaurus has not been established for this profile.")
            Else
                DecryptParmsAndApply(ConnectionDataThesaurus)
            End If
        End If

        bLoadingCB = False
    End Sub

    Sub DecryptParmsAndApply(ByVal tgtStr as string )
        Dim DecryptedParms As String = ENC.AES256DecryptString(tgtStr)

        Dim A() As String = DecryptedParms.Split(Chr(127))

        For Each S In A
            Dim Parm() As String = S.Split("|")
            Dim ParmName As String = Parm(0)

            If ParmName.Trim.Length > 0 Then
                Dim ParmVal As String = Parm(1)
                If ParmName.Equals("txtGlobalFileDirectory") Then
                    txtGlobalFileDirectory.Text = ParmVal
                ElseIf ParmName.Equals("txtRepositoryName") Then
                    txtRepositoryName.Text = ParmVal
                ElseIf ParmName.Equals("txtServerInstance") Then
                    txtServerInstance.Text = ParmVal
                ElseIf ParmName.Equals("ckWindowsAuthentication") Then
                    If ParmVal.Equals("True") Then
                        ckWindowsAuthentication.Checked = True
                    Else
                        ckWindowsAuthentication.Checked = False
                    End If
                ElseIf ParmName.Equals("ckRepository") Then
                    If ParmVal.Equals("True") Then
                        rbRepository.Checked = True
                    Else
                        rbRepository.Checked = False
                    End If
                ElseIf ParmName.Equals("ckThesaurus") Then
                    If ParmVal.Equals("True") Then
                        rbThesaurus.Checked = True
                    Else
                        rbThesaurus.Checked = False
                    End If
                ElseIf ParmName.Equals("txtLoginName") Then
                    txtLoginName.Text = ParmVal
                ElseIf ParmName.Equals("txtPw1") Then
                    txtPw1.Text = ParmVal
                    txtPw2.Text = ParmVal
                ElseIf ParmName.Equals("cbSavedDefinitions") Then
                    cbSavedDefinitions.Text = ParmVal
                ElseIf ParmName.Equals("ckHive") Then
                    If ParmVal.Equals("True") Then
                        ckHive.Checked = True
                    Else
                        ckHive.Checked = False
                    End If
                ElseIf ParmName.Equals("txtDBName") Then
                    txtDBName.Text = ParmVal
                End If
            End If
        Next
    End Sub

    Private Sub GotoGlobalDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GotoGlobalDirectoryToolStripMenuItem.Click
        Dim AppPath As String = txtGlobalFileDirectory.Text
        Dim procstart As New ProcessStartInfo("explorer")
        procstart.Arguments = AppPath
        Process.Start(procstart)
    End Sub

    Private Sub GotoApplicationDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GotoApplicationDirectoryToolStripMenuItem.Click
        Dim AppPath As String = System.AppDomain.CurrentDomain.BaseDirectory()
        Dim procstart As New ProcessStartInfo("explorer")
        Dim winDir As String = System.IO.Path.GetDirectoryName(AppPath)
        procstart.Arguments = AppPath
        Process.Start(procstart)
    End Sub

    'Private Sub LicenseToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LicenseToolStripMenuItem.Click

    '    frmLicense.txtServerName.Text = txtDBName.Text
    '    frmLicense.txtServer.Text = txtServerInstance.Text.Trim
    '    frmLicense.txtCurrConnStr.Text = BuildConnstr()
    '    frmLicense.Show()

    'End Sub
End Class
