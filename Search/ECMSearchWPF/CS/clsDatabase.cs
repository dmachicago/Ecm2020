// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;
using System.IO.Compression;


namespace ECMSearchWPF
{
	public class clsDatabase
	{
		
		clsEncrypt ENC = new clsEncrypt();
		
		public string getGatewayCs()
		{
			GLOBALS.gCSGateWay = ENC.getCSGateway();
			return GLOBALS.gCSGateWay;
		}
		
		
		public string getRepoCs(int RowID)
		{
			if (GLOBALS.gCSRepo.Length> 0)
			{
				return GLOBALS.gCSRepo;
			}
			GLOBALS.gCSRepo = setRepoCS(RowID);
			return GLOBALS.gCSRepo;
		}
		
		private string setRepoCS(int RowID)
		{
			
			string CS = getGatewayCs();
			string S = "";
			string RepoCS = "";
			
			S += (string) (" Select CSRepo from [SecureAttach] Where RowID = " + RowID.ToString());
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					RepoCS = (string) (RSData.GetValue(0).ToString());
					RepoCS = ENC.AES256DecryptString(RepoCS);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR 00A1: " + ex.Message);
				RepoCS = "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return RepoCS;
			
		}
		
		
		public void getEndpoint(string RowID)
		{
			
			
			string CS = getGatewayCs();
			string S = "";
			
			S += " Select " + "\r\n";
			S += " SVCGateway_Endpoint" + "\r\n";
			S += " ,SVCSearch_Endpoint" + "\r\n";
			S += " ,SVCDownload_Endpoint" + "\r\n";
			S += " FROM SecureAttach";
			S += (string) (" Where RowID = " + RowID);
			
			bool ddebug = false;
			if (ddebug.Equals(true))
			{
				Debug.Print((string) ("01x SQL: " + "\r\n" + S));
			}
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					GLOBALS.gSVCGateway_Endpoint = RSData.GetString(0);
					GLOBALS.gSVCSearch_Endpoint = RSData.GetString(1);
					GLOBALS.gSVCDownload_Endpoint = RSData.GetString(2);
					
					
					Debug.Print((string) ("gSVCGateway_Endpoint: " + GLOBALS.gSVCGateway_Endpoint));
					Debug.Print((string) ("gSVCSearch_Endpoint: " + GLOBALS.gSVCSearch_Endpoint));
					Debug.Print((string) ("gSVCDownload_Endpoint: " + GLOBALS.gSVCDownload_Endpoint));
					
					
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR 00A1: " + ex.Message);
				CS = "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public bool setEndpoints()
		{
			
			bool B = true;
			try
			{
				
				if (GLOBALS.ProxyGateway == null)
				{
					GLOBALS.ProxyGateway = new SVCGateway.Service1Client();
				}
				GLOBALS.ProxyGateway.Endpoint.Address = new System.ServiceModel.EndpointAddress(GLOBALS.gSVCGateway_Endpoint);
				
				if (GLOBALS.gSVCSearch_Endpoint.Length > 0)
				{
					GLOBALS.ProxySearch = new SVCSearch.Service1Client();
				}
				GLOBALS.ProxySearch.Endpoint.Address = new System.ServiceModel.EndpointAddress(GLOBALS.gSVCSearch_Endpoint);
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR 223: Failed to set endpoints - " + ex.Message));
				B = false;
			}
			
			return B;
			
		}
		
	}
	
	
}
