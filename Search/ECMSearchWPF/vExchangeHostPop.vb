Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

<Table("vExchangeHostPop")>
Partial Public Class vExchangeHostPop
    <Key>
    <Column(Order:=0)>
    <StringLength(100)>
    Public Property HostNameIp As String

    <Key>
    <Column(Order:=1)>
    <StringLength(80)>
    Public Property UserLoginID As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property LoginPw As String

    Public Property PortNbr As Integer?

    Public Property DeleteAfterDownload As Boolean?

    <StringLength(50)>
    Public Property RetentionCode As String

    Public Property SSL As Boolean?

    Public Property IMAP As Boolean?

    <StringLength(80)>
    Public Property FolderName As String

    <StringLength(80)>
    Public Property LibraryName As String

    Public Property isPublic As Boolean?

    Public Property DaysToHold As Integer?

    <StringLength(250)>
    Public Property strReject As String

    Public Property ConvertEmlToMSG As Boolean?
End Class
