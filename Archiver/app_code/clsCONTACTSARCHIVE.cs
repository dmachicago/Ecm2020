using global::System.Data.SqlClient;
using System.Diagnostics;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsCONTACTSARCHIVE
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string Email1Address = "";
        private string FullName = "";
        private string UserID = "";
        private string Account = "";
        private string Anniversary = "";
        private string Application = "";
        private string AssistantName = "";
        private string AssistantTelephoneNumber = "";
        private string BillingInformation = "";
        private string Birthday = "";
        private string Business2TelephoneNumber = "";
        private string BusinessAddress = "";
        private string BusinessAddressCity = "";
        private string BusinessAddressCountry = "";
        private string BusinessAddressPostalCode = "";
        private string BusinessAddressPostOfficeBox = "";
        private string BusinessAddressState = "";
        private string BusinessAddressStreet = "";
        private string BusinessCardType = "";
        private string BusinessFaxNumber = "";
        private string BusinessHomePage = "";
        private string BusinessTelephoneNumber = "";
        private string CallbackTelephoneNumber = "";
        private string CarTelephoneNumber = "";
        private string Categories = "";
        private string Children = "";
        private string xClass = "";
        private string Companies = "";
        private string CompanyName = "";
        private string ComputerNetworkName = "";
        private string Conflicts = "";
        private string ConversationTopic = "";
        private string CreationTime = "";
        private string CustomerID = "";
        private string Department = "";
        private string Email1AddressType = "";
        private string Email1DisplayName = "";
        private string Email1EntryID = "";
        private string Email2Address = "";
        private string Email2AddressType = "";
        private string Email2DisplayName = "";
        private string Email2EntryID = "";
        private string Email3Address = "";
        private string Email3AddressType = "";
        private string Email3DisplayName = "";
        private string Email3EntryID = "";
        private string FileAs = "";
        private string FirstName = "";
        private string FTPSite = "";
        private string Gender = "";
        private string GovernmentIDNumber = "";
        private string Hobby = "";
        private string Home2TelephoneNumber = "";
        private string HomeAddress = "";
        private string HomeAddressCountry = "";
        private string HomeAddressPostalCode = "";
        private string HomeAddressPostOfficeBox = "";
        private string HomeAddressState = "";
        private string HomeAddressStreet = "";
        private string HomeFaxNumber = "";
        private string HomeTelephoneNumber = "";
        private string IMAddress = "";
        private string Importance = "";
        private string Initials = "";
        private string InternetFreeBusyAddress = "";
        private string JobTitle = "";
        private string Journal = "";
        private string Language = "";
        private string LastModificationTime = "";
        private string LastName = "";
        private string LastNameAndFirstName = "";
        private string MailingAddress = "";
        private string MailingAddressCity = "";
        private string MailingAddressCountry = "";
        private string MailingAddressPostalCode = "";
        private string MailingAddressPostOfficeBox = "";
        private string MailingAddressState = "";
        private string MailingAddressStreet = "";
        private string ManagerName = "";
        private string MiddleName = "";
        private string Mileage = "";
        private string MobileTelephoneNumber = "";
        private string NetMeetingAlias = "";
        private string NetMeetingServer = "";
        private string NickName = "";
        private string Title = "";
        private string Body = "";
        private string OfficeLocation = "";
        private string Subject = "";


        // ** Generate the SET methods 
        public void setEmail1address(string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Email1address' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Email1Address = val;
        }

        public void setFullname(string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Fullname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FullName = val;
        }

        public void setUserid(string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = modGlobals.gCurrLoginID;
                // messagebox.show("SET: Field 'Userid' cannot be NULL.")
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



        // ** Generate the GET methods 
        public string getEmail1address()
        {
            if (Strings.Len(Email1Address) == 0)
            {
                MessageBox.Show("GET: Field 'Email1address' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Email1Address);
        }

        public string getFullname()
        {
            if (Strings.Len(FullName) == 0)
            {
                MessageBox.Show("GET: Field 'Fullname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FullName);
        }

        public string getUserid()
        {
            if (Strings.Len(UserID) == 0)
            {
                MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
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



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (Email1Address.Length == 0)
                return false;
            if (FullName.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (Email1Address.Length == 0)
                return false;
            if (FullName.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ContactsArchive(" + Constants.vbCrLf;
            s = s + "Email1Address," + Constants.vbCrLf;
            s = s + "FullName," + Constants.vbCrLf;
            s = s + "UserID," + Constants.vbCrLf;
            s = s + "Account," + Constants.vbCrLf;
            s = s + "Anniversary," + Constants.vbCrLf;
            s = s + "Application," + Constants.vbCrLf;
            s = s + "AssistantName," + Constants.vbCrLf;
            s = s + "AssistantTelephoneNumber," + Constants.vbCrLf;
            s = s + "BillingInformation," + Constants.vbCrLf;
            s = s + "Birthday," + Constants.vbCrLf;
            s = s + "Business2TelephoneNumber," + Constants.vbCrLf;
            s = s + "BusinessAddress," + Constants.vbCrLf;
            s = s + "BusinessAddressCity," + Constants.vbCrLf;
            s = s + "BusinessAddressCountry," + Constants.vbCrLf;
            s = s + "BusinessAddressPostalCode," + Constants.vbCrLf;
            s = s + "BusinessAddressPostOfficeBox," + Constants.vbCrLf;
            s = s + "BusinessAddressState," + Constants.vbCrLf;
            s = s + "BusinessAddressStreet," + Constants.vbCrLf;
            s = s + "BusinessCardType," + Constants.vbCrLf;
            s = s + "BusinessFaxNumber," + Constants.vbCrLf;
            s = s + "BusinessHomePage," + Constants.vbCrLf;
            s = s + "BusinessTelephoneNumber," + Constants.vbCrLf;
            s = s + "CallbackTelephoneNumber," + Constants.vbCrLf;
            s = s + "CarTelephoneNumber," + Constants.vbCrLf;
            s = s + "Categories," + Constants.vbCrLf;
            s = s + "Children," + Constants.vbCrLf;
            s = s + "xClass," + Constants.vbCrLf;
            s = s + "Companies," + Constants.vbCrLf;
            s = s + "CompanyName," + Constants.vbCrLf;
            s = s + "ComputerNetworkName," + Constants.vbCrLf;
            s = s + "Conflicts," + Constants.vbCrLf;
            s = s + "ConversationTopic," + Constants.vbCrLf;
            s = s + "CreationTime," + Constants.vbCrLf;
            s = s + "CustomerID," + Constants.vbCrLf;
            s = s + "Department," + Constants.vbCrLf;
            s = s + "Email1AddressType," + Constants.vbCrLf;
            s = s + "Email1DisplayName," + Constants.vbCrLf;
            s = s + "Email1EntryID," + Constants.vbCrLf;
            s = s + "Email2Address," + Constants.vbCrLf;
            s = s + "Email2AddressType," + Constants.vbCrLf;
            s = s + "Email2DisplayName," + Constants.vbCrLf;
            s = s + "Email2EntryID," + Constants.vbCrLf;
            s = s + "Email3Address," + Constants.vbCrLf;
            s = s + "Email3AddressType," + Constants.vbCrLf;
            s = s + "Email3DisplayName," + Constants.vbCrLf;
            s = s + "Email3EntryID," + Constants.vbCrLf;
            s = s + "FileAs," + Constants.vbCrLf;
            s = s + "FirstName," + Constants.vbCrLf;
            s = s + "FTPSite," + Constants.vbCrLf;
            s = s + "Gender," + Constants.vbCrLf;
            s = s + "GovernmentIDNumber," + Constants.vbCrLf;
            s = s + "Hobby," + Constants.vbCrLf;
            s = s + "Home2TelephoneNumber," + Constants.vbCrLf;
            s = s + "HomeAddress," + Constants.vbCrLf;
            s = s + "HomeAddressCountry," + Constants.vbCrLf;
            s = s + "HomeAddressPostalCode," + Constants.vbCrLf;
            s = s + "HomeAddressPostOfficeBox," + Constants.vbCrLf;
            s = s + "HomeAddressState," + Constants.vbCrLf;
            s = s + "HomeAddressStreet," + Constants.vbCrLf;
            s = s + "HomeFaxNumber," + Constants.vbCrLf;
            s = s + "HomeTelephoneNumber," + Constants.vbCrLf;
            s = s + "IMAddress," + Constants.vbCrLf;
            s = s + "Importance," + Constants.vbCrLf;
            s = s + "Initials," + Constants.vbCrLf;
            s = s + "InternetFreeBusyAddress," + Constants.vbCrLf;
            s = s + "JobTitle," + Constants.vbCrLf;
            s = s + "Journal," + Constants.vbCrLf;
            s = s + "Language," + Constants.vbCrLf;
            s = s + "LastModificationTime," + Constants.vbCrLf;
            s = s + "LastName," + Constants.vbCrLf;
            s = s + "LastNameAndFirstName," + Constants.vbCrLf;
            s = s + "MailingAddress," + Constants.vbCrLf;
            s = s + "MailingAddressCity," + Constants.vbCrLf;
            s = s + "MailingAddressCountry," + Constants.vbCrLf;
            s = s + "MailingAddressPostalCode," + Constants.vbCrLf;
            s = s + "MailingAddressPostOfficeBox," + Constants.vbCrLf;
            s = s + "MailingAddressState," + Constants.vbCrLf;
            s = s + "MailingAddressStreet," + Constants.vbCrLf;
            s = s + "ManagerName," + Constants.vbCrLf;
            s = s + "MiddleName," + Constants.vbCrLf;
            s = s + "Mileage," + Constants.vbCrLf;
            s = s + "MobileTelephoneNumber," + Constants.vbCrLf;
            s = s + "NetMeetingAlias," + Constants.vbCrLf;
            s = s + "NetMeetingServer," + Constants.vbCrLf;
            s = s + "NickName," + Constants.vbCrLf;
            s = s + "Title," + Constants.vbCrLf;
            s = s + "Body," + Constants.vbCrLf;
            s = s + "OfficeLocation," + Constants.vbCrLf;
            s = s + "Subject) values (";
            s = s + "'" + Email1Address.ToString() + "'" + "," + Constants.vbCrLf;
            s = s + "'" + FullName.ToString() + "'" + "," + Constants.vbCrLf;
            s = s + "'" + UserID.ToString() + "'" + "," + Constants.vbCrLf;
            if (Account == null)
            {
                Account = " ";
            }

            s = s + "'" + Account.ToString() + "'" + "," + Constants.vbCrLf;
            if (Anniversary == null)
            {
                Anniversary = " ";
            }

            s = s + "'" + Anniversary.ToString() + "'" + "," + Constants.vbCrLf;
            if (Application == null)
            {
                Application = " ";
            }

            s = s + "'" + Application.ToString() + "'" + "," + Constants.vbCrLf;
            if (AssistantName == null)
            {
                AssistantName = " ";
            }

            s = s + "'" + AssistantName.ToString() + "'" + "," + Constants.vbCrLf;
            if (AssistantTelephoneNumber == null)
            {
                AssistantTelephoneNumber = " ";
            }

            s = s + "'" + AssistantTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (BillingInformation == null)
            {
                BillingInformation = " ";
            }

            s = s + "'" + BillingInformation.ToString() + "'" + "," + Constants.vbCrLf;
            if (Birthday == null)
            {
                Birthday = " ";
            }

            s = s + "'" + Birthday.ToString() + "'" + "," + Constants.vbCrLf;
            if (Business2TelephoneNumber == null)
            {
                Business2TelephoneNumber = " ";
            }

            s = s + "'" + Business2TelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddress == null)
            {
                BusinessAddress = " ";
            }

            s = s + "'" + BusinessAddress.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressCity == null)
            {
                BusinessAddressCity = " ";
            }

            s = s + "'" + BusinessAddressCity.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressCountry == null)
            {
                BusinessAddressCountry = " ";
            }

            s = s + "'" + BusinessAddressCountry.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressPostalCode == null)
            {
                BusinessAddressPostalCode = " ";
            }

            s = s + "'" + BusinessAddressPostalCode.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressPostOfficeBox == null)
            {
                BusinessAddressPostOfficeBox = " ";
            }

            s = s + "'" + BusinessAddressPostOfficeBox.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressState == null)
            {
                BusinessAddressState = " ";
            }

            s = s + "'" + BusinessAddressState.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessAddressStreet == null)
            {
                BusinessAddressStreet = " ";
            }

            s = s + "'" + BusinessAddressStreet.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessCardType == null)
            {
                BusinessCardType = " ";
            }

            s = s + "'" + BusinessCardType.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessFaxNumber == null)
            {
                BusinessFaxNumber = " ";
            }

            s = s + "'" + BusinessFaxNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessHomePage == null)
            {
                BusinessHomePage = " ";
            }

            s = s + "'" + BusinessHomePage.ToString() + "'" + "," + Constants.vbCrLf;
            if (BusinessTelephoneNumber == null)
            {
                BusinessTelephoneNumber = " ";
            }

            s = s + "'" + BusinessTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (CallbackTelephoneNumber == null)
            {
                CallbackTelephoneNumber = " ";
            }

            s = s + "'" + CallbackTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (CarTelephoneNumber == null)
            {
                CarTelephoneNumber = " ";
            }

            s = s + "'" + CarTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (Categories == null)
            {
                Categories = " ";
            }

            s = s + "'" + Categories.ToString() + "'" + "," + Constants.vbCrLf;
            if (Children == null)
            {
                Children = " ";
            }

            s = s + "'" + Children.ToString() + "'" + "," + Constants.vbCrLf;
            if (xClass == null)
            {
                xClass = " ";
            }

            s = s + "'" + xClass.ToString() + "'" + "," + Constants.vbCrLf;
            if (Companies == null)
            {
                Companies = " ";
            }

            s = s + "'" + Companies.ToString() + "'" + "," + Constants.vbCrLf;
            if (CompanyName == null)
            {
                CompanyName = " ";
            }

            s = s + "'" + CompanyName.ToString() + "'" + "," + Constants.vbCrLf;
            if (ComputerNetworkName == null)
            {
                ComputerNetworkName = " ";
            }

            s = s + "'" + ComputerNetworkName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Conflicts == null)
            {
                Conflicts = " ";
            }

            s = s + "'" + Conflicts.ToString() + "'" + "," + Constants.vbCrLf;
            if (ConversationTopic == null)
            {
                ConversationTopic = " ";
            }

            s = s + "'" + ConversationTopic.ToString() + "'" + "," + Constants.vbCrLf;
            if (CreationTime == null)
            {
                CreationTime = " ";
            }

            s = s + "'" + CreationTime.ToString() + "'" + "," + Constants.vbCrLf;
            // Debug.Print(s.Length.ToString)
            if (CustomerID == null)
            {
                CustomerID = " ";
            }

            s = s + "'" + CustomerID.ToString() + "'" + "," + Constants.vbCrLf;
            if (Department == null)
            {
                Department = " ";
            }

            s = s + "'" + Department.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email1AddressType == null)
            {
                Email1AddressType = " ";
            }

            s = s + "'" + Email1AddressType.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email1DisplayName == null)
            {
                Email1DisplayName = " ";
            }

            s = s + "'" + Email1DisplayName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email1EntryID == null)
            {
                Email1EntryID = " ";
            }

            s = s + "'" + Email1EntryID.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email2Address == null)
            {
                Email2Address = " ";
            }

            s = s + "'" + Email2Address.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email2AddressType == null)
            {
                Email2AddressType = " ";
            }

            s = s + "'" + Email2AddressType.ToString() + "'" + "," + Constants.vbCrLf;
            // Debug.Print(s.Length.ToString)
            if (Email2DisplayName == null)
            {
                Email2DisplayName = " ";
            }

            s = s + "'" + Email2DisplayName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email2EntryID == null)
            {
                Email2EntryID = " ";
            }

            s = s + "'" + Email2EntryID.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email3Address == null)
            {
                Email3Address = " ";
            }

            s = s + "'" + Email3Address.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email3AddressType == null)
            {
                Email3AddressType = " ";
            }

            s = s + "'" + Email3AddressType.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email3DisplayName == null)
            {
                Email3DisplayName = " ";
            }

            s = s + "'" + Email3DisplayName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Email3EntryID == null)
            {
                Email3EntryID = " ";
            }

            s = s + "'" + Email3EntryID.ToString() + "'" + "," + Constants.vbCrLf;
            if (FileAs == null)
            {
                FileAs = " ";
            }

            s = s + "'" + FileAs.ToString() + "'" + "," + Constants.vbCrLf;
            if (FirstName == null)
            {
                FirstName = " ";
            }

            s = s + "'" + FirstName.ToString() + "'" + "," + Constants.vbCrLf;
            if (FTPSite == null)
            {
                FTPSite = " ";
            }

            s = s + "'" + FTPSite.ToString() + "'" + "," + Constants.vbCrLf;
            if (Gender == null)
            {
                Gender = " ";
            }

            s = s + "'" + Gender.ToString() + "'" + "," + Constants.vbCrLf;
            if (GovernmentIDNumber == null)
            {
                GovernmentIDNumber = " ";
            }

            s = s + "'" + GovernmentIDNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (Hobby == null)
            {
                Hobby = " ";
            }

            s = s + "'" + Hobby.ToString() + "'" + "," + Constants.vbCrLf;
            if (Home2TelephoneNumber == null)
            {
                Home2TelephoneNumber = " ";
            }

            s = s + "'" + Home2TelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddress == null)
            {
                HomeAddress = " ";
            }

            s = s + "'" + HomeAddress.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddressCountry == null)
            {
                HomeAddressCountry = " ";
            }

            s = s + "'" + HomeAddressCountry.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddressPostalCode == null)
            {
                HomeAddressPostalCode = " ";
            }

            s = s + "'" + HomeAddressPostalCode.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddressPostOfficeBox == null)
            {
                HomeAddressPostOfficeBox = " ";
            }

            s = s + "'" + HomeAddressPostOfficeBox.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddressState == null)
            {
                HomeAddressState = " ";
            }

            s = s + "'" + HomeAddressState.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeAddressStreet == null)
            {
                HomeAddressStreet = " ";
            }

            s = s + "'" + HomeAddressStreet.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeFaxNumber == null)
            {
                HomeFaxNumber = " ";
            }

            s = s + "'" + HomeFaxNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (HomeTelephoneNumber == null)
            {
                HomeTelephoneNumber = " ";
            }

            s = s + "'" + HomeTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (IMAddress == null)
            {
                IMAddress = " ";
            }

            s = s + "'" + IMAddress.ToString() + "'" + "," + Constants.vbCrLf;
            if (Importance == null)
            {
                Importance = " ";
            }

            s = s + "'" + Importance.ToString() + "'" + "," + Constants.vbCrLf;
            if (Initials == null)
            {
                Initials = " ";
            }

            s = s + "'" + Initials.ToString() + "'" + "," + Constants.vbCrLf;
            if (InternetFreeBusyAddress == null)
            {
                InternetFreeBusyAddress = " ";
            }

            s = s + "'" + InternetFreeBusyAddress.ToString() + "'" + "," + Constants.vbCrLf;
            if (JobTitle == null)
            {
                JobTitle = " ";
            }

            s = s + "'" + JobTitle.ToString() + "'" + "," + Constants.vbCrLf;
            if (Journal == null)
            {
                Journal = " ";
            }

            s = s + "'" + Journal.ToString() + "'" + "," + Constants.vbCrLf;
            if (Language == null)
            {
                Language = " ";
            }

            s = s + "'" + Language.ToString() + "'" + "," + Constants.vbCrLf;
            if (LastModificationTime == null)
            {
                LastModificationTime = " ";
            }

            s = s + "'" + LastModificationTime.ToString() + "'" + "," + Constants.vbCrLf;
            if (LastName == null)
            {
                LastName = " ";
            }

            s = s + "'" + LastName.ToString() + "'" + "," + Constants.vbCrLf;
            if (LastNameAndFirstName == null)
            {
                LastNameAndFirstName = " ";
            }

            s = s + "'" + LastNameAndFirstName.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddress == null)
            {
                MailingAddress = " ";
            }

            s = s + "'" + MailingAddress.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressCity == null)
            {
                MailingAddressCity = " ";
            }

            s = s + "'" + MailingAddressCity.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressCountry == null)
            {
                MailingAddressCountry = " ";
            }

            s = s + "'" + MailingAddressCountry.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressPostalCode == null)
            {
                MailingAddressPostalCode = " ";
            }

            s = s + "'" + MailingAddressPostalCode.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressPostOfficeBox == null)
            {
                MailingAddressPostOfficeBox = " ";
            }

            s = s + "'" + MailingAddressPostOfficeBox.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressState == null)
            {
                MailingAddressState = " ";
            }

            s = s + "'" + MailingAddressState.ToString() + "'" + "," + Constants.vbCrLf;
            if (MailingAddressStreet == null)
            {
                MailingAddressStreet = " ";
            }

            s = s + "'" + MailingAddressStreet.ToString() + "'" + "," + Constants.vbCrLf;
            if (ManagerName == null)
            {
                ManagerName = " ";
            }

            s = s + "'" + ManagerName.ToString() + "'" + "," + Constants.vbCrLf;
            if (MiddleName == null)
            {
                MiddleName = " ";
            }

            s = s + "'" + MiddleName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Mileage == null)
            {
                Mileage = " ";
            }

            s = s + "'" + Mileage.ToString() + "'" + "," + Constants.vbCrLf;
            if (MobileTelephoneNumber == null)
            {
                MobileTelephoneNumber = " ";
            }

            s = s + "'" + MobileTelephoneNumber.ToString() + "'" + "," + Constants.vbCrLf;
            if (NetMeetingAlias == null)
            {
                NetMeetingAlias = " ";
            }

            s = s + "'" + NetMeetingAlias.ToString() + "'" + "," + Constants.vbCrLf;
            if (NetMeetingServer == null)
            {
                NetMeetingServer = " ";
            }

            s = s + "'" + NetMeetingServer.ToString() + "'" + "," + Constants.vbCrLf;
            if (NickName == null)
            {
                NickName = " ";
            }

            s = s + "'" + NickName.ToString() + "'" + "," + Constants.vbCrLf;
            if (Title == null)
            {
                Title = " ";
            }

            s = s + "'" + Title.ToString() + "'" + "," + Constants.vbCrLf;
            if (Body == null)
            {
                Body = " ";
            }

            s = s + "'" + Body.ToString() + "'" + "," + Constants.vbCrLf;
            if (OfficeLocation == null)
            {
                OfficeLocation = " ";
            }

            s = s + "'" + OfficeLocation.ToString() + "'" + "," + Constants.vbCrLf;
            if (Subject == null)
            {
                Subject = " ";
            }

            s = s + "'" + Subject.ToString() + "'";
            s = s + ")";
            Debug.Print(s.Length.ToString());
            Debug.Print(s);
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ContactsArchive set ";
            s = s + "Email1Address = '" + getEmail1address() + "'" + ", ";
            s = s + "FullName = '" + getFullname() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "Account = '" + getAccount() + "'" + ", ";
            s = s + "Anniversary = '" + getAnniversary() + "'" + ", ";
            s = s + "Application = '" + getApplication() + "'" + ", ";
            s = s + "AssistantName = '" + getAssistantname() + "'" + ", ";
            s = s + "AssistantTelephoneNumber = '" + getAssistanttelephonenumber() + "'" + ", ";
            s = s + "BillingInformation = '" + getBillinginformation() + "'" + ", ";
            s = s + "Birthday = '" + getBirthday() + "'" + ", ";
            s = s + "Business2TelephoneNumber = '" + getBusiness2telephonenumber() + "'" + ", ";
            s = s + "BusinessAddress = '" + getBusinessaddress() + "'" + ", ";
            s = s + "BusinessAddressCity = '" + getBusinessaddresscity() + "'" + ", ";
            s = s + "BusinessAddressCountry = '" + getBusinessaddresscountry() + "'" + ", ";
            s = s + "BusinessAddressPostalCode = '" + getBusinessaddresspostalcode() + "'" + ", ";
            s = s + "BusinessAddressPostOfficeBox = '" + getBusinessaddresspostofficebox() + "'" + ", ";
            s = s + "BusinessAddressState = '" + getBusinessaddressstate() + "'" + ", ";
            s = s + "BusinessAddressStreet = '" + getBusinessaddressstreet() + "'" + ", ";
            s = s + "BusinessCardType = '" + getBusinesscardtype() + "'" + ", ";
            s = s + "BusinessFaxNumber = '" + getBusinessfaxnumber() + "'" + ", ";
            s = s + "BusinessHomePage = '" + getBusinesshomepage() + "'" + ", ";
            s = s + "BusinessTelephoneNumber = '" + getBusinesstelephonenumber() + "'" + ", ";
            s = s + "CallbackTelephoneNumber = '" + getCallbacktelephonenumber() + "'" + ", ";
            s = s + "CarTelephoneNumber = '" + getCartelephonenumber() + "'" + ", ";
            s = s + "Categories = '" + getCategories() + "'" + ", ";
            s = s + "Children = '" + getChildren() + "'" + ", ";
            s = s + "xClass = '" + getXclass() + "'" + ", ";
            s = s + "Companies = '" + getCompanies() + "'" + ", ";
            s = s + "CompanyName = '" + getCompanyname() + "'" + ", ";
            s = s + "ComputerNetworkName = '" + getComputernetworkname() + "'" + ", ";
            s = s + "Conflicts = '" + getConflicts() + "'" + ", ";
            s = s + "ConversationTopic = '" + getConversationtopic() + "'" + ", ";
            s = s + "CreationTime = '" + getCreationtime() + "'" + ", ";
            s = s + "CustomerID = '" + getCustomerid() + "'" + ", ";
            s = s + "Department = '" + getDepartment() + "'" + ", ";
            s = s + "Email1AddressType = '" + getEmail1addresstype() + "'" + ", ";
            s = s + "Email1DisplayName = '" + getEmail1displayname() + "'" + ", ";
            s = s + "Email1EntryID = '" + getEmail1entryid() + "'" + ", ";
            s = s + "Email2Address = '" + getEmail2address() + "'" + ", ";
            s = s + "Email2AddressType = '" + getEmail2addresstype() + "'" + ", ";
            s = s + "Email2DisplayName = '" + getEmail2displayname() + "'" + ", ";
            s = s + "Email2EntryID = '" + getEmail2entryid() + "'" + ", ";
            s = s + "Email3Address = '" + getEmail3address() + "'" + ", ";
            s = s + "Email3AddressType = '" + getEmail3addresstype() + "'" + ", ";
            s = s + "Email3DisplayName = '" + getEmail3displayname() + "'" + ", ";
            s = s + "Email3EntryID = '" + getEmail3entryid() + "'" + ", ";
            s = s + "FileAs = '" + getFileas() + "'" + ", ";
            s = s + "FirstName = '" + getFirstname() + "'" + ", ";
            s = s + "FTPSite = '" + getFtpsite() + "'" + ", ";
            s = s + "Gender = '" + getGender() + "'" + ", ";
            s = s + "GovernmentIDNumber = '" + getGovernmentidnumber() + "'" + ", ";
            s = s + "Hobby = '" + getHobby() + "'" + ", ";
            s = s + "Home2TelephoneNumber = '" + getHome2telephonenumber() + "'" + ", ";
            s = s + "HomeAddress = '" + getHomeaddress() + "'" + ", ";
            s = s + "HomeAddressCountry = '" + getHomeaddresscountry() + "'" + ", ";
            s = s + "HomeAddressPostalCode = '" + getHomeaddresspostalcode() + "'" + ", ";
            s = s + "HomeAddressPostOfficeBox = '" + getHomeaddresspostofficebox() + "'" + ", ";
            s = s + "HomeAddressState = '" + getHomeaddressstate() + "'" + ", ";
            s = s + "HomeAddressStreet = '" + getHomeaddressstreet() + "'" + ", ";
            s = s + "HomeFaxNumber = '" + getHomefaxnumber() + "'" + ", ";
            s = s + "HomeTelephoneNumber = '" + getHometelephonenumber() + "'" + ", ";
            s = s + "IMAddress = '" + getImaddress() + "'" + ", ";
            s = s + "Importance = '" + getImportance() + "'" + ", ";
            s = s + "Initials = '" + getInitials() + "'" + ", ";
            s = s + "InternetFreeBusyAddress = '" + getInternetfreebusyaddress() + "'" + ", ";
            s = s + "JobTitle = '" + getJobtitle() + "'" + ", ";
            s = s + "Journal = '" + getJournal() + "'" + ", ";
            s = s + "Language = '" + getLanguage() + "'" + ", ";
            s = s + "LastModificationTime = '" + getLastmodificationtime() + "'" + ", ";
            s = s + "LastName = '" + getLastname() + "'" + ", ";
            s = s + "LastNameAndFirstName = '" + getLastnameandfirstname() + "'" + ", ";
            s = s + "MailingAddress = '" + getMailingaddress() + "'" + ", ";
            s = s + "MailingAddressCity = '" + getMailingaddresscity() + "'" + ", ";
            s = s + "MailingAddressCountry = '" + getMailingaddresscountry() + "'" + ", ";
            s = s + "MailingAddressPostalCode = '" + getMailingaddresspostalcode() + "'" + ", ";
            s = s + "MailingAddressPostOfficeBox = '" + getMailingaddresspostofficebox() + "'" + ", ";
            s = s + "MailingAddressState = '" + getMailingaddressstate() + "'" + ", ";
            s = s + "MailingAddressStreet = '" + getMailingaddressstreet() + "'" + ", ";
            s = s + "ManagerName = '" + getManagername() + "'" + ", ";
            s = s + "MiddleName = '" + getMiddlename() + "'" + ", ";
            s = s + "Mileage = '" + getMileage() + "'" + ", ";
            s = s + "MobileTelephoneNumber = '" + getMobiletelephonenumber() + "'" + ", ";
            s = s + "NetMeetingAlias = '" + getNetmeetingalias() + "'" + ", ";
            s = s + "NetMeetingServer = '" + getNetmeetingserver() + "'" + ", ";
            s = s + "NickName = '" + getNickname() + "'" + ", ";
            s = s + "Title = '" + getTitle() + "'" + ", ";
            s = s + "Body = '" + getBody() + "'" + ", ";
            s = s + "OfficeLocation = '" + getOfficelocation() + "'" + ", ";
            s = s + "Subject = '" + getSubject() + "'";
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
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
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the Select One Row method 
        public SqlDataReader SelectOne(string WhereClause)
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
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
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the DELETE method 
        public bool Delete(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            WhereClause = " " + WhereClause;
            s = " Delete from ContactsArchive";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize(string WhereClause)
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ContactsArchive";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }
    }
}