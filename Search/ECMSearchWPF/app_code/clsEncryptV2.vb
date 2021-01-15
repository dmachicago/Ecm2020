Public Class clsEncryptV2

    Function EncryptTripleDES_V2(ByVal Phrase As String) As String
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
            Dim msg As String = (I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & SIC) + Environment.NewLine + ex.Message
            MessageBox.Show(msg)
        End Try

        Return S
    End Function
    Function Reverse(ByVal value As String) As String
        ' Convert to char array.
        Dim arr() As Char = value.ToCharArray()
        ' Use Array.Reverse function.
        Array.Reverse(arr)
        ' Construct new string.
        Return New String(arr)
    End Function
    Function EncryptTripleDES_V2(ByVal Phrase As String, ByVal shiftKey As String) As String
        shiftKey = ContractID
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
        Dim LL As Decimal = 0

        Dim sKey As String = shiftKey + RevshiftKey
        Try
            For I = 0 To Phrase.Length - 1
                If K >= sKey.Length - 1 Then : LL = 1
                    K = 0 : LL = 5
                End If
                IC = 0 : LL = 10
                CH = Phrase.Substring(I, 1) : LL = 15
                KCH = sKey.Substring(K, 1) : LL = 20
                IC = AscW(CH) : LL = 25
                KIC = AscW(KCH) : LL = 30
                IC = IC + 88 + KIC : LL = 35
                SIC = IC.ToString : LL = 40
                WCH += ChrW(SIC) : LL = 45
                S += SIC : LL = 50
                K = K + 1 : LL = 55
            Next
        Catch ex As Exception
            MessageBox.Show("K: " & K & Environment.NewLine & "LL: " & LL.ToString & Environment.NewLine & I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & SIC)
            MessageBox.Show("ERROR 100xx02: " + ex.Message)
        End Try

        Return WCH
    End Function
    Function EncryptPhraseV1(ByVal Phrase As String, ByVal shiftKey As String) As String
        Dim S As String = ""
        Dim I As Integer = 0
        Dim K As Integer = 0
        Dim CH As String = ""
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
                If SIC.Length < 2 Then
                    SIC = "00" + SIC
                End If
                If SIC.Length < 3 Then
                    SIC = "0" + SIC
                End If
                S += SIC
                K = K + 1
            Next
        Catch ex As Exception
            MessageBox.Show(I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & SIC)
            MessageBox.Show("ERROR 100xx03: " + ex.Message)
        End Try

        Return S
    End Function
    Function AES256EncryptString(ByVal Phrase As String, ByVal shiftKey As String) As String
        shiftKey = ContractID
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
        Try
            For I = 0 To Phrase.Length - 1
                If K >= shiftKey.Length Then
                    K = 0
                End If
                CH = Phrase.Substring(I, 1)
                KCH = shiftKey.Substring(K, 1)
                IC = AscW(CH)
                IC2 = AscW(KCH)
                IC = IC - 88 - IC2
                CHX = ChrW(IC)
                S += CHX
                K = K + 1
            Next
        Catch ex As Exception
            MessageBox.Show(I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & CHX)
            MessageBox.Show("ERROR 100xx04: " + ex.Message)
        End Try

        Return S
    End Function
    Function AES256EncryptString(ByVal Phrase As String) As String
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
                'I += 2
            Next
        Catch ex As Exception
            MessageBox.Show(I & ChrW(9) & CH & ChrW(9) & Phrase & ChrW(9) & CHX)
            MessageBox.Show("ERROR 100xx05: " + ex.Message)
        End Try

        Return S
    End Function

End Class
