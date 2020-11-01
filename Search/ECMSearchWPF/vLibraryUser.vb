Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class vLibraryUser
    <Key>
    <Column(Order:=0)>
    <StringLength(50)>
    Public Property UserID As String

    <Key>
    <Column(Order:=1)>
    <StringLength(80)>
    Public Property LibraryName As String

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property LibraryOwnerUserID As String

    <Key>
    <Column(Order:=3)>
    <StringLength(50)>
    Public Property UserName As String
End Class
