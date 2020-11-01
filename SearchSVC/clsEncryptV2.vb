Public Class clsEncryptV2

    Dim LOG As New clsLogging
    Function Reverse(ByVal value As String) As String
        ' Convert to char array.
        Dim arr() As Char = value.ToCharArray()
        ' Use Array.Reverse function.
        Array.Reverse(arr)
        ' Construct new string.
        Return New String(arr)
    End Function

    Public Function EncryptPhrase(ByVal Phrase As String, ByVal shiftKey As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim K As Integer = 0
        Dim CH As String = ""
        Dim WCH As String = ""
        Dim KCH As String = ""
        Dim SIC As String = ""
        Dim IC As Integer = 0
        Dim KIC As Integer = 0
        Dim RevshiftKey As String = Reverse(shiftKey)
        shiftKey = shiftKey + RevshiftKey
        Try
            For I = 0 To Phrase.Length - 1
                If K >= shiftKey.Length Then
                    K = 0
                End If
                IC = 0
                CH = Phrase.Substring(I, 1)
                KCH = shiftKey.Substring(K, 1)
                IC = AscW(CH)
                KIC = AscW(KCH)
                IC = IC + 88 + KIC
                SIC = IC.ToString
                WCH += ChrW(SIC)
                S += SIC
                K = K + 1
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR EncryptPhrase 01: " + ex.Message)
        End Try

        Return WCH
    End Function

    Public Function DecryptPhrase(ByVal Phrase As String, ByVal shiftKey As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim K As Integer = 0
        Dim CH As String = ""
        Dim KCH As String = ""
        Dim IC As Integer = 0
        Dim IC2 As Integer = 0
        Dim CHX As String = ""
        Dim KIC As Integer = 0
        Dim RevshiftKey As String = Reverse(shiftKey)

        shiftKey = shiftKey + RevshiftKey
        Dim sKey As String = shiftKey
        Try
            For I = 0 To Phrase.Length - 1
                If K >= sKey.Length - 1 Then
                    K = 0
                End If
                CH = Phrase.Substring(I, 1)
                KCH = sKey.Substring(K, 1)
                IC = AscW(CH)
                IC2 = AscW(KCH)
                IC = IC - 88 - IC2
                CHX = ChrW(IC)
                S += CHX
                K = K + 1
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR DecryptPhrase 01: " + ex.Message)
        End Try

        Return S
    End Function

    Function EncryptPhrase(ByVal Phrase As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim CH As String = ""
        Dim SIC As String = ""
        Try
            For I = 0 To Phrase.Length - 1
                CH = Phrase.Substring(I, 1)
                Dim IC As Integer = AscW(CH)
                IC += 88
                SIC = IC.ToString
                If SIC.Length < 2 Then
                    SIC = "00" + SIC
                End If
                If SIC.Length < 3 Then
                    SIC = "0" + SIC
                End If
                S += SIC
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 100xx06: " + ex.Message)
            LOG.WriteToArchiveLog(I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & SIC)
        End Try
        
        Return S
    End Function

    Function DecryptPhrase(ByVal Phrase As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim CH As String = ""
        Dim IC As Integer = 0
        Dim CHX As String = ""

        Try
            For I = 0 To Phrase.Length - 1 Step 3
                CH = Phrase.Substring(I, 3)
                IC = Val(CH)
                IC = IC - 88
                CHX = ChrW(IC)
                S += CHX
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog(I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & CHX)
            LOG.WriteToArchiveLog("ERROR 100xx02: " + ex.Message)
        End Try

        Return S
    End Function

End Class
