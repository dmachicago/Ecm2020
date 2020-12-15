' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="popupReviewSearchParms.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************


Imports System.Data

''' <summary>
''' Class popupReviewSearchParms.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class popupReviewSearchParms

    ''' <summary>
    ''' The dm
    ''' </summary>
    Dim DM As New clsDatasetMgt
    ''' <summary>
    ''' The dsparms
    ''' </summary>
    Dim DSPARMS As New DataSet
    ''' <summary>
    ''' The dt
    ''' </summary>
    Dim DT As New DataTable

    ''' <summary>
    ''' Initializes a new instance of the <see cref="popupReviewSearchParms"/> class.
    ''' </summary>
    Public Sub New()
        InitializeComponent()


        'Dim obj As Object = ListOfSearchTerms

        DSPARMS = DM.ConvertObjDS_SearchTerms()

        dgParms.ItemsSource = New DataView(DSPARMS.Tables(0))
        dgParms.Items.Refresh()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the OKButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.Close()
    End Sub


    ''' <summary>
    ''' Handles the Click event of the btnCopy control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
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

    ''' <summary>
    ''' Handles the Unloaded event of the popupReviewSearchParms control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub popupReviewSearchParms_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        Console.WriteLine("Closing window")
    End Sub
End Class
