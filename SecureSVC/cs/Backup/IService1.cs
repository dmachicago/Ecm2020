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
	
	
	// NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1"
	//       in both code and config file together.
	namespace EcmSecureAttachWCF2
	{
		[ServiceContract()]public interface IService1
		{
			
			
			[OperationContract]bool duplicateEntry(string ConnStr, Dictionary<string, string> tDict);
		
		[OperationContract()]string getSessionID();
		
		[OperationContract()]string getServiceVersion();
		
		[OperationContract()]string updateRepoUsers(string CompanyID, string RepoID);
		
		[OperationContract()]int validateAttachSecureLogin(int gSecureID, string gCompanyID, string gRepoID, string LoginID, string EPW);
		
		[OperationContract()]string getGatewayCS(int gSecureID, string gCompanyID, string gRepoID, string EPW);
		
		[OperationContract()]string getEndPoints(string CompanyID, string RepoID);
		
		[OperationContract()]string PopulateGatewayLoginCB(string CS, string CompanyID);
		
		[OperationContract()]int getSecureID(string CompanyID, string RepoID);
		
		[OperationContract()]string getCS(int gSecureID);
		
		[OperationContract()]string getRepoCS(int gSecureID);
		
		[OperationContract()]string getConnection(string CompanyID, string RepoID, ref bool RC, ref string RetMsg);
		
		[OperationContract()]bool ValidateUserLogin(string UID, string EncPW);
		
		[OperationContract()]bool ValidateGatewayLogin(string CompanyID, string RepoID, string EncPW, ref bool RC, ref string RtnMsg);
		
		[OperationContract()]string getSecureKey(string CompanyID, string RepoID, string LoginPassword, ref bool RC, ref string RetMsg);
		
		[OperationContract()]string PopulateCombo(string CS, string CompanyID, ref bool RC, ref string RetTxt);
		
		[OperationContract()]string PopulateCompanyComboSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt);
		
		[OperationContract()]string PopulateRepoCombo(string CS, string CompanyID, ref bool RC, ref string RetTxt);
		
		[OperationContract()]string PopulateRepoSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt);
		
		[OperationContract()]bool DeleteExistingConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg);
		
		[OperationContract()]List<DS_SecureAttach> PopulateGrid(string CS, string CompanyID, string EncPW, ref bool RC, ref string RetTxt, int LimitToCompany);
		
		[OperationContract()]bool SaveConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg);
		
		[OperationContract()]bool AttachToSecureLoginDB(string ConnStr, ref bool RC, ref string RtnMsg);
		
		[OperationContract()]string GetData(int value);
		
		[OperationContract()]CompositeType GetDataUsingDataContract(CompositeType composite);
		
		// TODO: Add your service operations here
		
	}
	
	// Use a data contract as illustrated in the sample below to add composite types to service operations.
	
	[DataContract()]public class CompositeType
	{
		
		[DataMember()]public bool BoolValue {get; set;}
		
		[DataMember()]public string StringValue {get; set;}
		
	}
	
	public class DS_SecureAttach
	{
		
		[DataMember()]public string CompanyID;
		
		[DataMember()]public string EncPW;
		
		[DataMember()]public string RepoID;
		
		[DataMember()]public string CS;
		
		[DataMember()]public int Disabled;
		
		[DataMember()]public int RowID;
		
		[DataMember()]public int isThesaurus;
		
		[DataMember()]public string CSRepo;
		
		[DataMember()]public string CSThesaurus;
		
		[DataMember()]public string CSHive;
		
		[DataMember()]public string CSDMALicense;
		
		[DataMember()]public string CSGateWay;
		
		[DataMember()]public string CSTDR;
		
		[DataMember()]public string CSKBase;
		
		[DataMember()]public DateTime CreateDate;
		
		[DataMember()]public DateTime LastModDate;
		
		[DataMember()]public string SVCFS_Endpoint;
		
		[DataMember()]public string SVCGateway_Endpoint;
		
		[DataMember()]public string SVCCLCArchive_Endpoint;
		
		[DataMember()]public string SVCSearch_Endpoint;
		
		[DataMember()]public string SVCDownload_Endpoint;
		
		[DataMember()]public string SVCFS_CS;
		
		[DataMember()]public string SVCGateway_CS;
		
		[DataMember()]public string SVCSearch_CS;
		
		[DataMember()]public string SVCDownload_CS;
		
		[DataMember()]public string SVCThesaurus_CS;
		
	}
	
	[System.Runtime.Serialization.DataContract()]public class DS_Combo
	{
		
		[System.Runtime.Serialization.DataMember()]public string CompanyID;
		
	}
}
