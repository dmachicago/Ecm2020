Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class vLibraryStat
    <Key>
    <Column(Order:=0)>
    <StringLength(80)>
    Public Property LibraryName As String

    <Key>
    <Column(Order:=1)>
    <StringLength(1)>
    Public Property isPublic As String

    Public Property Items As Integer?

    Public Property Members As Integer?

    <Key>
    <Column(Order:=2)>
    <StringLength(50)>
    Public Property UserID As String
End Class
