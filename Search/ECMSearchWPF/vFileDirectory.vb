Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

<Table("vFileDirectory")>
Partial Public Class vFileDirectory
    <Key>
    <Column(Order:=0)>
    <StringLength(449)>
    Public Property ContainerName As String

    <StringLength(50)>
    Public Property UserID As String

    <Key>
    <Column(Order:=1)>
    <StringLength(1)>
    Public Property ContentTypeCode As String
End Class
