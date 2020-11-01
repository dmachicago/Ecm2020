Public Class clsEncryptV2
    Function EncryptPhrase(ByVal Phrase As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim CH As String = ""
        Dim SIC As String = ""
        Dim IC As Integer = 0
        Try
            For I = 0 To Phrase.Length - 1
                IC = 0
                CH = Phrase.Substring(I, 1)
                IC = AscW(CH)
                IC = IC + 88
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
            S = "ERROR 100xx01: " + ex.Message
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
            S = "ERROR 100xx01: " + ex.Message
        End Try

        Return S
    End Function

End Class
