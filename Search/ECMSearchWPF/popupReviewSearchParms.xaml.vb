

Imports System.Data

Public Class popupReviewSearchParms

    Dim DM As New clsDatasetMgt
    Dim DSPARMS As New DataSet
    Dim DT As New DataTable

    Public Sub New()
        InitializeComponent()


        'Dim obj As Object = ListOfSearchTerms

        DSPARMS = DM.ConvertObjDS_SearchTerms()

        dgParms.ItemsSource = New DataView(DSPARMS.Tables(0))
        dgParms.Items.Refresh()

    End Sub

    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.Close()
    End Sub


    Private Sub btnCopy_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnCopy.Click
        Dim sText As String = ""

        For I As Integer = 0 To dgParms.Items.Count - 1
            Try
                sText += dgParms.Items(I).Item("Term") + ", "
                sText += dgParms.Items(I).Item("TermVal") + ", "
                sText += dgParms.Items(I).Item("SearchTypeCode") + ", "
                sText += dgParms.Items(I).Item("TermDataType") + vbCrLf
            Catch ex As Exception
                Console.WriteLine("Missing Item #" + I.ToString)
            End Try

        Next

        txtParms.SelectAll()
        txtParms.Cut()
        txtParms.AppendText(sText)
        txtParms.SelectAll()
        txtParms.Copy()

        MessageBox.Show("All parameters are in the clipboard.")

    End Sub

    Private Sub popupReviewSearchParms_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        Console.WriteLine("Closing window")
    End Sub
End Class
