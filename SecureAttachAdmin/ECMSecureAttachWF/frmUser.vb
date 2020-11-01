Imports System.Data.SqlClient
Imports ECMEncryption

Public Class frmUser

    Dim ENC As New ECMEncrypt
    Dim UM As New clsUserMgt

    Dim DictSecure As Dictionary(Of String, String) = New Dictionary(Of String, String)
    Dim DictRebo As Dictionary(Of String, String) = New Dictionary(Of String, String)

    Private Sub SplitContainer1_Panel2_Paint(sender As Object, e As PaintEventArgs) Handles SplitContainer1.Panel2.Paint

    End Sub

    Private Sub dgSecureServer_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgSecureServer.CellContentClick

    End Sub

    Private Sub dgRepo_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgRepo.CellContentClick

    End Sub

    Private Sub btnLoadSecure_Click(sender As Object, e As EventArgs) Handles btnLoadSecure.Click
        UM.SyncPW()
        UM.getActiveUsers()
        fillSecureGrid()
    End Sub



    Sub fillSecureGrid()

        UM.SyncPW()

        Dim Sql As String = "select UserID, SvrName,DBName,InstanceName,RepoID,CreateDate from UserRepo order by UserID"
        Dim dtb As New DataTable

        Using cnn As New SqlConnection(gGatewayCS)
            cnn.Open()
            Using dad As New SqlDataAdapter(Sql, cnn)
                dad.Fill(dtb)
            End Using
            cnn.Close()
        End Using

        dgSecureServer.DataSource = dtb
        dgSecureServer.Refresh()
    End Sub

    Private Sub btnLoadRepo_Click(sender As Object, e As EventArgs) Handles btnLoadRepo.Click
        Dim Sql As String = "SELECT [UserID]
                          ,[UserName]
                          ,[EmailAddress]
                          ,[Admin]
                          ,[isActive]
                          ,[RowGuid]
                      FROM [Users]
                      order by UserID"

        Dim dtb As New DataTable

        Using cnn As New SqlConnection(gRepoCS)
            cnn.Open()
            Using dad As New SqlDataAdapter(Sql, cnn)
                dad.Fill(dtb)
            End Using
            cnn.Close()
        End Using

        dgRepo.DataSource = dtb
        dgRepo.Refresh()
    End Sub

    Private Sub setActiveFlag(guid As String, activeflag As String)
        Try
            activeflag = activeflag.ToUpper
            Dim S As String = "Update [Users] set isActive = '" + activeflag + "' where RowGuid = '" + guid + "' "
            Using repoconn As New SqlConnection(gRepoCS)
                Using cmd2 As SqlCommand = repoconn.CreateCommand()
                    cmd2.CommandText = S
                    cmd2.CommandType = CommandType.Text
                    cmd2.Connection.Open()
                    cmd2.ExecuteNonQuery()
                End Using
            End Using
        Catch ex As Exception
            MessageBox.Show("ERROR X1: " + ex.Message)
        End Try

    End Sub

    Private Sub btnAddRepo_Click(sender As Object, e As EventArgs) Handles btnAddRepo.Click

        Dim guid As String = ""
        Dim active As String = ""

        For Each row As DataGridViewRow In dgRepo.SelectedRows
            active = row.Cells("isActive").Value.ToString
            guid = row.Cells("RowGuid").Value.ToString
            setActiveFlag(guid, "Y")
        Next

        btnLoadSecure_Click(Nothing, Nothing)
        btnLoadRepo_Click(Nothing, Nothing)
        UM.SyncPW()
    End Sub

    Private Sub btnDelRepo_Click(sender As Object, e As EventArgs) Handles btnDelRepo.Click
        Dim guid As String = ""
        Dim active As String = ""

        For Each row As DataGridViewRow In dgRepo.SelectedRows
            active = row.Cells("isActive").Value.ToString
            guid = row.Cells("RowGuid").Value.ToString
            setActiveFlag(guid, "N")
        Next

        btnLoadSecure_Click(Nothing, Nothing)
        btnLoadRepo_Click(Nothing, Nothing)
        UM.SyncPW()

    End Sub
End Class