' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="gv_ContactsArchive.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

''' <summary>
''' Class gv_ContactsArchive.
''' </summary>
Partial Public Class gv_ContactsArchive
    ''' <summary>
    ''' Gets or sets the email1 address.
    ''' </summary>
    ''' <value>The email1 address.</value>
    <Key>
    <Column(Order:=0)>
    <StringLength(80)>
    Public Property Email1Address As String

    ''' <summary>
    ''' Gets or sets the full name.
    ''' </summary>
    ''' <value>The full name.</value>
    <Key>
    <Column(Order:=1)>
    <StringLength(80)>
    Public Property FullName As String

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property UserID As String

    ''' <summary>
    ''' Gets or sets the account.
    ''' </summary>
    ''' <value>The account.</value>
    <StringLength(4000)>
    Public Property Account As String

    ''' <summary>
    ''' Gets or sets the anniversary.
    ''' </summary>
    ''' <value>The anniversary.</value>
    <StringLength(4000)>
    Public Property Anniversary As String

    ''' <summary>
    ''' Gets or sets the application.
    ''' </summary>
    ''' <value>The application.</value>
    <StringLength(4000)>
    Public Property Application As String

    ''' <summary>
    ''' Gets or sets the name of the assistant.
    ''' </summary>
    ''' <value>The name of the assistant.</value>
    <StringLength(4000)>
    Public Property AssistantName As String

    ''' <summary>
    ''' Gets or sets the assistant telephone number.
    ''' </summary>
    ''' <value>The assistant telephone number.</value>
    <StringLength(4000)>
    Public Property AssistantTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the billing information.
    ''' </summary>
    ''' <value>The billing information.</value>
    <StringLength(4000)>
    Public Property BillingInformation As String

    ''' <summary>
    ''' Gets or sets the birthday.
    ''' </summary>
    ''' <value>The birthday.</value>
    <StringLength(4000)>
    Public Property Birthday As String

    ''' <summary>
    ''' Gets or sets the business2 telephone number.
    ''' </summary>
    ''' <value>The business2 telephone number.</value>
    <StringLength(4000)>
    Public Property Business2TelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the business address.
    ''' </summary>
    ''' <value>The business address.</value>
    <StringLength(4000)>
    Public Property BusinessAddress As String

    ''' <summary>
    ''' Gets or sets the business address city.
    ''' </summary>
    ''' <value>The business address city.</value>
    <StringLength(4000)>
    Public Property BusinessAddressCity As String

    ''' <summary>
    ''' Gets or sets the business address country.
    ''' </summary>
    ''' <value>The business address country.</value>
    <StringLength(4000)>
    Public Property BusinessAddressCountry As String

    ''' <summary>
    ''' Gets or sets the business address postal code.
    ''' </summary>
    ''' <value>The business address postal code.</value>
    <StringLength(4000)>
    Public Property BusinessAddressPostalCode As String

    ''' <summary>
    ''' Gets or sets the business address post office box.
    ''' </summary>
    ''' <value>The business address post office box.</value>
    <StringLength(4000)>
    Public Property BusinessAddressPostOfficeBox As String

    ''' <summary>
    ''' Gets or sets the state of the business address.
    ''' </summary>
    ''' <value>The state of the business address.</value>
    <StringLength(4000)>
    Public Property BusinessAddressState As String

    ''' <summary>
    ''' Gets or sets the business address street.
    ''' </summary>
    ''' <value>The business address street.</value>
    <StringLength(4000)>
    Public Property BusinessAddressStreet As String

    ''' <summary>
    ''' Gets or sets the type of the business card.
    ''' </summary>
    ''' <value>The type of the business card.</value>
    <StringLength(4000)>
    Public Property BusinessCardType As String

    ''' <summary>
    ''' Gets or sets the business fax number.
    ''' </summary>
    ''' <value>The business fax number.</value>
    <StringLength(4000)>
    Public Property BusinessFaxNumber As String

    ''' <summary>
    ''' Gets or sets the business home page.
    ''' </summary>
    ''' <value>The business home page.</value>
    <StringLength(4000)>
    Public Property BusinessHomePage As String

    ''' <summary>
    ''' Gets or sets the business telephone number.
    ''' </summary>
    ''' <value>The business telephone number.</value>
    <StringLength(4000)>
    Public Property BusinessTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the callback telephone number.
    ''' </summary>
    ''' <value>The callback telephone number.</value>
    <StringLength(4000)>
    Public Property CallbackTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the car telephone number.
    ''' </summary>
    ''' <value>The car telephone number.</value>
    <StringLength(4000)>
    Public Property CarTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the categories.
    ''' </summary>
    ''' <value>The categories.</value>
    <StringLength(4000)>
    Public Property Categories As String

    ''' <summary>
    ''' Gets or sets the children.
    ''' </summary>
    ''' <value>The children.</value>
    <StringLength(4000)>
    Public Property Children As String

    ''' <summary>
    ''' Gets or sets the x class.
    ''' </summary>
    ''' <value>The x class.</value>
    <StringLength(4000)>
    Public Property xClass As String

    ''' <summary>
    ''' Gets or sets the companies.
    ''' </summary>
    ''' <value>The companies.</value>
    <StringLength(4000)>
    Public Property Companies As String

    ''' <summary>
    ''' Gets or sets the name of the company.
    ''' </summary>
    ''' <value>The name of the company.</value>
    <StringLength(4000)>
    Public Property CompanyName As String

    ''' <summary>
    ''' Gets or sets the name of the computer network.
    ''' </summary>
    ''' <value>The name of the computer network.</value>
    <StringLength(4000)>
    Public Property ComputerNetworkName As String

    ''' <summary>
    ''' Gets or sets the conflicts.
    ''' </summary>
    ''' <value>The conflicts.</value>
    <StringLength(4000)>
    Public Property Conflicts As String

    ''' <summary>
    ''' Gets or sets the conversation topic.
    ''' </summary>
    ''' <value>The conversation topic.</value>
    <StringLength(4000)>
    Public Property ConversationTopic As String

    ''' <summary>
    ''' Gets or sets the creation time.
    ''' </summary>
    ''' <value>The creation time.</value>
    <StringLength(4000)>
    Public Property CreationTime As String

    ''' <summary>
    ''' Gets or sets the customer identifier.
    ''' </summary>
    ''' <value>The customer identifier.</value>
    <StringLength(4000)>
    Public Property CustomerID As String

    ''' <summary>
    ''' Gets or sets the department.
    ''' </summary>
    ''' <value>The department.</value>
    <StringLength(4000)>
    Public Property Department As String

    ''' <summary>
    ''' Gets or sets the type of the email1 address.
    ''' </summary>
    ''' <value>The type of the email1 address.</value>
    <StringLength(4000)>
    Public Property Email1AddressType As String

    ''' <summary>
    ''' Gets or sets the display name of the email1.
    ''' </summary>
    ''' <value>The display name of the email1.</value>
    <StringLength(4000)>
    Public Property Email1DisplayName As String

    ''' <summary>
    ''' Gets or sets the email1 entry identifier.
    ''' </summary>
    ''' <value>The email1 entry identifier.</value>
    <StringLength(4000)>
    Public Property Email1EntryID As String

    ''' <summary>
    ''' Gets or sets the email2 address.
    ''' </summary>
    ''' <value>The email2 address.</value>
    <StringLength(4000)>
    Public Property Email2Address As String

    ''' <summary>
    ''' Gets or sets the type of the email2 address.
    ''' </summary>
    ''' <value>The type of the email2 address.</value>
    <StringLength(4000)>
    Public Property Email2AddressType As String

    ''' <summary>
    ''' Gets or sets the display name of the email2.
    ''' </summary>
    ''' <value>The display name of the email2.</value>
    <StringLength(4000)>
    Public Property Email2DisplayName As String

    ''' <summary>
    ''' Gets or sets the email2 entry identifier.
    ''' </summary>
    ''' <value>The email2 entry identifier.</value>
    <StringLength(4000)>
    Public Property Email2EntryID As String

    ''' <summary>
    ''' Gets or sets the email3 address.
    ''' </summary>
    ''' <value>The email3 address.</value>
    <StringLength(4000)>
    Public Property Email3Address As String

    ''' <summary>
    ''' Gets or sets the type of the email3 address.
    ''' </summary>
    ''' <value>The type of the email3 address.</value>
    <StringLength(4000)>
    Public Property Email3AddressType As String

    ''' <summary>
    ''' Gets or sets the display name of the email3.
    ''' </summary>
    ''' <value>The display name of the email3.</value>
    <StringLength(4000)>
    Public Property Email3DisplayName As String

    ''' <summary>
    ''' Gets or sets the email3 entry identifier.
    ''' </summary>
    ''' <value>The email3 entry identifier.</value>
    <StringLength(4000)>
    Public Property Email3EntryID As String

    ''' <summary>
    ''' Gets or sets the file as.
    ''' </summary>
    ''' <value>The file as.</value>
    <StringLength(4000)>
    Public Property FileAs As String

    ''' <summary>
    ''' Gets or sets the first name.
    ''' </summary>
    ''' <value>The first name.</value>
    <StringLength(4000)>
    Public Property FirstName As String

    ''' <summary>
    ''' Gets or sets the FTP site.
    ''' </summary>
    ''' <value>The FTP site.</value>
    <StringLength(4000)>
    Public Property FTPSite As String

    ''' <summary>
    ''' Gets or sets the gender.
    ''' </summary>
    ''' <value>The gender.</value>
    <StringLength(4000)>
    Public Property Gender As String

    ''' <summary>
    ''' Gets or sets the government identifier number.
    ''' </summary>
    ''' <value>The government identifier number.</value>
    <StringLength(4000)>
    Public Property GovernmentIDNumber As String

    ''' <summary>
    ''' Gets or sets the hobby.
    ''' </summary>
    ''' <value>The hobby.</value>
    <StringLength(4000)>
    Public Property Hobby As String

    ''' <summary>
    ''' Gets or sets the home2 telephone number.
    ''' </summary>
    ''' <value>The home2 telephone number.</value>
    <StringLength(4000)>
    Public Property Home2TelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the home address.
    ''' </summary>
    ''' <value>The home address.</value>
    <StringLength(4000)>
    Public Property HomeAddress As String

    ''' <summary>
    ''' Gets or sets the home address country.
    ''' </summary>
    ''' <value>The home address country.</value>
    <StringLength(4000)>
    Public Property HomeAddressCountry As String

    ''' <summary>
    ''' Gets or sets the home address postal code.
    ''' </summary>
    ''' <value>The home address postal code.</value>
    <StringLength(4000)>
    Public Property HomeAddressPostalCode As String

    ''' <summary>
    ''' Gets or sets the home address post office box.
    ''' </summary>
    ''' <value>The home address post office box.</value>
    <StringLength(4000)>
    Public Property HomeAddressPostOfficeBox As String

    ''' <summary>
    ''' Gets or sets the state of the home address.
    ''' </summary>
    ''' <value>The state of the home address.</value>
    <StringLength(4000)>
    Public Property HomeAddressState As String

    ''' <summary>
    ''' Gets or sets the home address street.
    ''' </summary>
    ''' <value>The home address street.</value>
    <StringLength(4000)>
    Public Property HomeAddressStreet As String

    ''' <summary>
    ''' Gets or sets the home fax number.
    ''' </summary>
    ''' <value>The home fax number.</value>
    <StringLength(4000)>
    Public Property HomeFaxNumber As String

    ''' <summary>
    ''' Gets or sets the home telephone number.
    ''' </summary>
    ''' <value>The home telephone number.</value>
    <StringLength(4000)>
    Public Property HomeTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the im address.
    ''' </summary>
    ''' <value>The im address.</value>
    <StringLength(4000)>
    Public Property IMAddress As String

    ''' <summary>
    ''' Gets or sets the importance.
    ''' </summary>
    ''' <value>The importance.</value>
    <StringLength(4000)>
    Public Property Importance As String

    ''' <summary>
    ''' Gets or sets the initials.
    ''' </summary>
    ''' <value>The initials.</value>
    <StringLength(4000)>
    Public Property Initials As String

    ''' <summary>
    ''' Gets or sets the internet free busy address.
    ''' </summary>
    ''' <value>The internet free busy address.</value>
    <StringLength(4000)>
    Public Property InternetFreeBusyAddress As String

    ''' <summary>
    ''' Gets or sets the job title.
    ''' </summary>
    ''' <value>The job title.</value>
    <StringLength(4000)>
    Public Property JobTitle As String

    ''' <summary>
    ''' Gets or sets the journal.
    ''' </summary>
    ''' <value>The journal.</value>
    <StringLength(4000)>
    Public Property Journal As String

    ''' <summary>
    ''' Gets or sets the language.
    ''' </summary>
    ''' <value>The language.</value>
    <StringLength(4000)>
    Public Property Language As String

    ''' <summary>
    ''' Gets or sets the last modification time.
    ''' </summary>
    ''' <value>The last modification time.</value>
    <StringLength(4000)>
    Public Property LastModificationTime As String

    ''' <summary>
    ''' Gets or sets the last name.
    ''' </summary>
    ''' <value>The last name.</value>
    <StringLength(4000)>
    Public Property LastName As String

    ''' <summary>
    ''' Gets or sets the last name of the name and first.
    ''' </summary>
    ''' <value>The last name of the name and first.</value>
    <StringLength(4000)>
    Public Property LastNameAndFirstName As String

    ''' <summary>
    ''' Gets or sets the mailing address.
    ''' </summary>
    ''' <value>The mailing address.</value>
    <StringLength(4000)>
    Public Property MailingAddress As String

    ''' <summary>
    ''' Gets or sets the mailing address city.
    ''' </summary>
    ''' <value>The mailing address city.</value>
    <StringLength(4000)>
    Public Property MailingAddressCity As String

    ''' <summary>
    ''' Gets or sets the mailing address country.
    ''' </summary>
    ''' <value>The mailing address country.</value>
    <StringLength(4000)>
    Public Property MailingAddressCountry As String

    ''' <summary>
    ''' Gets or sets the mailing address postal code.
    ''' </summary>
    ''' <value>The mailing address postal code.</value>
    <StringLength(4000)>
    Public Property MailingAddressPostalCode As String

    ''' <summary>
    ''' Gets or sets the mailing address post office box.
    ''' </summary>
    ''' <value>The mailing address post office box.</value>
    <StringLength(4000)>
    Public Property MailingAddressPostOfficeBox As String

    ''' <summary>
    ''' Gets or sets the state of the mailing address.
    ''' </summary>
    ''' <value>The state of the mailing address.</value>
    <StringLength(4000)>
    Public Property MailingAddressState As String

    ''' <summary>
    ''' Gets or sets the mailing address street.
    ''' </summary>
    ''' <value>The mailing address street.</value>
    <StringLength(4000)>
    Public Property MailingAddressStreet As String

    ''' <summary>
    ''' Gets or sets the name of the manager.
    ''' </summary>
    ''' <value>The name of the manager.</value>
    <StringLength(4000)>
    Public Property ManagerName As String

    ''' <summary>
    ''' Gets or sets the name of the middle.
    ''' </summary>
    ''' <value>The name of the middle.</value>
    <StringLength(4000)>
    Public Property MiddleName As String

    ''' <summary>
    ''' Gets or sets the mileage.
    ''' </summary>
    ''' <value>The mileage.</value>
    <StringLength(4000)>
    Public Property Mileage As String

    ''' <summary>
    ''' Gets or sets the mobile telephone number.
    ''' </summary>
    ''' <value>The mobile telephone number.</value>
    <StringLength(4000)>
    Public Property MobileTelephoneNumber As String

    ''' <summary>
    ''' Gets or sets the net meeting alias.
    ''' </summary>
    ''' <value>The net meeting alias.</value>
    <StringLength(4000)>
    Public Property NetMeetingAlias As String

    ''' <summary>
    ''' Gets or sets the net meeting server.
    ''' </summary>
    ''' <value>The net meeting server.</value>
    <StringLength(4000)>
    Public Property NetMeetingServer As String

    ''' <summary>
    ''' Gets or sets the name of the nick.
    ''' </summary>
    ''' <value>The name of the nick.</value>
    <StringLength(4000)>
    Public Property NickName As String

    ''' <summary>
    ''' Gets or sets the title.
    ''' </summary>
    ''' <value>The title.</value>
    <StringLength(4000)>
    Public Property Title As String

    ''' <summary>
    ''' Gets or sets the body.
    ''' </summary>
    ''' <value>The body.</value>
    <StringLength(4000)>
    Public Property Body As String

    ''' <summary>
    ''' Gets or sets the office location.
    ''' </summary>
    ''' <value>The office location.</value>
    <StringLength(4000)>
    Public Property OfficeLocation As String

    ''' <summary>
    ''' Gets or sets the subject.
    ''' </summary>
    ''' <value>The subject.</value>
    <StringLength(4000)>
    Public Property Subject As String

    ''' <summary>
    ''' Gets or sets the name of the hive connection.
    ''' </summary>
    ''' <value>The name of the hive connection.</value>
    <StringLength(50)>
    Public Property HiveConnectionName As String

    ''' <summary>
    ''' Gets or sets a value indicating whether [hive active].
    ''' </summary>
    ''' <value><c>null</c> if [hive active] contains no value, <c>true</c> if [hive active]; otherwise, <c>false</c>.</value>
    Public Property HiveActive As Boolean?

    ''' <summary>
    ''' Gets or sets the name of the repo SVR.
    ''' </summary>
    ''' <value>The name of the repo SVR.</value>
    <StringLength(254)>
    Public Property RepoSvrName As String

    ''' <summary>
    ''' Gets or sets the row creation date.
    ''' </summary>
    ''' <value>The row creation date.</value>
    Public Property RowCreationDate As Date?

    ''' <summary>
    ''' Gets or sets the row last mod date.
    ''' </summary>
    ''' <value>The row last mod date.</value>
    Public Property RowLastModDate As Date?

    ''' <summary>
    ''' Gets or sets the name of the repo.
    ''' </summary>
    ''' <value>The name of the repo.</value>
    <StringLength(50)>
    Public Property RepoName As String

    ''' <summary>
    ''' Gets or sets the row unique identifier.
    ''' </summary>
    ''' <value>The row unique identifier.</value>
    Public Property RowGuid As Guid?
End Class
