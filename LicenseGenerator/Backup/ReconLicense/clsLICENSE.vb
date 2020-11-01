Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsLICENSE

    '** DIM the selected table columns 
    Dim DB As New clsDatabase
    Dim DMA As New clsDma
    '    Dim DG As New clsDataGrid

    Dim CustomerName As String = ""
    Dim CustomerID As String = ""
    Dim LicenseExpireDate As String = ""
    Dim NbrSeats As String = ""
    Dim NbrSimlUsers As String = ""
    Dim CompanyResetID As String = ""
    Dim MasterPW As String = ""
    Dim LicenseGenDate As String = ""
    Dim License As String = ""
    Dim LicenseID As String = ""
    Dim ContactName As String = ""
    Dim ContactEmail As String = ""
    Dim ContactPhoneNbr As String = ""
    Dim CompanyStreetAddress As String = ""
    Dim CompanyCity As String = ""
    Dim CompanyState As String = ""
    Dim CompanyZip As String = ""
    Dim MaintExpireDate As String = ""
    Dim CompanyCountry As String = ""
    Dim LicenseTypeCode As String = ""
    Dim ckSdk As Integer = 0
    Dim ckLease As Integer = 0
    Dim MaxClients As Integer = 0
    Dim SharePointNbr As Integer = 0

    '** Generate the SET methods 
    Public Sub setSharePointNbr(ByRef tVal$)
        tVal = DMA.RemoveSingleQuotes(tVal)
        SharePointNbr = Val(tVal)
    End Sub
    Public Sub setMaxClients(ByRef tVal$)
        tVal = DMA.RemoveSingleQuotes(tVal)
        MaxClients = Val(tVal)
    End Sub
    Public Sub setLease(ByRef tVal$)
        tVal = DMA.RemoveSingleQuotes(tVal)
        If tVal.ToUpper.Equals("TRUE") Then
            ckLease = 1
        Else
            ckLease = 0
        End If
    End Sub
    Public Sub setSdk(ByRef tVal$)
        tVal = DMA.RemoveSingleQuotes(tVal)
        If tVal.ToUpper.Equals("TRUE") Then
            ckSdk = 1
        Else
            ckSdk = 0
        End If
    End Sub

    Public Sub setCustomername(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Customername' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        CustomerName = val
    End Sub

    Public Sub setCustomerid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Customerid' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        CustomerID = val
    End Sub
    Public Sub setLicenseTypeCode(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Customerid' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        LicenseTypeCode = val
    End Sub

    Public Sub setLicenseexpiredate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        LicenseExpireDate = val
    End Sub

    Public Sub setNbrseats(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        NbrSeats = val
    End Sub

    Public Sub setNbrsimlusers(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        NbrSimlUsers = val
    End Sub

    Public Sub setCompanyresetid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Companyresetid' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        CompanyResetID = val
    End Sub

    Public Sub setMasterpw(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Masterpw' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        MasterPW = val
    End Sub

    Public Sub setLicensegendate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        LicenseGenDate = val
    End Sub

    Public Sub setLicense(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'License' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        License = val
    End Sub

    Public Sub setLicenseid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Licenseid' cannot be NULL.")
            Return
        End If
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        LicenseID = val
    End Sub

    Public Sub setContactname(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        ContactName = val
    End Sub

    Public Sub setContactemail(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        ContactEmail = val
    End Sub

    Public Sub setContactphonenbr(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        ContactPhoneNbr = val
    End Sub

    Public Sub setCompanystreetaddress(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        CompanyStreetAddress = val
    End Sub

    Public Sub setCompanycity(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        CompanyCity = val
    End Sub

    Public Sub setCompanystate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        CompanyState = val
    End Sub

    Public Sub setCompanyzip(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        CompanyZip = val
    End Sub

    Public Sub setMaintexpiredate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        MaintExpireDate = val
    End Sub

    Public Sub setCompanycountry(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        CompanyCountry = val
    End Sub

    '** Generate the GET methods 
    Public Function getLicenseTypeCode() As String
        If Len(LicenseTypeCode) = 0 Then
            MsgBox("GET: Field 'LicenseTypeCode' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(LicenseTypeCode)
    End Function
    Public Function getCustomername() As String
        If Len(CustomerName) = 0 Then
            MsgBox("GET: Field 'Customername' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(CustomerName)
    End Function

    Public Function getCustomerid() As String
        If Len(CustomerID) = 0 Then
            MsgBox("GET: Field 'Customerid' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(CustomerID)
    End Function

    Public Function getLicenseexpiredate() As String
        Return DMA.RemoveSingleQuotes(LicenseExpireDate)
    End Function

    Public Function getNbrseats() As String
        If Len(NbrSeats) = 0 Then
            NbrSeats = "null"
        End If
        Return NbrSeats
    End Function

    Public Function getNbrsimlusers() As String
        If Len(NbrSimlUsers) = 0 Then
            NbrSimlUsers = "null"
        End If
        Return NbrSimlUsers
    End Function

    Public Function getCompanyresetid() As String
        If Len(CompanyResetID) = 0 Then
            MsgBox("GET: Field 'Companyresetid' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(CompanyResetID)
    End Function

    Public Function getMasterpw() As String
        If Len(MasterPW) = 0 Then
            MsgBox("GET: Field 'Masterpw' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(MasterPW)
    End Function

    Public Function getLicensegendate() As String
        Return DMA.RemoveSingleQuotes(LicenseGenDate)
    End Function

    Public Function getLicense() As String
        If Len(License) = 0 Then
            MsgBox("GET: Field 'License' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(License)
    End Function

    Public Function getLicenseid() As String
        If Len(LicenseID) = 0 Then
            MsgBox("GET: Field 'Licenseid' cannot be NULL.")
            Return ""
        End If
        If Len(LicenseID) = 0 Then
            LicenseID = "null"
        End If
        Return LicenseID
    End Function

    Public Function getContactname() As String
        Return DMA.RemoveSingleQuotes(ContactName)
    End Function

    Public Function getContactemail() As String
        Return DMA.RemoveSingleQuotes(ContactEmail)
    End Function

    Public Function getContactphonenbr() As String
        Return DMA.RemoveSingleQuotes(ContactPhoneNbr)
    End Function

    Public Function getCompanystreetaddress() As String
        Return DMA.RemoveSingleQuotes(CompanyStreetAddress)
    End Function

    Public Function getCompanycity() As String
        Return DMA.RemoveSingleQuotes(CompanyCity)
    End Function

    Public Function getCompanystate() As String
        Return DMA.RemoveSingleQuotes(CompanyState)
    End Function

    Public Function getCompanyzip() As String
        Return DMA.RemoveSingleQuotes(CompanyZip)
    End Function

    Public Function getMaintexpiredate() As String
        Return DMA.RemoveSingleQuotes(MaintExpireDate)
    End Function

    Public Function getCompanycountry() As String
        Return DMA.RemoveSingleQuotes(CompanyCountry)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If CustomerName.Length = 0 Then Return False
        If CustomerID.Length = 0 Then Return False
        If CompanyResetID.Length = 0 Then Return False
        If MasterPW.Length = 0 Then Return False
        If License.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If CustomerName.Length = 0 Then Return False
        If CustomerID.Length = 0 Then Return False
        If CompanyResetID.Length = 0 Then Return False
        If MasterPW.Length = 0 Then Return False
        If License.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert(ByVal ServerName As String, ByVal SqlInstanceName As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO License("
        s = s + "CustomerName,"
        s = s + "CustomerID,"
        s = s + "LicenseExpireDate,"
        s = s + "NbrSeats,"
        s = s + "NbrSimlUsers,"
        s = s + "CompanyResetID,"
        s = s + "MasterPW,"
        s = s + "LicenseGenDate,"
        s = s + "License,"
        s = s + "LicenseID,"
        s = s + "ContactName,"
        s = s + "ContactEmail,"
        s = s + "ContactPhoneNbr,"
        s = s + "CompanyStreetAddress,"
        s = s + "CompanyCity,"
        s = s + "CompanyState,"
        s = s + "CompanyZip,"
        s = s + "MaintExpireDate,"
        s = s + "CompanyCountry, LicenseTypeCode, ckSdk, MaxClients, ServerName, SqlInstanceName) values ("
        s = s + "'" + CustomerName + "'" + ","
        s = s + "'" + CustomerID + "'" + ","
        s = s + "'" + CDate(LicenseExpireDate).ToString + "'" + ","
        s = s + NbrSeats + ","
        s = s + NbrSimlUsers + ","
        s = s + "'" + CompanyResetID + "'" + ","
        s = s + "'" + MasterPW + "'" + ","
        s = s + "'" + CDate(LicenseGenDate).ToString + "'" + ","
        s = s + "'" + License + "'" + ","
        s = s + LicenseID + ","
        s = s + "'" + ContactName + "'" + ","
        s = s + "'" + ContactEmail + "'" + ","
        s = s + "'" + ContactPhoneNbr + "'" + ","
        s = s + "'" + CompanyStreetAddress + "'" + ","
        s = s + "'" + CompanyCity + "'" + ","
        s = s + "'" + CompanyState + "'" + ","
        s = s + "'" + CompanyZip + "'" + ","
        s = s + "'" + CDate(MaintExpireDate).ToString + "'" + ","
        s = s + "'" + CompanyCountry + "'" + ","
        s = s + "'" + LicenseTypeCode + "',"
        s = s + ckSdk.ToString + ","
        s = s + MaxClients.ToString + ","
        s = s + "'" + ServerName + "',"
        s = s + "'" + SqlInstanceName + "')"
        Return DB.ExecuteSql(s)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause$, ByVal ServerName As String, ByVal SqlInstanceName As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update License set "
        s = s + "CustomerName = '" + getCustomername() + "'" + ", "
        s = s + "CustomerID = '" + getCustomerid() + "'" + ", "
        s = s + "LicenseExpireDate = '" + getLicenseexpiredate() + "'" + ", "
        s = s + "NbrSeats = " + getNbrseats() + ", "
        s = s + "NbrSimlUsers = " + getNbrsimlusers() + ", "
        s = s + "CompanyResetID = '" + getCompanyresetid() + "'" + ", "
        s = s + "MasterPW = '" + getMasterpw() + "'" + ", "
        s = s + "LicenseGenDate = '" + getLicensegendate() + "'" + ", "
        s = s + "License = '" + getLicense() + "'" + ", "
        s = s + "LicenseID = " + getLicenseid() + ", "
        s = s + "ContactName = '" + getContactname() + "'" + ", "
        s = s + "ContactEmail = '" + getContactemail() + "'" + ", "
        s = s + "ContactPhoneNbr = '" + getContactphonenbr() + "'" + ", "
        s = s + "CompanyStreetAddress = '" + getCompanystreetaddress() + "'" + ", "
        s = s + "CompanyCity = '" + getCompanycity() + "'" + ", "
        s = s + "CompanyState = '" + getCompanystate() + "'" + ", "
        s = s + "CompanyZip = '" + getCompanyzip() + "'" + ", "
        s = s + "MaintExpireDate = '" + getMaintexpiredate() + "'" + ", "
        s = s + "CompanyCountry = '" + getCompanycountry() + "',"
        s = s + "LicenseTypeCode = '" + getLicenseTypeCode() + "', "
        s = s + "ckSdk = " + ckSdk.ToString + ", "
        s = s + "ckLease = " + ckLease.ToString + ", "
        s = s + "MaxClients = " + MaxClients.ToString + ", "
        s = s + "ServerName = '" + ServerName + "', "
        s = s + "SqlInstanceName = '" + SqlInstanceName + "' "
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.ExecuteSql(s)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "CustomerName,"
        s = s + "CustomerID,"
        s = s + "LicenseExpireDate,"
        s = s + "NbrSeats,"
        s = s + "NbrSimlUsers,"
        s = s + "CompanyResetID,"
        s = s + "MasterPW,"
        s = s + "LicenseGenDate,"
        s = s + "License,"
        s = s + "LicenseID,"
        s = s + "ContactName,"
        s = s + "ContactEmail,"
        s = s + "ContactPhoneNbr,"
        s = s + "CompanyStreetAddress,"
        s = s + "CompanyCity,"
        s = s + "CompanyState,"
        s = s + "CompanyZip,"
        s = s + "MaintExpireDate,"
        s = s + "CompanyCountry,LicenseTypeCode "
        s = s + " FROM License"
        '** s=s+ "ORDERBY xxxx"
        rsData = DB.SqlQry(s)
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause$) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "CustomerName,"
        s = s + "CustomerID,"
        s = s + "LicenseExpireDate,"
        s = s + "NbrSeats,"
        s = s + "NbrSimlUsers,"
        s = s + "CompanyResetID,"
        s = s + "MasterPW,"
        s = s + "LicenseGenDate,"
        s = s + "License,"
        s = s + "LicenseID,"
        s = s + "ContactName,"
        s = s + "ContactEmail,"
        s = s + "ContactPhoneNbr,"
        s = s + "CompanyStreetAddress,"
        s = s + "CompanyCity,"
        s = s + "CompanyState,"
        s = s + "CompanyZip,"
        s = s + "MaintExpireDate,"
        s = s + "CompanyCountry,LicenseTypeCode "
        s = s + " FROM License"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        rsData = DB.SqlQry(s)
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from License"
        s = s + WhereClause

        b = DB.ExecuteSql(s)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from License"

        b = DB.ExecuteSql(s)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PI01License_CustName(ByVal CustomerName As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerName = '" + CustomerName + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PI01License_CustName
    Public Function cnt_PI02_LicenseCustID(ByVal CustomerID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerID = '" + CustomerID + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PI02_LicenseCustID
    Public Function cnt_PK_License(ByVal CustomerID As String, ByVal LicenseID As Integer) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerID = '" + CustomerID + "' and   LicenseID = " & LicenseID

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK_License

    '** Generate Index ROW Queries 
    Public Function getRow_PI01License_CustName(ByVal CustomerName As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerName = '" + CustomerName + "'"

        rsData = DB.GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI01License_CustName
    Public Function getRow_PI02_LicenseCustID(ByVal CustomerID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerID = '" + CustomerID + "'"

        rsData = DB.GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI02_LicenseCustID
    Public Function getRow_PK_License(ByVal CustomerID As String, ByVal LicenseID As Integer) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC$ = "Where CustomerID = '" + CustomerID + "' and   LicenseID = " & LicenseID

        rsData = DB.GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_License

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI01License_CustName(ByVal CustomerName As String) As String

        Dim WC$ = "Where CustomerName = '" + CustomerName + "'"

        Return WC
    End Function     '** wc_PI01License_CustName
    Public Function wc_PI02_LicenseCustID(ByVal CustomerID As String) As String

        Dim WC$ = "Where CustomerID = '" + CustomerID + "'"

        Return WC
    End Function     '** wc_PI02_LicenseCustID
    Public Function wc_PK_License(ByVal CustomerID As String, ByVal LicenseID As Integer) As String

        Dim WC$ = "Where CustomerID = '" + CustomerID + "' and   LicenseID = " & LicenseID

        Return WC
    End Function     '** wc_PK_License

    '** Generate the SET methods 

End Class
