// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using Outlook = Microsoft.Office.Interop.Outlook;
using System.Reflection;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
//using System.Configuration.AppSettingsReader;
//using System.Configuration.ConfigurationSettings;
using System.Security.Principal;
using Microsoft.VisualBasic.CompilerServices;



namespace EcmArchiveClcSetup
{
	public class clsRecon
	{
		
		clsDatabase DB = new clsDatabase();
		clsEMAIL EMAIL = new clsEMAIL();
		clsRECIPIENTS RECIPS = new clsRECIPIENTS();
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		public string OutlookFolderNames()
		{
			try
			{
				//********************************************************
				//PARAMETER: MailboxName = Name of Parent Outlook Folder for
				//the current user: Usually in the form of
				//"Mailbox - Doe, John" or
				//"Public Folders
				//RETURNS: Array of SubFolders in Current User's Mailbox
				//Or unitialized array if error occurs
				//Because it returns an array, it is for VB6 only.
				//Change to return a variant or a delimited list for
				//previous versions of vb
				//EXAMPLE:
				//Dim sArray() As String
				//Dim ictr As Integer
				//sArray = OutlookFolderNames("Mailbox - Doe, John")
				//            'On Error Resume Next
				//For ictr = 0 To UBound(sArray)
				// Debug.Print sArray(ictr)
				//Next
				//*********************************************************
				Outlook.Application oOutlook;
				Outlook._NameSpace oMAPI;
				Outlook.MAPIFolder oParentFolder;
				string[] sArray;
				int i;
				int iElement = 0;
				
				
				oOutlook = new Outlook.Application();
				oMAPI = oOutlook.GetNamespace("MAPI");
				string MailboxName = "Personal Folders";
				oParentFolder = oMAPI.Folders[MailboxName];
				
				
				Array.Resize(ref sArray, 1);
				
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							Debug.Print(oParentFolder.Folders[i].Name);
						}
					}
				}
				else
				{
					sArray[0] = oParentFolder.Name;
				}
				//OutlookFolderNames = sArray
				oMAPI = null;
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
				LOG.WriteToArchiveLog((string) ("clsRecon : OutlookFolderNames : 23 : " + ex.Message));
			}
			return "";
		}
		
		
		public void ConvertName(ref string FQN)
		{
			for (int i = 1; i <= FQN.Length; i++)
			{
				string CH = FQN.Substring(i - 1, 1);
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
