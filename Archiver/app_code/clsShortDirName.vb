Imports System
Imports System.Runtime.InteropServices
Imports System.Text
Imports System.Security.Cryptography

Public Class clsShortDirName

    <DllImport("kernel32.dll")>
    Private Shared Function GetShortPathName(ByVal lpszLongPath As String, ByVal lpszShortPath As Char(), ByVal cchBuffer As Integer) As UInteger
    End Function


    Public Function ShortDirName(ByVal long_name As String) As String
        Dim name_chars As Char() = New Char(1023) {}
        Dim length As Long = GetShortPathName(long_name, name_chars, name_chars.Length)
        If (length <= 254) Then
            Return long_name
        End If
        Dim short_name As String = New String(name_chars)
        Return short_name.Substring(0, CInt(length))
    End Function

    Public Function ShortFileName(ByVal long_name As String) As String
        Dim name_chars As Char() = New Char(1023) {}
        Dim length As Long = GetShortPathName(long_name, name_chars, name_chars.Length)
        Dim short_name As String = New String(name_chars)
        Return short_name.Substring(0, CInt(length))
    End Function

    Public Function LongFileName(ByVal short_name As String) As String
        Return New IO.FileInfo(short_name).FullName
    End Function

End Class
