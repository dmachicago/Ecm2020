using System;
using System.Diagnostics;
using System.Windows.Forms;
using Outlook = Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsRecon
    {

        // Dim DBARCH As New clsDatabaseARCH
        private clsEMAIL EMAIL = new clsEMAIL();
        private clsRECIPIENTS RECIPS = new clsRECIPIENTS();
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();

        public string OutlookFolderNames()
        {
            try
            {
                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // Debug.Print sArray(ictr)
                // Next
                // *********************************************************
                Outlook.Application oOutlook;
                Outlook._NameSpace oMAPI;
                Outlook.MAPIFolder oParentFolder;
                var sArray = default(string[]);
                int i;
                int iElement = 0;
                oOutlook = new Outlook.Application();
                oMAPI = oOutlook.GetNamespace("MAPI");
                string MailboxName = "Personal Folders";
                oParentFolder = oMAPI.Folders[MailboxName];
                Array.Resize(ref sArray, 1);
                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            Debug.Print(oParentFolder.Folders[i].Name);
                        }
                    }
                }
                else
                {
                    sArray[0] = oParentFolder.Name;
                }
                // OutlookFolderNames = sArray
                oMAPI = null;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                LOG.WriteToArchiveLog("clsRecon : OutlookFolderNames : 23 : " + ex.Message);
            }

            return "";
        }

        public void ConvertName(ref string FQN)
        {
            for (int i = 1, loopTo = FQN.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(FQN, i, 1);
                if (CH == " ")
                {
                    StringType.MidStmtStr(ref FQN, i, 1, "_");
                }

                if (CH == ":")
                {
                    StringType.MidStmtStr(ref FQN, i, 1, ".");
                }

                if (CH == "/")
                {
                    StringType.MidStmtStr(ref FQN, i, 1, ".");
                }
            }
        }
    }
}