' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsParms.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsParms.
''' </summary>
Public Class clsParms
    ''' <summary>
    ''' Builds the parm string.
    ''' </summary>
    ''' <param name="ParmDict">The parm dictionary.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Res the build parm dist.
    ''' </summary>
    ''' <param name="ParmString">The parm string.</param>
    ''' <param name="ParmDict">The parm dictionary.</param>
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
