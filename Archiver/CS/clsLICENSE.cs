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
	public class clsLICENSE
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsDataGrid DG = new clsDataGrid();
		
		string Agreement = "";
		string VersionNbr = "";
		string ActivationDate = "";
		string InstallDate = "";
		string CustomerID = "";
		string CustomerName = "";
		string LicenseID = "";
		string XrtNxr1 = "";
		string SqlServerInstanceNameX = "";
		string SqlServerMachineName = "";
		
		
		//** Generate the SET methods
		public void setAgreement(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Agreement\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Agreement = val;
		}
		
		public void setVersionnbr(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Versionnbr\' cannot be NULL.");
				return;
			}
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			VersionNbr = val;
		}
		
		public void setActivationdate(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Activationdate\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ActivationDate = val;
		}
		
		public void setInstalldate(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Installdate\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			InstallDate = val;
		}
		
		public void setCustomerid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Customerid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			CustomerID = val;
		}
		
		public void setCustomername(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Customername\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			CustomerName = val;
		}
		
		public void setXrtnxr1(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			XrtNxr1 = val;
		}
		
		public void setServeridentifier(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SqlServerInstanceNameX = val;
		}
		
		public void setSqlinstanceidentifier(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SqlServerMachineName = val;
		}
		
		
		
		//** Generate the GET methods
		public string getAgreement()
		{
			if (Agreement.Length == 0)
			{
				MessageBox.Show("GET: Field \'Agreement\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Agreement);
		}
		
		public string getVersionnbr()
		{
			if (VersionNbr.Length == 0)
			{
				MessageBox.Show("GET: Field \'Versionnbr\' cannot be NULL.");
				return "";
			}
			if (VersionNbr.Length == 0)
			{
				VersionNbr = "null";
			}
			return VersionNbr;
		}
		
		public string getActivationdate()
		{
			if (ActivationDate.Length == 0)
			{
				MessageBox.Show("GET: Field \'Activationdate\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ActivationDate);
		}
		
		public string getInstalldate()
		{
			if (InstallDate.Length == 0)
			{
				MessageBox.Show("GET: Field \'Installdate\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(InstallDate);
		}
		
		public string getCustomerid()
		{
			if (CustomerID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Customerid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(CustomerID);
		}
		
		public string getCustomername()
		{
			if (CustomerName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Customername\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(CustomerName);
		}
		
		public string getLicenseid()
		{
			if (LicenseID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Licenseid\' cannot be NULL.");
				return "";
			}
			if (LicenseID.Length == 0)
			{
				LicenseID = "null";
			}
			return LicenseID;
		}
		
		public string getXrtnxr1()
		{
			return UTIL.RemoveSingleQuotes(XrtNxr1);
		}
		
		public string getServeridentifier()
		{
			return UTIL.RemoveSingleQuotes(SqlServerInstanceNameX);
		}
		
		public string getSqlinstanceidentifier()
		{
			return UTIL.RemoveSingleQuotes(SqlServerMachineName);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Agreement.Length == 0)
			{
				return false;
			}
			if (VersionNbr.Length == 0)
			{
				return false;
			}
			if (ActivationDate.Length == 0)
			{
				return false;
			}
			if (InstallDate.Length == 0)
			{
				return false;
			}
			if (CustomerID.Length == 0)
			{
				return false;
			}
			if (CustomerName.Length == 0)
			{
				return false;
			}
			if (LicenseID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Agreement.Length == 0)
			{
				return false;
			}
			if (VersionNbr.Length == 0)
			{
				return false;
			}
			if (ActivationDate.Length == 0)
			{
				return false;
			}
			if (InstallDate.Length == 0)
			{
				return false;
			}
			if (CustomerID.Length == 0)
			{
				return false;
			}
			if (CustomerName.Length == 0)
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
			s = s + " INSERT INTO License(" + "\r\n";
			s = s + "Agreement," + "\r\n";
			s = s + "VersionNbr," + "\r\n";
			s = s + "ActivationDate," + "\r\n";
			s = s + "InstallDate," + "\r\n";
			s = s + "CustomerID," + "\r\n";
			s = s + "CustomerName," + "\r\n";
			s = s + "XrtNxr1," + "\r\n";
			s = s + "SqlServerInstanceName," + "\r\n";
			s = s + "SqlServerMachineName) values (" + "\r\n";
			s = s + "\'" + Agreement + "\'" + "," + "\r\n";
			s = s + VersionNbr + "," + "\r\n";
			s = s + "\'" + ActivationDate + "\'" + "," + "\r\n";
			s = s + "\'" + InstallDate + "\'" + "," + "\r\n";
			s = s + "\'" + CustomerID + "\'" + "," + "\r\n";
			s = s + "\'" + CustomerName + "\'" + "," + "\r\n";
			s = s + "\'" + XrtNxr1 + "\'" + "," + "\r\n";
			s = s + "\'" + SqlServerInstanceNameX + "\'" + "," + "\r\n";
			s = s + "\'" + SqlServerMachineName + "\'" + ")";
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
			
			s = s + " update License set ";
			s = s + "Agreement = \'" + getAgreement() + "\'" + ", ";
			s = s + "VersionNbr = " + getVersionnbr() + ", ";
			s = s + "ActivationDate = \'" + getActivationdate() + "\'" + ", ";
			s = s + "InstallDate = \'" + getInstalldate() + "\'" + ", ";
			s = s + "CustomerID = \'" + getCustomerid() + "\'" + ", ";
			s = s + "CustomerName = \'" + getCustomername() + "\'" + ", ";
			s = s + "XrtNxr1 = \'" + getXrtnxr1() + "\'" + ", ";
			s = s + "SqlServerInstanceNameX = \'" + getServeridentifier() + "\'" + ", ";
			s = s + "SqlServerMachineName = \'" + getSqlinstanceidentifier() + "\'";
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
			s = s + "Agreement,";
			s = s + "VersionNbr,";
			s = s + "ActivationDate,";
			s = s + "InstallDate,";
			s = s + "CustomerID,";
			s = s + "CustomerName,";
			s = s + "LicenseID,";
			s = s + "XrtNxr1,";
			s = s + "SqlServerInstanceNameX,";
			s = s + "SqlServerMachineName ";
			s = s + " FROM License";
			//** s=s+ "ORDERBY xxxx"
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
			s = s + "Agreement,";
			s = s + "VersionNbr,";
			s = s + "ActivationDate,";
			s = s + "InstallDate,";
			s = s + "CustomerID,";
			s = s + "CustomerName,";
			s = s + "LicenseID,";
			s = s + "XrtNxr1,";
			s = s + "SqlServerInstanceNameX,";
			s = s + "SqlServerMachineName ";
			s = s + " FROM License";
			s = s + WhereClause;
			//** s=s+ "ORDERBY xxxx"
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
			
			s = " Delete from License";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from License";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_License(string LicenseID)
		{
			
			int B = 0;
			string TBL = "License";
			string WC = "Where LicenseID = " + LicenseID;
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_License
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_License(string LicenseID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "License";
			string WC = "Where LicenseID = " + LicenseID;
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_License
		
		/// Build Index Where Caluses
		///
		public string wc_PK_License(string LicenseID)
		{
			
			string WC = "Where LicenseID = " + LicenseID;
			
			return WC;
		} //** wc_PK_License
		
		//** Generate the SET methods
		
	}
	
}
