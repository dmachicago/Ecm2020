Imports System
Imports Microsoft.VisualBasic

Public Class clsLocalEncrypt

    Public Function GX() As String
        Dim s As String = ""
        s += "A"
        s += "F"
        s += "6"
        s += "1"
        s += "D"
        s += "r"
        s += "y"
        s += "7"
        s += "4"
        s += "F"
        s += "G"
        s += "Q"
        s += "3"
        s += "B"
        s += "F"

        Return s
    End Function

    Private Function getAdddon(c As String) As Integer
        Dim i As Integer = 0
        If c.ToUpper().Equals("0") Then
            i = 50
        ElseIf c.ToUpper().Equals("1") Then
            i = 1
        ElseIf c.ToUpper().Equals("2") Then
            i = 2
        ElseIf c.ToUpper().Equals("3") Then
            i = 3
        ElseIf c.ToUpper().Equals("4") Then
            i = 4
        ElseIf c.ToUpper().Equals("5") Then
            i = 5
        ElseIf c.ToUpper().Equals("6") Then
            i = 6
        ElseIf c.ToUpper().Equals("7") Then
            i = 7
        ElseIf c.ToUpper().Equals("8") Then
            i = 8
        ElseIf c.ToUpper().Equals("9") Then
            i = 9
        ElseIf c.ToUpper().Equals("A") Then
            i = 10
        ElseIf c.ToUpper().Equals("B") Then
            i = 11
        ElseIf c.ToUpper().Equals("C") Then
            i = 12
        ElseIf c.ToUpper().Equals("D") Then
            i = 13
        ElseIf c.ToUpper().Equals("E") Then
            i = 14
        ElseIf c.ToUpper().Equals("F") Then
            i = 15
        ElseIf c.ToUpper().Equals("-") Then
            i = 16
        ElseIf c.ToUpper().Equals("=") Then
            i = AscW(Convert.ToChar(253))
        Else
            Dim c1 As Char = Convert.ToChar(c)
            i = AscW(c1)
        End If
        Return i
    End Function

    ''' <summary>
    ''' Encrypts the specified phrase.
    ''' </summary>
    ''' <param name="phrase">The phrase.</param>
    ''' <param name="encKey">The enc key.</param>
    ''' <returns></returns>
    Public Function Encrypt(phrase As String, encKey As String) As String
        Dim cs As String = ""
        Dim es As String = ""
        Dim j As Integer = 0
        Dim k As Integer = encKey.Length
        Dim RetStr As String = ""

        For i As Integer = 0 To (phrase.Length - 1)
            If j >= k - 1 Then
                j = 0
            End If
            cs = phrase.Substring(i, 1)
            es = encKey.Substring(j, 1)
            Dim ix As Integer = getAdddon(es)

            Dim i1 As Integer = AscW(Convert.ToChar(cs))
            i1 = i1 + ix
            Dim xx As Char = Convert.ToChar(i1)
            RetStr += xx.ToString()
            j += 1
        Next

        Dim xChar As New String(ChrW(253), 1)
        Dim xStr As String = RetStr.Replace("=", xChar)

        Return xStr
    End Function

    ''' <summary>
    ''' Decrypts the specified phrase.
    ''' </summary>
    ''' <param name="phrase">The phrase.</param>
    ''' <param name="encKey">The enc key.</param>
    ''' <returns></returns>
    Public Function Decrypt(phrase As String, encKey As String) As String
        Dim xChar As New String(ChrW(253), 1)
        Dim xphrase As String = phrase.Replace(xChar, "=")
        phrase = xphrase

        Dim cs As String = ""
        Dim es As String = ""
        Dim j As Integer = 0
        Dim k As Integer = encKey.Length
        Dim RetStr As String = ""

        For i As Integer = 0 To (phrase.Length - 1)
            If j >= k - 1 Then
                j = 0
            End If
            cs = phrase.Substring(i, 1)
            es = encKey.Substring(j, 1)
            Dim ix As Integer = getAdddon(es)

            Dim i1 As Integer = AscW(Convert.ToChar(cs))
            i1 = i1 - ix
            Dim xx As Char = Convert.ToChar(i1)
            RetStr += xx.ToString()
            j += 1
        Next
        Return RetStr
    End Function

    ''' <summary>
    ''' LUNCGUIDs the specified phrase.
    ''' </summary>
    ''' <param name="phrase">The phrase.</param>
    ''' <param name="strGuid">The STR GUID.</param>
    ''' <returns></returns>
    Public Function LUNCGUID(phrase As String, strGuid As String) As String
        Dim xChar As New String(ChrW(253), 1)
        Dim xphrase As String = phrase.Replace(xChar, "=")
        phrase = xphrase

        Dim cs As String = ""
        Dim es As String = ""
        Dim j As Integer = 0
        Dim k As Integer = strGuid.Length
        Dim RetStr As String = ""

        For i As Integer = 0 To (phrase.Length - 1)
            If j >= k - 1 Then
                j = 0
            End If
            cs = phrase.Substring(i, 1)
            es = strGuid.Substring(j, 1)
            Dim ix As Integer = getAdddon(es)

            Dim i1 As Integer = AscW(Convert.ToChar(cs))
            i1 = i1 - ix
            Dim xx As Char = Convert.ToChar(i1)
            RetStr += xx.ToString()
            j += 1
        Next
        Return RetStr
    End Function

    Public Function LENCGUID(phrase As String, strGuid As String) As String
        Dim cs As String = ""
        Dim es As String = ""
        Dim j As Integer = 0
        Dim k As Integer = strGuid.Length
        Dim RetStr As String = ""

        For i As Integer = 0 To (phrase.Length - 1)
            If j >= k - 1 Then
                j = 0
            End If
            cs = phrase.Substring(i, 1)
            es = strGuid.Substring(j, 1)
            Dim ix As Integer = getAdddon(es)

            Dim i1 As Integer = AscW(Convert.ToChar(cs))
            i1 = i1 + ix
            Dim xx As Char = Convert.ToChar(i1)
            RetStr += xx.ToString()
            j += 1
        Next

        Dim xChar As New String(ChrW(253), 1)
        Dim xStr As String = RetStr.Replace("=", xChar)

        Return xStr
    End Function

    Public Function LENC(phrase As String) As String
        Dim IDX As Integer = 0
        Dim cs As String = ""
        Dim es As String = ""
        '  Char c = 'a';

        For i As Integer = 0 To (phrase.Length - 1)
            IDX += 1
            cs = phrase.Substring(i, 1)
            Dim ii As Integer = AscW(Convert.ToChar(cs))
            ii = ii + 50 + IDX
            If IDX > 30 Then
                IDX = 0
            End If
            Dim xx As Char = Convert.ToChar(ii)
            es += xx.ToString()
        Next
        Return es
    End Function

    Public Function LUNC(phrase As String) As String
        Dim IDX As Integer = 0
        Dim cs As String = ""
        Dim es As String = ""
        '  Char c = 'a';

        For i As Integer = 0 To (phrase.Length - 1)
            IDX += 1
            cs = phrase.Substring(i, 1)
            Dim ii As Integer = AscW(Convert.ToChar(cs))
            ii = ii - 50 - IDX
            If IDX > 30 Then
                IDX = 0
            End If
            Dim xx As Char = Convert.ToChar(ii)
            es += xx.ToString()
        Next

        Return es
    End Function

    Public Function strEncrypt(phrase As String) As String
        Dim IDX As Integer = 0
        Dim cs As String = ""
        Dim es As String = ""
        '  Char c = 'a';

        For i As Integer = 0 To (phrase.Length - 1)
            IDX += 1
            cs = phrase.Substring(i, 1)
            Dim ii As Integer = AscW(Convert.ToChar(cs))
            ii = ii + 50 + IDX
            If IDX > 22 Then
                IDX = 0
            End If
            Dim xx As Char = Convert.ToChar(ii)
            es += xx.ToString()
        Next
        Return es
    End Function

    Public Function strDecrypt(phrase As String) As String
        Dim IDX As Integer = 0
        Dim cs As String = ""
        Dim es As String = ""
        '  Char c = 'a';

        For i As Integer = 0 To (phrase.Length - 1)
            IDX += 1
            cs = phrase.Substring(i, 1)
            Dim ii As Integer = AscW(Convert.ToChar(cs))
            ii = ii - 50 - IDX
            If IDX > 22 Then
                IDX = 0
            End If
            Dim xx As Char = Convert.ToChar(ii)
            es += xx.ToString()
        Next

        Return es
    End Function
End Class
