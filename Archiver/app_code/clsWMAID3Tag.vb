Imports System
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.ComponentModel


Public Class clsWMAID3Tag

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    ' This class will read all the attributes from the ContextBlock and ExtendedContextBlock in a WMA file
    ' It makes available the attributes that are most interesting directly, and allows the retrieval on any string attribute by name.
    ' Could easily be extended to allow the retrieval of non-string attributes, I just didn't need them.
    ' I couldn't find an easy way to have a resumable enumeration over a hash table (there's not items() array) I didn't 
    ' implement an enumerator.  It wouldn't be hard to do, just clumsy.
Public FQN AS String  = "" 
    Public title, artist, album, genre, copyright, description, rating As String
    Public year, track As Integer
    Private stream As FileStream
    Private binRead As BinaryReader
    Private attrs As New Hashtable
    Private attrValues As New ArrayList
    Private Structure value
        Public dataType As Int16
        Public index As Integer
    End Structure
    ' WMA GUIDs
    Private hdrGUID As Guid = New Guid("75B22630-668E-11CF-A6D9-00AA0062CE6C")
    Private contentGUID As Guid = New Guid("75B22633-668E-11CF-A6D9-00AA0062CE6C")
    Private extendedContentGUID As Guid = New Guid("D2D0A440-E307-11D2-97F0-00A0C95EA850")


    Public Sub New(ByVal fn As String)


        Dim g As Guid
        Dim CBDone, ECBDone As Boolean
        Dim sizeBlock As Long
        Dim s As String
        Dim i As Integer


        Try
            stream = New FileStream(fn, FileMode.Open, FileAccess.Read)
            binRead = New BinaryReader(stream)
        Catch ex As Exception
            messagebox.show("Could not open " & fn)
            log.WriteToArchiveLog("clsWMAID3Tag : New : 9 : " + ex.Message)
            Return
        End Try


        readGUID(g)
        If Not Guid.op_Equality(g, hdrGUID) Then
            ' throw an exception
            Debug.Print("Invalid WMA file format, skipping file.")
            stream.Close()
            Return
        End If
        binRead.ReadInt64() ' the size of the entire block
        binRead.ReadInt32() ' the number of entries
        binRead.ReadBytes(2) ' two reserved bytes
        ' Process all the GUIDs until you get both the contextblock and the extendedcontextblock
        While readGUID(g)
            sizeBlock = binRead.ReadInt64() ' this is the size of the block
            ' shouldn't happen, but at least fail gracefully
            If binRead.BaseStream.Position + sizeBlock > stream.Length Then
                Exit While
            End If
            If Guid.op_Equality(g, contentGUID) Then
                processContentBlock()
                If ECBDone Then
                    Exit While
                End If
                CBDone = True
            ElseIf Guid.op_Equality(g, extendedContentGUID) Then
                processExtendedContentBlock()
                If CBDone Then
                    Exit While
                End If
                ECBDone = True
            Else
                ' not one we're interested in, skip it
                sizeBlock -= 24 ' already read the guid header info
                binRead.BaseStream.Position += sizeBlock
            End If
        End While


        ' Get the attributes we're interested in
        album = getStringAttribute("WM/AlbumTitle")
        genre = getStringAttribute("WM/Genre")
        s = getStringAttribute("WM/Year")
        If IsNumeric(s) Then
            year = CInt(s)
        End If
        s = getStringAttribute("WM/TrackNumber")
        ' could be n/<total>
        i = s.IndexOf("/")
        If Not i = -1 Then
            s = s.Substring(0, i)
        End If
        If IsNumeric(s) Then
            track = CInt(s)
        Else
            s = getStringAttribute("WM/Track")
            i = s.IndexOf("/")
            If Not i = -1 Then
                s = s.Substring(0, i)
            End If
            If IsNumeric(s) Then
                track = CInt(s)
            End If
        End If
    End Sub
    Private Function readUnicodeString(ByVal len As Int16) As String
        'Can't use .NET functions, since they expect the length field to be a single byte for strings < 256 chars
        Dim ch() As Char
        Dim i As Integer
        Dim k As Short


        ReDim ch(len - 2)
        For i = 0 To len - 2
            k = binRead.ReadInt16
            ch(i) = ChrW(k)
        Next
        k = binRead.ReadInt16
        Return New String(ch)
    End Function
    Private Function readUnicodeString() As String
        Dim datalen, len As Int16
        'Can't use .NET functions, since they expect the length field to be a single byte for strings < 256 chars
        datalen = binRead.ReadInt16
        len = CShort(datalen / 2) ' length in Unicode characters
        Return readUnicodeString(len)


    End Function
    Private Sub processExtendedContentBlock()
        Dim numAttrs, dataType, dataLen, sValue As Int16
        Dim attrName, strValue As String
        Dim bValue() As Byte
        Dim boolValue As Boolean
        Dim i, iValue, index As Integer
        Dim lValue As Long
        Dim valueObject As value
        Dim ch() As Char


        numAttrs = binRead.ReadInt16
        For i = 0 To numAttrs - 1
            attrName = readUnicodeString()
            dataType = binRead.ReadInt16
            Select Case dataType
                Case 0
                    strValue = readUnicodeString()
                    valueObject.dataType = 0
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(strValue)
                    index += 1


                Case 1
                    dataLen = binRead.ReadInt16
                    ReDim bValue(dataLen - 1)
                    bValue = binRead.ReadBytes(dataLen)
                    valueObject.dataType = 1
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(bValue)
                    index += 1


                Case 2
                    dataLen = binRead.ReadInt16
                    iValue = binRead.ReadInt32
                    If iValue = 0 Then
                        boolValue = False
                    Else
                        boolValue = True
                    End If
                    valueObject.dataType = 2
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(boolValue)
                    index += 1


                Case 3
                    dataLen = binRead.ReadInt16
                    iValue = binRead.ReadInt32
                    valueObject.dataType = 3
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(iValue)
                    index += 1


                Case 4
                    dataLen = binRead.ReadInt16
                    lValue = binRead.ReadInt64
                    valueObject.dataType = 4
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(lValue)
                    index += 1


                Case 5
                    dataLen = binRead.ReadInt16
                    sValue = binRead.ReadInt16
                    valueObject.dataType = 5
                    valueObject.index = index
                    attrs.Add(attrName, valueObject)
                    attrValues.Add(sValue)
                    index += 1


                Case Else
                    Throw New Exception("Bad value for datatype in Extended Content Block. Value = " & dataType)
            End Select
        Next
    End Sub
    Private Sub processContentBlock()
        Dim lTitle, lAuthor, lCopyright, lDescription, lRating, i As Short
        Dim ch() As Char


        lTitle = binRead.ReadInt16
        lAuthor = binRead.ReadInt16
        lCopyright = binRead.ReadInt16
        lDescription = binRead.ReadInt16
        lRating = binRead.ReadInt16
        If lTitle > 0 Then
            i = CShort(lTitle / 2)
            title = readUnicodeString(i)
        End If
        If lAuthor > 0 Then
            i = CShort(lAuthor / 2)
            artist = readUnicodeString(i)
        End If
        If lCopyright > 0 Then
            i = CShort(lCopyright / 2)
            copyright = readUnicodeString(i)
        End If
        If lDescription > 0 Then
            i = CShort(lDescription / 2)
            description = readUnicodeString(i)
        End If
        If lRating > 0 Then
            i = CShort(lRating / 2)
            rating = readUnicodeString(i)
        End If
    End Sub
    Private Function readGUID(ByRef g As Guid) As Boolean
        Dim int1 As Integer
        Dim shrt1, shrt2 As Short
        Dim b(6) As Byte


        Try
            int1 = binRead.ReadInt32
            If int1 = -1 Then
                Return False
            End If
            shrt1 = binRead.ReadInt16
            shrt2 = binRead.ReadInt16
            b = binRead.ReadBytes(8)
            g = New Guid(int1, shrt1, shrt2, b)
            Return True
        Catch ex As Exception
            Throw New Exception("Invalid WMA format.")
            log.WriteToArchiveLog("clsWMAID3Tag : readGUID : 180 : " + ex.Message)
        End Try
    End Function
    Public Function getStringAttribute(ByVal name As String) As String
        Dim s As String = ""
        Dim v As value


        If Not attrs.Contains(name) Then
            Return ""
        End If
        v = CType(attrs(name), value)
        If Not v.dataType = 0 Then
            ' it's not a string type
            Return ""
        Else
            Return CType(attrValues(v.index), String)
        End If
    End Function




End Class
