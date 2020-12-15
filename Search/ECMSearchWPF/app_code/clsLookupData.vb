' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsLookupData.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class clsLookupData.
''' </summary>
Public Class clsLookupData

    ''' <summary>
    ''' Initializes the lookup tables.
    ''' </summary>
    Sub InitializeLookupTables()
        AddDefaultRetentionCode()
    End Sub

    ''' <summary>
    ''' Adds the default retention code.
    ''' </summary>
    Sub AddDefaultRetentionCode()

        Dim S$ = "INSERT INTO [Retention]"
        S = S + " ([RetentionCode]"
        S = S + " ,[RetentionDesc]"
        S = S + " ,[RetentionYears]"
        S = S + " ,[RetentionAction]"
        S = S + " ,[ManagerID]"
        S = S + " ,[ManagerName])"
        S = S + " VALUES "
        S = S + " ('10 Years'"
        S = S + " ,'Retain for 10 years.'"
        S = S + " ,10"
        S = S + " ,'Move'"
        S = S + " ,'admin'"
        S = S + " ,'admin')"
        ExecuteSql(_SecureID, S)
        S$ = "INSERT INTO [Retention]"
        S = S + " ([RetentionCode]"
        S = S + " ,[RetentionDesc]"
        S = S + " ,[RetentionYears]"
        S = S + " ,[RetentionAction]"
        S = S + " ,[ManagerID]"
        S = S + " ,[ManagerName])"
        S = S + " VALUES "
        S = S + " ('20 Years'"
        S = S + " ,'Retain for 20 years.'"
        S = S + " ,20"
        S = S + " ,'Move'"
        S = S + " ,'admin'"
        S = S + " ,'admin')"
        ExecuteSql(_SecureID, S)
        S$ = "INSERT INTO [Retention]"
        S = S + " ([RetentionCode]"
        S = S + " ,[RetentionDesc]"
        S = S + " ,[RetentionYears]"
        S = S + " ,[RetentionAction]"
        S = S + " ,[ManagerID]"
        S = S + " ,[ManagerName])"
        S = S + " VALUES "
        S = S + " ('30 Years'"
        S = S + " ,'Retain for 20 years.'"
        S = S + " ,30"
        S = S + " ,'Move'"
        S = S + " ,'admin'"
        S = S + " ,'admin')"
        ExecuteSql(_SecureID, S)
        S$ = "INSERT INTO [Retention]"
        S = S + " ([RetentionCode]"
        S = S + " ,[RetentionDesc]"
        S = S + " ,[RetentionYears]"
        S = S + " ,[RetentionAction]"
        S = S + " ,[ManagerID]"
        S = S + " ,[ManagerName])"
        S = S + " VALUES "
        S = S + " ('40 Years'"
        S = S + " ,'Retain for 20 years.'"
        S = S + " ,40"
        S = S + " ,'Move'"
        S = S + " ,'admin'"
        S = S + " ,'admin')"
        ExecuteSql(_SecureID, S)
        S$ = "INSERT INTO [Retention]"
        S = S + " ([RetentionCode]"
        S = S + " ,[RetentionDesc]"
        S = S + " ,[RetentionYears]"
        S = S + " ,[RetentionAction]"
        S = S + " ,[ManagerID]"
        S = S + " ,[ManagerName])"
        S = S + " VALUES "
        S = S + " ('50 Years'"
        S = S + " ,'Retain for 20 years.'"
        S = S + " ,50"
        S = S + " ,'Move'"
        S = S + " ,'admin'"
        S = S + " ,'admin')"
        ExecuteSql(_SecureID, S)
    End Sub

End Class
