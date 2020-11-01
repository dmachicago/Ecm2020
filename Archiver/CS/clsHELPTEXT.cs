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
	public class clsHELPTEXT
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsDataGrid DG = new clsDataGrid();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string ScreenName = "";
		string HelpText = "";
		string WidgetName = "";
		string WidgetText = "";
		string DisplayHelpText = "";
		string LastUpdate = "";
		string CreateDate = "";
		string UpdatedBy = "";
		
		
		//** Generate the SET methods
		public void setScreenname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Screenname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ScreenName = val;
		}
		
		public void setHelptext(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HelpText = val;
		}
		
		public void setWidgetname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Widgetname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			WidgetName = val;
		}
		
		public void setWidgettext(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			WidgetText = val;
		}
		
		public void setDisplayhelptext(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			DisplayHelpText = val;
		}
		
		public void setLastupdate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LastUpdate = val;
		}
		
		public void setCreatedate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CreateDate = val;
		}
		
		public void setUpdatedby(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			UpdatedBy = val;
		}
		
		
		
		//** Generate the GET methods
		public string getScreenname()
		{
			if (ScreenName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Screenname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ScreenName);
		}
		
		public string getHelptext()
		{
			return UTIL.RemoveSingleQuotes(HelpText);
		}
		
		public string getWidgetname()
		{
			if (WidgetName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Widgetname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(WidgetName);
		}
		
		public string getWidgettext()
		{
			return UTIL.RemoveSingleQuotes(WidgetText);
		}
		
		public string getDisplayhelptext()
		{
			if (DisplayHelpText.Length == 0)
			{
				DisplayHelpText = "null";
			}
			return DisplayHelpText;
		}
		
		public string getLastupdate()
		{
			return UTIL.RemoveSingleQuotes(LastUpdate);
		}
		
		public string getCreatedate()
		{
			return UTIL.RemoveSingleQuotes(CreateDate);
		}
		
		public string getUpdatedby()
		{
			return UTIL.RemoveSingleQuotes(UpdatedBy);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (ScreenName.Length == 0)
			{
				return false;
			}
			if (WidgetName.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (ScreenName.Length == 0)
			{
				return false;
			}
			if (WidgetName.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = false;
			if (LastUpdate.Trim().Length == 0)
			{
				LastUpdate = DateTime.Now.ToString();
			}
			if (DisplayHelpText.Trim().Length == 0)
			{
				DisplayHelpText = "0";
			}
			string s = "";
			s = s + " INSERT INTO HelpText(";
			s = s + "ScreenName,";
			s = s + "HelpText,";
			s = s + "WidgetName,";
			s = s + "WidgetText,";
			s = s + "DisplayHelpText,";
			s = s + "LastUpdate,";
			s = s + "UpdatedBy) values (";
			s = s + "\'" + ScreenName + "\'" + ",";
			s = s + "\'" + HelpText + "\'" + ",";
			s = s + "\'" + WidgetName + "\'" + ",";
			s = s + "\'" + WidgetText + "\'" + ",";
			s = s + DisplayHelpText + ",";
			s = s + "\'" + LastUpdate + "\'" + ",";
			s = s + "\'" + UpdatedBy + "\'" + ")";
			return DB.ExecuteSqlNewConn(s, false);
			
		}
		public bool InsertRemote(string ConnStr)
		{
			bool b = false;
			string s = "";
			if (LastUpdate.Trim().Length == 0)
			{
				LastUpdate = DateTime.Now.ToString();
			}
			if (DisplayHelpText.Trim().Length == 0)
			{
				DisplayHelpText = "0";
			}
			s = s + " INSERT INTO HelpText(";
			s = s + "ScreenName,";
			s = s + "HelpText,";
			s = s + "WidgetName,";
			s = s + "WidgetText,";
			s = s + "DisplayHelpText,";
			s = s + "LastUpdate,";
			s = s + "UpdatedBy) values (";
			s = s + "\'" + ScreenName + "\'" + ",";
			s = s + "\'" + HelpText + "\'" + ",";
			s = s + "\'" + WidgetName + "\'" + ",";
			s = s + "\'" + WidgetText + "\'" + ",";
			s = s + DisplayHelpText + ",";
			s = s + "\'" + LastUpdate + "\'" + ",";
			s = s + "\'" + UpdatedBy + "\'" + ")";
			return DB.ExecuteSqlNewConn(s, bool.Parse(ConnStr));
			
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
			
			s = s + " update HelpText set ";
			//s = s + "ScreenName = '" + getScreenname() + "'" + ", "
			s = s + "HelpText = \'" + getHelptext() + "\'" + ", ";
			//s = s + "WidgetName = '" + getWidgetname() + "'" + ", "
			s = s + "WidgetText = \'" + getWidgettext() + "\'" + ", ";
			s = s + "DisplayHelpText = " + getDisplayhelptext() + ", ";
			s = s + "LastUpdate = \'" + getLastupdate() + "\'" + ", ";
			s = s + "CreateDate = \'" + getCreatedate() + "\'" + ", ";
			s = s + "UpdatedBy = \'" + getUpdatedby() + "\'";
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
			s = s + "ScreenName,";
			s = s + "HelpText,";
			s = s + "WidgetName,";
			s = s + "WidgetText,";
			s = s + "DisplayHelpText,";
			s = s + "LastUpdate,";
			s = s + "CreateDate,";
			s = s + "UpdatedBy ";
			s = s + " FROM HelpText";
			
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
			s = s + "ScreenName,";
			s = s + "HelpText,";
			s = s + "WidgetName,";
			s = s + "WidgetText,";
			s = s + "DisplayHelpText,";
			s = s + "LastUpdate,";
			s = s + "CreateDate,";
			s = s + "UpdatedBy ";
			s = s + " FROM HelpText";
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
			
			s = " Delete from HelpText";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from HelpText";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_HelpText(string ScreenName, string WidgetName)
		{
			
			int B = 0;
			string TBL = "HelpText";
			string WC = "Where ScreenName = \'" + ScreenName + "\' and   WidgetName = \'" + WidgetName + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_HelpText
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_HelpText(string ScreenName, string WidgetName)
		{
			
			SqlDataReader rsData = null;
			string TBL = "HelpText";
			string WC = "Where ScreenName = \'" + ScreenName + "\' and   WidgetName = \'" + WidgetName + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_HelpText
		
		/// Build Index Where Caluses
		///
		public string wc_PK_HelpText(string ScreenName, string WidgetName)
		{
			
			string WC = "Where ScreenName = \'" + ScreenName + "\' and   WidgetName = \'" + WidgetName + "\'";
			
			return WC;
		} //** wc_PK_HelpText
		
		//** Generate the SET methods
		
	}
	
}
