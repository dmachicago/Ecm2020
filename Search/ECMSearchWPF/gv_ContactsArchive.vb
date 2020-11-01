Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class gv_ContactsArchive
    <Key>
    <Column(Order:=0)>
    <StringLength(80)>
    Public Property Email1Address As String

    <Key>
    <Column(Order:=1)>
    <StringLength(80)>
    Public Property FullName As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property UserID As String

    <StringLength(4000)>
    Public Property Account As String

    <StringLength(4000)>
    Public Property Anniversary As String

    <StringLength(4000)>
    Public Property Application As String

    <StringLength(4000)>
    Public Property AssistantName As String

    <StringLength(4000)>
    Public Property AssistantTelephoneNumber As String

    <StringLength(4000)>
    Public Property BillingInformation As String

    <StringLength(4000)>
    Public Property Birthday As String

    <StringLength(4000)>
    Public Property Business2TelephoneNumber As String

    <StringLength(4000)>
    Public Property BusinessAddress As String

    <StringLength(4000)>
    Public Property BusinessAddressCity As String

    <StringLength(4000)>
    Public Property BusinessAddressCountry As String

    <StringLength(4000)>
    Public Property BusinessAddressPostalCode As String

    <StringLength(4000)>
    Public Property BusinessAddressPostOfficeBox As String

    <StringLength(4000)>
    Public Property BusinessAddressState As String

    <StringLength(4000)>
    Public Property BusinessAddressStreet As String

    <StringLength(4000)>
    Public Property BusinessCardType As String

    <StringLength(4000)>
    Public Property BusinessFaxNumber As String

    <StringLength(4000)>
    Public Property BusinessHomePage As String

    <StringLength(4000)>
    Public Property BusinessTelephoneNumber As String

    <StringLength(4000)>
    Public Property CallbackTelephoneNumber As String

    <StringLength(4000)>
    Public Property CarTelephoneNumber As String

    <StringLength(4000)>
    Public Property Categories As String

    <StringLength(4000)>
    Public Property Children As String

    <StringLength(4000)>
    Public Property xClass As String

    <StringLength(4000)>
    Public Property Companies As String

    <StringLength(4000)>
    Public Property CompanyName As String

    <StringLength(4000)>
    Public Property ComputerNetworkName As String

    <StringLength(4000)>
    Public Property Conflicts As String

    <StringLength(4000)>
    Public Property ConversationTopic As String

    <StringLength(4000)>
    Public Property CreationTime As String

    <StringLength(4000)>
    Public Property CustomerID As String

    <StringLength(4000)>
    Public Property Department As String

    <StringLength(4000)>
    Public Property Email1AddressType As String

    <StringLength(4000)>
    Public Property Email1DisplayName As String

    <StringLength(4000)>
    Public Property Email1EntryID As String

    <StringLength(4000)>
    Public Property Email2Address As String

    <StringLength(4000)>
    Public Property Email2AddressType As String

    <StringLength(4000)>
    Public Property Email2DisplayName As String

    <StringLength(4000)>
    Public Property Email2EntryID As String

    <StringLength(4000)>
    Public Property Email3Address As String

    <StringLength(4000)>
    Public Property Email3AddressType As String

    <StringLength(4000)>
    Public Property Email3DisplayName As String

    <StringLength(4000)>
    Public Property Email3EntryID As String

    <StringLength(4000)>
    Public Property FileAs As String

    <StringLength(4000)>
    Public Property FirstName As String

    <StringLength(4000)>
    Public Property FTPSite As String

    <StringLength(4000)>
    Public Property Gender As String

    <StringLength(4000)>
    Public Property GovernmentIDNumber As String

    <StringLength(4000)>
    Public Property Hobby As String

    <StringLength(4000)>
    Public Property Home2TelephoneNumber As String

    <StringLength(4000)>
    Public Property HomeAddress As String

    <StringLength(4000)>
    Public Property HomeAddressCountry As String

    <StringLength(4000)>
    Public Property HomeAddressPostalCode As String

    <StringLength(4000)>
    Public Property HomeAddressPostOfficeBox As String

    <StringLength(4000)>
    Public Property HomeAddressState As String

    <StringLength(4000)>
    Public Property HomeAddressStreet As String

    <StringLength(4000)>
    Public Property HomeFaxNumber As String

    <StringLength(4000)>
    Public Property HomeTelephoneNumber As String

    <StringLength(4000)>
    Public Property IMAddress As String

    <StringLength(4000)>
    Public Property Importance As String

    <StringLength(4000)>
    Public Property Initials As String

    <StringLength(4000)>
    Public Property InternetFreeBusyAddress As String

    <StringLength(4000)>
    Public Property JobTitle As String

    <StringLength(4000)>
    Public Property Journal As String

    <StringLength(4000)>
    Public Property Language As String

    <StringLength(4000)>
    Public Property LastModificationTime As String

    <StringLength(4000)>
    Public Property LastName As String

    <StringLength(4000)>
    Public Property LastNameAndFirstName As String

    <StringLength(4000)>
    Public Property MailingAddress As String

    <StringLength(4000)>
    Public Property MailingAddressCity As String

    <StringLength(4000)>
    Public Property MailingAddressCountry As String

    <StringLength(4000)>
    Public Property MailingAddressPostalCode As String

    <StringLength(4000)>
    Public Property MailingAddressPostOfficeBox As String

    <StringLength(4000)>
    Public Property MailingAddressState As String

    <StringLength(4000)>
    Public Property MailingAddressStreet As String

    <StringLength(4000)>
    Public Property ManagerName As String

    <StringLength(4000)>
    Public Property MiddleName As String

    <StringLength(4000)>
    Public Property Mileage As String

    <StringLength(4000)>
    Public Property MobileTelephoneNumber As String

    <StringLength(4000)>
    Public Property NetMeetingAlias As String

    <StringLength(4000)>
    Public Property NetMeetingServer As String

    <StringLength(4000)>
    Public Property NickName As String

    <StringLength(4000)>
    Public Property Title As String

    <StringLength(4000)>
    Public Property Body As String

    <StringLength(4000)>
    Public Property OfficeLocation As String

    <StringLength(4000)>
    Public Property Subject As String

    <StringLength(50)>
    Public Property HiveConnectionName As String

    Public Property HiveActive As Boolean?

    <StringLength(254)>
    Public Property RepoSvrName As String

    Public Property RowCreationDate As Date?

    Public Property RowLastModDate As Date?

    <StringLength(50)>
    Public Property RepoName As String

    Public Property RowGuid As Guid?
End Class
