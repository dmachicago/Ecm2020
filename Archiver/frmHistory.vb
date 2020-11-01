Public Class frmHistory

    Private Sub frmHistory_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        AddHistoryItems()
    End Sub
    Sub AddHistoryItems()

        lbHistory.Items.Clear()
        lbHistory.Items.Add("2010.12.27 - Force a backup of contacts if outlook is installed. (ECM)")
        lbHistory.Items.Add("2010.12.07 - Added the PDF OCR Extraction and text extraction functionality back into the standard license. (ECM)")
        lbHistory.Items.Add("2010.12.07 - Removed all references to Crystal Reports as Microsoft sold the rights. (ECM)")
        lbHistory.Items.Add("2010.11.30 - Allowed the EMAIL folder display window to expand. (Advent)")
        lbHistory.Items.Add("2010.11.25 - Created as a standalone applciation. (ECM)")

    End Sub


    Private Sub lbHistory_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbHistory.SelectedIndexChanged

    End Sub
End Class
