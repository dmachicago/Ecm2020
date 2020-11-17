using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace ToolBeltMgt
{
    internal static class DB
    {
        public static string curentlySelectedJob = "";

        public static string svrname = "";
        public static string dbname = "";
        public static string uid = "";
        public static string pw = "";
        public static string connStr = "";
        public static int svrConnected = 0;
        public static SqlConnection dbconn = new SqlConnection ();

        public static bool IsDigitsOnly (string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }

        public static void closeDatabase()
        {
            if (dbconn.State == ConnectionState.Open) {
                dbconn.Close ();
                dbconn.Dispose ();
            }
        }

        public static DataTable getServerDatabases (string ConnStr ) {

            DataTable dt = new DataTable ();
            SqlConnection conn = new SqlConnection ();
            try
            {
                conn.ConnectionString = ConnStr;
                conn.Open ();
                                
                string sqlQuery = @"Select Name From sys.databases order by Name";
                
                SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, conn);
                adapter.Fill (dt);
            }
            catch (Exception ex)
            {
                MessageBox.Show ("Login Failed, aborting... " + ex.Message);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close ();
                    conn.Dispose ();
                }
            }
            int cnt = dt.Rows.Count;
            return dt;
        }

        public static int updateActiveServers (string GroupName, string SvrName, string DBName, string UserID, string pwd, string isAzure, bool enable)
        {
            int rc = 0;
            string AzureCompliant = "0";
            string isEnabled = "0";
            if (enable.Equals (true))
                isEnabled = "1";
            else
                isEnabled = "0";

            if (isAzure.Equals ("true"))
                AzureCompliant = "1";
            else
                AzureCompliant = "0";

            string mysql = "UPDATE ActiveServers SET UserID = '" + UserID + "', pwd = '" + pwd + "', isAzure = '" + AzureCompliant + "', enable = " + isEnabled + " WHERE GroupName = '" + GroupName + "' and SvrName = '" + SvrName + "' and DBName = '" + DBName + "'";
            mysql += "IF @@ROWCOUNT = 0 ";
            mysql += "    INSERT INTO ActiveServers (GroupName, SvrName, DBName, UserID, pwd, isAzure, enable) VALUES ";
            mysql += "('" + GroupName + "','" + SvrName + "','" + DBName + "','" + UserID + "','" + pwd + "','" + AzureCompliant + "'," + isEnabled + ") ";

            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }
        public static int deleteActiveServerDatabase (string SvrName, string DBName)
        {
            int rc = 0;
            
            string mysql = "Delete from ActiveServers where SvrName = '"+ SvrName + "' and DBName = '"+ DBName + "' ; ";

            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }
        public static int deleteServer (string SvrName)
        {
            int rc = 0;
            string sqlQuery = @"delete from ActiveJobSchedule where SvrName = '" + SvrName + "'";
            try
            {
                using (var command = new SqlCommand (sqlQuery, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"001 - Failed to DELETE. Error message: {e.Message}");
            }
            sqlQuery = @"delete from ActiveServers where SvrName = '" + SvrName + "'";
            try
            {
                using (var command = new SqlCommand (sqlQuery, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"002 - Failed to DELETE. Error message: {e.Message}");
            }
           
            return rc;
        }

        public static DataTable getServerDB (string svrname)
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select DBName From ActiveServers where SvrName = '" + svrname + "' order by DBName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getActiveServers ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select GroupName, SvrName,DBName,UserID,pwd,[enable],isAzure From ActiveServers order by GroupName, SvrName,DBName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static int applyJobs (string JobName, string ScheduleUnit, string ScheduleVal, bool isOncePerServer, bool ckEnable, decimal ExecutionOrder)
        {
            int rc = 0;
            string mysql = "";
            string disabled = "";
            string OncePerServer = "";
            string enable = "";
            
            if (isOncePerServer.Equals (true))
            {
                OncePerServer = "Y";
            }
            else
            {
                OncePerServer = "N";
            }

            if (ckEnable.Equals (false))
            {
                disabled = "N";
                enable = "Y";
            }
            else
            {
                disabled = "Y";
                enable = "N";
            }

            mysql = "UPDATE ActiveJob SET OncePerServer = '"+ OncePerServer + "',  ScheduleUnit = '" + ScheduleUnit + "', ScheduleVal = " + ScheduleVal + ", disabled = '" + disabled + "', enable = '" + enable + "', ExecutionOrder = " +ExecutionOrder.ToString()+" WHERE JobName = '" + JobName + "' ";
            mysql += "IF @@ROWCOUNT = 0 ";
            mysql += "INSERT INTO ActiveJob (JobName, ScheduleUnit, ScheduleVal, disabled, OncePerServer, enable, ExecutionOrder) VALUES ('" + JobName + "','" + ScheduleUnit + "'," + ScheduleVal + ",'" + disabled + "','" + OncePerServer +"','" + enable + "', "+ExecutionOrder.ToString()+") ";

            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }

        public static int updateActiveJobSchedule (string SvrName, string JobName)
        {
            int rc = 0;
            string mysql = "UPDATE ActiveJobSchedule SET NextRunDate = getdate() where SvrName = '" + SvrName + "' and JobName = '" + JobName + "'";
            mysql += "IF @@ROWCOUNT = 0 ";
            mysql += "INSERT INTO ActiveJobSchedule (SvrName, JobName, LastRunDate, NextRunDate, Disabled) VALUES ('" + SvrName + "','" + JobName + "',getdate(), getdate(),'N');";

            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }
        public static int deleteActiveJobSchedule (string SvrName, string JobName)
        {
            int rc = 0;
            string mysql = "delete from ActiveJobSchedule where SvrName = '" + SvrName + "' and JobName = '" + JobName + "'";
            
            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }
        public static DataTable getJobNames ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select distinct JobName From ActiveJob order by JobName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }
        public static DataTable getJobs ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select JobName, ScheduleUnit, ScheduleVal, LastRunDate,NextRunDate, OncePerServer, [enable], ExecutionOrder From ActiveJob order by ExecutionOrder, JobName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getJobByName (string JobName)
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select JobName, ScheduleUnit, ScheduleVal, LastRunDate,NextRunDate,OncePerServer,[enable] From ActiveJob where JobName = '" + JobName+"' ";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static int deleteJob (string JobName)
        {
            int rc = 0;
            string sqlQuery = @"delete from ActiveJobSchedule where JobName = '" + JobName + "'";
            try
            {
                using (var command = new SqlCommand (sqlQuery, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"001 - Failed to DELETE. Error message: {e.Message}");
            }
            sqlQuery = @"delete from ActiveJobStep where JobName = '" + JobName + "'";
            try
            {
                using (var command = new SqlCommand (sqlQuery, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"002 - Failed to DELETE. Error message: {e.Message}");
            }
            sqlQuery = @"delete from ActiveJob where JobName = '" + JobName + "'";
            try
            {
                using (var command = new SqlCommand (sqlQuery, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"001 - Failed to DELETE. Error message: {e.Message}");
            }
            return rc;
        }

        public static string getJobStepJobUid (string JobName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select UID From ActiveJob where JObName = '" + JobName + "'";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static string getStepSQL (string JobName, string StepName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select StepSQL From ActiveJobStep where JObName = '" + JobName + "' and StepName = '"+ StepName + "' ; ";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }
        public static string getStepRunIDReq (string JobName, string StepName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select RunIdReq From ActiveJobStep where JObName = '" + JobName + "' and StepName = '" + StepName + "' ; ";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }
        public static string getStepIsAzure (string JobName, string StepName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select AzureOK From ActiveJobStep where JObName = '" + JobName + "' and StepName = '" + StepName + "' ; ";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static string getStepDisabled (string JobName, string StepName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select disabled From ActiveJobStep where JObName = '" + JobName + "' and StepName = '" + StepName + "' ; ";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static int applyJobStep (string JobName,  string StepName, string StepSQL, string disabled, string AzureOK, string RunIdReq, string ExecutionOrder)
        {
            int rc = 0;
            
            string JobUid = getJobStepJobUid (JobName);

            StepSQL = StepSQL.Replace ("'", @"''");

            string mysql = "UPDATE ActiveJobStep SET " + Environment.NewLine;
            mysql += "StepSQL = '" + StepSQL + "'," + Environment.NewLine;
            mysql += "   [disabled] = '" + disabled + "'," + Environment.NewLine;
            mysql += "   AzureOK = '" + AzureOK + "', " + Environment.NewLine;
            mysql += "   RunIdReq = '" + RunIdReq + "', " + Environment.NewLine;
            mysql += "   ExecutionOrder = " + ExecutionOrder + Environment.NewLine;
            mysql += "WHERE JobName = '" + JobName + "' and StepName = '"+ StepName + "' ";
            mysql += Environment.NewLine;
            mysql += "IF @@ROWCOUNT = 0 ";
            mysql += Environment.NewLine;
            mysql += "    INSERT INTO ActiveJobStep "+Environment.NewLine;
            mysql += "    (JOBUID, JobName, StepName, StepSQL, [disabled], AzureOK, RunIdReq,ExecutionOrder) " + Environment.NewLine;
            mysql += "     VALUES (" + Environment.NewLine;
            mysql += "'"+ JobUid + "'," + Environment.NewLine;
            mysql += "'" + JobName + "'," + Environment.NewLine;
            mysql += "'" + StepName + "'," + Environment.NewLine;
            mysql += "'" + StepSQL + "'," + Environment.NewLine;
            mysql += "'" + disabled + "'," + Environment.NewLine;
            mysql += "'" + AzureOK + "'," + Environment.NewLine;
            mysql += "'" + RunIdReq + "'," + Environment.NewLine;
            mysql += "'" + ExecutionOrder + "'" + Environment.NewLine;
            mysql += ")" + Environment.NewLine;

            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }

        public static int deleteJobStep (string JobName, string StepName)
        {
            int rc = 0;
            string mysql = "delete from ActiveJobStep WHERE JobName = '" + JobName + "' and StepName = '" + StepName + "'";
            
            try
            {
                using (var command = new SqlCommand (mysql, dbconn))
                {
                    command.ExecuteNonQuery ();
                }
                rc = 1;
            }
            catch (Exception e)
            {
                rc = -1;
                MessageBox.Show ($"Failed to update. Error message: {e.Message}");
            }

            return rc;
        }

        public static DataTable getJobSteps (string JobName)
        {
            DataTable dt = new DataTable ();
            //string sqlQuery = @"Select distinct StepName, ExecutionOrder From ActiveJobStep where JobName = '" + JobName + "';";
            string sqlQuery = @"SELECT distinct [StepName],[ExecutionOrder],[StepSQL],[disabled],[RunIdReq],[AzureOK] FROM [dbo].[ActiveJobStep] where JobName = '"+JobName+"' order by ExecutionOrder";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getServerJobs (string SvrName)
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select SvrName, JobName from ActiveJobSchedule where SvrName = '"+ SvrName + "' order by SvrName, JobName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getJobsAndTheirServer (string JobName)
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select SvrName, JobName from ActiveJobSchedule where JobName = '" + JobName + "' order by SvrName, JobName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }


        public static DataTable getJobServers ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select distinct JobName From ActiveJob order by JobName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static bool getGrpSvrDB_enabled (string GroupName, string SvrName, string DBName)
        {
            bool val = false;
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select enabled From ActiveServers where GroupName = '" + GroupName + "'";
            sqlQuery += @" and SvrName = '" + SvrName + "'";
            sqlQuery += @" and DBName = '" + DBName + "'";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);

            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = ((bool)dr[col]);
            }

            return val;
        }

        public static string getGrpSvrDB_pwd (string GroupName, string SvrName, string DBName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select pwd From ActiveServers where GroupName = '" + GroupName + "'";
            sqlQuery += @" and SvrName = '" + SvrName + "'";
            sqlQuery += @" and DBName = '" + DBName + "'";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);

            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static string getGrpSvrDB_uid (string GroupName, string SvrName, string DBName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select UserID From ActiveServers where GroupName = '" + GroupName + "'";
            sqlQuery += @" and SvrName = '" + SvrName + "'";
            sqlQuery += @" and DBName = '" + DBName + "'";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);

            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static string getGrpSvrDB_isAzure (string GroupName, string SvrName, string DBName)
        {
            string val = "";
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select UserID From ActiveServers where GroupName = '" + GroupName + "'";
            sqlQuery += @" and SvrName = '" + SvrName + "'";
            sqlQuery += @" and DBName = '" + DBName + "'";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    val = (dr[col].ToString ());
            }

            return val;
        }

        public static DataTable getGroupServers (string GroupName)
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select distinct SvrName From ActiveServers where GroupName = '" + GroupName + "' order by SvrName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getServers ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select distinct SvrName From ActiveServers order by SvrName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static DataTable getGroups ()
        {
            DataTable dt = new DataTable ();
            string sqlQuery = @"Select distinct GroupName From ActiveServers order by GroupName";
            SqlDataAdapter adapter = new SqlDataAdapter (sqlQuery, dbconn);
            adapter.Fill (dt);
            return dt;
        }

        public static int testDbConnection (string cs)
        {
            int rc = 0;
            SqlConnection conn = new SqlConnection ();
            try
            {
                conn.ConnectionString = cs;
                conn.Open ();
                rc = 1;
            }
            catch (Exception ex)
            {
                MessageBox.Show ("Login Failed, aborting... " + ex.Message);
                rc = -1;
            }
            finally {
                if (conn.State == ConnectionState.Open) {
                    conn.Close ();
                    conn.Dispose ();
                }
            }
            return rc;
        }

        public static string buildConnStr (string SvrName, string DBName, string UID, string pwd)
        {
            string connStr = null;
            if (uid.Length > 0)
            {
                connStr = "Data Source=" + SvrName + "; Initial Catalog = "+ DBName + "; User ID = " + UID + "; Password = " + pwd + "; Connection Timeout=30 ;";
                
            }
            else
            {
                connStr = "Data Source=" + svrname + ";Initial Catalog="+ DBName + ";Integrated Security = true; Connection Timeout=30 ;";
            }

            return connStr;
        }


        public static int setConnection ()
        {
            int rc = 0;
            string connStr = null;
            if (uid.Length > 0)
            {
                connStr = "Data Source=" + svrname + "; Initial Catalog = DFINAnalytics; User ID = " + uid + "; Password = " + pw + ";";
            }
            else
            {
                connStr = "Data Source=" + svrname + ";Initial Catalog=DFINAnalytics;Integrated Security = true;";
            }

            try
            {
                dbconn.ConnectionString = connStr;
                dbconn.Open ();
                rc = 1;
            }
            catch (Exception ex)
            {
                MessageBox.Show ("Login Failed, aborting... " + ex.Message);
                rc = -1;
            }

            return rc;
        }

        public static int closeConnection ()
        {
            int rc = 0;
            try
            {
                dbconn.Close ();
                dbconn.Dispose ();
                rc = 1;
            }
            catch
            {
                rc = -1;
            }

            return rc;
        }
    }
}