// VBConversions Note: VB project level imports
using System.Data;
using System.Web.UI.HtmlControls;
using System.ServiceModel.Web;
using System.Web.UI.WebControls.WebParts;
using System.Diagnostics;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Runtime.Serialization;
using System.Collections.Specialized;
using System.Web.Profile;
using Microsoft.VisualBasic;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Collections;
using System;
using System.Web;
using System.Web.UI;
using System.Web.SessionState;
using System.ServiceModel;
using System.Text;
using System.Web.Caching;
using System.Web.Security;
//using System.Linq;
	// End of VB project level imports
	
	
	// NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in
	//       code, svc and config file together.
	namespace EcmSecureAttachWCF2
	{
		public class SVCGateway : IService1
		{
			
			clsSecureLogin SL = new clsSecureLogin();
		
		
		public SVCGateway()
		{
		}
		
		public bool duplicateEntry(string ConnStr, Dictionary<string, string> tDict)
		{
			return SL.duplicateEntry(ConnStr, tDict);
		}
		public string getSessionID()
		{
			string strSession;
			//strSession = HttpContext.Current.Session.SessionID
			strSession = System.Guid.NewGuid().ToString();
			return strSession;
		}
		
		public string getServiceVersion()
		{
			return "17.1.0930";
		}
		
		public string updateRepoUsers(string CompanyID, string RepoID)
		{
			string RetMsg = SL.updateRepoUsers(CompanyID, RepoID);
			return RetMsg;
		}
		
		public int validateAttachSecureLogin(int gSecureID, string gCompanyID, string gRepoID, string LoginID, string EPW)
		{
			int RC = 0;
			RC = SL.validateAttachSecureLogin(gSecureID, gCompanyID, gRepoID, LoginID, EPW);
			return RC;
		}
		
		public string getGatewayCS(int gSecureID, string gCompanyID, string gRepoID, string EPW)
		{
			string items = SL.getGatewayCS(gSecureID, gCompanyID, gRepoID, EPW);
			return items;
		}
		
		public string getEndPoints(string CompanyID, string RepoID)
		{
			string items = SL.getEndPoints(CompanyID, RepoID);
			return items;
		}
		
		public string PopulateGatewayLoginCB(string CS, string CompanyID)
		{
			string items = SL.PopulateGatewayLoginCB(CS, CompanyID);
			return items;
		}
		
		public int getSecureID(string CompanyID, string RepoID)
		{
			int I = SL.getSecureID(CompanyID, RepoID);
			return I;
		}
		
		public string getCS(int gSecureID)
		{
			string S = SL.getCS(gSecureID);
			return S;
		}
		
		public string getRepoCS(int gSecureID)
		{
			string S = SL.getRepoCS(gSecureID);
			return S;
		}
		
		public string getConnection(string CompanyID, string RepoID, ref bool RC, ref string RetMsg)
		{
			string S = SL.getConnection(CompanyID, RepoID, ref RC, ref RetMsg);
			return S;
		}
		
		public bool ValidateUserLogin(string UID, string EncPW)
		{
			bool B = SL.ValidateUserLogin(UID, EncPW);
			return B;
		}
		
		public bool ValidateGatewayLogin(string CompanyID, string RepoID, string EncPW, ref bool RC, ref string RtnMsg)
		{
			bool B = SL.ValidateGatewayLogin(CompanyID, RepoID, EncPW, ref RC, ref RtnMsg);
			return B;
		}
		
		public string getSecureKey(string CompanyID, string RepoID, string LoginPassword, ref bool RC, ref string RetMsg)
		{
			string SecureKey = "";
			SecureKey = SL.getSecureKey(CompanyID, RepoID, LoginPassword, ref RC, ref RetMsg);
			return SecureKey;
		}
		
		public string PopulateCompanyComboSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt)
		{
			string S = SL.PopulateCompanyComboSecure(CS, CompanyID, EncryptedPW, ref RC, ref RetTxt);
			return S;
		}
		
		public string PopulateCombo(string CS, string CompanyID, ref bool RC, ref string RetTxt)
		{
			string S = SL.PopulateCombo(CS, CompanyID, ref RC, ref RetTxt);
			return S;
		}
		
		public string PopulateRepoSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt)
		{
			string S = SL.PopulateRepoSecure(CS, CompanyID, EncryptedPW, ref RC, ref RetTxt);
			return S;
		}
		
		public string PopulateRepoCombo(string CS, string CompanyID, ref bool RC, ref string RetTxt)
		{
			string S = SL.PopulateRepoCombo(CS, CompanyID, ref RC, ref RetTxt);
			return S;
		}
		
		public List<DS_SecureAttach> PopulateGrid(string CS, string CompanyID, string EncPW, ref bool RC, ref string RetTxt, int LimitToCompany)
		{
			List<DS_SecureAttach> LI = new List<DS_SecureAttach>();
			LI = SL.PopulateGrid(CS, CompanyID, EncPW, ref RC, ref RetTxt, LimitToCompany);
			return LI;
		}
		
		public bool saveConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			bool temp_object = RC;
			temp_object = bool.Parse(RtnMsg);
			string temp_string = temp_object.ToString();
			return this.SaveConnection(ConnStr, tDict, ref temp_object, ref temp_string);
		}
		
		public bool SaveConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			bool B = SL.SaveConnection(ConnStr, tDict, ref RC, ref RtnMsg);
			
			return B;
		}
		
		public bool DeleteExistingConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			bool B = SL.DeleteExistingConnection(ConnStr, tDict, ref RC, ref RtnMsg);
			
			return B;
		}
		
		public bool AttachToSecureLoginDB(string ConnStr, ref bool RC, ref string RtnMsg)
		{
			//Data Source=hp8gb;Initial Catalog=;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx; Connect Timeout = 45
			bool B = SL.AttachToSecureLoginDB(ConnStr, ref RC, ref RtnMsg);
			return B;
		}
		
		public string GetData(int value)
		{
			return string.Format("You entered: {0}", value);
		}
		
		public CompositeType GetDataUsingDataContract(CompositeType composite)
		{
			if (composite == null)
			{
				throw (new ArgumentNullException("composite"));
			}
			if (composite.BoolValue)
			{
				composite.StringValue += "Suffix";
			}
			return composite;
		}
		
	}
}
