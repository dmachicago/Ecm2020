Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

<Table("vReassignedTable")>
Partial Public Class vReassignedTable
    <StringLength(50)>
    Public Property PrevUserName As String

    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ReassignedUserName As String

    <Key>
    <Column(Order:=1)>
    <StringLength(50)>
    Public Property PrevUserLoginID As String

    <StringLength(50)>
    Public Property ReassignedUserLoginID As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property PrevUserID As String

    <StringLength(50)>
    Public Property ReassignedUserID As String

    <StringLength(254)>
    Public Property PrevEmailAddress As String

    <StringLength(254)>
    Public Property PrevUserPassword As String

    <StringLength(1)>
    Public Property PrevAdmin As String

    <StringLength(1)>
    Public Property PrevisActive As String

    <StringLength(254)>
    Public Property ReassignedEmailAddress As String

    <StringLength(254)>
    Public Property ReassignedUserPassword As String

    <StringLength(1)>
    Public Property ReassignedAdmin As String

    <StringLength(1)>
    Public Property ReassignedisActive As String

    <Key>
    <Column(Order:=3)>
    Public Property ReassignmentDate As Date
End Class
