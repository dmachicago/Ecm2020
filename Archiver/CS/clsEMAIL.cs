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

using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;



namespace EcmArchiveClcSetup
{
	public class clsEMAIL
	{
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsARCHIVEHIST ARCHHIST = new clsARCHIVEHIST();
		clsARCHIVEHISTCONTENTTYPE ARCHHISTTYPE = new clsARCHIVEHISTCONTENTTYPE();
		
		
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		
		
		string EmailGuid = "";
		string SUBJECT = "";
		string SentTO = "";
		string Body = "";
		string Bcc = "";
		string BillingInformation = "";
		string CC = "";
		string Companies = "";
		string CreationTime = "";
		string ReadReceiptRequested = "";
		string ReceivedByName = "";
		string ReceivedTime = "";
		string AllRecipients = "";
		string UserID = "";
		string SenderEmailAddress = "";
		string SenderName = "";
		string Sensitivity = "";
		string SentOn = "";
		string MsgSize = "";
		string DeferredDeliveryTime = "";
		string EmailIdentifier = "";
		string EntryID = "";
		string ExpiryTime = "";
		string LastModificationTime = "";
		string EmailImage = "";
		string Accounts = "";
		string RowID = "";
		string ShortSubj = "";
		string SourceTypeCode = "";
		string OriginalFolder = "";
		string StoreID = "";
		
		
		
		
		//** Generate the SET methods
		public void setEmailguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Emailguid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			EmailGuid = val;
		}
		
		
		public void setSubject(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SUBJECT = val;
		}
		
		
		public void setSentto(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SentTO = val;
		}
		
		
		public void setBody(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Body = val;
		}
		
		
		public void setBcc(ref string val)
		{
			val = val.Substring(0, 79).Trim();
			val = UTIL.RemoveSingleQuotes(val);
			Bcc = val;
		}
		
		
		public void setBillinginformation(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BillingInformation = val;
		}
		
		
		public void setCc(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CC = val;
		}
		
		
		public void setCompanies(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Companies = val;
		}
		
		
		public void setCreationtime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CreationTime = val;
		}
		
		
		public void setReadreceiptrequested(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ReadReceiptRequested = val;
		}
		
		
		public void setReceivedbyname(ref string val)
		{
			val = val.Substring(0, 79).Trim();
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Receivedbyname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ReceivedByName = val;
		}
		
		
		public void setReceivedtime(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Receivedtime\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ReceivedTime = val;
		}
		
		
		public void setAllrecipients(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AllRecipients = val;
		}
		
		
		public void setCurrentuser(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'UserID\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		
		public void setSenderemailaddress(ref string val)
		{
			val = val.Substring(0, 79).Trim();
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Senderemailaddress\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SenderEmailAddress = val;
		}
		
		
		public void setSendername(ref string val)
		{
			val = val.Substring(0, 99).Trim();
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Sendername\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SenderName = val;
		}
		
		
		public void setSensitivity(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Sensitivity = val;
		}
		
		
		public void setSenton(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Senton\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SentOn = val;
		}
		
		
		public void setMsgsize(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			MsgSize = val;
		}
		
		
		public void setDeferreddeliverytime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			DeferredDeliveryTime = val;
		}
		
		public void setEmailIdentifier(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			EmailIdentifier = val;
		}
		
		public void setEntryid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			EntryID = val;
		}
		
		public void setStoreID(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			StoreID = val;
		}
		public void setExpirytime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ExpiryTime = val;
		}
		
		
		public void setLastmodificationtime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LastModificationTime = val;
		}
		
		
		public void setEmailimage(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			EmailImage = val;
		}
		
		
		public void setAccounts(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Accounts = val;
		}
		
		
		public void setShortsubj(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ShortSubj = val;
		}
		
		
		public void setSourcetypecode(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SourceTypeCode = val;
		}
		
		
		public void setOriginalfolder(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			OriginalFolder = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getEmailguid()
		{
			if (EmailGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Emailguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(EmailGuid);
		}
		public string getStoreID()
		{
			return UTIL.RemoveSingleQuotes(StoreID);
		}
		public string getSubject()
		{
			return UTIL.RemoveSingleQuotes(SUBJECT);
		}
		
		
		public string getSentto()
		{
			return UTIL.RemoveSingleQuotes(SentTO);
		}
		
		
		public string getBody()
		{
			return UTIL.RemoveSingleQuotes(Body);
		}
		
		
		public string getBcc()
		{
			return UTIL.RemoveSingleQuotes(Bcc);
		}
		
		
		public string getBillinginformation()
		{
			return UTIL.RemoveSingleQuotes(BillingInformation);
		}
		
		
		public string getCc()
		{
			return UTIL.RemoveSingleQuotes(CC);
		}
		
		
		public string getCompanies()
		{
			return UTIL.RemoveSingleQuotes(Companies);
		}
		
		
		public string getCreationtime()
		{
			return UTIL.RemoveSingleQuotes(CreationTime);
		}
		
		
		public string getReadreceiptrequested()
		{
			return UTIL.RemoveSingleQuotes(ReadReceiptRequested);
		}
		
		
		public string getReceivedbyname()
		{
			if (ReceivedByName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Receivedbyname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ReceivedByName);
		}
		
		
		public string getReceivedtime()
		{
			if (ReceivedTime.Length == 0)
			{
				MessageBox.Show("GET: Field \'Receivedtime\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ReceivedTime);
		}
		
		
		public string getAllrecipients()
		{
			return UTIL.RemoveSingleQuotes(AllRecipients);
		}
		
		
		public string getCurrentuser()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'UserID\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		
		public string getSenderemailaddress()
		{
			if (SenderEmailAddress.Length == 0)
			{
				MessageBox.Show("GET: Field \'Senderemailaddress\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SenderEmailAddress);
		}
		
		
		public string getSendername()
		{
			if (SenderName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Sendername\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SenderName);
		}
		
		
		public string getSensitivity()
		{
			return UTIL.RemoveSingleQuotes(Sensitivity);
		}
		
		
		public string getSenton()
		{
			if (SentOn.Length == 0)
			{
				MessageBox.Show("GET: Field \'Senton\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SentOn);
		}
		
		
		public string getMsgsize()
		{
			if (MsgSize.Length == 0)
			{
				MsgSize = "null";
			}
			return MsgSize;
		}
		
		
		public string getDeferreddeliverytime()
		{
			return UTIL.RemoveSingleQuotes(DeferredDeliveryTime);
		}
		
		
		public string getCE_EmailIdentifiers()
		{
			return UTIL.RemoveSingleQuotes(EntryID);
		}
		
		
		public string getExpirytime()
		{
			return UTIL.RemoveSingleQuotes(ExpiryTime);
		}
		
		
		public string getLastmodificationtime()
		{
			return UTIL.RemoveSingleQuotes(LastModificationTime);
		}
		
		
		public string getEmailimage()
		{
			if (EmailImage.Length == 0)
			{
				EmailImage = "null";
			}
			return EmailImage;
		}
		
		
		public string getAccounts()
		{
			return UTIL.RemoveSingleQuotes(Accounts);
		}
		
		
		public string getRowid()
		{
			if (RowID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Rowid\' cannot be NULL.");
				return "";
			}
			if (RowID.Length == 0)
			{
				RowID = "null";
			}
			return RowID;
		}
		
		
		public string getShortsubj()
		{
			return UTIL.RemoveSingleQuotes(ShortSubj);
		}
		
		
		public string getSourcetypecode()
		{
			return UTIL.RemoveSingleQuotes(SourceTypeCode);
		}
		
		
		public string getOriginalfolder()
		{
			return UTIL.RemoveSingleQuotes(OriginalFolder);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			if (ReceivedByName.Length == 0)
			{
				return false;
			}
			if (ReceivedTime.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			if (SenderEmailAddress.Length == 0)
			{
				return false;
			}
			if (SenderName.Length == 0)
			{
				return false;
			}
			if (SentOn.Length == 0)
			{
				return false;
			}
			if (RowID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			if (ReceivedByName.Length == 0)
			{
				return false;
			}
			if (ReceivedTime.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			if (SenderEmailAddress.Length == 0)
			{
				return false;
			}
			if (SenderName.Length == 0)
			{
				return false;
			}
			if (SentOn.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		public bool ckEmailAlreadyExists(string EmailFolderName, string EmailIdentifier)
		{
			
			string SS = "select COUNT(*) from Email where EmailIdentifier = \'" + EmailIdentifier + "\' ";
			int iCnt = DB.iCount(SS);
			
			if (iCnt == 0)
			{
				DB.saveContentOwner(EmailGuid, modGlobals.gCurrUserGuidID, "E", EmailFolderName, modGlobals.gMachineID, modGlobals.gNetworkID);
				return false;
			}
			else
			{
				return true;
			}
		}
		
		
		//** Generate the INSERT method
		public bool InsertNewEmail(string MachineName, string NetworkName, string EmailSuffix, string EmailIdentifier, string CRC, string EmailFolderName)
		{
			
			bool bRtn = ckEmailAlreadyExists(EmailFolderName, EmailIdentifier);
			if (bRtn == true)
			{
				return true;
			}
			
			bool b = false;
			string NewID = Guid.NewGuid().ToString();
			string s = "";
			s = s + " INSERT INTO Email(RowGuid, ";
			s = s + "EmailGuid," + "\r\n";
			s = s + "SUBJECT," + "\r\n";
			s = s + "SentTO," + "\r\n";
			s = s + "Body," + "\r\n";
			s = s + "Bcc," + "\r\n";
			s = s + "BillingInformation," + "\r\n";
			s = s + "CC," + "\r\n";
			s = s + "Companies," + "\r\n";
			s = s + "CreationTime," + "\r\n";
			s = s + "ReadReceiptRequested," + "\r\n";
			s = s + "ReceivedByName," + "\r\n";
			s = s + "ReceivedTime," + "\r\n";
			s = s + "AllRecipients," + "\r\n";
			s = s + "UserID," + "\r\n";
			s = s + "SenderEmailAddress," + "\r\n";
			s = s + "SenderName," + "\r\n";
			s = s + "Sensitivity," + "\r\n";
			s = s + "SentOn," + "\r\n";
			s = s + "MsgSize," + "\r\n";
			s = s + "DeferredDeliveryTime," + "\r\n";
			s = s + "EntryID," + "\r\n";
			s = s + "ExpiryTime," + "\r\n";
			s = s + "LastModificationTime," + "\r\n";
			//s = s + "EmailImage," + vbcrlf
			s = s + "Accounts," + "\r\n";
			s = s + "ShortSubj," + "\r\n";
			s = s + "SourceTypeCode," + "\r\n";
			s = s + "OriginalFolder, StoreID, EmailIdentifier, CRC, RecHash) values ( ";
			s = s + "\'" + NewID + "\'" + "," + "\r\n";
			s = s + "\'" + EmailGuid + "\'" + "," + "\r\n";
			s = s + "\'" + SUBJECT + "\'" + "," + "\r\n";
			s = s + "\'" + SentTO + "\'" + "," + "\r\n";
			s = s + "\'" + Body + "\'" + "," + "\r\n";
			s = s + "\'" + Bcc + "\'" + "," + "\r\n";
			s = s + "\'" + BillingInformation + "\'" + "," + "\r\n";
			s = s + "\'" + CC + "\'" + "," + "\r\n";
			s = s + "\'" + Companies + "\'" + "," + "\r\n";
			s = s + "\'" + CreationTime + "\'" + "," + "\r\n";
			s = s + "\'" + ReadReceiptRequested + "\'" + "," + "\r\n";
			s = s + "\'" + ReceivedByName + "\'" + "," + "\r\n";
			s = s + "\'" + ReceivedTime + "\'" + "," + "\r\n";
			s = s + "\'" + AllRecipients + "\'" + "," + "\r\n";
			s = s + "\'" + UserID + "\'" + "," + "\r\n";
			s = s + "\'" + SenderEmailAddress + "\'" + "," + "\r\n";
			s = s + "\'" + SenderName + "\'" + "," + "\r\n";
			s = s + "\'" + Sensitivity + "\'" + "," + "\r\n";
			s = s + "\'" + SentOn + "\'" + "," + "\r\n";
			s = s + MsgSize + "," + "\r\n";
			s = s + "\'" + DeferredDeliveryTime + "\'" + "," + "\r\n";
			s = s + "\'" + EntryID + "\'" + "," + "\r\n";
			s = s + "\'" + ExpiryTime + "\'" + "," + "\r\n";
			s = s + "\'" + LastModificationTime + "\'" + "," + "\r\n";
			//s = s + EmailImage + "," + vbcrlf
			s = s + "\'" + Accounts + "\'" + "," + "\r\n";
			//s = s + RowID + "," + vbcrlf
			s = s + "\'" + ShortSubj + "\'" + "," + "\r\n";
			s = s + "\'" + SourceTypeCode + "\'" + "," + "\r\n";
			s = s + "\'" + OriginalFolder + "\'" + "," + "\r\n";
			s = s + "\'" + StoreID + "\'" + "," + "\r\n";
			s = s + "\'" + EmailIdentifier + "\', " + "\r\n";
			s = s + "\'" + CRC + "\', " + "\r\n";
			s = s + "\'" + CRC + "\') " + "\r\n";
			
			bool BB = DB.ExecuteSqlNewConn(s, false);
			
			if (BB)
			{
				if (OriginalFolder.Length == 0)
				{
					OriginalFolder = "NONE SUPPLIED";
				}
				
				DB.UpdateCurrArchiveStats(OriginalFolder, EmailSuffix);
				
				BB = DB.saveContentOwner(EmailGuid, UserID, "E", EmailFolderName, MachineName, NetworkName);
				
			}
			else
			{
				Console.WriteLine("ERROR 110xx1 - Failed rto insert Email \'" + SUBJECT + "\'.");
			}
			
			
			
			return BB;
			
			
		}
		
		
		//** Generate the UPDATE method
		public bool Update(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			
			s = s + " update Email set ";
			s = s + "EmailGuid = \'" + getEmailguid() + "\'" + ", ";
			s = s + "SUBJECT = \'" + getSubject() + "\'" + ", ";
			s = s + "SentTO = \'" + getSentto() + "\'" + ", ";
			s = s + "Body = \'" + getBody() + "\'" + ", ";
			s = s + "Bcc = \'" + getBcc() + "\'" + ", ";
			s = s + "BillingInformation = \'" + getBillinginformation() + "\'" + ", ";
			s = s + "CC = \'" + getCc() + "\'" + ", ";
			s = s + "Companies = \'" + getCompanies() + "\'" + ", ";
			s = s + "CreationTime = \'" + getCreationtime() + "\'" + ", ";
			s = s + "ReadReceiptRequested = \'" + getReadreceiptrequested() + "\'" + ", ";
			s = s + "ReceivedByName = \'" + getReceivedbyname() + "\'" + ", ";
			s = s + "ReceivedTime = \'" + getReceivedtime() + "\'" + ", ";
			s = s + "AllRecipients = \'" + getAllrecipients() + "\'" + ", ";
			s = s + "UserID = \'" + getCurrentuser() + "\'" + ", ";
			s = s + "SenderEmailAddress = \'" + getSenderemailaddress() + "\'" + ", ";
			s = s + "SenderName = \'" + getSendername() + "\'" + ", ";
			s = s + "Sensitivity = \'" + getSensitivity() + "\'" + ", ";
			s = s + "SentOn = \'" + getSenton() + "\'" + ", ";
			s = s + "MsgSize = " + getMsgsize() + ", ";
			s = s + "DeferredDeliveryTime = \'" + getDeferreddeliverytime() + "\'" + ", ";
			s = s + "EntryID = \'" + getCE_EmailIdentifiers() + "\'" + ", ";
			s = s + "ExpiryTime = \'" + getExpirytime() + "\'" + ", ";
			s = s + "LastModificationTime = \'" + getLastmodificationtime() + "\'" + ", ";
			//s = s + "EmailImage = " + getEmailimage() + ", "
			s = s + "Accounts = \'" + getAccounts() + "\'" + ", ";
			s = s + "ShortSubj = \'" + getShortsubj() + "\'" + ", ";
			s = s + "SourceTypeCode = \'" + getSourcetypecode() + "\'" + ", ";
			s = s + "OriginalFolder = \'" + getOriginalfolder() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			return DB.ExecuteSqlNewConn(s, false);
		}
		
		
		
		
		//** Generate the SELECT method
		public SqlDataReader SelectRecs()
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
			s = s + " SELECT ";
			s = s + "EmailGuid,";
			s = s + "SUBJECT,";
			s = s + "SentTO,";
			s = s + "Body,";
			s = s + "Bcc,";
			s = s + "BillingInformation,";
			s = s + "CC,";
			s = s + "Companies,";
			s = s + "CreationTime,";
			s = s + "ReadReceiptRequested,";
			s = s + "ReceivedByName,";
			s = s + "ReceivedTime,";
			s = s + "AllRecipients,";
			s = s + "UserID,";
			s = s + "SenderEmailAddress,";
			s = s + "SenderName,";
			s = s + "Sensitivity,";
			s = s + "SentOn,";
			s = s + "MsgSize,";
			s = s + "DeferredDeliveryTime,";
			s = s + "EntryID,";
			s = s + "ExpiryTime,";
			s = s + "LastModificationTime,";
			s = s + "EmailImage,";
			s = s + "Accounts,";
			s = s + "RowID,";
			s = s + "ShortSubj,";
			s = s + "SourceTypeCode,";
			s = s + "OriginalFolder ";
			s = s + " FROM Email";
			
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		
		
		//** Generate the Select One Row method
		public SqlDataReader SelectOne(string WhereClause)
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
			s = s + " SELECT ";
			s = s + "EmailGuid,";
			s = s + "SUBJECT,";
			s = s + "SentTO,";
			s = s + "Body,";
			s = s + "Bcc,";
			s = s + "BillingInformation,";
			s = s + "CC,";
			s = s + "Companies,";
			s = s + "CreationTime,";
			s = s + "ReadReceiptRequested,";
			s = s + "ReceivedByName,";
			s = s + "ReceivedTime,";
			s = s + "AllRecipients,";
			s = s + "UserID,";
			s = s + "SenderEmailAddress,";
			s = s + "SenderName,";
			s = s + "Sensitivity,";
			s = s + "SentOn,";
			s = s + "MsgSize,";
			s = s + "DeferredDeliveryTime,";
			s = s + "EntryID,";
			s = s + "ExpiryTime,";
			s = s + "LastModificationTime,";
			s = s + "EmailImage,";
			s = s + "Accounts,";
			s = s + "RowID,";
			s = s + "ShortSubj,";
			s = s + "SourceTypeCode,";
			s = s + "OriginalFolder ";
			s = s + " FROM Email";
			s = s + WhereClause;
			
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		
		
		//** Generate the DELETE method
		public bool Delete(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			
			WhereClause = (string) (" " + WhereClause);
			
			
			s = " Delete from Email";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from Email";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_FULL_UI_EMAIL(string EmailIdentifier)
		{
			
			EmailIdentifier = UTIL.RemoveSingleQuotes(EmailIdentifier);
			
			int B = 0;
			string TBL = "Email";
			string WC = "Where EmailIdentifier = \'" + EmailIdentifier + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_FULL_UI_EMAIL
		public int cnt_EntryID(string EmailIdentifier)
		{
			
			int iCnt = 0;
			string TBL = "Email";
			string WC = "Where EmailIdentifier = \'" + EmailIdentifier + "\' ";
			
			iCnt = DB.iGetRowCount(TBL, WC);
			
			return iCnt;
		} //** cnt_FULL_UI_EMAIL
		public int cnt_PI_EMAIL_01(DateTime ReceivedTime, DateTime SentOn, string ShortSubj)
		{
			
			
			int B = 0;
			string TBL = "Email";
			string WC = "Where ReceivedTime = \'" + ReceivedTime + "\' and   SentOn = \'" + SentOn + "\' and   ShortSubj = \'" + ShortSubj + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PI_EMAIL_01
		public int cnt_PK27(string EmailGuid)
		{
			
			
			int B = 0;
			string TBL = "Email";
			string WC = "Where EmailGuid = \'" + EmailGuid + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK27
		public int cnt_UK_EMAIL(int RowID)
		{
			
			
			int B = 0;
			string TBL = "Email";
			string WC = "Where RowID = " + RowID.ToString();
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_UK_EMAIL
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_FULL_UI_EMAIL(string UserID, string ReceivedByName, DateTime ReceivedTime, string SenderEmailAddress, string SenderName, DateTime SentOn)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Email";
			string WC = "Where UserID = \'" + UserID + "\' and   ReceivedByName = \'" + ReceivedByName + "\' and   ReceivedTime = \'" + ReceivedTime + "\' and   SenderEmailAddress = \'" + SenderEmailAddress + "\' and   SenderName = \'" + SenderName + "\' and   SentOn = \'" + SentOn + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_FULL_UI_EMAIL
		public SqlDataReader getRow_PI_EMAIL_01(DateTime ReceivedTime, DateTime SentOn, string ShortSubj)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Email";
			string WC = "Where ReceivedTime = \'" + ReceivedTime + "\' and   SentOn = \'" + SentOn + "\' and   ShortSubj = \'" + ShortSubj + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PI_EMAIL_01
		public SqlDataReader getRow_PK27(string EmailGuid)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Email";
			string WC = "Where EmailGuid = \'" + EmailGuid + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK27
		public SqlDataReader getRow_UK_EMAIL(int RowID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Email";
			string WC = "Where RowID = " + RowID.ToString();
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_UK_EMAIL
		
		
		/// Build Index Where Caluses
		///
		public string wc_FULL_UI_EMAIL(string UserID, string ReceivedByName, DateTime ReceivedTime, string SenderEmailAddress, string SenderName, DateTime SentOn)
		{
			
			
			string WC = "Where UserID = \'" + UserID + "\' and   ReceivedByName = \'" + ReceivedByName + "\' and   ReceivedTime = \'" + ReceivedTime + "\' and   SenderEmailAddress = \'" + SenderEmailAddress + "\' and   SenderName = \'" + SenderName + "\' and   SentOn = \'" + SentOn + "\'";
			
			
			return WC;
		} //** wc_FULL_UI_EMAIL
		public string wc_PI_EMAIL_01(DateTime ReceivedTime, DateTime SentOn, string ShortSubj)
		{
			
			
			string WC = "Where ReceivedTime = \'" + ReceivedTime + "\' and   SentOn = \'" + SentOn + "\' and   ShortSubj = \'" + ShortSubj + "\'";
			
			
			return WC;
		} //** wc_PI_EMAIL_01
		public string wc_PK27(string EmailGuid)
		{
			
			
			string WC = "Where EmailGuid = \'" + EmailGuid + "\'";
			
			
			return WC;
		} //** wc_PK27
		public string wc_UK_EMAIL(int RowID)
		{
			
			
			string WC = "Where RowID = " + RowID.ToString();
			
			
			return WC;
		} //** wc_UK_EMAIL
	}
	
}
