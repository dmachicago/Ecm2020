Public Class frmHelp
Public MsgToDisplay AS String  = "" 
Public CallingScreenName AS String  = "" 
Public CaptionName AS String  = "" 


    Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Private Sub frmHelp_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        rtbText.Text = MsgToDisplay
        Me.lblScreenName.Text = CallingScreenName 
        Me.lblObject.Text = CaptionName 
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        Me.Close()
    End Sub
End Class
