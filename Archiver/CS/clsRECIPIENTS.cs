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
	public class clsRECIPIENTS
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string Recipient = "";
		string EmailGuid = "";
		string TypeRecp = "";
		
		
		
		
		//** Generate the SET methods
		public void setRecipient(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Recipient\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Recipient = val;
		}
		
		
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
		
		
		public void setTyperecp(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			TypeRecp = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getRecipient()
		{
			if (Recipient.Length == 0)
			{
				MessageBox.Show("GET: Field \'Recipient\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Recipient);
		}
		
		
		public string getEmailguid()
		{
			if (EmailGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Emailguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(EmailGuid);
		}
		
		
		public string getTyperecp()
		{
			return UTIL.RemoveSingleQuotes(TypeRecp);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Recipient.Length == 0)
			{
				return false;
			}
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Recipient.Length == 0)
			{
				return false;
			}
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = false;
			string s = "";
			s = s + " INSERT INTO Recipients(";
			s = s + "Recipient,";
			s = s + "EmailGuid,";
			s = s + "TypeRecp) values (";
			s = s + "\'" + Recipient + "\'" + ",";
			s = s + "\'" + EmailGuid + "\'" + ",";
			s = s + "\'" + TypeRecp + "\'" + ")";
			return DB.ExecuteSqlNewConn(s, false);
			
			
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
			
			
			s = s + " update Recipients set ";
			s = s + "Recipient = \'" + getRecipient() + "\'" + ", ";
			s = s + "EmailGuid = \'" + getEmailguid() + "\'" + ", ";
			s = s + "TypeRecp = \'" + getTyperecp() + "\'";
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
			s = s + "Recipient,";
			s = s + "EmailGuid,";
			s = s + "TypeRecp ";
			s = s + " FROM Recipients";
			
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
			s = s + "Recipient,";
			s = s + "EmailGuid,";
			s = s + "TypeRecp ";
			s = s + " FROM Recipients";
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
			
			
			s = " Delete from Recipients";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from Recipients";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PK32A(string EmailGuid, string Recipient)
		{
			
			
			Recipient = UTIL.RemoveSingleQuotes(Recipient);
			
			
			int B = 0;
			string TBL = "Recipients";
			string WC = "Where EmailGuid = \'" + EmailGuid + "\' and   Recipient = \'" + Recipient + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK32A
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK32A(string EmailGuid, string Recipient)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Recipients";
			string WC = "Where EmailGuid = \'" + EmailGuid + "\' and   Recipient = \'" + Recipient + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK32A
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK32A(string EmailGuid, string Recipient)
		{
			
			
			string WC = "Where EmailGuid = \'" + EmailGuid + "\' and   Recipient = \'" + Recipient + "\'";
			
			
			return WC;
		} //** wc_PK32A
	}
	
}
