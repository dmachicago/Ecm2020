Imports System.IO

Public Class clsFileInfo

Dim FileKey AS String  = "" 

    Sub RemoveBadChars(ByRef FQN AS String )
        For i As Integer = 1 To FQN.Length
Dim CH AS String  = Mid(FQN, i, 1) 
            Select Case CH
                Case "/"
                    Mid(FQN, i, 1) = "."
                Case "'"
                    Mid(FQN, i, 1) = "."
                Case " "
                    Mid(FQN, i, 1) = "."
                Case ":"
                    Mid(FQN, i, 1) = "."
            End Select
        Next
    End Sub
End Class
