Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsCONTACTSARCHIVE

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim Email1Address As String = ""
    Dim FullName As String = ""
    Dim UserID As String = ""
    Dim Account As String = ""
    Dim Anniversary As String = ""
    Dim Application As String = ""
    Dim AssistantName As String = ""
    Dim AssistantTelephoneNumber As String = ""
    Dim BillingInformation As String = ""
    Dim Birthday As String = ""
    Dim Business2TelephoneNumber As String = ""
    Dim BusinessAddress As String = ""
    Dim BusinessAddressCity As String = ""
    Dim BusinessAddressCountry As String = ""
    Dim BusinessAddressPostalCode As String = ""
    Dim BusinessAddressPostOfficeBox As String = ""
    Dim BusinessAddressState As String = ""
    Dim BusinessAddressStreet As String = ""
    Dim BusinessCardType As String = ""
    Dim BusinessFaxNumber As String = ""
    Dim BusinessHomePage As String = ""
    Dim BusinessTelephoneNumber As String = ""
    Dim CallbackTelephoneNumber As String = ""
    Dim CarTelephoneNumber As String = ""
    Dim Categories As String = ""
    Dim Children As String = ""
    Dim xClass As String = ""
    Dim Companies As String = ""
    Dim CompanyName As String = ""
    Dim ComputerNetworkName As String = ""
    Dim Conflicts As String = ""
    Dim ConversationTopic As String = ""
    Dim CreationTime As String = ""
    Dim CustomerID As String = ""
    Dim Department As String = ""
    Dim Email1AddressType As String = ""
    Dim Email1DisplayName As String = ""
    Dim Email1EntryID As String = ""
    Dim Email2Address As String = ""
    Dim Email2AddressType As String = ""
    Dim Email2DisplayName As String = ""
    Dim Email2EntryID As String = ""
    Dim Email3Address As String = ""
    Dim Email3AddressType As String = ""
    Dim Email3DisplayName As String = ""
    Dim Email3EntryID As String = ""
    Dim FileAs As String = ""
    Dim FirstName As String = ""
    Dim FTPSite As String = ""
    Dim Gender As String = ""
    Dim GovernmentIDNumber As String = ""
    Dim Hobby As String = ""
    Dim Home2TelephoneNumber As String = ""
    Dim HomeAddress As String = ""
    Dim HomeAddressCountry As String = ""
    Dim HomeAddressPostalCode As String = ""
    Dim HomeAddressPostOfficeBox As String = ""
    Dim HomeAddressState As String = ""
    Dim HomeAddressStreet As String = ""
    Dim HomeFaxNumber As String = ""
    Dim HomeTelephoneNumber As String = ""
    Dim IMAddress As String = ""
    Dim Importance As String = ""
    Dim Initials As String = ""
    Dim InternetFreeBusyAddress As String = ""
    Dim JobTitle As String = ""
    Dim Journal As String = ""
    Dim Language As String = ""
    Dim LastModificationTime As String = ""
    Dim LastName As String = ""
    Dim LastNameAndFirstName As String = ""
    Dim MailingAddress As String = ""
    Dim MailingAddressCity As String = ""
    Dim MailingAddressCountry As String = ""
    Dim MailingAddressPostalCode As String = ""
    Dim MailingAddressPostOfficeBox As String = ""
    Dim MailingAddressState As String = ""
    Dim MailingAddressStreet As String = ""
    Dim ManagerName As String = ""
    Dim MiddleName As String = ""
    Dim Mileage As String = ""
    Dim MobileTelephoneNumber As String = ""
    Dim NetMeetingAlias As String = ""
    Dim NetMeetingServer As String = ""
    Dim NickName As String = ""
    Dim Title As String = ""
    Dim Body As String = ""
    Dim OfficeLocation As String = ""
    Dim Subject As String = ""


    '** Generate the SET methods 
    Public Sub setEmail1address(ByVal val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Email1address' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Email1Address = val
    End Sub

    Public Sub setFullname(ByVal val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Fullname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FullName = val
    End Sub

    Public Sub setUserid(ByVal val As String)
        If Len(val) = 0 Then
            val = gCurrLoginID
            'messagebox.show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setAccount(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Account = val
    End Sub

    Public Sub setAnniversary(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Anniversary = val
    End Sub

    Public Sub setApplication(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Application = val
    End Sub

    Public Sub setAssistantname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AssistantName = val
    End Sub

    Public Sub setAssistanttelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AssistantTelephoneNumber = val
    End Sub

    Public Sub setBillinginformation(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BillingInformation = val
    End Sub

    Public Sub setBirthday(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Birthday = val
    End Sub

    Public Sub setBusiness2telephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Business2TelephoneNumber = val
    End Sub

    Public Sub setBusinessaddress(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddress = val
    End Sub

    Public Sub setBusinessaddresscity(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressCity = val
    End Sub

    Public Sub setBusinessaddresscountry(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressCountry = val
    End Sub

    Public Sub setBusinessaddresspostalcode(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressPostalCode = val
    End Sub

    Public Sub setBusinessaddresspostofficebox(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressPostOfficeBox = val
    End Sub

    Public Sub setBusinessaddressstate(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressState = val
    End Sub

    Public Sub setBusinessaddressstreet(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessAddressStreet = val
    End Sub

    Public Sub setBusinesscardtype(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessCardType = val
    End Sub

    Public Sub setBusinessfaxnumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessFaxNumber = val
    End Sub

    Public Sub setBusinesshomepage(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessHomePage = val
    End Sub

    Public Sub setBusinesstelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        BusinessTelephoneNumber = val
    End Sub

    Public Sub setCallbacktelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CallbackTelephoneNumber = val
    End Sub

    Public Sub setCartelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CarTelephoneNumber = val
    End Sub

    Public Sub setCategories(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Categories = val
    End Sub

    Public Sub setChildren(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Children = val
    End Sub

    Public Sub setXclass(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        xClass = val
    End Sub

    Public Sub setCompanies(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Companies = val
    End Sub

    Public Sub setCompanyname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CompanyName = val
    End Sub

    Public Sub setComputernetworkname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ComputerNetworkName = val
    End Sub

    Public Sub setConflicts(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Conflicts = val
    End Sub

    Public Sub setConversationtopic(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ConversationTopic = val
    End Sub

    Public Sub setCreationtime(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreationTime = val
    End Sub

    Public Sub setCustomerid(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CustomerID = val
    End Sub

    Public Sub setDepartment(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Department = val
    End Sub

    Public Sub setEmail1addresstype(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email1AddressType = val
    End Sub

    Public Sub setEmail1displayname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email1DisplayName = val
    End Sub

    Public Sub setEmail1entryid(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email1EntryID = val
    End Sub

    Public Sub setEmail2address(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email2Address = val
    End Sub

    Public Sub setEmail2addresstype(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email2AddressType = val
    End Sub

    Public Sub setEmail2displayname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email2DisplayName = val
    End Sub

    Public Sub setEmail2entryid(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email2EntryID = val
    End Sub

    Public Sub setEmail3address(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email3Address = val
    End Sub

    Public Sub setEmail3addresstype(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email3AddressType = val
    End Sub

    Public Sub setEmail3displayname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email3DisplayName = val
    End Sub

    Public Sub setEmail3entryid(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Email3EntryID = val
    End Sub

    Public Sub setFileas(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FileAs = val
    End Sub

    Public Sub setFirstname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FirstName = val
    End Sub

    Public Sub setFtpsite(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FTPSite = val
    End Sub

    Public Sub setGender(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Gender = val
    End Sub

    Public Sub setGovernmentidnumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        GovernmentIDNumber = val
    End Sub

    Public Sub setHobby(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Hobby = val
    End Sub

    Public Sub setHome2telephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Home2TelephoneNumber = val
    End Sub

    Public Sub setHomeaddress(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddress = val
    End Sub

    Public Sub setHomeaddresscountry(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddressCountry = val
    End Sub

    Public Sub setHomeaddresspostalcode(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddressPostalCode = val
    End Sub

    Public Sub setHomeaddresspostofficebox(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddressPostOfficeBox = val
    End Sub

    Public Sub setHomeaddressstate(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddressState = val
    End Sub

    Public Sub setHomeaddressstreet(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeAddressStreet = val
    End Sub

    Public Sub setHomefaxnumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeFaxNumber = val
    End Sub

    Public Sub setHometelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HomeTelephoneNumber = val
    End Sub

    Public Sub setImaddress(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        IMAddress = val
    End Sub

    Public Sub setImportance(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Importance = val
    End Sub

    Public Sub setInitials(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Initials = val
    End Sub

    Public Sub setInternetfreebusyaddress(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        InternetFreeBusyAddress = val
    End Sub

    Public Sub setJobtitle(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        JobTitle = val
    End Sub

    Public Sub setJournal(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Journal = val
    End Sub

    Public Sub setLanguage(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Language = val
    End Sub

    Public Sub setLastmodificationtime(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastModificationTime = val
    End Sub

    Public Sub setLastname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastName = val
    End Sub

    Public Sub setLastnameandfirstname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastNameAndFirstName = val
    End Sub

    Public Sub setMailingaddress(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddress = val
    End Sub

    Public Sub setMailingaddresscity(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressCity = val
    End Sub

    Public Sub setMailingaddresscountry(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressCountry = val
    End Sub

    Public Sub setMailingaddresspostalcode(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressPostalCode = val
    End Sub

    Public Sub setMailingaddresspostofficebox(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressPostOfficeBox = val
    End Sub

    Public Sub setMailingaddressstate(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressState = val
    End Sub

    Public Sub setMailingaddressstreet(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MailingAddressStreet = val
    End Sub

    Public Sub setManagername(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ManagerName = val
    End Sub

    Public Sub setMiddlename(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MiddleName = val
    End Sub

    Public Sub setMileage(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Mileage = val
    End Sub

    Public Sub setMobiletelephonenumber(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MobileTelephoneNumber = val
    End Sub

    Public Sub setNetmeetingalias(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        NetMeetingAlias = val
    End Sub

    Public Sub setNetmeetingserver(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        NetMeetingServer = val
    End Sub

    Public Sub setNickname(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        NickName = val
    End Sub

    Public Sub setTitle(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Title = val
    End Sub

    Public Sub setBody(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Body = val
    End Sub

    Public Sub setOfficelocation(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        OfficeLocation = val
    End Sub

    Public Sub setSubject(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Subject = val
    End Sub



    '** Generate the GET methods 
    Public Function getEmail1address() As String
        If Len(Email1Address) = 0 Then
            MessageBox.Show("GET: Field 'Email1address' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Email1Address)
    End Function

    Public Function getFullname() As String
        If Len(FullName) = 0 Then
            MessageBox.Show("GET: Field 'Fullname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FullName)
    End Function

    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    Public Function getAccount() As String
        Return UTIL.RemoveSingleQuotes(Account)
    End Function

    Public Function getAnniversary() As String
        Return UTIL.RemoveSingleQuotes(Anniversary)
    End Function

    Public Function getApplication() As String
        Return UTIL.RemoveSingleQuotes(Application)
    End Function

    Public Function getAssistantname() As String
        Return UTIL.RemoveSingleQuotes(AssistantName)
    End Function

    Public Function getAssistanttelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(AssistantTelephoneNumber)
    End Function

    Public Function getBillinginformation() As String
        Return UTIL.RemoveSingleQuotes(BillingInformation)
    End Function

    Public Function getBirthday() As String
        Return UTIL.RemoveSingleQuotes(Birthday)
    End Function

    Public Function getBusiness2telephonenumber() As String
        Return UTIL.RemoveSingleQuotes(Business2TelephoneNumber)
    End Function

    Public Function getBusinessaddress() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddress)
    End Function

    Public Function getBusinessaddresscity() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressCity)
    End Function

    Public Function getBusinessaddresscountry() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressCountry)
    End Function

    Public Function getBusinessaddresspostalcode() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressPostalCode)
    End Function

    Public Function getBusinessaddresspostofficebox() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressPostOfficeBox)
    End Function

    Public Function getBusinessaddressstate() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressState)
    End Function

    Public Function getBusinessaddressstreet() As String
        Return UTIL.RemoveSingleQuotes(BusinessAddressStreet)
    End Function

    Public Function getBusinesscardtype() As String
        Return UTIL.RemoveSingleQuotes(BusinessCardType)
    End Function

    Public Function getBusinessfaxnumber() As String
        Return UTIL.RemoveSingleQuotes(BusinessFaxNumber)
    End Function

    Public Function getBusinesshomepage() As String
        Return UTIL.RemoveSingleQuotes(BusinessHomePage)
    End Function

    Public Function getBusinesstelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(BusinessTelephoneNumber)
    End Function

    Public Function getCallbacktelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(CallbackTelephoneNumber)
    End Function

    Public Function getCartelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(CarTelephoneNumber)
    End Function

    Public Function getCategories() As String
        Return UTIL.RemoveSingleQuotes(Categories)
    End Function

    Public Function getChildren() As String
        Return UTIL.RemoveSingleQuotes(Children)
    End Function

    Public Function getXclass() As String
        Return UTIL.RemoveSingleQuotes(xClass)
    End Function

    Public Function getCompanies() As String
        Return UTIL.RemoveSingleQuotes(Companies)
    End Function

    Public Function getCompanyname() As String
        Return UTIL.RemoveSingleQuotes(CompanyName)
    End Function

    Public Function getComputernetworkname() As String
        Return UTIL.RemoveSingleQuotes(ComputerNetworkName)
    End Function

    Public Function getConflicts() As String
        Return UTIL.RemoveSingleQuotes(Conflicts)
    End Function

    Public Function getConversationtopic() As String
        Return UTIL.RemoveSingleQuotes(ConversationTopic)
    End Function

    Public Function getCreationtime() As String
        Return UTIL.RemoveSingleQuotes(CreationTime)
    End Function

    Public Function getCustomerid() As String
        Return UTIL.RemoveSingleQuotes(CustomerID)
    End Function

    Public Function getDepartment() As String
        Return UTIL.RemoveSingleQuotes(Department)
    End Function

    Public Function getEmail1addresstype() As String
        Return UTIL.RemoveSingleQuotes(Email1AddressType)
    End Function

    Public Function getEmail1displayname() As String
        Return UTIL.RemoveSingleQuotes(Email1DisplayName)
    End Function

    Public Function getEmail1entryid() As String
        Return UTIL.RemoveSingleQuotes(Email1EntryID)
    End Function

    Public Function getEmail2address() As String
        Return UTIL.RemoveSingleQuotes(Email2Address)
    End Function

    Public Function getEmail2addresstype() As String
        Return UTIL.RemoveSingleQuotes(Email2AddressType)
    End Function

    Public Function getEmail2displayname() As String
        Return UTIL.RemoveSingleQuotes(Email2DisplayName)
    End Function

    Public Function getEmail2entryid() As String
        Return UTIL.RemoveSingleQuotes(Email2EntryID)
    End Function

    Public Function getEmail3address() As String
        Return UTIL.RemoveSingleQuotes(Email3Address)
    End Function

    Public Function getEmail3addresstype() As String
        Return UTIL.RemoveSingleQuotes(Email3AddressType)
    End Function

    Public Function getEmail3displayname() As String
        Return UTIL.RemoveSingleQuotes(Email3DisplayName)
    End Function

    Public Function getEmail3entryid() As String
        Return UTIL.RemoveSingleQuotes(Email3EntryID)
    End Function

    Public Function getFileas() As String
        Return UTIL.RemoveSingleQuotes(FileAs)
    End Function

    Public Function getFirstname() As String
        Return UTIL.RemoveSingleQuotes(FirstName)
    End Function

    Public Function getFtpsite() As String
        Return UTIL.RemoveSingleQuotes(FTPSite)
    End Function

    Public Function getGender() As String
        Return UTIL.RemoveSingleQuotes(Gender)
    End Function

    Public Function getGovernmentidnumber() As String
        Return UTIL.RemoveSingleQuotes(GovernmentIDNumber)
    End Function

    Public Function getHobby() As String
        Return UTIL.RemoveSingleQuotes(Hobby)
    End Function

    Public Function getHome2telephonenumber() As String
        Return UTIL.RemoveSingleQuotes(Home2TelephoneNumber)
    End Function

    Public Function getHomeaddress() As String
        Return UTIL.RemoveSingleQuotes(HomeAddress)
    End Function

    Public Function getHomeaddresscountry() As String
        Return UTIL.RemoveSingleQuotes(HomeAddressCountry)
    End Function

    Public Function getHomeaddresspostalcode() As String
        Return UTIL.RemoveSingleQuotes(HomeAddressPostalCode)
    End Function

    Public Function getHomeaddresspostofficebox() As String
        Return UTIL.RemoveSingleQuotes(HomeAddressPostOfficeBox)
    End Function

    Public Function getHomeaddressstate() As String
        Return UTIL.RemoveSingleQuotes(HomeAddressState)
    End Function

    Public Function getHomeaddressstreet() As String
        Return UTIL.RemoveSingleQuotes(HomeAddressStreet)
    End Function

    Public Function getHomefaxnumber() As String
        Return UTIL.RemoveSingleQuotes(HomeFaxNumber)
    End Function

    Public Function getHometelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(HomeTelephoneNumber)
    End Function

    Public Function getImaddress() As String
        Return UTIL.RemoveSingleQuotes(IMAddress)
    End Function

    Public Function getImportance() As String
        Return UTIL.RemoveSingleQuotes(Importance)
    End Function

    Public Function getInitials() As String
        Return UTIL.RemoveSingleQuotes(Initials)
    End Function

    Public Function getInternetfreebusyaddress() As String
        Return UTIL.RemoveSingleQuotes(InternetFreeBusyAddress)
    End Function

    Public Function getJobtitle() As String
        Return UTIL.RemoveSingleQuotes(JobTitle)
    End Function

    Public Function getJournal() As String
        Return UTIL.RemoveSingleQuotes(Journal)
    End Function

    Public Function getLanguage() As String
        Return UTIL.RemoveSingleQuotes(Language)
    End Function

    Public Function getLastmodificationtime() As String
        Return UTIL.RemoveSingleQuotes(LastModificationTime)
    End Function

    Public Function getLastname() As String
        Return UTIL.RemoveSingleQuotes(LastName)
    End Function

    Public Function getLastnameandfirstname() As String
        Return UTIL.RemoveSingleQuotes(LastNameAndFirstName)
    End Function

    Public Function getMailingaddress() As String
        Return UTIL.RemoveSingleQuotes(MailingAddress)
    End Function

    Public Function getMailingaddresscity() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressCity)
    End Function

    Public Function getMailingaddresscountry() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressCountry)
    End Function

    Public Function getMailingaddresspostalcode() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressPostalCode)
    End Function

    Public Function getMailingaddresspostofficebox() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressPostOfficeBox)
    End Function

    Public Function getMailingaddressstate() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressState)
    End Function

    Public Function getMailingaddressstreet() As String
        Return UTIL.RemoveSingleQuotes(MailingAddressStreet)
    End Function

    Public Function getManagername() As String
        Return UTIL.RemoveSingleQuotes(ManagerName)
    End Function

    Public Function getMiddlename() As String
        Return UTIL.RemoveSingleQuotes(MiddleName)
    End Function

    Public Function getMileage() As String
        Return UTIL.RemoveSingleQuotes(Mileage)
    End Function

    Public Function getMobiletelephonenumber() As String
        Return UTIL.RemoveSingleQuotes(MobileTelephoneNumber)
    End Function

    Public Function getNetmeetingalias() As String
        Return UTIL.RemoveSingleQuotes(NetMeetingAlias)
    End Function

    Public Function getNetmeetingserver() As String
        Return UTIL.RemoveSingleQuotes(NetMeetingServer)
    End Function

    Public Function getNickname() As String
        Return UTIL.RemoveSingleQuotes(NickName)
    End Function

    Public Function getTitle() As String
        Return UTIL.RemoveSingleQuotes(Title)
    End Function

    Public Function getBody() As String
        Return UTIL.RemoveSingleQuotes(Body)
    End Function

    Public Function getOfficelocation() As String
        Return UTIL.RemoveSingleQuotes(OfficeLocation)
    End Function

    Public Function getSubject() As String
        Return UTIL.RemoveSingleQuotes(Subject)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If Email1Address.Length = 0 Then Return False
        If FullName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If Email1Address.Length = 0 Then Return False
        If FullName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ContactsArchive(" + vbCrLf
        s = s + "Email1Address," + vbCrLf
        s = s + "FullName," + vbCrLf
        s = s + "UserID," + vbCrLf
        s = s + "Account," + vbCrLf
        s = s + "Anniversary," + vbCrLf
        s = s + "Application," + vbCrLf
        s = s + "AssistantName," + vbCrLf
        s = s + "AssistantTelephoneNumber," + vbCrLf
        s = s + "BillingInformation," + vbCrLf
        s = s + "Birthday," + vbCrLf
        s = s + "Business2TelephoneNumber," + vbCrLf
        s = s + "BusinessAddress," + vbCrLf
        s = s + "BusinessAddressCity," + vbCrLf
        s = s + "BusinessAddressCountry," + vbCrLf
        s = s + "BusinessAddressPostalCode," + vbCrLf
        s = s + "BusinessAddressPostOfficeBox," + vbCrLf
        s = s + "BusinessAddressState," + vbCrLf
        s = s + "BusinessAddressStreet," + vbCrLf
        s = s + "BusinessCardType," + vbCrLf
        s = s + "BusinessFaxNumber," + vbCrLf
        s = s + "BusinessHomePage," + vbCrLf
        s = s + "BusinessTelephoneNumber," + vbCrLf
        s = s + "CallbackTelephoneNumber," + vbCrLf
        s = s + "CarTelephoneNumber," + vbCrLf
        s = s + "Categories," + vbCrLf
        s = s + "Children," + vbCrLf
        s = s + "xClass," + vbCrLf
        s = s + "Companies," + vbCrLf
        s = s + "CompanyName," + vbCrLf
        s = s + "ComputerNetworkName," + vbCrLf
        s = s + "Conflicts," + vbCrLf
        s = s + "ConversationTopic," + vbCrLf
        s = s + "CreationTime," + vbCrLf
        s = s + "CustomerID," + vbCrLf
        s = s + "Department," + vbCrLf
        s = s + "Email1AddressType," + vbCrLf
        s = s + "Email1DisplayName," + vbCrLf
        s = s + "Email1EntryID," + vbCrLf
        s = s + "Email2Address," + vbCrLf
        s = s + "Email2AddressType," + vbCrLf
        s = s + "Email2DisplayName," + vbCrLf
        s = s + "Email2EntryID," + vbCrLf
        s = s + "Email3Address," + vbCrLf
        s = s + "Email3AddressType," + vbCrLf
        s = s + "Email3DisplayName," + vbCrLf
        s = s + "Email3EntryID," + vbCrLf
        s = s + "FileAs," + vbCrLf
        s = s + "FirstName," + vbCrLf
        s = s + "FTPSite," + vbCrLf
        s = s + "Gender," + vbCrLf
        s = s + "GovernmentIDNumber," + vbCrLf
        s = s + "Hobby," + vbCrLf
        s = s + "Home2TelephoneNumber," + vbCrLf
        s = s + "HomeAddress," + vbCrLf
        s = s + "HomeAddressCountry," + vbCrLf
        s = s + "HomeAddressPostalCode," + vbCrLf
        s = s + "HomeAddressPostOfficeBox," + vbCrLf
        s = s + "HomeAddressState," + vbCrLf
        s = s + "HomeAddressStreet," + vbCrLf
        s = s + "HomeFaxNumber," + vbCrLf
        s = s + "HomeTelephoneNumber," + vbCrLf
        s = s + "IMAddress," + vbCrLf
        s = s + "Importance," + vbCrLf
        s = s + "Initials," + vbCrLf
        s = s + "InternetFreeBusyAddress," + vbCrLf
        s = s + "JobTitle," + vbCrLf
        s = s + "Journal," + vbCrLf
        s = s + "Language," + vbCrLf
        s = s + "LastModificationTime," + vbCrLf
        s = s + "LastName," + vbCrLf
        s = s + "LastNameAndFirstName," + vbCrLf
        s = s + "MailingAddress," + vbCrLf
        s = s + "MailingAddressCity," + vbCrLf
        s = s + "MailingAddressCountry," + vbCrLf
        s = s + "MailingAddressPostalCode," + vbCrLf
        s = s + "MailingAddressPostOfficeBox," + vbCrLf
        s = s + "MailingAddressState," + vbCrLf
        s = s + "MailingAddressStreet," + vbCrLf
        s = s + "ManagerName," + vbCrLf
        s = s + "MiddleName," + vbCrLf
        s = s + "Mileage," + vbCrLf
        s = s + "MobileTelephoneNumber," + vbCrLf
        s = s + "NetMeetingAlias," + vbCrLf
        s = s + "NetMeetingServer," + vbCrLf
        s = s + "NickName," + vbCrLf
        s = s + "Title," + vbCrLf
        s = s + "Body," + vbCrLf
        s = s + "OfficeLocation," + vbCrLf
        s = s + "Subject) values ("
        s = s + "'" + Email1Address.ToString + "'" + "," + vbCrLf
        s = s + "'" + FullName.ToString + "'" + "," + vbCrLf
        s = s + "'" + UserID.ToString + "'" + "," + vbCrLf
        If Account = Nothing Then
            Account = " "
        End If
        s = s + "'" + Account.ToString + "'" + "," + vbCrLf
        If Anniversary = Nothing Then
            Anniversary = " "
        End If
        s = s + "'" + Anniversary.ToString + "'" + "," + vbCrLf
        If Application = Nothing Then
            Application = " "
        End If
        s = s + "'" + Application.ToString + "'" + "," + vbCrLf
        If AssistantName = Nothing Then
            AssistantName = " "
        End If
        s = s + "'" + AssistantName.ToString + "'" + "," + vbCrLf
        If AssistantTelephoneNumber = Nothing Then
            AssistantTelephoneNumber = " "
        End If
        s = s + "'" + AssistantTelephoneNumber.ToString + "'" + "," + vbCrLf
        If BillingInformation = Nothing Then
            BillingInformation = " "
        End If
        s = s + "'" + BillingInformation.ToString + "'" + "," + vbCrLf
        If Birthday = Nothing Then
            Birthday = " "
        End If
        s = s + "'" + Birthday.ToString + "'" + "," + vbCrLf
        If Business2TelephoneNumber = Nothing Then
            Business2TelephoneNumber = " "
        End If
        s = s + "'" + Business2TelephoneNumber.ToString + "'" + "," + vbCrLf
        If BusinessAddress = Nothing Then
            BusinessAddress = " "
        End If
        s = s + "'" + BusinessAddress.ToString + "'" + "," + vbCrLf
        If BusinessAddressCity = Nothing Then
            BusinessAddressCity = " "
        End If
        s = s + "'" + BusinessAddressCity.ToString + "'" + "," + vbCrLf
        If BusinessAddressCountry = Nothing Then
            BusinessAddressCountry = " "
        End If
        s = s + "'" + BusinessAddressCountry.ToString + "'" + "," + vbCrLf
        If BusinessAddressPostalCode = Nothing Then
            BusinessAddressPostalCode = " "
        End If
        s = s + "'" + BusinessAddressPostalCode.ToString + "'" + "," + vbCrLf
        If BusinessAddressPostOfficeBox = Nothing Then
            BusinessAddressPostOfficeBox = " "
        End If
        s = s + "'" + BusinessAddressPostOfficeBox.ToString + "'" + "," + vbCrLf
        If BusinessAddressState = Nothing Then
            BusinessAddressState = " "
        End If
        s = s + "'" + BusinessAddressState.ToString + "'" + "," + vbCrLf
        If BusinessAddressStreet = Nothing Then
            BusinessAddressStreet = " "
        End If
        s = s + "'" + BusinessAddressStreet.ToString + "'" + "," + vbCrLf
        If BusinessCardType = Nothing Then
            BusinessCardType = " "
        End If
        s = s + "'" + BusinessCardType.ToString + "'" + "," + vbCrLf
        If BusinessFaxNumber = Nothing Then
            BusinessFaxNumber = " "
        End If
        s = s + "'" + BusinessFaxNumber.ToString + "'" + "," + vbCrLf
        If BusinessHomePage = Nothing Then
            BusinessHomePage = " "
        End If
        s = s + "'" + BusinessHomePage.ToString + "'" + "," + vbCrLf
        If BusinessTelephoneNumber = Nothing Then
            BusinessTelephoneNumber = " "
        End If
        s = s + "'" + BusinessTelephoneNumber.ToString + "'" + "," + vbCrLf
        If CallbackTelephoneNumber = Nothing Then
            CallbackTelephoneNumber = " "
        End If
        s = s + "'" + CallbackTelephoneNumber.ToString + "'" + "," + vbCrLf
        If CarTelephoneNumber = Nothing Then
            CarTelephoneNumber = " "
        End If
        s = s + "'" + CarTelephoneNumber.ToString + "'" + "," + vbCrLf
        If Categories = Nothing Then
            Categories = " "
        End If
        s = s + "'" + Categories.ToString + "'" + "," + vbCrLf
        If Children = Nothing Then
            Children = " "
        End If
        s = s + "'" + Children.ToString + "'" + "," + vbCrLf
        If xClass = Nothing Then
            xClass = " "
        End If
        s = s + "'" + xClass.ToString + "'" + "," + vbCrLf
        If Companies = Nothing Then
            Companies = " "
        End If
        s = s + "'" + Companies.ToString + "'" + "," + vbCrLf
        If CompanyName = Nothing Then
            CompanyName = " "
        End If
        s = s + "'" + CompanyName.ToString + "'" + "," + vbCrLf
        If ComputerNetworkName = Nothing Then
            ComputerNetworkName = " "
        End If
        s = s + "'" + ComputerNetworkName.ToString + "'" + "," + vbCrLf
        If Conflicts = Nothing Then
            Conflicts = " "
        End If
        s = s + "'" + Conflicts.ToString + "'" + "," + vbCrLf
        If ConversationTopic = Nothing Then
            ConversationTopic = " "
        End If
        s = s + "'" + ConversationTopic.ToString + "'" + "," + vbCrLf
        If CreationTime = Nothing Then
            CreationTime = " "
        End If
        s = s + "'" + CreationTime.ToString + "'" + "," + vbCrLf
        'Debug.Print(s.Length.ToString)
        If CustomerID = Nothing Then
            CustomerID = " "
        End If
        s = s + "'" + CustomerID.ToString + "'" + "," + vbCrLf
        If Department = Nothing Then
            Department = " "
        End If
        s = s + "'" + Department.ToString + "'" + "," + vbCrLf
        If Email1AddressType = Nothing Then
            Email1AddressType = " "
        End If
        s = s + "'" + Email1AddressType.ToString + "'" + "," + vbCrLf
        If Email1DisplayName = Nothing Then
            Email1DisplayName = " "
        End If
        s = s + "'" + Email1DisplayName.ToString + "'" + "," + vbCrLf
        If Email1EntryID = Nothing Then
            Email1EntryID = " "
        End If
        s = s + "'" + Email1EntryID.ToString + "'" + "," + vbCrLf
        If Email2Address = Nothing Then
            Email2Address = " "
        End If
        s = s + "'" + Email2Address.ToString + "'" + "," + vbCrLf
        If Email2AddressType = Nothing Then
            Email2AddressType = " "
        End If
        s = s + "'" + Email2AddressType.ToString + "'" + "," + vbCrLf
        'Debug.Print(s.Length.ToString)
        If Email2DisplayName = Nothing Then
            Email2DisplayName = " "
        End If
        s = s + "'" + Email2DisplayName.ToString + "'" + "," + vbCrLf
        If Email2EntryID = Nothing Then
            Email2EntryID = " "
        End If
        s = s + "'" + Email2EntryID.ToString + "'" + "," + vbCrLf
        If Email3Address = Nothing Then
            Email3Address = " "
        End If
        s = s + "'" + Email3Address.ToString + "'" + "," + vbCrLf
        If Email3AddressType = Nothing Then
            Email3AddressType = " "
        End If
        s = s + "'" + Email3AddressType.ToString + "'" + "," + vbCrLf
        If Email3DisplayName = Nothing Then
            Email3DisplayName = " "
        End If
        s = s + "'" + Email3DisplayName.ToString + "'" + "," + vbCrLf
        If Email3EntryID = Nothing Then
            Email3EntryID = " "
        End If
        s = s + "'" + Email3EntryID.ToString + "'" + "," + vbCrLf
        If FileAs = Nothing Then
            FileAs = " "
        End If
        s = s + "'" + FileAs.ToString + "'" + "," + vbCrLf
        If FirstName = Nothing Then
            FirstName = " "
        End If
        s = s + "'" + FirstName.ToString + "'" + "," + vbCrLf
        If FTPSite = Nothing Then
            FTPSite = " "
        End If
        s = s + "'" + FTPSite.ToString + "'" + "," + vbCrLf
        If Gender = Nothing Then
            Gender = " "
        End If
        s = s + "'" + Gender.ToString + "'" + "," + vbCrLf
        If GovernmentIDNumber = Nothing Then
            GovernmentIDNumber = " "
        End If
        s = s + "'" + GovernmentIDNumber.ToString + "'" + "," + vbCrLf
        If Hobby = Nothing Then
            Hobby = " "
        End If
        s = s + "'" + Hobby.ToString + "'" + "," + vbCrLf
        If Home2TelephoneNumber = Nothing Then
            Home2TelephoneNumber = " "
        End If
        s = s + "'" + Home2TelephoneNumber.ToString + "'" + "," + vbCrLf
        If HomeAddress = Nothing Then
            HomeAddress = " "
        End If
        s = s + "'" + HomeAddress.ToString + "'" + "," + vbCrLf
        If HomeAddressCountry = Nothing Then
            HomeAddressCountry = " "
        End If
        s = s + "'" + HomeAddressCountry.ToString + "'" + "," + vbCrLf
        If HomeAddressPostalCode = Nothing Then
            HomeAddressPostalCode = " "
        End If
        s = s + "'" + HomeAddressPostalCode.ToString + "'" + "," + vbCrLf
        If HomeAddressPostOfficeBox = Nothing Then
            HomeAddressPostOfficeBox = " "
        End If
        s = s + "'" + HomeAddressPostOfficeBox.ToString + "'" + "," + vbCrLf
        If HomeAddressState = Nothing Then
            HomeAddressState = " "
        End If
        s = s + "'" + HomeAddressState.ToString + "'" + "," + vbCrLf
        If HomeAddressStreet = Nothing Then
            HomeAddressStreet = " "
        End If
        s = s + "'" + HomeAddressStreet.ToString + "'" + "," + vbCrLf
        If HomeFaxNumber = Nothing Then
            HomeFaxNumber = " "
        End If
        s = s + "'" + HomeFaxNumber.ToString + "'" + "," + vbCrLf
        If HomeTelephoneNumber = Nothing Then
            HomeTelephoneNumber = " "
        End If
        s = s + "'" + HomeTelephoneNumber.ToString + "'" + "," + vbCrLf
        If IMAddress = Nothing Then
            IMAddress = " "
        End If
        s = s + "'" + IMAddress.ToString + "'" + "," + vbCrLf
        If Importance = Nothing Then
            Importance = " "
        End If
        s = s + "'" + Importance.ToString + "'" + "," + vbCrLf
        If Initials = Nothing Then
            Initials = " "
        End If
        s = s + "'" + Initials.ToString + "'" + "," + vbCrLf
        If InternetFreeBusyAddress = Nothing Then
            InternetFreeBusyAddress = " "
        End If
        s = s + "'" + InternetFreeBusyAddress.ToString + "'" + "," + vbCrLf
        If JobTitle = Nothing Then
            JobTitle = " "
        End If
        s = s + "'" + JobTitle.ToString + "'" + "," + vbCrLf
        If Journal = Nothing Then
            Journal = " "
        End If
        s = s + "'" + Journal.ToString + "'" + "," + vbCrLf
        If Language = Nothing Then
            Language = " "
        End If
        s = s + "'" + Language.ToString + "'" + "," + vbCrLf
        If LastModificationTime = Nothing Then
            LastModificationTime = " "
        End If
        s = s + "'" + LastModificationTime.ToString + "'" + "," + vbCrLf
        If LastName = Nothing Then
            LastName = " "
        End If
        s = s + "'" + LastName.ToString + "'" + "," + vbCrLf
        If LastNameAndFirstName = Nothing Then
            LastNameAndFirstName = " "
        End If
        s = s + "'" + LastNameAndFirstName.ToString + "'" + "," + vbCrLf
        If MailingAddress = Nothing Then
            MailingAddress = " "
        End If
        s = s + "'" + MailingAddress.ToString + "'" + "," + vbCrLf
        If MailingAddressCity = Nothing Then
            MailingAddressCity = " "
        End If
        s = s + "'" + MailingAddressCity.ToString + "'" + "," + vbCrLf
        If MailingAddressCountry = Nothing Then
            MailingAddressCountry = " "
        End If
        s = s + "'" + MailingAddressCountry.ToString + "'" + "," + vbCrLf
        If MailingAddressPostalCode = Nothing Then
            MailingAddressPostalCode = " "
        End If
        s = s + "'" + MailingAddressPostalCode.ToString + "'" + "," + vbCrLf
        If MailingAddressPostOfficeBox = Nothing Then
            MailingAddressPostOfficeBox = " "
        End If
        s = s + "'" + MailingAddressPostOfficeBox.ToString + "'" + "," + vbCrLf
        If MailingAddressState = Nothing Then
            MailingAddressState = " "
        End If
        s = s + "'" + MailingAddressState.ToString + "'" + "," + vbCrLf
        If MailingAddressStreet = Nothing Then
            MailingAddressStreet = " "
        End If
        s = s + "'" + MailingAddressStreet.ToString + "'" + "," + vbCrLf
        If ManagerName = Nothing Then
            ManagerName = " "
        End If
        s = s + "'" + ManagerName.ToString + "'" + "," + vbCrLf
        If MiddleName = Nothing Then
            MiddleName = " "
        End If
        s = s + "'" + MiddleName.ToString + "'" + "," + vbCrLf
        If Mileage = Nothing Then
            Mileage = " "
        End If
        s = s + "'" + Mileage.ToString + "'" + "," + vbCrLf
        If MobileTelephoneNumber = Nothing Then
            MobileTelephoneNumber = " "
        End If
        s = s + "'" + MobileTelephoneNumber.ToString + "'" + "," + vbCrLf
        If NetMeetingAlias = Nothing Then
            NetMeetingAlias = " "
        End If
        s = s + "'" + NetMeetingAlias.ToString + "'" + "," + vbCrLf
        If NetMeetingServer = Nothing Then
            NetMeetingServer = " "
        End If
        s = s + "'" + NetMeetingServer.ToString + "'" + "," + vbCrLf
        If NickName = Nothing Then
            NickName = " "
        End If
        s = s + "'" + NickName.ToString + "'" + "," + vbCrLf
        If Title = Nothing Then
            Title = " "
        End If
        s = s + "'" + Title.ToString + "'" + "," + vbCrLf
        If Body = Nothing Then
            Body = " "
        End If
        s = s + "'" + Body.ToString + "'" + "," + vbCrLf
        If OfficeLocation = Nothing Then
            OfficeLocation = " "
        End If
        s = s + "'" + OfficeLocation.ToString + "'" + "," + vbCrLf
        If Subject = Nothing Then
            Subject = " "
        End If
        s = s + "'" + Subject.ToString + "'"
        s = s + ")"

        Debug.Print(s.Length.ToString)
        Debug.Print(s)
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ContactsArchive set "
        s = s + "Email1Address = '" + getEmail1address() + "'" + ", "
        s = s + "FullName = '" + getFullname() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "Account = '" + getAccount() + "'" + ", "
        s = s + "Anniversary = '" + getAnniversary() + "'" + ", "
        s = s + "Application = '" + getApplication() + "'" + ", "
        s = s + "AssistantName = '" + getAssistantname() + "'" + ", "
        s = s + "AssistantTelephoneNumber = '" + getAssistanttelephonenumber() + "'" + ", "
        s = s + "BillingInformation = '" + getBillinginformation() + "'" + ", "
        s = s + "Birthday = '" + getBirthday() + "'" + ", "
        s = s + "Business2TelephoneNumber = '" + getBusiness2telephonenumber() + "'" + ", "
        s = s + "BusinessAddress = '" + getBusinessaddress() + "'" + ", "
        s = s + "BusinessAddressCity = '" + getBusinessaddresscity() + "'" + ", "
        s = s + "BusinessAddressCountry = '" + getBusinessaddresscountry() + "'" + ", "
        s = s + "BusinessAddressPostalCode = '" + getBusinessaddresspostalcode() + "'" + ", "
        s = s + "BusinessAddressPostOfficeBox = '" + getBusinessaddresspostofficebox() + "'" + ", "
        s = s + "BusinessAddressState = '" + getBusinessaddressstate() + "'" + ", "
        s = s + "BusinessAddressStreet = '" + getBusinessaddressstreet() + "'" + ", "
        s = s + "BusinessCardType = '" + getBusinesscardtype() + "'" + ", "
        s = s + "BusinessFaxNumber = '" + getBusinessfaxnumber() + "'" + ", "
        s = s + "BusinessHomePage = '" + getBusinesshomepage() + "'" + ", "
        s = s + "BusinessTelephoneNumber = '" + getBusinesstelephonenumber() + "'" + ", "
        s = s + "CallbackTelephoneNumber = '" + getCallbacktelephonenumber() + "'" + ", "
        s = s + "CarTelephoneNumber = '" + getCartelephonenumber() + "'" + ", "
        s = s + "Categories = '" + getCategories() + "'" + ", "
        s = s + "Children = '" + getChildren() + "'" + ", "
        s = s + "xClass = '" + getXclass() + "'" + ", "
        s = s + "Companies = '" + getCompanies() + "'" + ", "
        s = s + "CompanyName = '" + getCompanyname() + "'" + ", "
        s = s + "ComputerNetworkName = '" + getComputernetworkname() + "'" + ", "
        s = s + "Conflicts = '" + getConflicts() + "'" + ", "
        s = s + "ConversationTopic = '" + getConversationtopic() + "'" + ", "
        s = s + "CreationTime = '" + getCreationtime() + "'" + ", "
        s = s + "CustomerID = '" + getCustomerid() + "'" + ", "
        s = s + "Department = '" + getDepartment() + "'" + ", "
        s = s + "Email1AddressType = '" + getEmail1addresstype() + "'" + ", "
        s = s + "Email1DisplayName = '" + getEmail1displayname() + "'" + ", "
        s = s + "Email1EntryID = '" + getEmail1entryid() + "'" + ", "
        s = s + "Email2Address = '" + getEmail2address() + "'" + ", "
        s = s + "Email2AddressType = '" + getEmail2addresstype() + "'" + ", "
        s = s + "Email2DisplayName = '" + getEmail2displayname() + "'" + ", "
        s = s + "Email2EntryID = '" + getEmail2entryid() + "'" + ", "
        s = s + "Email3Address = '" + getEmail3address() + "'" + ", "
        s = s + "Email3AddressType = '" + getEmail3addresstype() + "'" + ", "
        s = s + "Email3DisplayName = '" + getEmail3displayname() + "'" + ", "
        s = s + "Email3EntryID = '" + getEmail3entryid() + "'" + ", "
        s = s + "FileAs = '" + getFileas() + "'" + ", "
        s = s + "FirstName = '" + getFirstname() + "'" + ", "
        s = s + "FTPSite = '" + getFtpsite() + "'" + ", "
        s = s + "Gender = '" + getGender() + "'" + ", "
        s = s + "GovernmentIDNumber = '" + getGovernmentidnumber() + "'" + ", "
        s = s + "Hobby = '" + getHobby() + "'" + ", "
        s = s + "Home2TelephoneNumber = '" + getHome2telephonenumber() + "'" + ", "
        s = s + "HomeAddress = '" + getHomeaddress() + "'" + ", "
        s = s + "HomeAddressCountry = '" + getHomeaddresscountry() + "'" + ", "
        s = s + "HomeAddressPostalCode = '" + getHomeaddresspostalcode() + "'" + ", "
        s = s + "HomeAddressPostOfficeBox = '" + getHomeaddresspostofficebox() + "'" + ", "
        s = s + "HomeAddressState = '" + getHomeaddressstate() + "'" + ", "
        s = s + "HomeAddressStreet = '" + getHomeaddressstreet() + "'" + ", "
        s = s + "HomeFaxNumber = '" + getHomefaxnumber() + "'" + ", "
        s = s + "HomeTelephoneNumber = '" + getHometelephonenumber() + "'" + ", "
        s = s + "IMAddress = '" + getImaddress() + "'" + ", "
        s = s + "Importance = '" + getImportance() + "'" + ", "
        s = s + "Initials = '" + getInitials() + "'" + ", "
        s = s + "InternetFreeBusyAddress = '" + getInternetfreebusyaddress() + "'" + ", "
        s = s + "JobTitle = '" + getJobtitle() + "'" + ", "
        s = s + "Journal = '" + getJournal() + "'" + ", "
        s = s + "Language = '" + getLanguage() + "'" + ", "
        s = s + "LastModificationTime = '" + getLastmodificationtime() + "'" + ", "
        s = s + "LastName = '" + getLastname() + "'" + ", "
        s = s + "LastNameAndFirstName = '" + getLastnameandfirstname() + "'" + ", "
        s = s + "MailingAddress = '" + getMailingaddress() + "'" + ", "
        s = s + "MailingAddressCity = '" + getMailingaddresscity() + "'" + ", "
        s = s + "MailingAddressCountry = '" + getMailingaddresscountry() + "'" + ", "
        s = s + "MailingAddressPostalCode = '" + getMailingaddresspostalcode() + "'" + ", "
        s = s + "MailingAddressPostOfficeBox = '" + getMailingaddresspostofficebox() + "'" + ", "
        s = s + "MailingAddressState = '" + getMailingaddressstate() + "'" + ", "
        s = s + "MailingAddressStreet = '" + getMailingaddressstreet() + "'" + ", "
        s = s + "ManagerName = '" + getManagername() + "'" + ", "
        s = s + "MiddleName = '" + getMiddlename() + "'" + ", "
        s = s + "Mileage = '" + getMileage() + "'" + ", "
        s = s + "MobileTelephoneNumber = '" + getMobiletelephonenumber() + "'" + ", "
        s = s + "NetMeetingAlias = '" + getNetmeetingalias() + "'" + ", "
        s = s + "NetMeetingServer = '" + getNetmeetingserver() + "'" + ", "
        s = s + "NickName = '" + getNickname() + "'" + ", "
        s = s + "Title = '" + getTitle() + "'" + ", "
        s = s + "Body = '" + getBody() + "'" + ", "
        s = s + "OfficeLocation = '" + getOfficelocation() + "'" + ", "
        s = s + "Subject = '" + getSubject() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Email1Address,"
        s = s + "FullName,"
        s = s + "UserID,"
        s = s + "Account,"
        s = s + "Anniversary,"
        s = s + "Application,"
        s = s + "AssistantName,"
        s = s + "AssistantTelephoneNumber,"
        s = s + "BillingInformation,"
        s = s + "Birthday,"
        s = s + "Business2TelephoneNumber,"
        s = s + "BusinessAddress,"
        s = s + "BusinessAddressCity,"
        s = s + "BusinessAddressCountry,"
        s = s + "BusinessAddressPostalCode,"
        s = s + "BusinessAddressPostOfficeBox,"
        s = s + "BusinessAddressState,"
        s = s + "BusinessAddressStreet,"
        s = s + "BusinessCardType,"
        s = s + "BusinessFaxNumber,"
        s = s + "BusinessHomePage,"
        s = s + "BusinessTelephoneNumber,"
        s = s + "CallbackTelephoneNumber,"
        s = s + "CarTelephoneNumber,"
        s = s + "Categories,"
        s = s + "Children,"
        s = s + "xClass,"
        s = s + "Companies,"
        s = s + "CompanyName,"
        s = s + "ComputerNetworkName,"
        s = s + "Conflicts,"
        s = s + "ConversationTopic,"
        s = s + "CreationTime,"
        s = s + "CustomerID,"
        s = s + "Department,"
        s = s + "Email1AddressType,"
        s = s + "Email1DisplayName,"
        s = s + "Email1EntryID,"
        s = s + "Email2Address,"
        s = s + "Email2AddressType,"
        s = s + "Email2DisplayName,"
        s = s + "Email2EntryID,"
        s = s + "Email3Address,"
        s = s + "Email3AddressType,"
        s = s + "Email3DisplayName,"
        s = s + "Email3EntryID,"
        s = s + "FileAs,"
        s = s + "FirstName,"
        s = s + "FTPSite,"
        s = s + "Gender,"
        s = s + "GovernmentIDNumber,"
        s = s + "Hobby,"
        s = s + "Home2TelephoneNumber,"
        s = s + "HomeAddress,"
        s = s + "HomeAddressCountry,"
        s = s + "HomeAddressPostalCode,"
        s = s + "HomeAddressPostOfficeBox,"
        s = s + "HomeAddressState,"
        s = s + "HomeAddressStreet,"
        s = s + "HomeFaxNumber,"
        s = s + "HomeTelephoneNumber,"
        s = s + "IMAddress,"
        s = s + "Importance,"
        s = s + "Initials,"
        s = s + "InternetFreeBusyAddress,"
        s = s + "JobTitle,"
        s = s + "Journal,"
        s = s + "Language,"
        s = s + "LastModificationTime,"
        s = s + "LastName,"
        s = s + "LastNameAndFirstName,"
        s = s + "MailingAddress,"
        s = s + "MailingAddressCity,"
        s = s + "MailingAddressCountry,"
        s = s + "MailingAddressPostalCode,"
        s = s + "MailingAddressPostOfficeBox,"
        s = s + "MailingAddressState,"
        s = s + "MailingAddressStreet,"
        s = s + "ManagerName,"
        s = s + "MiddleName,"
        s = s + "Mileage,"
        s = s + "MobileTelephoneNumber,"
        s = s + "NetMeetingAlias,"
        s = s + "NetMeetingServer,"
        s = s + "NickName,"
        s = s + "Title,"
        s = s + "Body,"
        s = s + "OfficeLocation,"
        s = s + "Subject "
        s = s + " FROM ContactsArchive"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Email1Address,"
        s = s + "FullName,"
        s = s + "UserID,"
        s = s + "Account,"
        s = s + "Anniversary,"
        s = s + "Application,"
        s = s + "AssistantName,"
        s = s + "AssistantTelephoneNumber,"
        s = s + "BillingInformation,"
        s = s + "Birthday,"
        s = s + "Business2TelephoneNumber,"
        s = s + "BusinessAddress,"
        s = s + "BusinessAddressCity,"
        s = s + "BusinessAddressCountry,"
        s = s + "BusinessAddressPostalCode,"
        s = s + "BusinessAddressPostOfficeBox,"
        s = s + "BusinessAddressState,"
        s = s + "BusinessAddressStreet,"
        s = s + "BusinessCardType,"
        s = s + "BusinessFaxNumber,"
        s = s + "BusinessHomePage,"
        s = s + "BusinessTelephoneNumber,"
        s = s + "CallbackTelephoneNumber,"
        s = s + "CarTelephoneNumber,"
        s = s + "Categories,"
        s = s + "Children,"
        s = s + "xClass,"
        s = s + "Companies,"
        s = s + "CompanyName,"
        s = s + "ComputerNetworkName,"
        s = s + "Conflicts,"
        s = s + "ConversationTopic,"
        s = s + "CreationTime,"
        s = s + "CustomerID,"
        s = s + "Department,"
        s = s + "Email1AddressType,"
        s = s + "Email1DisplayName,"
        s = s + "Email1EntryID,"
        s = s + "Email2Address,"
        s = s + "Email2AddressType,"
        s = s + "Email2DisplayName,"
        s = s + "Email2EntryID,"
        s = s + "Email3Address,"
        s = s + "Email3AddressType,"
        s = s + "Email3DisplayName,"
        s = s + "Email3EntryID,"
        s = s + "FileAs,"
        s = s + "FirstName,"
        s = s + "FTPSite,"
        s = s + "Gender,"
        s = s + "GovernmentIDNumber,"
        s = s + "Hobby,"
        s = s + "Home2TelephoneNumber,"
        s = s + "HomeAddress,"
        s = s + "HomeAddressCountry,"
        s = s + "HomeAddressPostalCode,"
        s = s + "HomeAddressPostOfficeBox,"
        s = s + "HomeAddressState,"
        s = s + "HomeAddressStreet,"
        s = s + "HomeFaxNumber,"
        s = s + "HomeTelephoneNumber,"
        s = s + "IMAddress,"
        s = s + "Importance,"
        s = s + "Initials,"
        s = s + "InternetFreeBusyAddress,"
        s = s + "JobTitle,"
        s = s + "Journal,"
        s = s + "Language,"
        s = s + "LastModificationTime,"
        s = s + "LastName,"
        s = s + "LastNameAndFirstName,"
        s = s + "MailingAddress,"
        s = s + "MailingAddressCity,"
        s = s + "MailingAddressCountry,"
        s = s + "MailingAddressPostalCode,"
        s = s + "MailingAddressPostOfficeBox,"
        s = s + "MailingAddressState,"
        s = s + "MailingAddressStreet,"
        s = s + "ManagerName,"
        s = s + "MiddleName,"
        s = s + "Mileage,"
        s = s + "MobileTelephoneNumber,"
        s = s + "NetMeetingAlias,"
        s = s + "NetMeetingServer,"
        s = s + "NickName,"
        s = s + "Title,"
        s = s + "Body,"
        s = s + "OfficeLocation,"
        s = s + "Subject "
        s = s + " FROM ContactsArchive"
        s = s + WhereClause

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from ContactsArchive"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ContactsArchive"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

End Class
