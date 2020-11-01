Imports System.Deployment.Application
Imports ECMEncryption

Public Class clsLicenseMgt
    Inherits clsDatabaseARCH

    Dim ENC As New ECMEncrypt
    Dim localDebug As Boolean = True
    Dim DMA As New clsDma
    'Dim DBARCH As New clsDatabaseARCH

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim RS As New clsRemoteSupport

    Function ParseLic(ByVal S As String, ByVal ShowLicRules As Boolean) As Boolean

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
                '        If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                '    Catch ex As Exception
                '        Console.WriteLine(ex.Message)
                '    End Try
                'Next I
                Dim cbLicenseType As String = getEncryptedValue("cbLicenseType", LicList)
                Dim cbState As String = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard As String = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail As String = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile As String = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire As String = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire As String = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense As String = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats As String = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers As String = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers As String = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense As String = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity As String = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID As String = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail As String = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName As String = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone As String = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr As String = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry As String = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID As String = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName As String = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate As String = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats As String = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats As String = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr As String = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip As String = getEncryptedValue("txtZip", LicList)
                Dim Sdk As String = getEncryptedValue("ckSdk", LicList)
                If Sdk.Length = 0 Then
                    Sdk = "False"
                End If
                Dim Lease As String = getEncryptedValue("ckLease", LicList)
                If Lease.Length = 0 Then
                    Lease = "False"
                End If

                Dim MaxClients As String = getEncryptedValue("txtMaxClients", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""
                    Msg = Msg + "License Type:" + cbLicenseType + vbCrLf
                    Msg = Msg + "State: " + cbState + vbCrLf
                    'Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                    'Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                    'Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                    Msg = Msg + "City: " + txtCity + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate + vbCrLf
                    'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr + vbCrLf
                    Msg = Msg + "Type License: " + cbLicenseType + vbCrLf
                    Msg = Msg + "SDK: " + Sdk + vbCrLf
                    Msg = Msg + "Lease: " + Lease + vbCrLf
                    If MaxClients.Equals("0") Then
                        MaxClients = "Unlimited"
                    End If
                    Msg = Msg + "MaxClients: " + MaxClients + vbCrLf
                    'MaxClients
                    MessageBox.Show(Msg)
                End If

            End If
        Catch ex As Exception
            MessageBox.Show("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
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
                '        If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                '    Catch ex As Exception
                '        Console.WriteLine(ex.Message)
                '    End Try
                'Next I
                Dim cbState As String = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard As String = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail As String = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile As String = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire As String = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire As String = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense As String = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats As String = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers As String = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers As String = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense As String = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity As String = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID As String = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail As String = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName As String = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone As String = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr As String = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry As String = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID As String = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName As String = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate As String = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats As String = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats As String = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr As String = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip As String = getEncryptedValue("txtZip", LicList)
                Dim cbLicenseType As String = getEncryptedValue("cbLicenseType", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""

                    Msg = Msg + "State: " + cbState + vbCrLf
                    'Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                    'Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                    'Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                    Msg = Msg + "City: " + txtCity + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate + vbCrLf
                    'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr + vbCrLf
                    'Msg = Msg + "Zip: " + txtZip  + vbCrLf
                    CoName = txtCustName
                End If

            End If
        Catch ex As Exception
            MessageBox.Show("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            CoName = ""
            LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return CoName
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
                'For I = 0 To LicList.Count - 1
                '    Try
                '        If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                '    Catch ex As Exception
                '        Console.WriteLine(ex.Message)
                '    End Try
                'Next I
                Dim cbState As String = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard As String = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail As String = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile As String = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire As String = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire As String = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense As String = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats As String = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers As String = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers As String = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense As String = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity As String = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID As String = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail As String = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName As String = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone As String = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr As String = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry As String = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID As String = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName As String = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate As String = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats As String = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats As String = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr As String = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip As String = getEncryptedValue("txtZip", LicList)
                Dim cbLicenseType As String = getEncryptedValue("cbLicenseType", LicList)

                If ShowLicRules = True Then
                    Dim Msg As String = ""

                    Msg = Msg + "State: " + cbState + vbCrLf
                    'Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                    'Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                    'Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                    Msg = Msg + "City: " + txtCity + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate + vbCrLf
                    'Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr + vbCrLf
                    'Msg = Msg + "Zip: " + txtZip  + vbCrLf
                    CustID = txtCustID
                End If

            End If
        Catch ex As Exception
            MessageBox.Show("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            CustID = ""
            LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message)
        End Try
        Return CustID
    End Function

    Function LicenseType() As String
        Dim tKey As String = "cbLicenseType"
        Dim S As String = GetXrt(gCustomerName, gCustomerID)
        Dim tVal As String = ""
        'Dim I As Integer = 0
        Try
            LicList = ENC.xt001trc(S)
            tVal = getEncryptedValue(tKey, LicList)
            If tVal.ToUpper.Equals("ENTERPRISE") Then
                tVal = "Roaming"
            End If
        Catch ex As Exception
            MessageBox.Show("Error 53.25.1b: - LicenseType - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("clsLicenseMgt : LicenseType : 24 : " + ex.Message)
        End Try
        Return tVal
    End Function

    Function SdkLicenseExists() As Boolean
        Dim B As Boolean = False
        Dim tKey As String = "ckSdk"
        Dim S As String = GetXrt(gCustomerName, gCustomerID)
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
            MessageBox.Show("Error 53.25.21a: SdkLicenseExists - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToArchiveLog("clsLicenseMgt : SdkLicenseExists : 24 : " + ex.Message)
        End Try
        Return B
    End Function

    Function isLease() As Boolean
        Dim B As Boolean = False
        Dim dDebug As Integer = 1
        Dim tKey As String = "ckLease"
        Dim S As String = GetXrt(gCustomerName, gCustomerID, dDebug)
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim xTrv1 As Boolean = True
        Dim ix As Integer = 0
        Try
            ix = 1
            LicList = ENC.xt001trc(S, 1)
            ix = 2
            B = True
            ix = 3
            tVal = getEncryptedValue(tKey, LicList, dDebug)
            ix = 14
            If tVal.Length = 0 Then
                ix = 5
                B = True
            ElseIf tVal.ToUpper.Equals("TRUE") Then
                ix = 6
                B = True
            Else
                ix = 7
                B = False
            End If
            ix = 8
        Catch ex As Exception
            MessageBox.Show("Error 53.25.11a: isLease - failed to Parse License.  IX=" + ix.ToString + vbCrLf + vbCrLf + ex.Message + vbCrLf + "Customer Name: " + gCustomerName + vbCrLf + "Customer ID: " + gCustomerID + vbCrLf + "Step# " + ix.ToString)
            B = False
            LOG.WriteToTraceLog("clsLicenseMgt : isLease : 24  IX = " + ix.ToString + vbCrLf + ex.Message)
        End Try
        Return B
    End Function

    Public Function getMaxClients() As Integer
        Dim tKey As String = "txtMaxClients"
        Dim S As String = GetXrt(gCustomerName, gCustomerID)
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
            MessageBox.Show("Error 53.25.01a: isLease - failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
            I = 0
            LOG.WriteToArchiveLog("clsLicenseMgt : isLease : 24 : " + ex.Message)
        End Try
        Return I
    End Function

    Function ParseLic(ByVal S As String, ByVal tKey As String) As String
        Dim ll As Integer = 0
        Dim tVal As String = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Dim dDebug As Integer = 1
        Try
            ll = 1
            LicList = ENC.xt001trc(S)
            ll = 2
            B = True
            ll = 3
            tVal = getEncryptedValue(tKey, LicList, dDebug)
            ll = 4
        Catch ex As Exception
            MessageBox.Show("Error 53.25.1: failed to Parse License. LL=" + ll.ToString + vbCrLf + vbCrLf + ex.Message)
            B = False
            LOG.WriteToTraceLog("clsLicenseMgt : ParseLic : 24 : LL=" + ll.ToString + vbCrLf + ex.Message)
        End Try
        Return tVal
    End Function

    Public Function getEncryptedValue(ByVal iKey As String, ByVal A As SortedList(Of String, String), Optional dDebug As Integer = 0) As String
        Dim tVal As String = ""
        Dim iDx As Integer = A.IndexOfKey(iKey)
        Dim ll As Integer = 0
        Try
            If iDx >= 0 Then
                ll = 1
                tVal = A.Values(iDx).ToString
            Else
                ll = 2
                tVal = ""
            End If
        Catch ex As Exception
            LOG.WriteToTraceLog("getEncryptedValue 20: " + "LL=" + ll.ToString + vbCrLf + ex.Message)
        End Try


        Return tVal
    End Function

    Function ckExpirationDate() As Boolean
        Dim B As Boolean = False
        Dim tDate As String = getEncryptedValue("dtExpire", LicList)
        If tDate.Trim.Length > 0 Then
            Dim ExpireDate As Date = CDate(getEncryptedValue("dtExpire", LicList))
            Dim iDays As Integer = DetermineNumberofDays(ExpireDate)
            If iDays <= 0 Then
                MessageBox.Show("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.")
                Stop
                B = False
            ElseIf iDays <= 2 Then
                MessageBox.Show("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            ElseIf iDays <= 7 Then
                MessageBox.Show("NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            ElseIf iDays <= 30 Then
                MessageBox.Show("Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                B = True
            Else
                B = True
            End If
            Return True
        End If
    End Function

    Private Function DetermineNumberofDays(ByVal ExpireDate As Date) As Integer

        Dim dtStartDate As Date = Now
        Dim tsTimeSpan As TimeSpan
        Dim iNumberOfDays As Integer
        tsTimeSpan = ExpireDate.Subtract(Now)
        iNumberOfDays = tsTimeSpan.Days
        Return iNumberOfDays

    End Function

    ''' This one validates a bit differently than most. When failue, it sends back a string with the
    ''' failure. Otherwise, a null string is returned.
    Function ValidateLicense() As String

        Dim LicenseMessage As String = ""
        Dim cbLicenseType As String = ""
        Dim CustomerID As String = ""
        Dim LicenseID As String = ""
        Dim ExpirationDate As Date
        Dim RemoteServerKey As String = ""
        Dim LT = GetXrt(gCustomerName, gCustomerID)

        Try
            ExpirationDate = CDate(ParseLic(LT, "dtExpire"))
            If Now > ExpirationDate Then
                LicenseMessage += "We are very sorry to inform you, but your maintenance agreement has expired." + " Please contact ECM Library support."
                LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
                Return LicenseMessage
            End If
            CustomerID = ParseLic(LT, "txtCustID")
            LicenseID = ParseLic(LT, "txtVersionNbr")
            cbLicenseType = Val(ParseLic(cbLicenseType, "cbLicenseType"))
            gLicenseType = cbLicenseType
            Dim CurrentServer As String = getServerInstanceName()
            Dim LicensedServer As String = getServerIdentifier(CustomerID, LicenseID)
            If LicensedServer.Length = 0 Then
                RemoteServerKey = RS.getClientLicenseServer(CustomerID, LicenseID)
                If RemoteServerKey.Trim.Length > 0 And RemoteServerKey.Equals("ECMNEWXX") Then
                    '** It needs to be defined to the remote system and to the new
                    Dim BB As Boolean = setServerIdentifier(CurrentServer, CustomerID, LicenseID)
                    If Not BB Then
                        MessageBox.Show("Error 721.32a - Failed to set the server credentials to that of the specified server '" + CurrentServer + "'.")
                        Return False
                    End If
                    BB = RS.setClientLicenseServer(CustomerID, LicenseID, CurrentServer)
                    If Not BB Then
                        MessageBox.Show("Error  721.32b - Failed to set the remote server credentials to that of the specified server '" + CurrentServer + "'.")
                        Return False
                    End If
                    Return True
                ElseIf RemoteServerKey.Trim.Length > 0 Then
                    If RemoteServerKey.Equals(CurrentServer) Then
                        '** Add the Server
                        Dim BB As Boolean = setServerIdentifier(CurrentServer, CustomerID, LicenseID)
                        Return True
                    Else
                        '** Issue an error.
                        Return False
                    End If
                End If
            Else
                If CurrentServer.Equals(LicensedServer) Then
                    gValidated = True
                    Return ""
                Else
                    LicenseMessage += "We are very sorry to inform you, but your license could not be validated." + vbCrLf + " Please contact ECM Library support or your administrator."
                    LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
                    gValidated = False
                    Return LicenseMessage
                End If
            End If
        Catch ex As Exception
            LicenseMessage = "666.666 Unrecoverable Error 001: Failed to validate license, closing down."
        End Try
        Return LicenseMessage
    End Function

    Function isLicenseLocatedOnAssignedMachine(ByRef ServerValText As String, ByRef InstanceValText As String) As Boolean

        Dim LT As String = GetXrt(gCustomerName, gCustomerID)
        Dim LicensedMachineName As String = ParseLic(LT, "txtServerName")
        Dim HostServerName As String = getServerMachineName()
        Dim B As Boolean = True

        Dim SqlInstanceName As String = ParseLic(LT, "txtSSINstance")
        Dim currSqlInstanceName As String = getServerInstanceName()

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
        Dim B As Boolean = False
        Dim tDate As String = getEncryptedValue("dtMaintExpire", LicList)
        If tDate.Trim.Length > 0 Then
            Dim ExpireDate As Date = CDate(tDate)
            NumberOfDaysTillExpire = DetermineNumberofDays(ExpireDate)
            'If iDays <= 0 Then
            '    messagebox.show("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 2 Then
            '    messagebox.show("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 7 Then
            '    messagebox.show("NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'ElseIf iDays <= 30 Then
            '    messagebox.show("Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
            'Else
            '    B = True
            'End If
            Return NumberOfDaysTillExpire
        End If
    End Function

    'Create a new Windows Forms application using your preferred command-line or visual tools.
    'Create whatever button, menu item, or other user interface item you want your users to select to check for updates.
    'From that item's event handler, call the following method to check for and install updates.
    Public Function isSoftwareUnderMaint() As Boolean

        Dim CurrDate As Date = Now
        Dim info As UpdateCheckInfo = Nothing
        Dim NbrOfMaintDaysLeft As Integer = getMaintExpireDate()

        LOG.WriteToArchiveLog("Click Once #Days before Maint Expires = " + NbrOfMaintDaysLeft.ToString)

        If NbrOfMaintDaysLeft > 1 And NbrOfMaintDaysLeft < 10 Then
            MessageBox.Show("Your maintenance will expire within the next 10 days - no further updates after that. Please renew your maintenance subscription.")
        End If

        If NbrOfMaintDaysLeft < 1 Then
            MessageBox.Show("Your maintenance has expired - no further updates after that. Please renew your maintenance subscription.")
            Return False
        End If

        LOG.WriteToArchiveLog("Click Once update = " + ApplicationDeployment.IsNetworkDeployed.ToString)

        If (ApplicationDeployment.IsNetworkDeployed) Then

            Dim AD As ApplicationDeployment = ApplicationDeployment.CurrentDeployment

            Try
                info = AD.CheckForDetailedUpdate()
            Catch dde As DeploymentDownloadException
                MessageBox.Show("The new version of the application cannot be downloaded at this time. " + ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later. Error: " + dde.Message)
                Return True
            Catch ioe As InvalidOperationException
                MessageBox.Show("This application cannot be updated. It is likely not a ClickOnce application. Error: " & ioe.Message)
                Return True
            End Try

            If (info.UpdateAvailable) Then
                Dim doUpdate As Boolean = True

                If (Not info.IsUpdateRequired) Then
                    Dim dr As DialogResult = MessageBox.Show("An update is available. Would you like to update the application now?", "Update Available", MessageBoxButtons.OKCancel)
                    If (Not System.Windows.Forms.DialogResult.OK = dr) Then
                        doUpdate = False
                    End If
                Else
                    ' Display a message that the app MUST reboot. Display the minimum required version.
                    MessageBox.Show("This application has detected a mandatory update from your current " &
                     "version to version " & info.MinimumRequiredVersion.ToString() &
                        ". The application will now install the update and restart.",
                        "Update Available", MessageBoxButtons.OK, MessageBoxIcon.Information)
                End If

                If (doUpdate) Then
                    Try
                        AD.Update()
                        MessageBox.Show("The application has been upgraded, please restart.")
                        'Application.Restart()
                    Catch dde As DeploymentDownloadException
                        MessageBox.Show("Cannot install the latest version of the application. " & ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later.")
                        Return True
                    End Try
                End If
            End If
        End If
    End Function

End Class