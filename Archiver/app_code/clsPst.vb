Imports Microsoft.Office.Interop.Outlook

Public Class clsPst

    Dim DBLocal As New clsDbLocal
    Dim LOG As New clsLogging
    Dim currLevel As Integer = 0
    Dim TotalFolders As Integer = 0
    Dim TotalItems As Integer = 0

    Shared StoresToRemove As New List(Of String)

    Dim ProcFolders As New frmPstLoader.ProcessFolders

    Public Sub RemoveStores()
        Try
            Dim objOL As Microsoft.Office.Interop.Outlook.Application
            Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
            Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

            objOL = CreateObject("Outlook.Application")
            objNS = objOL.GetNamespace("MAPI")
            objFolder = objNS.Folders.GetLast

            objNS.RemoveStore(objFolder)

            objOL = Nothing
            objNS = Nothing
            objFolder = Nothing
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("NOTICE: RemoveStores 100 - " + ex.Message)
        End Try

    End Sub

    Public Sub PstStats(ByRef lbMsg As ListBox, ByVal pstFQN As String, ByVal pstName As String, ByVal bArchiveEmails As Boolean)
        Try
            Dim L As New SortedList(Of String, String)

            If bArchiveEmails = False Then
                lbMsg.Items.Clear()
            End If

            StoresToRemove.Clear()

            Dim StoreIndexNbr As Integer = 0
            Dim mailItems As New LinkedList(Of String)
            Dim objOL As Microsoft.Office.Interop.Outlook.Application
            Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
            Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

            objOL = CreateObject("Outlook.Application")
            objNS = objOL.GetNamespace("MAPI")

            '** Add PST file (Outlook Data File) to Default Profile
            objNS.AddStore(pstFQN)

            objFolder = objNS.Folders.GetLast
            Console.WriteLine(objFolder.Name)
            'objFolder.Name = pstName

            StoresToRemove.Add(objFolder.Name)

            Dim S As String = ""
            Dim iStoresCnt As Integer = objNS.Stores.Count

            S = "#Stores: " + iStoresCnt.ToString
            If bArchiveEmails = False Then
                lbMsg.Items.Add(S)
            End If

            For StoreIndexNbr = iStoresCnt To iStoresCnt

                Dim ParentFolderName As String = ""
                Dim rootFolder As Microsoft.Office.Interop.Outlook.MAPIFolder = objNS.Stores(StoreIndexNbr).GetRootFolder
                Dim rootFolderName = rootFolder.Name
                Dim iFolderItems As Integer = rootFolder.Items.Count
                Dim iFoldercnt As Integer = rootFolder.Folders.Count

                ParentFolderName = rootFolderName

                Dim ParentFolderID As String = rootFolder.EntryID

                S = "FLDR: " + rootFolderName
                If bArchiveEmails = False Then
                    lbMsg.Items.Add(S)
                End If

                S = "     #Folders: " + iFoldercnt.ToString
                If bArchiveEmails = False Then
                    lbMsg.Items.Add(S)
                End If

                S = "     #Items: " + iFolderItems.ToString
                If bArchiveEmails = False Then
                    lbMsg.Items.Add(S)
                End If

                frmPstLoader.Refresh()
                Windows.Forms.Application.DoEvents()

                '** Traverse through all folders in the PST file
                '** TODO: This is not recursive, refactor
                Dim Folder As Microsoft.Office.Interop.Outlook.Folder
                Dim subFolder As Microsoft.Office.Interop.Outlook.Folders
                Dim II As Integer = 0

                For Each Folder In rootFolder.Folders
                    frmPstLoader.CurrIdNbr += 1
                    Windows.Forms.Application.DoEvents()

                    Dim pName As String = Folder.Name
                    Dim iSubfolders As Integer = Folder.Folders.Count

                    II += 1
                    frmPstLoader.SB.Text = pName + " : " + II.ToString
                    Windows.Forms.Application.DoEvents()

                    '***************************************************************************************************
                    Dim TopFolderName As String = pName
                    Dim CurrFolder As Microsoft.Office.Interop.Outlook.Folder = Folder
                    Dim DeleteFile As Boolean = False
                    Dim ArchiveEmails As String = "Y"
                    Dim RemoveAfterArchive As String = ""
                    Dim SetAsDefaultFolder As String = ""
                    Dim ArchiveAfterXDays As String = ""
                    Dim RemoveAfterXDays As String = ""
                    Dim RemoveXDays As String = ""
                    Dim ArchiveXDays As String = ""

                    '** When we start using multiple databases, we have to replace ECMREPO with the real value.
                    Dim DB_ID As String = "ECMREPO"

                    Dim UserID As String = gCurrUserGuidID
                    Dim ArchiveOnlyIfRead As String
                    Dim RetentionYears As Integer = 20
                    Dim RetentionCode As String

                    S = "          SubFldr: " + Folder.Name + " : " + Folder.Folders.Count.ToString + " : " + Folder.Items.Count.ToString + " " + Chr(254) + frmPstLoader.CurrIdNbr.ToString + Chr(254)

                    '************************************************************************
                    ProcFolders.oFolder = Folder
                    ProcFolders.iKey = frmPstLoader.CurrIdNbr

                    If frmPstLoader.FoldersToProcess Is Nothing Then
                        ReDim frmPstLoader.FoldersToProcess(0)
                        frmPstLoader.FoldersToProcess(0) = ProcFolders
                    Else
                        Dim iBound As Integer = UBound(frmPstLoader.FoldersToProcess) + 1
                        ReDim Preserve frmPstLoader.FoldersToProcess(iBound)
                        frmPstLoader.FoldersToProcess(iBound) = ProcFolders
                    End If
                    '************************************************************************

                    If bArchiveEmails = False Then
                        lbMsg.Items.Add(S)
                    End If

                    If iSubfolders > 0 Then
                        GetSubFolders(lbMsg, pName, Folder, L)
                    End If
                    '**************************************************
                    pName = ""
                Next    '** Folder
            Next    '** StoreIndexNbr
            frmPstLoader.SB.Text = "Loaded."
            'objNS.RemoveStore(pstFQN )
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("PstStats: ERROR 100.10 - " + ex.Message)
            LOG.WriteToArchiveLog("PstStats: ERROR 100.10 - " + ex.StackTrace)
            frmPstLoader.SB.Text = "ERROR: Check Logs: " + ex.Message
        End Try

    End Sub

    Sub GetSubFolders(ByRef lbMsg As ListBox, ByVal CurrentFolderName As String, ByVal CurrentFolder As Microsoft.Office.Interop.Outlook.MAPIFolder, ByRef L As SortedList(Of String, String))
        Dim Folder As Microsoft.Office.Interop.Outlook.Folder
        Dim OrigFolder As Microsoft.Office.Interop.Outlook.MAPIFolder = CurrentFolder
        Dim cFolder As String = CurrentFolder.Name
        For Each Folder In CurrentFolder.Folders
            frmPstLoader.CurrIdNbr += 1
            currLevel = currLevel + 1
            Dim FullFolderName As String = CurrentFolderName + "->" + Folder.Name + "     "
            Dim iSubfolders As Integer = Folder.Folders.Count
            '**************************************************
            If iSubfolders > 0 Then
                GetSubFolders(lbMsg, FullFolderName, Folder, L)
            End If

            Dim S As String = "          SubFldr: " + FullFolderName + " : " + Folder.Name + " : " + Folder.Folders.Count.ToString + " : " + Folder.Items.Count.ToString + Chr(254) + frmPstLoader.CurrIdNbr.ToString + Chr(254)
            lbMsg.Items.Add(S)

            '************************************************************************
            ProcFolders.oFolder = Folder
            ProcFolders.iKey = frmPstLoader.CurrIdNbr

            If frmPstLoader.FoldersToProcess Is Nothing Then
                ReDim frmPstLoader.FoldersToProcess(0)
                frmPstLoader.FoldersToProcess(0) = ProcFolders
            Else
                Dim iBound As Integer = UBound(frmPstLoader.FoldersToProcess) + 1
                ReDim Preserve frmPstLoader.FoldersToProcess(iBound)
                frmPstLoader.FoldersToProcess(iBound) = ProcFolders
            End If
            '************************************************************************

        Next
        currLevel = currLevel - 1
    End Sub

    Public Sub readPst(ByVal pstFQN As String, ByVal pstName As String)

        Dim StoreIndexNbr As Integer = 0
        Dim mailItems As New LinkedList(Of String)
        Dim objOL As Microsoft.Office.Interop.Outlook.Application
        Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
        Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

        objOL = CreateObject("Outlook.Application")
        objNS = objOL.GetNamespace("MAPI")

        '** Add PST file (Outlook Data File) to Default Profile
        objNS.AddStore(pstFQN)

        objFolder = objNS.Folders.GetLast
        objFolder.Name = pstName

        Dim iStoresCnt As Integer = objNS.Stores.Count
        For StoreIndexNbr = 0 To iStoresCnt - 1
            Dim rootFolder As Microsoft.Office.Interop.Outlook.MAPIFolder = objNS.Stores(StoreIndexNbr).GetRootFolder
            '** Traverse through all folders in the PST file
            '** TODO: This is not recursive, refactor
            Dim Folder As Microsoft.Office.Interop.Outlook.Folder
            Dim subFolder As Microsoft.Office.Interop.Outlook.Folders

            For Each Folder In rootFolder.Folders
                Console.WriteLine("rootFolder: " + rootFolder.Name)
                Console.WriteLine("rootFolder: " + rootFolder.EntryID)
                Console.WriteLine("Folder: " + Folder.Name)
                Console.WriteLine("Folder EntryID: " + Folder.EntryID)
                Console.WriteLine("Folder Items.Count: " + Folder.Items.Count)
                Dim item As Microsoft.Office.Interop.Outlook.MailItem
                For Each item In Folder.Items
                    Console.WriteLine("Subject: " + item.Subject)
                    Console.WriteLine("SentOn : " + item.SentOn.ToString)
                    Console.WriteLine("Attachments.Count: " + item.Attachments.Count)
                Next    '** item
            Next    '** Folder
        Next    '** StoreIndexNbr

    End Sub

    Sub SetNewStore(ByVal strFileName As String, ByVal strDisplayName As String)

        Dim objOL As Microsoft.Office.Interop.Outlook.Application
        Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
        Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

        objOL = CreateObject("Outlook.Application")
        objNS = objOL.GetNamespace("MAPI")
        objNS.AddStore(strFileName)
        objFolder = objNS.Folders.GetLast
        objFolder.Name = strDisplayName

        objOL = Nothing
        objNS = Nothing
        objFolder = Nothing

    End Sub

    Public Sub ArchiveSelectedFolders(ByVal UID As String, ByVal L As ListBox, ByVal PstFQN As String, ByVal RetentionCode As String, ByVal Library As String, ByVal slStoreId As SortedList)

        Dim isPublic As String = "N"

        Dim Owner As New SortedList(Of Integer, String)
        Dim DB_ID As String = "ECMREPO"
        Dim UserID As String = gCurrUserGuidID
        Dim ArchiveOnlyIfRead As String = ""
        Dim RetentionYears As Integer = 20

        Dim KeysToProcess As New SortedList(Of Integer, String)
        Dim FolderNames As New SortedList(Of Integer, String)
        Dim FolderItemCount As New SortedList(Of Integer, String)
        Dim TopFolder As New SortedList(Of Integer, String)
        Dim OwnerFolder As String = ""

        For X As Integer = 0 To L.Items.Count - 1
            Dim S As String = L.Items(X).ToString
            Dim TestStr As String = S.Trim
            If InStr(TestStr, "FLDR:", CompareMethod.Text) > 0 Then
                TestStr = Mid(S, 1, 5)
                If TestStr.Equals("FLDR:") Then
                    Dim A As String() = S.Split(":")
                    OwnerFolder = A(1).Trim
                End If
            End If
            If InStr(S, "SubFldr", CompareMethod.Text) > 0 Then
                If InStr(S, Chr(254)) > 0 Then
                    Dim A As String() = S.Split(Chr(254))
                    Dim B As String() = S.Split(":")
                    If UBound(A) > 0 Then
                        If A(1).Trim <> Nothing Then
                            If IsNumeric(A(1)) Then
                                'KeysToProcess.Add(Val(A(1)))
                                If Owner.IndexOfKey(Val(A(1))) >= 0 Then
                                    Console.WriteLine("Exists")
                                Else
                                    Try
                                        Owner.Add(Val(A(1)), OwnerFolder)
                                    Catch ex As System.Exception
                                        LOG.WriteToArchiveLog("OwnerFolder  100: " + ex.Message)
                                    End Try
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Next

        KeysToProcess.Clear()
        FolderNames.Clear()

        For Each S As String In L.SelectedItems
            S = S.Trim
            frmMain.SB2.Text = "Folder: " + S
            frmMain.SB2.Refresh()
            Windows.Forms.Application.DoEvents()

            If InStr(S, "subfldr", CompareMethod.Text) > 0 Then
                If InStr(S, Chr(254), CompareMethod.Text) > 0 Then
                    Dim A As String() = S.Split(Chr(254))
                    Dim B As String() = S.Split(":")
                    If UBound(A) > 0 Then
                        If A(1).Trim <> Nothing Then
                            If IsNumeric(A(1)) Then
                                Dim iLoc As Integer = Val(A(1))
                                If KeysToProcess.IndexOfKey(iLoc) >= 0 Then
                                Else
                                    KeysToProcess.Add(iLoc, iLoc)
                                End If
                                If FolderNames.IndexOfKey(iLoc) >= 0 Then
                                    LOG.WriteToArchiveLog("PST Exception - IndexOfKey 1001: " + OwnerFolder + "|" + B(1))
                                Else
                                    Try
                                        FolderNames.Add(iLoc, OwnerFolder + "|" + B(1))
                                    Catch ex As System.Exception
                                        LOG.WriteToArchiveLog("PST Exception - IndexOfKey 2001: " + OwnerFolder + "|" + B(1))
                                    End Try
                                End If
                                If InStr(B(3), Chr(254)) > 0 Then
                                    Dim II As Integer = InStr(B(3), Chr(254))
                                    B(3) = Mid(B(3), 1, II - 1)
                                    B(3) = B(3).Trim
                                End If
                                If FolderItemCount.IndexOfKey(iLoc) >= 0 Then
                                Else
                                    FolderItemCount.Add(iLoc, Val(B(3)))
                                End If

                                If Owner.IndexOfKey(Val(A(1))) >= 0 Then
                                    Try
                                        OwnerFolder = Owner.Item(Val(A(1)))
                                    Catch ex As System.Exception
                                        LOG.WriteToArchiveLog("OwnerFolder  200: " + ex.Message)
                                    End Try
                                End If
                                Console.WriteLine("Processing Folder: " + OwnerFolder + " | " + B(1) + ", Emails = " + B(3) + ", Key = " + A(1) + ".")
                            End If
                        End If
                    End If
                End If
            End If
        Next

        Dim ARCH As New clsArchiver

        Dim CurrFolder As Microsoft.Office.Interop.Outlook.Folder
        Dim iKey As Integer = -1

        '************************************************************************
        'Dim oEcmHistFolder As Outlook.MAPIFolder = Nothing
        'Dim FolderFound As Boolean = False
        'For Each oFolder In oParentFolder.Folders
        '    If oFolder.Name.ToUpper.Equals("ECM_HISTORY") Then
        '        oEcmHistFolder = oFolder
        '        FolderFound = True
        '    End If
        'Next
        'If FolderFound = False Then
        '    messagebox.show("Create folder here")
        'End If

        For i As Integer = 0 To frmPstLoader.FoldersToProcess.Count - 1
            '.Text = i.ToString
            'FrmMDIMain.SB.Text = "PST Folder# " + i.ToString
            Windows.Forms.Application.DoEvents()

            CurrFolder = frmPstLoader.FoldersToProcess(i).oFolder
            iKey = frmPstLoader.FoldersToProcess(i).iKey
            Dim II As Integer = 0
            If KeysToProcess.IndexOfKey(iKey) >= 0 Then
                II += 1
                'FrmMDIMain.SB.Text = "PST Folder# " + i.ToString + " : " + "inserts - " + II.ToString
                frmMain.SB.Text = "PST Folder# " + i.ToString + " : " + "inserts - " + II.ToString
                frmMain.SB.Refresh()
                frmPstLoader.SB.Text = "PST Folder# " + i.ToString + " : " + "inserts - " + II.ToString
                frmPstLoader.SB.Refresh()
                Windows.Forms.Application.DoEvents()

                Dim DisplayName As String = CurrFolder.Store.DisplayName

                Dim ParentFldr As Microsoft.Office.Interop.Outlook.Folder
                ParentFldr = CurrFolder.Parent
                Dim PID As String = ParentFldr.EntryID
                ParentFldr = Nothing

                frmMain.SB.Text = "PST Folder: " + DisplayName + i.ToString + " : " + "inserts - " + II.ToString

                Dim CurrentKey As Integer = KeysToProcess.Item(iKey)

                Dim A As String() = FolderNames.Item(iKey).Trim.Split("|")

                frmPstLoader.SB.Text = FolderNames.Item(iKey).Trim
                frmPstLoader.SB.Refresh()
                Windows.Forms.Application.DoEvents()

                Dim NewName As String = ""
                If UBound(A) = 1 Then
                    NewName = A(0).Trim + "|" + A(1).Trim
                Else
                    NewName = FolderNames.Item(iKey).Trim
                End If

                Dim CurrentFolderName As String = NewName
                Dim NbrOfItemsToProcess As Integer = FolderItemCount.Item(iKey)

                Dim StoreName As String = DisplayName
                'If NbrOfItemsToProcess = 0 Then
                '    GoTo NEXTONE
                'End If

                '** Process this folder.
                frmPstLoader.SB.Text = StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString + " of " + CurrFolder.Items.Count.ToString
                frmPstLoader.SB.Refresh()
                Windows.Forms.Application.DoEvents()

                LOG.WriteToArchiveLog("PST 300: " + StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString + " of " + CurrFolder.Items.Count.ToString)

                Dim StoreID As String = CurrFolder.StoreID.ToString
                Dim TopFolderName As String = "PST: <" + PstFQN + "> : " + StoreName
                Dim ParentFolderID As String = PID
                Dim FolderKeyName As String = CurrentFolderName
                Dim FID As String = CurrFolder.EntryID

                '*************************************************************************************************************
                ARCH.AddPstFolder(StoreID, TopFolderName, ParentFolderID, FolderKeyName, FID, PstFQN, RetentionCode)
                '*************************************************************************************************************

                Dim ArchiveEmails As String = "Y"
                Dim RemoveAfterArchive As String = "N"
                Dim SetAsDefaultFolder As String = "N"
                Dim ArchiveAfterXDays As String = ""
                Dim RemoveAfterXDays As String = ""
                Dim RemoveXDays As String = ""
                Dim ArchiveXDays As String = ""
                Dim DeleteFile As Boolean = False

                '*************************************************************************************************************
                DBLocal.setOutlookMissing()
                ARCH.EmailLibrary = Library

                ARCH.ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails,
                      RemoveAfterArchive,
                      SetAsDefaultFolder,
                      ArchiveAfterXDays,
                      RemoveAfterXDays,
                      RemoveXDays,
                      ArchiveXDays,
                      DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead,
                      RetentionYears, RetentionCode, FolderKeyName, slStoreId, isPublic)
                '*************************************************************************************************************
            End If
NEXTONE:
        Next
        '************************************************************************

        ARCH = Nothing

    End Sub

End Class