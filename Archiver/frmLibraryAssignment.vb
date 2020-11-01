Public Class frmLibraryAssignment

    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim isEmail As Boolean = False
    Dim tgtLibName As String = ""
    Dim FolderID As String = ""
    Dim EmailLib As New clsLIBEMAIL
    Dim ContentLib As New clsLIBDIRECTORY
    Public FolderName As String = ""

    Dim bHelpLoaded As Boolean = False
    Dim formloaded As Boolean = False

    Private Sub frmLibraryAssignment_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        formloaded = False
        GetLocation(Me)

        If HelpOn Then
            DBARCH.getFormTooltips(Me, TT, True)
            TT.Active = True
            bHelpLoaded = True
        Else
            TT.Active = False
        End If
        'Dim bGetScreenObjects As Boolean = True
        'If bGetScreenObjects Then DMA.getFormWidgets(Me)

        PopulateLibraryCombo()
        If FolderID.Length > 0 Then
            FolderName = DBARCH.getFolderNameById(FolderID)
        End If

        PopulateAssignedLibraryCombo()

        formloaded = True

    End Sub
    Public Sub setLibraryName(ByVal LibName As String)
        tgtLibName = LibName
        Me.cbLibrary.Text = tgtLibName
    End Sub
    Public Sub setFolderID(ByVal MailFolderID As String)
        FolderID = MailFolderID
    End Sub
    Public Sub setFolderName(ByVal tFolderName As String)
        txtFolderName.Text = tFolderName.Trim
        FolderName = tFolderName.Trim
    End Sub
    Sub PopulateLibraryCombo()

        Try
            Dim S As String = ""

            S = S + " SELECT [LibraryName]"
            S = S + " FROM  [Library]"
            S = S + " where userid = '" + gCurrUserGuidID + "'"
            S = S + " order by [LibraryName]"

            DBARCH.PopulateComboBox(Me.cbLibrary, "LibraryName", S)

        Catch ex As Exception
            SB.Text = "Failed to load Libraries."
        End Try

    End Sub

    Sub PopulateAssignedLibraryCombo()
        Dim S As String = ""
        Dim FolderName = txtFolderName.Text.Trim

        Me.cbAssignedLibs.Items.Clear()
        cbAssignedLibs.Text = ""

        If isEmail Then
            S = S + " SELECT  [LibraryName]"
            S = S + " FROM  [LibEmail]"
            S = S + " where [FolderName] = '" + FolderName + "'"
            DBARCH.PopulateComboBox(Me.cbAssignedLibs, "LibraryName", S)
        Else
            S = S + " SELECT  [LibraryName]"
            S = S + " FROM  [LibDirectory]"
            S = S + " where [DirectoryName] = '" + FolderName + "'"
            DBARCH.PopulateComboBox(Me.cbAssignedLibs, "LibraryName", S)
        End If

    End Sub
    Public Sub SetTypeContent(ByVal isDocument As Boolean)
        If isDocument = True Then
            isEmail = False
        Else
            isEmail = True
        End If
    End Sub

    Private Sub btnAssign_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAssign.Click

        Dim LibToAdd As String = Me.cbLibrary.Text
        FolderName = txtFolderName.Text.Trim
        Dim RecordsAdded As Integer = 0

        If isEmail Then
            Dim FolderID As String = DBARCH.getFolderIdByName(FolderName, gCurrUserGuidID)
            If FolderID.Length = 0 Then
                MessageBox.Show("Could not find Mailbox " + FolderName + " as an archived folder, skipping.")
                Return
            End If
            EmailLib.setEmailfolderentryid(FolderID)
            EmailLib.setLibraryname(LibToAdd)
            EmailLib.setUserid(gCurrUserGuidID)
            EmailLib.setFoldername(FolderName)
            '***************************************
            Dim b As Boolean = EmailLib.Insert
            '***************************************
            If b Then
                PopulateAssignedLibraryCombo()
                DBARCH.AddLibraryEmail(FolderName, LibToAdd, gCurrUserGuidID, RecordsAdded)
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "User '" + LID + "' assigned EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
                MessageBox.Show("Added email folder to library...")
            Else
                MessageBox.Show("ERROR: DID NOT Add email folder to library...")
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "ERROR: 3302.1.y - User '" + LID + "' failed to assign EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
            End If
        Else
            ContentLib.setDirectoryname(Me.txtFolderName.Text.Trim)
            ContentLib.setLibraryname(LibToAdd)
            ContentLib.setUserid(gCurrUserGuidID)
            '*******************************************
            Dim b As Boolean = ContentLib.Insert
            '*******************************************

            Dim bProcessSubDirs As Boolean = DBARCH.isSubDirProcessed(gCurrUserGuidID, Me.txtFolderName.Text.Trim)

            If b Then
                PopulateAssignedLibraryCombo()
                DBARCH.AddLibraryDirectory(Me.txtFolderName.Text.Trim, LibToAdd, gCurrUserGuidID, RecordsAdded, bProcessSubDirs)
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "User '" + LID + "' assigned directory '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
            Else
                MessageBox.Show("ERROR: DID NOT Add content folder to library...")
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "ERROR: 3302.1.x - User '" + LID + "' failed to assign directory '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd + "' on " + Now.ToString + "."
                LOG.WriteToArchiveLog(tMsg)
                DBARCH.AddSysMsg(tMsg)
            End If
        End If

        Dim LibName As String = LibToAdd
        LibName = UTIL.RemoveSingleQuotes(LibName)
        Dim S As String = "Select count(*) from LibraryItems where LibraryName like '" + LibName + "' "
        Dim iCnt As Integer = DBARCH.iCount(S)

        SB.Text = "Records in library: " + iCnt.ToString
    End Sub

    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemove.Click
        Me.Cursor = Cursors.AppStarting
        Dim LibToRemove As String = Me.cbAssignedLibs.Text.Trim

        LibToRemove = UTIL.RemoveSingleQuotes(LibToRemove)

        If isEmail Then
            FolderName = UTIL.RemoveSingleQuotes(FolderName)
            'Dim FolderName As String = Me.txtFolderName.Text.Trim
            FolderID = DBARCH.getFolderIdByName(FolderName, gCurrUserGuidID)
            Dim wc As String = EmailLib.wc_PK99(FolderName, Me.cbAssignedLibs.Text, gCurrUserGuidID)
            Dim b As Boolean = EmailLib.Delete(wc)

            Dim II As Integer = EmailLib.cnt_PI01_LibEmail(FolderName, LibToRemove)

            'Dim Mysql As String = ""
            'Mysql = "delete from LibEmail where LibraryName = '" + LibToRemove  + "'"
            'b = DBARCH.ExecuteSqlNewConn(Mysql)

            'Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
            'b = DBARCH.ExecuteSqlNewConn(Mysql)

            If b Then
                MessageBox.Show("Removed email folder from library... applying changes across the repository, this can take a long while.")
                DBARCH.RemoveLibraryEmails(Me.txtFolderName.Text.Trim, LibToRemove, gCurrUserGuidID)
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "Notice: 3302.2.y - User '" + LID + "' removed EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' from library '" + LibToRemove + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
                PopulateAssignedLibraryCombo()
            Else
                MessageBox.Show("ERROR: DID NOT Remove email folder to library...")
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "Notice: 3302.2.x - User '" + LID + "' FAILED to assign EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToRemove + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
            End If
        Else
            Dim wc As String = ContentLib.wc_PK98(Me.txtFolderName.Text.Trim, LibToRemove, gCurrUserGuidID)
            Dim b As Boolean = ContentLib.Delete(wc)

            'Dim Mysql As String = ""
            'Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
            'b = DBARCH.ExecuteSqlNewConn(Mysql)

            'Mysql = "delete from LibDirectory where LibraryName = '" + LibToRemove  + "'"
            'b = DBARCH.ExecuteSqlNewConn(Mysql)

            If b Then
                MessageBox.Show("Removed content folder from library... applying changes across the repository, this can take a long while.")
                DBARCH.RemoveLibraryDirectories(Me.txtFolderName.Text.Trim, LibToRemove)
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "Notice: 3303.2.y - User '" + LID + "' assigned Content Folder '" + Me.txtFolderName.Text.Trim + "' from library '" + LibToRemove + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
                PopulateAssignedLibraryCombo()
            Else
                MessageBox.Show("ERROR: DID NOT Remove ontent folder to library...")
                Dim LID As String = DBARCH.getUserLoginByUserid(gCurrUserGuidID)
                Dim tMsg As String = "Notice: 3303.2.y - User '" + LID + "' FAILED to remove Content Folder '" + Me.txtFolderName.Text.Trim + "' from library '" + LibToRemove + "' on " + Now.ToString + "."
                DBARCH.AddSysMsg(tMsg)
                LOG.WriteToArchiveLog(tMsg)
            End If
        End If

        DBARCH.cleanUpLibraryItems()
        Me.Cursor = Cursors.Default

    End Sub

    Private Sub frmLibraryAssignment_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If formloaded = False Then Return
        ResizeControls(Me)

    End Sub
End Class
