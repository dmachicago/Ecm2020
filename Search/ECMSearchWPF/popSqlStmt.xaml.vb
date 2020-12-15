' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="popSqlStmt.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class popSqlStmt.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class popSqlStmt

    ''' <summary>
    ''' The SQL text
    ''' </summary>
    Dim SqlText As String = ""
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    ''' <summary>
    ''' The userid
    ''' </summary>
    Dim Userid As String

    ''' <summary>
    ''' Initializes a new instance of the <see cref="popSqlStmt"/> class.
    ''' </summary>
    ''' <param name="rtbSqlText">The RTB SQL text.</param>
    Public Sub New(ByVal rtbSqlText As String)
        InitializeComponent()

        Userid = _UserID
        COMMON.SaveClick(6930, Userid)

        SqlText = rtbSqlText
        rtbSql.Text = SqlText

    End Sub

    ''' <summary>
    ''' Handles the Click event of the CancelButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        'Me.Visibility = Windows.Visibility.Collapsed
        Me.Close()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlCopy control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlCopy_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlCopy.Click
        Try
            Clipboard.SetText(rtbSql.Text)
            MessageBox.Show("Qry in clipboard")
        Catch ex As Exception
            MessageBox.Show("Could not place Qry in clipboard, copy and paste from the window please.")
        End Try

    End Sub

End Class
