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
	public class clsCONTACTSARCHIVE
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string Email1Address = "";
		string FullName = "";
		string UserID = "";
		string Account = "";
		string Anniversary = "";
		string Application = "";
		string AssistantName = "";
		string AssistantTelephoneNumber = "";
		string BillingInformation = "";
		string Birthday = "";
		string Business2TelephoneNumber = "";
		string BusinessAddress = "";
		string BusinessAddressCity = "";
		string BusinessAddressCountry = "";
		string BusinessAddressPostalCode = "";
		string BusinessAddressPostOfficeBox = "";
		string BusinessAddressState = "";
		string BusinessAddressStreet = "";
		string BusinessCardType = "";
		string BusinessFaxNumber = "";
		string BusinessHomePage = "";
		string BusinessTelephoneNumber = "";
		string CallbackTelephoneNumber = "";
		string CarTelephoneNumber = "";
		string Categories = "";
		string Children = "";
		string xClass = "";
		string Companies = "";
		string CompanyName = "";
		string ComputerNetworkName = "";
		string Conflicts = "";
		string ConversationTopic = "";
		string CreationTime = "";
		string CustomerID = "";
		string Department = "";
		string Email1AddressType = "";
		string Email1DisplayName = "";
		string Email1EntryID = "";
		string Email2Address = "";
		string Email2AddressType = "";
		string Email2DisplayName = "";
		string Email2EntryID = "";
		string Email3Address = "";
		string Email3AddressType = "";
		string Email3DisplayName = "";
		string Email3EntryID = "";
		string FileAs = "";
		string FirstName = "";
		string FTPSite = "";
		string Gender = "";
		string GovernmentIDNumber = "";
		string Hobby = "";
		string Home2TelephoneNumber = "";
		string HomeAddress = "";
		string HomeAddressCountry = "";
		string HomeAddressPostalCode = "";
		string HomeAddressPostOfficeBox = "";
		string HomeAddressState = "";
		string HomeAddressStreet = "";
		string HomeFaxNumber = "";
		string HomeTelephoneNumber = "";
		string IMAddress = "";
		string Importance = "";
		string Initials = "";
		string InternetFreeBusyAddress = "";
		string JobTitle = "";
		string Journal = "";
		string Language = "";
		string LastModificationTime = "";
		string LastName = "";
		string LastNameAndFirstName = "";
		string MailingAddress = "";
		string MailingAddressCity = "";
		string MailingAddressCountry = "";
		string MailingAddressPostalCode = "";
		string MailingAddressPostOfficeBox = "";
		string MailingAddressState = "";
		string MailingAddressStreet = "";
		string ManagerName = "";
		string MiddleName = "";
		string Mileage = "";
		string MobileTelephoneNumber = "";
		string NetMeetingAlias = "";
		string NetMeetingServer = "";
		string NickName = "";
		string Title = "";
		string Body = "";
		string OfficeLocation = "";
		string Subject = "";
		
		
		//** Generate the SET methods
		public void setEmail1address(string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Email1address\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Email1Address = val;
		}
		
		public void setFullname(string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Fullname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FullName = val;
		}
		
		public void setUserid(string val)
		{
			if (val.Length == 0)
			{
				val = modGlobals.gCurrLoginID;
				//messagebox.show("SET: Field 'Userid' cannot be NULL.")
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		public void setAccount(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Account = val;
		}
		
		public void setAnniversary(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Anniversary = val;
		}
		
		public void setApplication(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Application = val;
		}
		
		public void setAssistantname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AssistantName = val;
		}
		
		public void setAssistanttelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AssistantTelephoneNumber = val;
		}
		
		public void setBillinginformation(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BillingInformation = val;
		}
		
		public void setBirthday(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Birthday = val;
		}
		
		public void setBusiness2telephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Business2TelephoneNumber = val;
		}
		
		public void setBusinessaddress(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddress = val;
		}
		
		public void setBusinessaddresscity(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressCity = val;
		}
		
		public void setBusinessaddresscountry(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressCountry = val;
		}
		
		public void setBusinessaddresspostalcode(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressPostalCode = val;
		}
		
		public void setBusinessaddresspostofficebox(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressPostOfficeBox = val;
		}
		
		public void setBusinessaddressstate(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressState = val;
		}
		
		public void setBusinessaddressstreet(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessAddressStreet = val;
		}
		
		public void setBusinesscardtype(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessCardType = val;
		}
		
		public void setBusinessfaxnumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessFaxNumber = val;
		}
		
		public void setBusinesshomepage(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessHomePage = val;
		}
		
		public void setBusinesstelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			BusinessTelephoneNumber = val;
		}
		
		public void setCallbacktelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CallbackTelephoneNumber = val;
		}
		
		public void setCartelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CarTelephoneNumber = val;
		}
		
		public void setCategories(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Categories = val;
		}
		
		public void setChildren(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Children = val;
		}
		
		public void setXclass(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			xClass = val;
		}
		
		public void setCompanies(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Companies = val;
		}
		
		public void setCompanyname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CompanyName = val;
		}
		
		public void setComputernetworkname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ComputerNetworkName = val;
		}
		
		public void setConflicts(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Conflicts = val;
		}
		
		public void setConversationtopic(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ConversationTopic = val;
		}
		
		public void setCreationtime(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CreationTime = val;
		}
		
		public void setCustomerid(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CustomerID = val;
		}
		
		public void setDepartment(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Department = val;
		}
		
		public void setEmail1addresstype(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email1AddressType = val;
		}
		
		public void setEmail1displayname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email1DisplayName = val;
		}
		
		public void setEmail1entryid(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email1EntryID = val;
		}
		
		public void setEmail2address(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email2Address = val;
		}
		
		public void setEmail2addresstype(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email2AddressType = val;
		}
		
		public void setEmail2displayname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email2DisplayName = val;
		}
		
		public void setEmail2entryid(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email2EntryID = val;
		}
		
		public void setEmail3address(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email3Address = val;
		}
		
		public void setEmail3addresstype(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email3AddressType = val;
		}
		
		public void setEmail3displayname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email3DisplayName = val;
		}
		
		public void setEmail3entryid(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Email3EntryID = val;
		}
		
		public void setFileas(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FileAs = val;
		}
		
		public void setFirstname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FirstName = val;
		}
		
		public void setFtpsite(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FTPSite = val;
		}
		
		public void setGender(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Gender = val;
		}
		
		public void setGovernmentidnumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			GovernmentIDNumber = val;
		}
		
		public void setHobby(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Hobby = val;
		}
		
		public void setHome2telephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Home2TelephoneNumber = val;
		}
		
		public void setHomeaddress(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddress = val;
		}
		
		public void setHomeaddresscountry(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddressCountry = val;
		}
		
		public void setHomeaddresspostalcode(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddressPostalCode = val;
		}
		
		public void setHomeaddresspostofficebox(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddressPostOfficeBox = val;
		}
		
		public void setHomeaddressstate(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddressState = val;
		}
		
		public void setHomeaddressstreet(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeAddressStreet = val;
		}
		
		public void setHomefaxnumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeFaxNumber = val;
		}
		
		public void setHometelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			HomeTelephoneNumber = val;
		}
		
		public void setImaddress(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			IMAddress = val;
		}
		
		public void setImportance(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Importance = val;
		}
		
		public void setInitials(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Initials = val;
		}
		
		public void setInternetfreebusyaddress(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			InternetFreeBusyAddress = val;
		}
		
		public void setJobtitle(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			JobTitle = val;
		}
		
		public void setJournal(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Journal = val;
		}
		
		public void setLanguage(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Language = val;
		}
		
		public void setLastmodificationtime(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LastModificationTime = val;
		}
		
		public void setLastname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LastName = val;
		}
		
		public void setLastnameandfirstname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LastNameAndFirstName = val;
		}
		
		public void setMailingaddress(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddress = val;
		}
		
		public void setMailingaddresscity(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressCity = val;
		}
		
		public void setMailingaddresscountry(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressCountry = val;
		}
		
		public void setMailingaddresspostalcode(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressPostalCode = val;
		}
		
		public void setMailingaddresspostofficebox(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressPostOfficeBox = val;
		}
		
		public void setMailingaddressstate(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressState = val;
		}
		
		public void setMailingaddressstreet(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MailingAddressStreet = val;
		}
		
		public void setManagername(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ManagerName = val;
		}
		
		public void setMiddlename(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MiddleName = val;
		}
		
		public void setMileage(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Mileage = val;
		}
		
		public void setMobiletelephonenumber(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MobileTelephoneNumber = val;
		}
		
		public void setNetmeetingalias(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			NetMeetingAlias = val;
		}
		
		public void setNetmeetingserver(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			NetMeetingServer = val;
		}
		
		public void setNickname(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			NickName = val;
		}
		
		public void setTitle(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Title = val;
		}
		
		public void setBody(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Body = val;
		}
		
		public void setOfficelocation(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			OfficeLocation = val;
		}
		
		public void setSubject(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Subject = val;
		}
		
		
		
		//** Generate the GET methods
		public string getEmail1address()
		{
			if (Email1Address.Length == 0)
			{
				MessageBox.Show("GET: Field \'Email1address\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Email1Address);
		}
		
		public string getFullname()
		{
			if (FullName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Fullname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FullName);
		}
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		public string getAccount()
		{
			return UTIL.RemoveSingleQuotes(Account);
		}
		
		public string getAnniversary()
		{
			return UTIL.RemoveSingleQuotes(Anniversary);
		}
		
		public string getApplication()
		{
			return UTIL.RemoveSingleQuotes(Application);
		}
		
		public string getAssistantname()
		{
			return UTIL.RemoveSingleQuotes(AssistantName);
		}
		
		public string getAssistanttelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(AssistantTelephoneNumber);
		}
		
		public string getBillinginformation()
		{
			return UTIL.RemoveSingleQuotes(BillingInformation);
		}
		
		public string getBirthday()
		{
			return UTIL.RemoveSingleQuotes(Birthday);
		}
		
		public string getBusiness2telephonenumber()
		{
			return UTIL.RemoveSingleQuotes(Business2TelephoneNumber);
		}
		
		public string getBusinessaddress()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddress);
		}
		
		public string getBusinessaddresscity()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressCity);
		}
		
		public string getBusinessaddresscountry()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressCountry);
		}
		
		public string getBusinessaddresspostalcode()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressPostalCode);
		}
		
		public string getBusinessaddresspostofficebox()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressPostOfficeBox);
		}
		
		public string getBusinessaddressstate()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressState);
		}
		
		public string getBusinessaddressstreet()
		{
			return UTIL.RemoveSingleQuotes(BusinessAddressStreet);
		}
		
		public string getBusinesscardtype()
		{
			return UTIL.RemoveSingleQuotes(BusinessCardType);
		}
		
		public string getBusinessfaxnumber()
		{
			return UTIL.RemoveSingleQuotes(BusinessFaxNumber);
		}
		
		public string getBusinesshomepage()
		{
			return UTIL.RemoveSingleQuotes(BusinessHomePage);
		}
		
		public string getBusinesstelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(BusinessTelephoneNumber);
		}
		
		public string getCallbacktelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(CallbackTelephoneNumber);
		}
		
		public string getCartelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(CarTelephoneNumber);
		}
		
		public string getCategories()
		{
			return UTIL.RemoveSingleQuotes(Categories);
		}
		
		public string getChildren()
		{
			return UTIL.RemoveSingleQuotes(Children);
		}
		
		public string getXclass()
		{
			return UTIL.RemoveSingleQuotes(xClass);
		}
		
		public string getCompanies()
		{
			return UTIL.RemoveSingleQuotes(Companies);
		}
		
		public string getCompanyname()
		{
			return UTIL.RemoveSingleQuotes(CompanyName);
		}
		
		public string getComputernetworkname()
		{
			return UTIL.RemoveSingleQuotes(ComputerNetworkName);
		}
		
		public string getConflicts()
		{
			return UTIL.RemoveSingleQuotes(Conflicts);
		}
		
		public string getConversationtopic()
		{
			return UTIL.RemoveSingleQuotes(ConversationTopic);
		}
		
		public string getCreationtime()
		{
			return UTIL.RemoveSingleQuotes(CreationTime);
		}
		
		public string getCustomerid()
		{
			return UTIL.RemoveSingleQuotes(CustomerID);
		}
		
		public string getDepartment()
		{
			return UTIL.RemoveSingleQuotes(Department);
		}
		
		public string getEmail1addresstype()
		{
			return UTIL.RemoveSingleQuotes(Email1AddressType);
		}
		
		public string getEmail1displayname()
		{
			return UTIL.RemoveSingleQuotes(Email1DisplayName);
		}
		
		public string getEmail1entryid()
		{
			return UTIL.RemoveSingleQuotes(Email1EntryID);
		}
		
		public string getEmail2address()
		{
			return UTIL.RemoveSingleQuotes(Email2Address);
		}
		
		public string getEmail2addresstype()
		{
			return UTIL.RemoveSingleQuotes(Email2AddressType);
		}
		
		public string getEmail2displayname()
		{
			return UTIL.RemoveSingleQuotes(Email2DisplayName);
		}
		
		public string getEmail2entryid()
		{
			return UTIL.RemoveSingleQuotes(Email2EntryID);
		}
		
		public string getEmail3address()
		{
			return UTIL.RemoveSingleQuotes(Email3Address);
		}
		
		public string getEmail3addresstype()
		{
			return UTIL.RemoveSingleQuotes(Email3AddressType);
		}
		
		public string getEmail3displayname()
		{
			return UTIL.RemoveSingleQuotes(Email3DisplayName);
		}
		
		public string getEmail3entryid()
		{
			return UTIL.RemoveSingleQuotes(Email3EntryID);
		}
		
		public string getFileas()
		{
			return UTIL.RemoveSingleQuotes(FileAs);
		}
		
		public string getFirstname()
		{
			return UTIL.RemoveSingleQuotes(FirstName);
		}
		
		public string getFtpsite()
		{
			return UTIL.RemoveSingleQuotes(FTPSite);
		}
		
		public string getGender()
		{
			return UTIL.RemoveSingleQuotes(Gender);
		}
		
		public string getGovernmentidnumber()
		{
			return UTIL.RemoveSingleQuotes(GovernmentIDNumber);
		}
		
		public string getHobby()
		{
			return UTIL.RemoveSingleQuotes(Hobby);
		}
		
		public string getHome2telephonenumber()
		{
			return UTIL.RemoveSingleQuotes(Home2TelephoneNumber);
		}
		
		public string getHomeaddress()
		{
			return UTIL.RemoveSingleQuotes(HomeAddress);
		}
		
		public string getHomeaddresscountry()
		{
			return UTIL.RemoveSingleQuotes(HomeAddressCountry);
		}
		
		public string getHomeaddresspostalcode()
		{
			return UTIL.RemoveSingleQuotes(HomeAddressPostalCode);
		}
		
		public string getHomeaddresspostofficebox()
		{
			return UTIL.RemoveSingleQuotes(HomeAddressPostOfficeBox);
		}
		
		public string getHomeaddressstate()
		{
			return UTIL.RemoveSingleQuotes(HomeAddressState);
		}
		
		public string getHomeaddressstreet()
		{
			return UTIL.RemoveSingleQuotes(HomeAddressStreet);
		}
		
		public string getHomefaxnumber()
		{
			return UTIL.RemoveSingleQuotes(HomeFaxNumber);
		}
		
		public string getHometelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(HomeTelephoneNumber);
		}
		
		public string getImaddress()
		{
			return UTIL.RemoveSingleQuotes(IMAddress);
		}
		
		public string getImportance()
		{
			return UTIL.RemoveSingleQuotes(Importance);
		}
		
		public string getInitials()
		{
			return UTIL.RemoveSingleQuotes(Initials);
		}
		
		public string getInternetfreebusyaddress()
		{
			return UTIL.RemoveSingleQuotes(InternetFreeBusyAddress);
		}
		
		public string getJobtitle()
		{
			return UTIL.RemoveSingleQuotes(JobTitle);
		}
		
		public string getJournal()
		{
			return UTIL.RemoveSingleQuotes(Journal);
		}
		
		public string getLanguage()
		{
			return UTIL.RemoveSingleQuotes(Language);
		}
		
		public string getLastmodificationtime()
		{
			return UTIL.RemoveSingleQuotes(LastModificationTime);
		}
		
		public string getLastname()
		{
			return UTIL.RemoveSingleQuotes(LastName);
		}
		
		public string getLastnameandfirstname()
		{
			return UTIL.RemoveSingleQuotes(LastNameAndFirstName);
		}
		
		public string getMailingaddress()
		{
			return UTIL.RemoveSingleQuotes(MailingAddress);
		}
		
		public string getMailingaddresscity()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressCity);
		}
		
		public string getMailingaddresscountry()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressCountry);
		}
		
		public string getMailingaddresspostalcode()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressPostalCode);
		}
		
		public string getMailingaddresspostofficebox()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressPostOfficeBox);
		}
		
		public string getMailingaddressstate()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressState);
		}
		
		public string getMailingaddressstreet()
		{
			return UTIL.RemoveSingleQuotes(MailingAddressStreet);
		}
		
		public string getManagername()
		{
			return UTIL.RemoveSingleQuotes(ManagerName);
		}
		
		public string getMiddlename()
		{
			return UTIL.RemoveSingleQuotes(MiddleName);
		}
		
		public string getMileage()
		{
			return UTIL.RemoveSingleQuotes(Mileage);
		}
		
		public string getMobiletelephonenumber()
		{
			return UTIL.RemoveSingleQuotes(MobileTelephoneNumber);
		}
		
		public string getNetmeetingalias()
		{
			return UTIL.RemoveSingleQuotes(NetMeetingAlias);
		}
		
		public string getNetmeetingserver()
		{
			return UTIL.RemoveSingleQuotes(NetMeetingServer);
		}
		
		public string getNickname()
		{
			return UTIL.RemoveSingleQuotes(NickName);
		}
		
		public string getTitle()
		{
			return UTIL.RemoveSingleQuotes(Title);
		}
		
		public string getBody()
		{
			return UTIL.RemoveSingleQuotes(Body);
		}
		
		public string getOfficelocation()
		{
			return UTIL.RemoveSingleQuotes(OfficeLocation);
		}
		
		public string getSubject()
		{
			return UTIL.RemoveSingleQuotes(Subject);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Email1Address.Length == 0)
			{
				return false;
			}
			if (FullName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Email1Address.Length == 0)
			{
				return false;
			}
			if (FullName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
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
			s = s + " INSERT INTO ContactsArchive(" + "\r\n";
			s = s + "Email1Address," + "\r\n";
			s = s + "FullName," + "\r\n";
			s = s + "UserID," + "\r\n";
			s = s + "Account," + "\r\n";
			s = s + "Anniversary," + "\r\n";
			s = s + "Application," + "\r\n";
			s = s + "AssistantName," + "\r\n";
			s = s + "AssistantTelephoneNumber," + "\r\n";
			s = s + "BillingInformation," + "\r\n";
			s = s + "Birthday," + "\r\n";
			s = s + "Business2TelephoneNumber," + "\r\n";
			s = s + "BusinessAddress," + "\r\n";
			s = s + "BusinessAddressCity," + "\r\n";
			s = s + "BusinessAddressCountry," + "\r\n";
			s = s + "BusinessAddressPostalCode," + "\r\n";
			s = s + "BusinessAddressPostOfficeBox," + "\r\n";
			s = s + "BusinessAddressState," + "\r\n";
			s = s + "BusinessAddressStreet," + "\r\n";
			s = s + "BusinessCardType," + "\r\n";
			s = s + "BusinessFaxNumber," + "\r\n";
			s = s + "BusinessHomePage," + "\r\n";
			s = s + "BusinessTelephoneNumber," + "\r\n";
			s = s + "CallbackTelephoneNumber," + "\r\n";
			s = s + "CarTelephoneNumber," + "\r\n";
			s = s + "Categories," + "\r\n";
			s = s + "Children," + "\r\n";
			s = s + "xClass," + "\r\n";
			s = s + "Companies," + "\r\n";
			s = s + "CompanyName," + "\r\n";
			s = s + "ComputerNetworkName," + "\r\n";
			s = s + "Conflicts," + "\r\n";
			s = s + "ConversationTopic," + "\r\n";
			s = s + "CreationTime," + "\r\n";
			s = s + "CustomerID," + "\r\n";
			s = s + "Department," + "\r\n";
			s = s + "Email1AddressType," + "\r\n";
			s = s + "Email1DisplayName," + "\r\n";
			s = s + "Email1EntryID," + "\r\n";
			s = s + "Email2Address," + "\r\n";
			s = s + "Email2AddressType," + "\r\n";
			s = s + "Email2DisplayName," + "\r\n";
			s = s + "Email2EntryID," + "\r\n";
			s = s + "Email3Address," + "\r\n";
			s = s + "Email3AddressType," + "\r\n";
			s = s + "Email3DisplayName," + "\r\n";
			s = s + "Email3EntryID," + "\r\n";
			s = s + "FileAs," + "\r\n";
			s = s + "FirstName," + "\r\n";
			s = s + "FTPSite," + "\r\n";
			s = s + "Gender," + "\r\n";
			s = s + "GovernmentIDNumber," + "\r\n";
			s = s + "Hobby," + "\r\n";
			s = s + "Home2TelephoneNumber," + "\r\n";
			s = s + "HomeAddress," + "\r\n";
			s = s + "HomeAddressCountry," + "\r\n";
			s = s + "HomeAddressPostalCode," + "\r\n";
			s = s + "HomeAddressPostOfficeBox," + "\r\n";
			s = s + "HomeAddressState," + "\r\n";
			s = s + "HomeAddressStreet," + "\r\n";
			s = s + "HomeFaxNumber," + "\r\n";
			s = s + "HomeTelephoneNumber," + "\r\n";
			s = s + "IMAddress," + "\r\n";
			s = s + "Importance," + "\r\n";
			s = s + "Initials," + "\r\n";
			s = s + "InternetFreeBusyAddress," + "\r\n";
			s = s + "JobTitle," + "\r\n";
			s = s + "Journal," + "\r\n";
			s = s + "Language," + "\r\n";
			s = s + "LastModificationTime," + "\r\n";
			s = s + "LastName," + "\r\n";
			s = s + "LastNameAndFirstName," + "\r\n";
			s = s + "MailingAddress," + "\r\n";
			s = s + "MailingAddressCity," + "\r\n";
			s = s + "MailingAddressCountry," + "\r\n";
			s = s + "MailingAddressPostalCode," + "\r\n";
			s = s + "MailingAddressPostOfficeBox," + "\r\n";
			s = s + "MailingAddressState," + "\r\n";
			s = s + "MailingAddressStreet," + "\r\n";
			s = s + "ManagerName," + "\r\n";
			s = s + "MiddleName," + "\r\n";
			s = s + "Mileage," + "\r\n";
			s = s + "MobileTelephoneNumber," + "\r\n";
			s = s + "NetMeetingAlias," + "\r\n";
			s = s + "NetMeetingServer," + "\r\n";
			s = s + "NickName," + "\r\n";
			s = s + "Title," + "\r\n";
			s = s + "Body," + "\r\n";
			s = s + "OfficeLocation," + "\r\n";
			s = s + "Subject) values (";
			s = s + "\'" + Email1Address.ToString() + "\'" + "," + "\r\n";
			s = s + "\'" + FullName.ToString() + "\'" + "," + "\r\n";
			s = s + "\'" + UserID.ToString() + "\'" + "," + "\r\n";
			if (Account == null)
			{
				Account = " ";
			}
			s = s + "\'" + Account.ToString() + "\'" + "," + "\r\n";
			if (Anniversary == null)
			{
				Anniversary = " ";
			}
			s = s + "\'" + Anniversary.ToString() + "\'" + "," + "\r\n";
			if (Application == null)
			{
				Application = " ";
			}
			s = s + "\'" + Application.ToString() + "\'" + "," + "\r\n";
			if (AssistantName == null)
			{
				AssistantName = " ";
			}
			s = s + "\'" + AssistantName.ToString() + "\'" + "," + "\r\n";
			if (AssistantTelephoneNumber == null)
			{
				AssistantTelephoneNumber = " ";
			}
			s = s + "\'" + AssistantTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (BillingInformation == null)
			{
				BillingInformation = " ";
			}
			s = s + "\'" + BillingInformation.ToString() + "\'" + "," + "\r\n";
			if (Birthday == null)
			{
				Birthday = " ";
			}
			s = s + "\'" + Birthday.ToString() + "\'" + "," + "\r\n";
			if (Business2TelephoneNumber == null)
			{
				Business2TelephoneNumber = " ";
			}
			s = s + "\'" + Business2TelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddress == null)
			{
				BusinessAddress = " ";
			}
			s = s + "\'" + BusinessAddress.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressCity == null)
			{
				BusinessAddressCity = " ";
			}
			s = s + "\'" + BusinessAddressCity.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressCountry == null)
			{
				BusinessAddressCountry = " ";
			}
			s = s + "\'" + BusinessAddressCountry.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressPostalCode == null)
			{
				BusinessAddressPostalCode = " ";
			}
			s = s + "\'" + BusinessAddressPostalCode.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressPostOfficeBox == null)
			{
				BusinessAddressPostOfficeBox = " ";
			}
			s = s + "\'" + BusinessAddressPostOfficeBox.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressState == null)
			{
				BusinessAddressState = " ";
			}
			s = s + "\'" + BusinessAddressState.ToString() + "\'" + "," + "\r\n";
			if (BusinessAddressStreet == null)
			{
				BusinessAddressStreet = " ";
			}
			s = s + "\'" + BusinessAddressStreet.ToString() + "\'" + "," + "\r\n";
			if (BusinessCardType == null)
			{
				BusinessCardType = " ";
			}
			s = s + "\'" + BusinessCardType.ToString() + "\'" + "," + "\r\n";
			if (BusinessFaxNumber == null)
			{
				BusinessFaxNumber = " ";
			}
			s = s + "\'" + BusinessFaxNumber.ToString() + "\'" + "," + "\r\n";
			if (BusinessHomePage == null)
			{
				BusinessHomePage = " ";
			}
			s = s + "\'" + BusinessHomePage.ToString() + "\'" + "," + "\r\n";
			if (BusinessTelephoneNumber == null)
			{
				BusinessTelephoneNumber = " ";
			}
			s = s + "\'" + BusinessTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (CallbackTelephoneNumber == null)
			{
				CallbackTelephoneNumber = " ";
			}
			s = s + "\'" + CallbackTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (CarTelephoneNumber == null)
			{
				CarTelephoneNumber = " ";
			}
			s = s + "\'" + CarTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (Categories == null)
			{
				Categories = " ";
			}
			s = s + "\'" + Categories.ToString() + "\'" + "," + "\r\n";
			if (Children == null)
			{
				Children = " ";
			}
			s = s + "\'" + Children.ToString() + "\'" + "," + "\r\n";
			if (xClass == null)
			{
				xClass = " ";
			}
			s = s + "\'" + xClass.ToString() + "\'" + "," + "\r\n";
			if (Companies == null)
			{
				Companies = " ";
			}
			s = s + "\'" + Companies.ToString() + "\'" + "," + "\r\n";
			if (CompanyName == null)
			{
				CompanyName = " ";
			}
			s = s + "\'" + CompanyName.ToString() + "\'" + "," + "\r\n";
			if (ComputerNetworkName == null)
			{
				ComputerNetworkName = " ";
			}
			s = s + "\'" + ComputerNetworkName.ToString() + "\'" + "," + "\r\n";
			if (Conflicts == null)
			{
				Conflicts = " ";
			}
			s = s + "\'" + Conflicts.ToString() + "\'" + "," + "\r\n";
			if (ConversationTopic == null)
			{
				ConversationTopic = " ";
			}
			s = s + "\'" + ConversationTopic.ToString() + "\'" + "," + "\r\n";
			if (CreationTime == null)
			{
				CreationTime = " ";
			}
			s = s + "\'" + CreationTime.ToString() + "\'" + "," + "\r\n";
			//Debug.Print(s.Length.ToString)
			if (CustomerID == null)
			{
				CustomerID = " ";
			}
			s = s + "\'" + CustomerID.ToString() + "\'" + "," + "\r\n";
			if (Department == null)
			{
				Department = " ";
			}
			s = s + "\'" + Department.ToString() + "\'" + "," + "\r\n";
			if (Email1AddressType == null)
			{
				Email1AddressType = " ";
			}
			s = s + "\'" + Email1AddressType.ToString() + "\'" + "," + "\r\n";
			if (Email1DisplayName == null)
			{
				Email1DisplayName = " ";
			}
			s = s + "\'" + Email1DisplayName.ToString() + "\'" + "," + "\r\n";
			if (Email1EntryID == null)
			{
				Email1EntryID = " ";
			}
			s = s + "\'" + Email1EntryID.ToString() + "\'" + "," + "\r\n";
			if (Email2Address == null)
			{
				Email2Address = " ";
			}
			s = s + "\'" + Email2Address.ToString() + "\'" + "," + "\r\n";
			if (Email2AddressType == null)
			{
				Email2AddressType = " ";
			}
			s = s + "\'" + Email2AddressType.ToString() + "\'" + "," + "\r\n";
			//Debug.Print(s.Length.ToString)
			if (Email2DisplayName == null)
			{
				Email2DisplayName = " ";
			}
			s = s + "\'" + Email2DisplayName.ToString() + "\'" + "," + "\r\n";
			if (Email2EntryID == null)
			{
				Email2EntryID = " ";
			}
			s = s + "\'" + Email2EntryID.ToString() + "\'" + "," + "\r\n";
			if (Email3Address == null)
			{
				Email3Address = " ";
			}
			s = s + "\'" + Email3Address.ToString() + "\'" + "," + "\r\n";
			if (Email3AddressType == null)
			{
				Email3AddressType = " ";
			}
			s = s + "\'" + Email3AddressType.ToString() + "\'" + "," + "\r\n";
			if (Email3DisplayName == null)
			{
				Email3DisplayName = " ";
			}
			s = s + "\'" + Email3DisplayName.ToString() + "\'" + "," + "\r\n";
			if (Email3EntryID == null)
			{
				Email3EntryID = " ";
			}
			s = s + "\'" + Email3EntryID.ToString() + "\'" + "," + "\r\n";
			if (FileAs == null)
			{
				FileAs = " ";
			}
			s = s + "\'" + FileAs.ToString() + "\'" + "," + "\r\n";
			if (FirstName == null)
			{
				FirstName = " ";
			}
			s = s + "\'" + FirstName.ToString() + "\'" + "," + "\r\n";
			if (FTPSite == null)
			{
				FTPSite = " ";
			}
			s = s + "\'" + FTPSite.ToString() + "\'" + "," + "\r\n";
			if (Gender == null)
			{
				Gender = " ";
			}
			s = s + "\'" + Gender.ToString() + "\'" + "," + "\r\n";
			if (GovernmentIDNumber == null)
			{
				GovernmentIDNumber = " ";
			}
			s = s + "\'" + GovernmentIDNumber.ToString() + "\'" + "," + "\r\n";
			if (Hobby == null)
			{
				Hobby = " ";
			}
			s = s + "\'" + Hobby.ToString() + "\'" + "," + "\r\n";
			if (Home2TelephoneNumber == null)
			{
				Home2TelephoneNumber = " ";
			}
			s = s + "\'" + Home2TelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (HomeAddress == null)
			{
				HomeAddress = " ";
			}
			s = s + "\'" + HomeAddress.ToString() + "\'" + "," + "\r\n";
			if (HomeAddressCountry == null)
			{
				HomeAddressCountry = " ";
			}
			s = s + "\'" + HomeAddressCountry.ToString() + "\'" + "," + "\r\n";
			if (HomeAddressPostalCode == null)
			{
				HomeAddressPostalCode = " ";
			}
			s = s + "\'" + HomeAddressPostalCode.ToString() + "\'" + "," + "\r\n";
			if (HomeAddressPostOfficeBox == null)
			{
				HomeAddressPostOfficeBox = " ";
			}
			s = s + "\'" + HomeAddressPostOfficeBox.ToString() + "\'" + "," + "\r\n";
			if (HomeAddressState == null)
			{
				HomeAddressState = " ";
			}
			s = s + "\'" + HomeAddressState.ToString() + "\'" + "," + "\r\n";
			if (HomeAddressStreet == null)
			{
				HomeAddressStreet = " ";
			}
			s = s + "\'" + HomeAddressStreet.ToString() + "\'" + "," + "\r\n";
			if (HomeFaxNumber == null)
			{
				HomeFaxNumber = " ";
			}
			s = s + "\'" + HomeFaxNumber.ToString() + "\'" + "," + "\r\n";
			if (HomeTelephoneNumber == null)
			{
				HomeTelephoneNumber = " ";
			}
			s = s + "\'" + HomeTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (IMAddress == null)
			{
				IMAddress = " ";
			}
			s = s + "\'" + IMAddress.ToString() + "\'" + "," + "\r\n";
			if (Importance == null)
			{
				Importance = " ";
			}
			s = s + "\'" + Importance.ToString() + "\'" + "," + "\r\n";
			if (Initials == null)
			{
				Initials = " ";
			}
			s = s + "\'" + Initials.ToString() + "\'" + "," + "\r\n";
			if (InternetFreeBusyAddress == null)
			{
				InternetFreeBusyAddress = " ";
			}
			s = s + "\'" + InternetFreeBusyAddress.ToString() + "\'" + "," + "\r\n";
			if (JobTitle == null)
			{
				JobTitle = " ";
			}
			s = s + "\'" + JobTitle.ToString() + "\'" + "," + "\r\n";
			if (Journal == null)
			{
				Journal = " ";
			}
			s = s + "\'" + Journal.ToString() + "\'" + "," + "\r\n";
			if (Language == null)
			{
				Language = " ";
			}
			s = s + "\'" + Language.ToString() + "\'" + "," + "\r\n";
			if (LastModificationTime == null)
			{
				LastModificationTime = " ";
			}
			s = s + "\'" + LastModificationTime.ToString() + "\'" + "," + "\r\n";
			if (LastName == null)
			{
				LastName = " ";
			}
			s = s + "\'" + LastName.ToString() + "\'" + "," + "\r\n";
			if (LastNameAndFirstName == null)
			{
				LastNameAndFirstName = " ";
			}
			s = s + "\'" + LastNameAndFirstName.ToString() + "\'" + "," + "\r\n";
			if (MailingAddress == null)
			{
				MailingAddress = " ";
			}
			s = s + "\'" + MailingAddress.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressCity == null)
			{
				MailingAddressCity = " ";
			}
			s = s + "\'" + MailingAddressCity.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressCountry == null)
			{
				MailingAddressCountry = " ";
			}
			s = s + "\'" + MailingAddressCountry.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressPostalCode == null)
			{
				MailingAddressPostalCode = " ";
			}
			s = s + "\'" + MailingAddressPostalCode.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressPostOfficeBox == null)
			{
				MailingAddressPostOfficeBox = " ";
			}
			s = s + "\'" + MailingAddressPostOfficeBox.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressState == null)
			{
				MailingAddressState = " ";
			}
			s = s + "\'" + MailingAddressState.ToString() + "\'" + "," + "\r\n";
			if (MailingAddressStreet == null)
			{
				MailingAddressStreet = " ";
			}
			s = s + "\'" + MailingAddressStreet.ToString() + "\'" + "," + "\r\n";
			if (ManagerName == null)
			{
				ManagerName = " ";
			}
			s = s + "\'" + ManagerName.ToString() + "\'" + "," + "\r\n";
			if (MiddleName == null)
			{
				MiddleName = " ";
			}
			s = s + "\'" + MiddleName.ToString() + "\'" + "," + "\r\n";
			if (Mileage == null)
			{
				Mileage = " ";
			}
			s = s + "\'" + Mileage.ToString() + "\'" + "," + "\r\n";
			if (MobileTelephoneNumber == null)
			{
				MobileTelephoneNumber = " ";
			}
			s = s + "\'" + MobileTelephoneNumber.ToString() + "\'" + "," + "\r\n";
			if (NetMeetingAlias == null)
			{
				NetMeetingAlias = " ";
			}
			s = s + "\'" + NetMeetingAlias.ToString() + "\'" + "," + "\r\n";
			if (NetMeetingServer == null)
			{
				NetMeetingServer = " ";
			}
			s = s + "\'" + NetMeetingServer.ToString() + "\'" + "," + "\r\n";
			if (NickName == null)
			{
				NickName = " ";
			}
			s = s + "\'" + NickName.ToString() + "\'" + "," + "\r\n";
			if (Title == null)
			{
				Title = " ";
			}
			s = s + "\'" + Title.ToString() + "\'" + "," + "\r\n";
			if (Body == null)
			{
				Body = " ";
			}
			s = s + "\'" + Body.ToString() + "\'" + "," + "\r\n";
			if (OfficeLocation == null)
			{
				OfficeLocation = " ";
			}
			s = s + "\'" + OfficeLocation.ToString() + "\'" + "," + "\r\n";
			if (Subject == null)
			{
				Subject = " ";
			}
			s = s + "\'" + Subject.ToString() + "\'";
			s = s + ")";
			
			Debug.Print(s.Length.ToString());
			Debug.Print(s);
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
			
			s = s + " update ContactsArchive set ";
			s = s + "Email1Address = \'" + getEmail1address() + "\'" + ", ";
			s = s + "FullName = \'" + getFullname() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "Account = \'" + getAccount() + "\'" + ", ";
			s = s + "Anniversary = \'" + getAnniversary() + "\'" + ", ";
			s = s + "Application = \'" + getApplication() + "\'" + ", ";
			s = s + "AssistantName = \'" + getAssistantname() + "\'" + ", ";
			s = s + "AssistantTelephoneNumber = \'" + getAssistanttelephonenumber() + "\'" + ", ";
			s = s + "BillingInformation = \'" + getBillinginformation() + "\'" + ", ";
			s = s + "Birthday = \'" + getBirthday() + "\'" + ", ";
			s = s + "Business2TelephoneNumber = \'" + getBusiness2telephonenumber() + "\'" + ", ";
			s = s + "BusinessAddress = \'" + getBusinessaddress() + "\'" + ", ";
			s = s + "BusinessAddressCity = \'" + getBusinessaddresscity() + "\'" + ", ";
			s = s + "BusinessAddressCountry = \'" + getBusinessaddresscountry() + "\'" + ", ";
			s = s + "BusinessAddressPostalCode = \'" + getBusinessaddresspostalcode() + "\'" + ", ";
			s = s + "BusinessAddressPostOfficeBox = \'" + getBusinessaddresspostofficebox() + "\'" + ", ";
			s = s + "BusinessAddressState = \'" + getBusinessaddressstate() + "\'" + ", ";
			s = s + "BusinessAddressStreet = \'" + getBusinessaddressstreet() + "\'" + ", ";
			s = s + "BusinessCardType = \'" + getBusinesscardtype() + "\'" + ", ";
			s = s + "BusinessFaxNumber = \'" + getBusinessfaxnumber() + "\'" + ", ";
			s = s + "BusinessHomePage = \'" + getBusinesshomepage() + "\'" + ", ";
			s = s + "BusinessTelephoneNumber = \'" + getBusinesstelephonenumber() + "\'" + ", ";
			s = s + "CallbackTelephoneNumber = \'" + getCallbacktelephonenumber() + "\'" + ", ";
			s = s + "CarTelephoneNumber = \'" + getCartelephonenumber() + "\'" + ", ";
			s = s + "Categories = \'" + getCategories() + "\'" + ", ";
			s = s + "Children = \'" + getChildren() + "\'" + ", ";
			s = s + "xClass = \'" + getXclass() + "\'" + ", ";
			s = s + "Companies = \'" + getCompanies() + "\'" + ", ";
			s = s + "CompanyName = \'" + getCompanyname() + "\'" + ", ";
			s = s + "ComputerNetworkName = \'" + getComputernetworkname() + "\'" + ", ";
			s = s + "Conflicts = \'" + getConflicts() + "\'" + ", ";
			s = s + "ConversationTopic = \'" + getConversationtopic() + "\'" + ", ";
			s = s + "CreationTime = \'" + getCreationtime() + "\'" + ", ";
			s = s + "CustomerID = \'" + getCustomerid() + "\'" + ", ";
			s = s + "Department = \'" + getDepartment() + "\'" + ", ";
			s = s + "Email1AddressType = \'" + getEmail1addresstype() + "\'" + ", ";
			s = s + "Email1DisplayName = \'" + getEmail1displayname() + "\'" + ", ";
			s = s + "Email1EntryID = \'" + getEmail1entryid() + "\'" + ", ";
			s = s + "Email2Address = \'" + getEmail2address() + "\'" + ", ";
			s = s + "Email2AddressType = \'" + getEmail2addresstype() + "\'" + ", ";
			s = s + "Email2DisplayName = \'" + getEmail2displayname() + "\'" + ", ";
			s = s + "Email2EntryID = \'" + getEmail2entryid() + "\'" + ", ";
			s = s + "Email3Address = \'" + getEmail3address() + "\'" + ", ";
			s = s + "Email3AddressType = \'" + getEmail3addresstype() + "\'" + ", ";
			s = s + "Email3DisplayName = \'" + getEmail3displayname() + "\'" + ", ";
			s = s + "Email3EntryID = \'" + getEmail3entryid() + "\'" + ", ";
			s = s + "FileAs = \'" + getFileas() + "\'" + ", ";
			s = s + "FirstName = \'" + getFirstname() + "\'" + ", ";
			s = s + "FTPSite = \'" + getFtpsite() + "\'" + ", ";
			s = s + "Gender = \'" + getGender() + "\'" + ", ";
			s = s + "GovernmentIDNumber = \'" + getGovernmentidnumber() + "\'" + ", ";
			s = s + "Hobby = \'" + getHobby() + "\'" + ", ";
			s = s + "Home2TelephoneNumber = \'" + getHome2telephonenumber() + "\'" + ", ";
			s = s + "HomeAddress = \'" + getHomeaddress() + "\'" + ", ";
			s = s + "HomeAddressCountry = \'" + getHomeaddresscountry() + "\'" + ", ";
			s = s + "HomeAddressPostalCode = \'" + getHomeaddresspostalcode() + "\'" + ", ";
			s = s + "HomeAddressPostOfficeBox = \'" + getHomeaddresspostofficebox() + "\'" + ", ";
			s = s + "HomeAddressState = \'" + getHomeaddressstate() + "\'" + ", ";
			s = s + "HomeAddressStreet = \'" + getHomeaddressstreet() + "\'" + ", ";
			s = s + "HomeFaxNumber = \'" + getHomefaxnumber() + "\'" + ", ";
			s = s + "HomeTelephoneNumber = \'" + getHometelephonenumber() + "\'" + ", ";
			s = s + "IMAddress = \'" + getImaddress() + "\'" + ", ";
			s = s + "Importance = \'" + getImportance() + "\'" + ", ";
			s = s + "Initials = \'" + getInitials() + "\'" + ", ";
			s = s + "InternetFreeBusyAddress = \'" + getInternetfreebusyaddress() + "\'" + ", ";
			s = s + "JobTitle = \'" + getJobtitle() + "\'" + ", ";
			s = s + "Journal = \'" + getJournal() + "\'" + ", ";
			s = s + "Language = \'" + getLanguage() + "\'" + ", ";
			s = s + "LastModificationTime = \'" + getLastmodificationtime() + "\'" + ", ";
			s = s + "LastName = \'" + getLastname() + "\'" + ", ";
			s = s + "LastNameAndFirstName = \'" + getLastnameandfirstname() + "\'" + ", ";
			s = s + "MailingAddress = \'" + getMailingaddress() + "\'" + ", ";
			s = s + "MailingAddressCity = \'" + getMailingaddresscity() + "\'" + ", ";
			s = s + "MailingAddressCountry = \'" + getMailingaddresscountry() + "\'" + ", ";
			s = s + "MailingAddressPostalCode = \'" + getMailingaddresspostalcode() + "\'" + ", ";
			s = s + "MailingAddressPostOfficeBox = \'" + getMailingaddresspostofficebox() + "\'" + ", ";
			s = s + "MailingAddressState = \'" + getMailingaddressstate() + "\'" + ", ";
			s = s + "MailingAddressStreet = \'" + getMailingaddressstreet() + "\'" + ", ";
			s = s + "ManagerName = \'" + getManagername() + "\'" + ", ";
			s = s + "MiddleName = \'" + getMiddlename() + "\'" + ", ";
			s = s + "Mileage = \'" + getMileage() + "\'" + ", ";
			s = s + "MobileTelephoneNumber = \'" + getMobiletelephonenumber() + "\'" + ", ";
			s = s + "NetMeetingAlias = \'" + getNetmeetingalias() + "\'" + ", ";
			s = s + "NetMeetingServer = \'" + getNetmeetingserver() + "\'" + ", ";
			s = s + "NickName = \'" + getNickname() + "\'" + ", ";
			s = s + "Title = \'" + getTitle() + "\'" + ", ";
			s = s + "Body = \'" + getBody() + "\'" + ", ";
			s = s + "OfficeLocation = \'" + getOfficelocation() + "\'" + ", ";
			s = s + "Subject = \'" + getSubject() + "\'";
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
			s = s + "Email1Address,";
			s = s + "FullName,";
			s = s + "UserID,";
			s = s + "Account,";
			s = s + "Anniversary,";
			s = s + "Application,";
			s = s + "AssistantName,";
			s = s + "AssistantTelephoneNumber,";
			s = s + "BillingInformation,";
			s = s + "Birthday,";
			s = s + "Business2TelephoneNumber,";
			s = s + "BusinessAddress,";
			s = s + "BusinessAddressCity,";
			s = s + "BusinessAddressCountry,";
			s = s + "BusinessAddressPostalCode,";
			s = s + "BusinessAddressPostOfficeBox,";
			s = s + "BusinessAddressState,";
			s = s + "BusinessAddressStreet,";
			s = s + "BusinessCardType,";
			s = s + "BusinessFaxNumber,";
			s = s + "BusinessHomePage,";
			s = s + "BusinessTelephoneNumber,";
			s = s + "CallbackTelephoneNumber,";
			s = s + "CarTelephoneNumber,";
			s = s + "Categories,";
			s = s + "Children,";
			s = s + "xClass,";
			s = s + "Companies,";
			s = s + "CompanyName,";
			s = s + "ComputerNetworkName,";
			s = s + "Conflicts,";
			s = s + "ConversationTopic,";
			s = s + "CreationTime,";
			s = s + "CustomerID,";
			s = s + "Department,";
			s = s + "Email1AddressType,";
			s = s + "Email1DisplayName,";
			s = s + "Email1EntryID,";
			s = s + "Email2Address,";
			s = s + "Email2AddressType,";
			s = s + "Email2DisplayName,";
			s = s + "Email2EntryID,";
			s = s + "Email3Address,";
			s = s + "Email3AddressType,";
			s = s + "Email3DisplayName,";
			s = s + "Email3EntryID,";
			s = s + "FileAs,";
			s = s + "FirstName,";
			s = s + "FTPSite,";
			s = s + "Gender,";
			s = s + "GovernmentIDNumber,";
			s = s + "Hobby,";
			s = s + "Home2TelephoneNumber,";
			s = s + "HomeAddress,";
			s = s + "HomeAddressCountry,";
			s = s + "HomeAddressPostalCode,";
			s = s + "HomeAddressPostOfficeBox,";
			s = s + "HomeAddressState,";
			s = s + "HomeAddressStreet,";
			s = s + "HomeFaxNumber,";
			s = s + "HomeTelephoneNumber,";
			s = s + "IMAddress,";
			s = s + "Importance,";
			s = s + "Initials,";
			s = s + "InternetFreeBusyAddress,";
			s = s + "JobTitle,";
			s = s + "Journal,";
			s = s + "Language,";
			s = s + "LastModificationTime,";
			s = s + "LastName,";
			s = s + "LastNameAndFirstName,";
			s = s + "MailingAddress,";
			s = s + "MailingAddressCity,";
			s = s + "MailingAddressCountry,";
			s = s + "MailingAddressPostalCode,";
			s = s + "MailingAddressPostOfficeBox,";
			s = s + "MailingAddressState,";
			s = s + "MailingAddressStreet,";
			s = s + "ManagerName,";
			s = s + "MiddleName,";
			s = s + "Mileage,";
			s = s + "MobileTelephoneNumber,";
			s = s + "NetMeetingAlias,";
			s = s + "NetMeetingServer,";
			s = s + "NickName,";
			s = s + "Title,";
			s = s + "Body,";
			s = s + "OfficeLocation,";
			s = s + "Subject ";
			s = s + " FROM ContactsArchive";
			
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
			s = s + "Email1Address,";
			s = s + "FullName,";
			s = s + "UserID,";
			s = s + "Account,";
			s = s + "Anniversary,";
			s = s + "Application,";
			s = s + "AssistantName,";
			s = s + "AssistantTelephoneNumber,";
			s = s + "BillingInformation,";
			s = s + "Birthday,";
			s = s + "Business2TelephoneNumber,";
			s = s + "BusinessAddress,";
			s = s + "BusinessAddressCity,";
			s = s + "BusinessAddressCountry,";
			s = s + "BusinessAddressPostalCode,";
			s = s + "BusinessAddressPostOfficeBox,";
			s = s + "BusinessAddressState,";
			s = s + "BusinessAddressStreet,";
			s = s + "BusinessCardType,";
			s = s + "BusinessFaxNumber,";
			s = s + "BusinessHomePage,";
			s = s + "BusinessTelephoneNumber,";
			s = s + "CallbackTelephoneNumber,";
			s = s + "CarTelephoneNumber,";
			s = s + "Categories,";
			s = s + "Children,";
			s = s + "xClass,";
			s = s + "Companies,";
			s = s + "CompanyName,";
			s = s + "ComputerNetworkName,";
			s = s + "Conflicts,";
			s = s + "ConversationTopic,";
			s = s + "CreationTime,";
			s = s + "CustomerID,";
			s = s + "Department,";
			s = s + "Email1AddressType,";
			s = s + "Email1DisplayName,";
			s = s + "Email1EntryID,";
			s = s + "Email2Address,";
			s = s + "Email2AddressType,";
			s = s + "Email2DisplayName,";
			s = s + "Email2EntryID,";
			s = s + "Email3Address,";
			s = s + "Email3AddressType,";
			s = s + "Email3DisplayName,";
			s = s + "Email3EntryID,";
			s = s + "FileAs,";
			s = s + "FirstName,";
			s = s + "FTPSite,";
			s = s + "Gender,";
			s = s + "GovernmentIDNumber,";
			s = s + "Hobby,";
			s = s + "Home2TelephoneNumber,";
			s = s + "HomeAddress,";
			s = s + "HomeAddressCountry,";
			s = s + "HomeAddressPostalCode,";
			s = s + "HomeAddressPostOfficeBox,";
			s = s + "HomeAddressState,";
			s = s + "HomeAddressStreet,";
			s = s + "HomeFaxNumber,";
			s = s + "HomeTelephoneNumber,";
			s = s + "IMAddress,";
			s = s + "Importance,";
			s = s + "Initials,";
			s = s + "InternetFreeBusyAddress,";
			s = s + "JobTitle,";
			s = s + "Journal,";
			s = s + "Language,";
			s = s + "LastModificationTime,";
			s = s + "LastName,";
			s = s + "LastNameAndFirstName,";
			s = s + "MailingAddress,";
			s = s + "MailingAddressCity,";
			s = s + "MailingAddressCountry,";
			s = s + "MailingAddressPostalCode,";
			s = s + "MailingAddressPostOfficeBox,";
			s = s + "MailingAddressState,";
			s = s + "MailingAddressStreet,";
			s = s + "ManagerName,";
			s = s + "MiddleName,";
			s = s + "Mileage,";
			s = s + "MobileTelephoneNumber,";
			s = s + "NetMeetingAlias,";
			s = s + "NetMeetingServer,";
			s = s + "NickName,";
			s = s + "Title,";
			s = s + "Body,";
			s = s + "OfficeLocation,";
			s = s + "Subject ";
			s = s + " FROM ContactsArchive";
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
			
			s = " Delete from ContactsArchive";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from ContactsArchive";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
	}
	
}
