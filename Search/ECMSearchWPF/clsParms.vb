Public Class clsParms
    Function BuildParmString(ByVal ParmDict As Dictionary(Of String, String)) As String

        Dim S As String = ""
        Dim sParms As String = ""
        Dim sVal As String = ""

        For Each S In ParmDict.Keys
            sVal = ParmDict.Item(S)
            sParms = sParms + S + ChrW(253) + sVal + ChrW(254)
        Next
        sParms.Replace("'", "`")
        Return sParms

    End Function

    Sub ReBuildParmDist(ByVal ParmString As String, ByRef ParmDict As Dictionary(Of String, String))

        ParmDict.Clear()
        Dim Parms() As String
        Parms = ParmString.Split(ChrW(254))

        Dim ParmPair() As String

        Dim S As String = ""
        Dim sKey As String = ""
        Dim sVal As String = ""

        For Each S In Parms
            ParmPair = S.Split(ChrW(253))
            sKey = ParmPair(0)
            If ParmPair.Count > 1 Then
                sVal = ParmPair(1)
                If Not ParmDict.ContainsKey(sKey) Then
                    ParmDict.Add(sKey, sVal)
                End If
            End If
        Next

    End Sub
End Class
