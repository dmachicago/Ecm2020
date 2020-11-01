using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsSOURCEATTRIBUTE
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string AttributeValue = "";
        private string AttributeName = "";
        private string SourceGuid = "";
        private string DataSourceOwnerUserID = "";
        private string SourceTypeCode = "";


        // ** Generate the SET methods 
        public void setAttributevalue(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            AttributeValue = val;
        }

        public void setAttributename(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Attributename' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            AttributeName = val;
        }

        public void setSourceguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Sourceguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SourceGuid = val;
        }

        public void setDatasourceowneruserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Datasourceowneruserid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            DataSourceOwnerUserID = val;
        }

        public void setSourcetypecode(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SourceTypeCode = val;
        }



        // ** Generate the GET methods 
        public string getAttributevalue()
        {
            return UTIL.RemoveSingleQuotes(AttributeValue);
        }

        public string getAttributename()
        {
            if (Strings.Len(AttributeName) == 0)
            {
                MessageBox.Show("GET: Field 'Attributename' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(AttributeName);
        }

        public string getSourceguid()
        {
            if (Strings.Len(SourceGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Sourceguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SourceGuid);
        }

        public string getDatasourceowneruserid()
        {
            if (Strings.Len(DataSourceOwnerUserID) == 0)
            {
                MessageBox.Show("GET: Field 'Datasourceowneruserid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID);
        }

        public string getSourcetypecode()
        {
            return UTIL.RemoveSingleQuotes(SourceTypeCode);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (AttributeName.Length == 0)
                return false;
            if (SourceGuid.Length == 0)
                return false;
            if (DataSourceOwnerUserID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (AttributeName.Length == 0)
                return false;
            if (SourceGuid.Length == 0)
                return false;
            if (DataSourceOwnerUserID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO SourceAttribute(";
            s = s + "AttributeValue,";
            s = s + "AttributeName,";
            s = s + "SourceGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "SourceTypeCode) values (";
            s = s + "'" + AttributeValue + "'" + ",";
            s = s + "'" + AttributeName + "'" + ",";
            s = s + "'" + SourceGuid + "'" + ",";
            s = s + "'" + DataSourceOwnerUserID + "'" + ",";
            s = s + "'" + SourceTypeCode + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update SourceAttribute set ";
            s = s + "AttributeValue = '" + getAttributevalue() + "'" + ", ";
            s = s + "AttributeName = '" + getAttributename() + "'" + ", ";
            s = s + "SourceGuid = '" + getSourceguid() + "'" + ", ";
            s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", ";
            s = s + "SourceTypeCode = '" + getSourcetypecode() + "'";
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
            s = s + "AttributeValue,";
            s = s + "AttributeName,";
            s = s + "SourceGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "SourceTypeCode ";
            s = s + " FROM SourceAttribute";
            // ** s=s+ "ORDERBY xxxx"
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
            s = s + "AttributeValue,";
            s = s + "AttributeName,";
            s = s + "SourceGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "SourceTypeCode ";
            s = s + " FROM SourceAttribute";
            s = s + WhereClause;
            // ** s=s+ "ORDERBY xxxx"
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
            s = " Delete from SourceAttribute";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from SourceAttribute";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2(string AttributeName, string SourceGuid)
        {
            int B = 0;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2

        public int cnt_PI001_SourceAttribute(string SourceGuid)
        {
            int B = 0;
            string TBL = "SourceAttribute";
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI001_SourceAttribute

        public int cnt_PI02_SourceAttributes(string AttributeName, string AttributeValue)
        {
            int B = 0;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI02_SourceAttributes

        public int cnt_PK35(string AttributeName, string DataSourceOwnerUserID, string SourceGuid)
        {
            int B = 0;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK35

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2(string AttributeName, string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2

        public SqlDataReader getRow_PI001_SourceAttribute(string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "SourceAttribute";
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI001_SourceAttribute

        public SqlDataReader getRow_PI02_SourceAttributes(string AttributeName, string AttributeValue)
        {
            SqlDataReader rsData = null;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI02_SourceAttributes

        public SqlDataReader getRow_PK35(string AttributeName, string DataSourceOwnerUserID, string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "SourceAttribute";
            string WC = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK35

        /// Build Index Where Caluses
        public string wc__dta_index_SourceAttribute_c_11_786101841__K3_K2(string AttributeName, string SourceGuid)
        {
            string WC = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc__dta_index_SourceAttribute_c_11_786101841__K3_K2

        public string wc_PI001_SourceAttribute(string SourceGuid)
        {
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_PI001_SourceAttribute

        public string wc_PI02_SourceAttributes(string AttributeName, string AttributeValue)
        {
            string WC = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'";
            return WC;
        }     // ** wc_PI02_SourceAttributes

        public string wc_PK35(string AttributeName, string DataSourceOwnerUserID, string SourceGuid)
        {
            string WC = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_PK35

        public bool Add()
        {
            bool bSuccess = false;
            int iCnt = 0;
            iCnt = cnt_PK35(AttributeName, DataSourceOwnerUserID, SourceGuid);
            if (iCnt == 0)
            {
                bSuccess = Insert();
            }
            else
            {
                string WC = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
                bSuccess = Update(WC);
            }

            if (bSuccess == true)
            {
                if (AttributeName.ToUpper().Equals("PRIVATE"))
                {
                    string S = "Update Datasource set isPublic = '" + AttributeValue + "' where SourceGuid = '" + SourceGuid + "'";
                    bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!BB)
                    {
                        LOG.WriteToArchiveLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.");
                        DBARCH.xTrace(9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE");
                    }
                }

                if (AttributeName.ToUpper().Equals("MASTERDOC"))
                {
                    string S = "Update Datasource set isMaster = '" + AttributeValue + "' where SourceGuid = '" + SourceGuid + "'";
                    bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!BB)
                    {
                        LOG.WriteToArchiveLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.");
                        DBARCH.xTrace(9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE");
                    }
                }
            }

            return bSuccess;
        }
    }
}