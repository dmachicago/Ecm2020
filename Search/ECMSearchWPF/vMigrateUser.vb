Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class vMigrateUser
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property ECM_UserName As String

    <StringLength(50)>
    Public Property ECM_UserID As String

    <StringLength(254)>
    Public Property ECM_UserPW As String

    <StringLength(254)>
    Public Property ECM_UserEmail As String

    <Key>
    <Column(Order:=1)>
    <StringLength(2)>
    Public Property ECM_GroupName As String

    <Key>
    <Column(Order:=2)>
    <StringLength(2)>
    Public Property ECM_Library As String

    <Key>
    <Column(Order:=3)>
    <StringLength(1)>
    Public Property ECM_Authority As String

    Public Property ECM_ClientOnly As Boolean?
End Class
