
Imports System.ComponentModel

Module modDatabase

    Public Function DS2DT(Of T)(list As IList(Of T)) As DataTable
        Dim entityType As Type = GetType(T)
        Dim table As New DataTable()
        Dim properties As PropertyDescriptorCollection = TypeDescriptor.GetProperties(entityType)
        For Each prop As PropertyDescriptor In properties
            Try
                table.Columns.Add(prop.Name, If(Nullable.GetUnderlyingType(prop.PropertyType), prop.PropertyType))
            Catch ex As Exception
                Console.WriteLine("ERROR 0200B1: " + ex.Message)
            End Try
        Next
        For Each item As T In list
            Dim row As DataRow = table.NewRow()
            For Each prop As PropertyDescriptor In properties
                Try
                    row(prop.Name) = If(prop.GetValue(item), DBNull.Value)
                Catch ex As Exception
                    Console.WriteLine("ERROR 0300B1: " + ex.Message)
                End Try

            Next
            Try
                table.Rows.Add(row)
            Catch ex As Exception
                Console.WriteLine("ERROR 0300B1: " + ex.Message)
            End Try

        Next
        Return table
    End Function


End Module
