Imports System.IO
Imports System.Data.SqlClient

Public Class clsSqlReaderStream
    Inherits Stream
    Private reader As SqlDataReader
    Private columnIndex As Integer
    Private m_position As Long

    Public Sub New(ByVal reader As SqlDataReader, ByVal columnIndex As Integer)
        Me.reader = reader
        Me.columnIndex = columnIndex
    End Sub

    Public Overrides Property Position() As Long
        Get
            Return m_position
        End Get
        Set(ByVal value As Long)
            Throw New NotImplementedException()
        End Set
    End Property

    Public Overrides Function Read(ByVal buffer As Byte(), ByVal offset As Integer, ByVal count As Integer) As Integer
        Dim bytesRead As Long = reader.GetBytes(columnIndex, m_position, buffer, offset, count)
        m_position += bytesRead
        Return CInt(bytesRead)
    End Function

    Public Overrides ReadOnly Property CanRead() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Overrides ReadOnly Property CanSeek() As Boolean
        Get
            Return false
        End Get
    End Property

    Public Overrides ReadOnly Property CanWrite() As Boolean
        Get
            Return false
        End Get
    End Property

    Public Overrides Sub Flush()
        Throw New NotImplementedException()
    End Sub

    Public Overrides ReadOnly Property Length() As Long
        Get
            Throw New NotImplementedException()
        End Get
    End Property

    Public Overrides Function Seek(ByVal offset As Long, ByVal origin As SeekOrigin) As Long
        Throw New NotImplementedException()
    End Function

    Public Overrides Sub SetLength(ByVal value As Long)
        Throw New NotImplementedException()
    End Sub

    Public Overrides Sub Write(ByVal buffer As Byte(), ByVal offset As Integer, ByVal count As Integer)
        Throw New NotImplementedException()
    End Sub

    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso reader IsNot Nothing Then
            reader.Dispose()
            reader = Nothing
        End If
        MyBase.Dispose(disposing)
    End Sub

End Class
