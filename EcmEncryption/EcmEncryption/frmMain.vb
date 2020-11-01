Imports System.IO
Imports System.Data.SqlClient
Imports EcmEncryption

Public Class frmMain

    Dim ENC As New ECMEncrypt()
    Dim RC As Integer = 0
    Dim RetMsg As String = ""

    ''' <summary>
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e">     </param>
    ''' <remarks></remarks>
    Private Sub frmMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        lblVerNo.Text = "2.17.9.08"
        Dim cla As String() = Environment.GetCommandLineArgs()
        Dim i As Int32 = 0

        If cla.Length > 1 Then
            '** Example
            '-ae "CopperMountain@01"
            Dim str As String = ""
            Dim parms As String = ""
            For i = 1 To cla.Length - 1
                If i = 1 Then
                    parms = cla(i).ToString()
                ElseIf i > 1 Then
                    Dim s As String = cla(i).ToString()
                    Debug.Print("Parm:", i, s)
                    If (parms.Contains("h")) Then
                        Debug.Print("-er  <string to process in quotes>  Encrypt and replace c:\temp\encrypted.txt")
                        Debug.Print("-ea  <string to process in quotes>  Encrypt and append to c:\temp\encrypted.txt")
                        Debug.Print("-dr  <string to process in quotes>  Decrypt and replace c:\temp\encrypted.txt")
                        Debug.Print("-da  <string to process in quotes>  Decrypt and append to c:\temp\encrypted.txt")
                        Application.Exit()
                    ElseIf (parms.Contains("e")) Then
                        'ENCRYPT String
                        str = ENC.EncryptPhrase(s)
                        If parms.Contains("a") Then
                            'append to encrypted file
                            ENC.saveString("a", "@INPUT: " + s)
                            ENC.saveString("a", str)
                        Else
                            'replace encrypted file
                            ENC.saveString("r", "@INPUT: " + s)
                            ENC.saveString("a", str)
                        End If
                    ElseIf (parms.Contains("d")) Then
                        'ENCRYPT String
                        str = ENC.DecryptPhrase(s)
                        If parms.Contains("a") Then
                            'append to encrypted file
                            ENC.saveString("a", "@INPUT: " + s)
                            ENC.saveString("a", str)
                        Else
                            'replace encrypted file
                            ENC.saveString("r", "@INPUT: " + s)
                            ENC.saveString("a", str)
                        End If
                    Else
                        Print("Please review the passed in parameters - h for help.")
                    End If
                End If
            Next
            Application.Exit()
        End If

    End Sub

    ''' <summary>
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e">     </param>
    ''' <remarks></remarks>
    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        Dim S As String = txtPlain.Text.Trim
        txtEncrypted.Text = ENC.AES256EncryptString(S)
    End Sub

    Private Sub btnDecrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDecrypt.Click
        Dim S As String = txtEncrypted.Text.Trim
        txtPlain.Text = ENC.AES256DecryptString(S)
    End Sub

    Private Sub btnCB01_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCB01.Click
        Clipboard.Clear()
        Clipboard.SetText(txtPlain.Text)
    End Sub

    Private Sub btnCB02_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCB02.Click
        Clipboard.Clear()
        Clipboard.SetText(txtEncrypted.Text)
    End Sub

    Private Sub btnEncConn_Click(sender As Object, e As EventArgs) Handles btnEncConn.Click
        Dim S As String = txtConnStr.Text.Trim
        Dim sEnc = ENC.EncryptPhrase(S)
        txtPlain.Text = txtConnStr.Text.Trim
        txtEncrypted.Text = sEnc
    End Sub

    Private Sub btnGenConn_Click(sender As Object, e As EventArgs) Handles btnGenConn.Click
        'Data Source=ALIEN; Initial Catalog=ECM.Library; Integrated Security=True;  Connect Timeout = 30;
        Dim strConn As String = ""
        If (ckWindowsAuth.Checked) Then
            If (txtInstanceName.Text.Length > 0) Then
                strConn = "Data Source=" + txtServerName.Text + "\" + txtInstanceName.Text + "; Initial Catalog=" + txtDbName.Text + "; Integrated Security=True;  Connect Timeout = " + txtTimeOut.Text + ";"
            Else
                strConn = "Data Source=" + txtServerName.Text + "; Initial Catalog=" + txtDbName.Text + "; Integrated Security=True;  Connect Timeout = " + txtTimeOut.Text + "; Connect Timeout = " + txtTimeOut.Text + ";"
            End If
            txtConnStr.Text = strConn
        Else
            strConn = ""
            If (txtInstanceName.Text.Length > 0) Then
                strConn = "Data Source=" + txtServerName.Text + "\" + txtInstanceName.Text + ";Initial Catalog=" + txtDbName.Text + ";Persist Security Info=True;User ID=" + txtEcmUserName.Text + ";Password=" + txtUserPW.Text + ";  Connect Timeout = " + txtTimeOut.Text + ";"
            Else
                strConn = "Data Source=" + txtServerName.Text + ";Initial Catalog=" + txtDbName.Text + ";Persist Security Info=True;User ID=" + txtEcmUserName.Text + ";Password=" + txtUserPW.Text + ";  Connect Timeout = " + txtTimeOut.Text + ";"
            End If
            If cbProvider.Text.Trim.Length > 0 Then
                Dim provider As String = cbProvider.Text
                If (provider.Equals("NONE")) Then
                    Debug.Print("No provider")
                Else
                    strConn += "providerName=" + """" + provider + """; "
                End If
            End If
        End If
        txtConnStr.Text = strConn
    End Sub

    Private Sub btnTestConn_Click(sender As Object, e As EventArgs) Handles btnTestConn.Click
        Dim ConnectionStr$ = txtConnStr.Text
        Dim b As Boolean = ckDbConnection(ConnectionStr$)
        If b Then
            MessageBox.Show("Connection successul")
        Else
            MessageBox.Show("Connection FAILED")
        End If
    End Sub

    Public Function ckDbConnection(ByVal ConnectionStr$) As Boolean

        Dim gConn As New SqlConnection

        Dim b As Boolean = False
        Dim CS$ = ""
        Try
            If gConn Is Nothing Then
                Try
                    gConn.ConnectionString = ConnectionStr
                    gConn.Open()
                    b = True
                Catch ex As Exception
                    MsgBox("clsDatabase : ckDbConnection : 24 : " + gConn.ConnectionString)
                    b = False
                End Try
            End If
            If gConn.State = Data.ConnectionState.Closed Then
                Try
                    CS$ = ConnectionStr$
                    gConn.ConnectionString = CS
                    gConn.Open()
                    b = True
                Catch ex As Exception
                    MsgBox("clsDatabase : ckDbConnection : 33 : " + CS)
                End Try
            Else
                b = True
            End If
        Catch ex As Exception
            MsgBox("clsDatabase : ckDbConnection : 43 : " + CS)
            b = False
        End Try
        Return b
    End Function

    Private Sub btnParse_Click(sender As Object, e As EventArgs) Handles btnParse.Click
        Dim s As String = Clipboard.GetText()
        txtConnStr.Text = ScrollStateAutoScrolling
    End Sub

    Private Sub btnParseCS_Click(sender As Object, e As EventArgs) Handles btnParseCS.Click
        Dim s As String = txtConnStr.Text
        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim K As Integer = 0
        Dim ds As String = ""
        Dim ic As String = ""
        Dim uid As String = ""
        Dim pw As String = ""

        txtServerName.Text = ""
        txtDbName.Text = ""
        txtEcmUserName.Text = ""
        txtUserPW.Text = ""
        txtTimeOut.Text = ""

        If (s.Length <= 0) Then
            txtConnStr.Text = txtPlain.Text
            s = txtConnStr.Text
        End If

        If s.Contains("Data Source") Then
            I = s.IndexOf("=", 0)
            If I > 0 Then
                J = s.IndexOf(";", I)
                ds = s.Substring(I + 1, J - I - 1)
                If ds.Contains("\") Then
                    Dim iname As String = ""
                    Dim L As Integer = 0
                    L = s.IndexOf("\", I)
                    iname = s.Substring(L + 1, J - L - 1)
                    K = ds.IndexOf("\", I)
                    ds = ds.Substring(0, K)
                    txtInstanceName.Text = iname
                End If
                txtServerName.Text = ds
                txtServerName.Refresh()
            End If
        End If
        If s.Contains("Initial Catalog") Then
            K = s.IndexOf("Initial Catalog", 0)
            I = s.IndexOf("=", K)
            J = s.IndexOf(";", I)
            ic = s.Substring(I + 1, J - I - 1)
            txtDbName.Text = ic
        End If
        If s.Contains("User ID") Then
            K = s.IndexOf("User ID", 0)
            I = s.IndexOf("=", K)
            J = s.IndexOf(";", I)
            uid = s.Substring(I + 1, J - I - 1)
            txtEcmUserName.Text = uid
        End If
        If s.Contains("Password") Then
            K = s.IndexOf("Password", 0)
            I = s.IndexOf("=", K)
            J = s.IndexOf(";", I)
            If J > 0 Then
                pw = s.Substring(I + 1, J - I - 1)
            Else
                pw = s.Substring(I + 1)
            End If
            txtUserPW.Text = pw
        End If
        If s.Contains("Persist Security Info") Then
            ckWindowsAuth.Checked = False
        End If
        If s.Contains("Integrated Security") Then
            ckWindowsAuth.Checked = True
        End If
        If s.Contains("Connect Timeout") Then
            Dim tout As String = ""
            K = s.IndexOf("Connect Timeout", 0)
            I = s.IndexOf("=", K)
            J = s.IndexOf(";", I)
            If J >= 0 Then
                tout = s.Substring(I + 1, J - I - 1)
            Else
                tout = s.Substring(I + 1)
            End If
            txtTimeOut.Text = tout
        End If
        If s.Contains("providerName") Then
            Dim tout As String = ""
            K = s.IndexOf("providerName", 0)
            I = s.IndexOf("=", K)
            J = s.IndexOf(";", I)
            If J >= 0 Then
                tout = s.Substring(I + 1, J - I - 1)
            Else
                tout = s.Substring(I + 1)
            End If
            tout = tout.Replace("""", "")
            cbProvider.Text = tout
        End If
        txtServerName.Refresh()
        txtDbName.Refresh()
        txtEcmUserName.Refresh()
        txtUserPW.Refresh()
        txtTimeOut.Refresh()
    End Sub

End Class