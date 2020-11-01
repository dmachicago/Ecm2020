'Imports System.Deployment.Application
Imports System.Deployment
Imports ECMEncryption
Public Class clsLicenseMgt

    Dim ENC As New ECMEncrypt
    Dim dDebug As Boolean = True
    Dim DMA As New clsDmaSVR
    Dim DB As New clsDatabaseSVR

    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    Dim RS As New clsRemoteSupport(SecureID)

    Dim SecureID As Integer = -1
    Sub New()
        SecureID = 0
    End Sub

    Function ParseLic(ByVal S as string, byval ShowLicRules As Boolean) As Boolean

        Dim tKey As String = ""
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            B = True
            If xTrv1 Then
                'For I = 0 To LicList.Count - 1
                '    Try
                '        If dDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                '    Catch ex As Exception
                '        Console.WriteLine(ex.Message)
                '    End Try
                'Next I
                Dim cbLicenseType$ = getEncryptedValue("cbLicenseType", LicList)
                Dim cbState$ = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard$ = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail$ = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile$ = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire$ = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire$ = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense$ = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats$ = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers$ = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers$ = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense$ = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity$ = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID$ = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail$ = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName$ = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone$ = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr$ = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry$ = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID$ = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName$ = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate$ = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats$ = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats$ = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr$ = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip$ = getEncryptedValue("txtZip", LicList)
                Dim Sdk$ = getEncryptedValue("ckSdk", LicList)
                If Sdk$.Length = 0 Then
                    Sdk$ = "false"
                End If
                Dim Lease$ = getEncryptedValue("ckLease", LicList)
                If Lease.Length = 0 Then
                    Lease = "false"
                End If

                Dim MaxClients$ = getEncryptedValue("txtMaxClients", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""
                    Msg = Msg + "License Type:" + cbLicenseType$ + vbCrLf
                    Msg = Msg + "State: " + cbState$ + vbCrLf
                    'Msg = Msg + " ckToClipboard$: " + ckToClipboard$ + vbCrLf
                    'Msg = Msg + " ckToEmail$: " + ckToEmail$ + vbCrLf
                    'Msg = Msg + " ckToFile$: " + ckToFile$ + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire$ + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire$ + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense$ + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats$ + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers$ + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers$ + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense$ + vbCrLf
                    Msg = Msg + "City: " + txtCity$ + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID$ + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail$ + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName$ + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone$ + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr$ + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry$ + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID$ + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName$ + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate$ + vbCrLf
                    'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats$ + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats$ + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr$ + vbCrLf
                    Msg = Msg + "Type License: " + cbLicenseType$ + vbCrLf
                    Msg = Msg + "SDK: " + Sdk + vbCrLf
                    Msg = Msg + "Lease: " + Lease + vbCrLf
                    If MaxClients.Equals("0") Then
                        MaxClients = "Unlimited"
                    End If
                    Msg = Msg + "MaxClients: " + MaxClients + vbCrLf
                    'MaxClients$
                    MsgBox(Msg)
                End If

            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToSqlLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return B
    End Function
    Function ParseLicCompanyName(ByVal S As String, ByVal ShowLicRules As Boolean) As String

        Dim tKey As String = ""
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Dim CoName As String = ""
        Try

            LicList = ENC.xt001trc(S)
            B = True
            If xTrv1 Then
                'For I = 0 To LicList.Count - 1
                '    Try
                '        If dDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                '    Catch ex As Exception
                '        Console.WriteLine(ex.Message)
                '    End Try
                'Next I
                Dim cbState$ = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard$ = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail$ = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile$ = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire$ = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire$ = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense$ = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats$ = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers$ = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers$ = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense$ = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity$ = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID$ = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail$ = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName$ = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone$ = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr$ = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry$ = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID$ = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName$ = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate$ = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats$ = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats$ = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr$ = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip$ = getEncryptedValue("txtZip", LicList)
                Dim cbLicenseType$ = getEncryptedValue("cbLicenseType", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""

                    Msg = Msg + "State: " + cbState$ + vbCrLf
                    'Msg = Msg + " ckToClipboard$: " + ckToClipboard$ + vbCrLf
                    'Msg = Msg + " ckToEmail$: " + ckToEmail$ + vbCrLf
                    'Msg = Msg + " ckToFile$: " + ckToFile$ + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire$ + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire$ + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense$ + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats$ + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers$ + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers$ + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense$ + vbCrLf
                    Msg = Msg + "City: " + txtCity$ + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID$ + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail$ + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName$ + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone$ + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr$ + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry$ + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID$ + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName$ + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate$ + vbCrLf
                    'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats$ + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats$ + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr$ + vbCrLf
                    'Msg = Msg + "Zip: " + txtZip$ + vbCrLf
                    CoName$ = txtCustName$
                End If

            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            CoName = ""
            LOG.WriteToSqlLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return CoName$
    End Function
    Function ParseLicCustomerID(ByVal S As String, ByVal ShowLicRules As Boolean) As String

        Dim tKey As String = ""
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Dim CustID As String = ""
        Try

            LicList = ENC.xt001trc(S)
            B = True
            If xTrv1 Then
                Dim cbState$ = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard$ = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail$ = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile$ = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire$ = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire$ = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense$ = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats$ = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers$ = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers$ = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense$ = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity$ = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID$ = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail$ = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName$ = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone$ = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr$ = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry$ = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID$ = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName$ = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate$ = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats$ = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats$ = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr$ = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip$ = getEncryptedValue("txtZip", LicList)
                Dim cbLicenseType$ = getEncryptedValue("cbLicenseType", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""

                    Msg = Msg + "State: " + cbState$ + vbCrLf
                    'Msg = Msg + " ckToClipboard$: " + ckToClipboard$ + vbCrLf
                    'Msg = Msg + " ckToEmail$: " + ckToEmail$ + vbCrLf
                    'Msg = Msg + " ckToFile$: " + ckToFile$ + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire$ + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire$ + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense$ + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats$ + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers$ + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers$ + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense$ + vbCrLf
                    Msg = Msg + "City: " + txtCity$ + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID$ + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail$ + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName$ + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone$ + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr$ + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry$ + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID$ + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName$ + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate$ + vbCrLf
                    'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats$ + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats$ + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr$ + vbCrLf
                    'Msg = Msg + "Zip: " + txtZip$ + vbCrLf
                    CustID = txtCustID$
                End If

            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            CustID = ""
            LOG.WriteToSqlLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return CustID
    End Function
    Function LicenseType(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String
        Dim tKey$ = "cbLicenseType"
        Dim S$ = DB.GetXrt(SecureID, RC, RetMsg)
        Dim tVal As String = ""
        'Dim I As Integer = 0
        Try
            LicList = ENC.xt001trc(S)
            tVal = getEncryptedValue(tKey, LicList)
            If tVal.ToUpper.Equals("ENTERPRISE") Then
                tVal = "Roaming"
            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1b: - LicenseType - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            LOG.WriteToSqlLog("clsLicenseMgt : LicenseType : 24 : " + ex.Message)
        End Try
        Return tVal$
    End Function
    Function SdkLicenseExists(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean
        Dim B As Boolean = False
        Dim tKey$ = "ckSdk"
        Dim S$ = DB.GetXrt(SecureID, RC, RetMsg)
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            B = True
            tVal = getEncryptedValue(tKey, LicList)
            If tVal.ToUpper.Equals("TRUE") Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1a: SdkLicenseExists - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToSqlLog("clsLicenseMgt : SdkLicenseExists : 24 : " + ex.Message)
        End Try
        Return B
    End Function
    Function isLease(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean
        Dim B As Boolean = False
        Dim tKey$ = "ckLease"
        Dim S$ = DB.GetXrt(SecureID, RC, RetMsg)
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            B = True
            tVal = getEncryptedValue(tKey, LicList)
            If tVal.Length = 0 Then
                B = True
            ElseIf tVal.ToUpper.Equals("TRUE") Then
                B = True
            Else
                B = False
            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1a: isLease - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToSqlLog("clsLicenseMgt : isLease : 24 : " + ex.Message)
        End Try
        Return B
    End Function

    Public Function getMaxClients(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Integer
        Dim tKey$ = "txtMaxClients"
        Dim S$ = DB.GetXrt(SecureID, RC, RetMsg)
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            tVal = getEncryptedValue(tKey, LicList)
            If tVal.Length > 0 Then
                I = Val(tVal)
            Else
                I = 0
            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1a: isLease - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            I = 0
            LOG.WriteToSqlLog("clsLicenseMgt : isLease : 24 : " + ex.Message)
        End Try
        Return I
    End Function

    Sub ParseLicDictionary(ByVal S As String, ByRef D As Dictionary(Of String, String))
        D.Clear()
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            For Each sItem As String In LicList.Keys
                If Not D.ContainsKey(sItem) Then
                    Dim sVal As String = LicList.Item(sItem)
                    D.Add(sItem, sVal)
                End If
            Next
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToSqlLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try

    End Sub

    Function ParseLic(ByVal S As String, ByVal tKey As String) As String

        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Try
            LicList = ENC.xt001trc(S)
            B = True
            tVal = getEncryptedValue(tKey, LicList)
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToSqlLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return tVal$
    End Function
    Public Function getEncryptedValue(ByVal iKey As String, ByVal A As SortedList(Of String, String)) As String
        Dim tVal As String = ""

        For I As Integer = 0 To A.Count - 1
            Console.WriteLine(A.Values(I).ToString + " : " + A.Keys(I).ToString)
        Next

        Dim iDx As Integer = A.IndexOfKey(iKey)
        'iDx = A.ContainsValue(iKey)
        If iDx >= 0 Then
            tVal$ = A.Values(iDx).ToString
        Else
            tVal = ""
        End If
        Return tVal
    End Function
    Function ckExpirationDate() As Boolean
        Dim B As Boolean = False
        Dim tDate$ = getEncryptedValue("dtExpire", LicList)
        If tDate$.Trim.Length > 0 Then
            Dim ExpireDate As Date = CDate(getEncryptedValue("dtExpire", LicList))
            Dim iDays As Integer = DetermineNumberofDays(ExpireDate)
            If iDays <= 0 Then
                MsgBox("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.")
                Stop
                B = False
            ElseIf iDays <= 2 Then
                MsgBox("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            ElseIf iDays <= 7 Then
                MsgBox("NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            ElseIf iDays <= 30 Then
                MsgBox("Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            Else
                B = True
            End If
        End If
        Return B
    End Function
    Private Function DetermineNumberofDays(ByVal ExpireDate As Date) As Integer

        Dim dtStartDate As Date = Now
        Dim tsTimeSpan As TimeSpan
        Dim iNumberOfDays As Integer
        tsTimeSpan = ExpireDate.Subtract(Now)
        iNumberOfDays = tsTimeSpan.Days
        Return iNumberOfDays


    End Function
    '''
    ''' This one validates a bit differently than most.
    ''' When failue, it sends back a string with the failure.
    ''' Otherwise, a null string is returned.
    '''
    Function GetXrt(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String

        Dim LicenseMessage As String = ""
        Dim cbLicenseType As String = ""
        Dim CustomerID = ""
        Dim LicenseID As String = ""
        Dim ExpirationDate As Date
        Dim RemoteServerKey As String = ""
        Dim LT = DB.GetXrt(SecureID, RC, RetMsg)

        Try
            ExpirationDate = CDate(ParseLic(LT, "dtExpire"))
            If Now > ExpirationDate Then
                LicenseMessage$ += "We are very sorry to inform you, but your maintenance agreement has expired." + " Please contact ECM Library support."
                LOG.WriteToSqlLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
                Return LicenseMessage$
            End If
            CustomerID = ParseLic(LT, "txtCustID")
            LicenseID$ = ParseLic(LT, "txtVersionNbr")
            cbLicenseType = Val(ParseLic(cbLicenseType, "cbLicenseType"))
            gLicenseType = cbLicenseType
            Dim CurrentServer$ = DB.getServerInstanceName(SecureID)
            Dim LicensedServer As String = DB.getServerIdentifier(SecureID, CustomerID, LicenseID)
            If LicensedServer.Length = 0 Then
                RemoteServerKey = RS.getClientLicenseServer(SecureID, CustomerID, LicenseID)
                If RemoteServerKey.Trim.Length > 0 And RemoteServerKey.Equals("ECMNEWXX") Then
                    '** It needs to be defined to the remote system and to the new
                    Dim BB As Boolean = DB.setServerIdentifier(SecureID, CurrentServer$, CustomerID, LicenseID)
                    If Not BB Then
                        MsgBox("Error 721.32a - Failed to set the server credentials to that of the specified server '" + CurrentServer$ + "'.")
                        Return False
                    End If
                    BB = RS.setClientLicenseServer(SecureID, CustomerID, LicenseID$, CurrentServer)
                    If Not BB Then
                        MsgBox("Error  721.32b - Failed to set the remote server credentials to that of the specified server '" + CurrentServer$ + "'.")
                        Return False
                    End If
                    Return True
                ElseIf RemoteServerKey.Trim.Length > 0 Then
                    If RemoteServerKey.Equals(CurrentServer) Then
                        '** Add the Server
                        Dim BB As Boolean = DB.setServerIdentifier(SecureID, CurrentServer$, CustomerID, LicenseID)
                        Return True
                    Else
                        '** Issue an error.
                        Return False
                    End If
                End If
            Else
                If CurrentServer$.Equals(LicensedServer) Then
                    gValidated = True
                    Return ""
                Else
                    LicenseMessage$ += "We are very sorry to inform you, but your license could not be validated." + vbCrLf + " Please contact ECM Library support or your administrator."
                    LOG.WriteToSqlLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
                    gValidated = False
                    Return LicenseMessage$
                End If
            End If
        Catch ex As Exception
            LicenseMessage$ = "666.666 Unrecoverable Error 001: Failed to validate license, closing down."
        End Try
        Return LicenseMessage$
    End Function

    Function isLicenseLocatedOnAssignedMachine(ByRef ServerValText As String, ByRef InstanceValText As String, ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

        Dim LT As String = DB.GetXrt(SecureID, RC, RetMsg)
        Dim LicensedMachineName As String = ParseLic(LT, "txtServerName")
        Dim HostServerName As String = DB.getServerMachineName(SecureID)
        Dim B As Boolean = True

        Dim SqlInstanceName As String = ParseLic(LT, "txtSSINstance")
        Dim currSqlInstanceName As String = DB.getServerInstanceName(SecureID)

        If LicensedMachineName.ToUpper.Equals(HostServerName.ToUpper) Then
            ServerValText = ":Server Validated"
        Else
            ServerValText = "WARNING: Server Name"
            B = False
        End If

        If SqlInstanceName.ToUpper.Equals(currSqlInstanceName.ToUpper) Then
            InstanceValText += ":SQL Instance Validated"
        Else
            InstanceValText += "WARNING: SQL Instance Name"
            B = False
        End If
        Return B
    End Function

    Function getMaintExpireDate() As Integer
        Dim NumberOfDaysTillExpire
        Dim B As Boolean = false
        Dim tDate$ = getEncryptedValue("dtMaintExpire", LicList)
        If tDate$.Trim.Length > 0 Then
            Dim ExpireDate As Date = CDate(tDate)
            NumberOfDaysTillExpire = DetermineNumberofDays(ExpireDate)
            'If iDays <= 0 Then
            '    MsgBox("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 2 Then
            '    MsgBox("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 7 Then
            '    MsgBox("NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 30 Then
            '    MsgBox("Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'Else
            '    B = True
            'End If
            Return NumberOfDaysTillExpire
        End If
    End Function

    'Create a new Windows Forms application using your preferred command-line or visual tools.
    'Create whatever button, menu item, or other user interface item you want your users to select to check for updates. 
    'From that item's event handler, call the following AS string to check for and install updates.
    'Public Function isSoftwareUnderMaint() As Boolean

    '    Dim CurrDate As Date = Now
    '    Dim info As UpdateCheckInfo = Nothing
    '    Dim NbrOfMaintDaysLeft As Integer = getMaintExpireDate()

    '    LOG.WriteToSqlLog("Click Once #Days before Maint Expires = " + NbrOfMaintDaysLeft.ToString)

    '    If NbrOfMaintDaysLeft > 1 And NbrOfMaintDaysLeft < 10 Then
    '        MsgBox("Your maintenance will expire within the next 10 days - no further updates after that. Please renew your maintenance subscription.")
    '    End If

    '    If NbrOfMaintDaysLeft < 1 Then
    '        MsgBox("Your maintenance has expired - no further updates after that. Please renew your maintenance subscription.")
    '        Return false
    '    End If

    '    LOG.WriteToSqlLog("Click Once update = " + ApplicationDeployment.IsNetworkDeployed.ToString)

    '    If (ApplicationDeployment.IsNetworkDeployed) Then

    '        Dim AD As ApplicationDeployment = ApplicationDeployment.CurrentDeployment

    '        Try
    '            info = AD.CheckForDetailedUpdate()
    '        Catch dde As DeploymentDownloadException
    '            MessageBox.Show("The new version of the application cannot be downloaded at this time. " + ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later. Error: " + dde.Message)
    '            Return True
    '        Catch ioe As InvalidOperationException
    '            MessageBox.Show("This application cannot be updated. It is likely not a ClickOnce application. Error: " & ioe.Message)
    '            Return True
    '        End Try

    '        If (info.UpdateAvailable) Then
    '            Dim doUpdate As Boolean = True

    '            If (Not info.IsUpdateRequired) Then
    '                Dim dr As DialogResult = MessageBox.Show("An update is available. Would you like to update the application now?", "Update Available", MessageBoxButtons.OKCancel)
    '                If (Not System.Windows.Forms.DialogResult.OK = dr) Then
    '                    doUpdate = false
    '                End If
    '            Else
    '                ' Display a message that the app MUST reboot. Display the minimum required version.
    '                MessageBox.Show("This application has detected a mandatory update from your current " & _
    '                 "version to version " & info.MinimumRequiredVersion.ToString() & _
    '                    ". The application will now install the update and restart.", _
    '                    "Update Available", MessageBoxButtons.OK, MessageBoxIcon.Information)
    '            End If

    '            If (doUpdate) Then
    '                Try
    '                    AD.Update()
    '                    MessageBox.Show("The application has been upgraded, please restart.")
    '                    'Application.Restart()
    '                Catch dde As DeploymentDownloadException
    '                    MessageBox.Show("Cannot install the latest version of the application. " & ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later.")
    '                    Return True
    '                End Try
    '            End If
    '        End If
    '    End If
    'End Function

End Class
