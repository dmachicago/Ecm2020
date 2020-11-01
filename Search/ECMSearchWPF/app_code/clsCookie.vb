Imports System.Windows.Browser
Imports System.Windows.Browser.HtmlPage

Public NotInheritable Class clsCookie
    Private Sub New()
    End Sub
    Public Shared Function SaveUserParm(ByVal Parm As String, ByVal ParmValue As String) As Boolean
        Dim B As Boolean = True
        Dim key = Parm
        Dim value = ParmValue
        Dim expireDays As Integer = 360
        Try
            Write(Key, value, expireDays)
        Catch ex As Exception
            B = False
        End Try
        Return B
    End Function
    Public Shared Function getUserParm(ByVal Parm As String) As String
        Dim B As Boolean = True
        Dim value As String = ""
        Try
            value = Read(Parm)
        Catch ex As Exception
            value = ""
        End Try
        Return value
    End Function
    Public Shared Function Exists(ByVal key As String, ByVal value As String) As Boolean
        Return HtmlPage.Document.Cookies.Contains(key & "=" & value)
    End Function
    Public Shared Function Read(ByVal key As String) As String
        Dim cookies As String() = HtmlPage.Document.Cookies.Split(";"c)
        For Each cookie As String In cookies
            Dim keyValuePair As String() = cookie.Split("="c)
            If keyValuePair.Length = 2 AndAlso key = keyValuePair(0).Trim() Then
                Return keyValuePair(1).Trim()
            End If
        Next
        Return Nothing
    End Function
    Public Shared Sub Write(ByVal key As String, ByVal value As String, ByVal expireDays As Integer)
        ' expireDays = 0, indicates a session cookie that will not be written to disk 
        ' expireDays = -1, indicates that the cookie will not expire and will be permanent 
        ' expireDays = n, indicates that the cookie will expire in “n” days 
        Dim expires As String = ""
        If expireDays <> 0 Then
            Dim expireDate As DateTime = (If(expireDays > 0, DateTime.Now + TimeSpan.FromDays(expireDays), DateTime.MaxValue))
            expires = ";expires=" & expireDate.ToString("R")
        End If
        Dim cookie As String = key & "=" & value & expires
        HtmlPage.Document.SetProperty("cookie", cookie)
    End Sub
    Public Shared Sub Delete(ByVal key As String)
        Dim expireDate As DateTime = DateTime.Now - TimeSpan.FromDays(1)
        ' yesterday 
        Dim expires As String = ";expires=" & expireDate.ToString("R")
        Dim cookie As String = key & "=" & expires
        HtmlPage.Document.SetProperty("cookie", cookie)
    End Sub
End Class
