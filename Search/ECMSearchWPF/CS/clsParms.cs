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


namespace ECMSearchWPF
{
	public class clsParms
	{
		public string BuildParmString(Dictionary<string, string> ParmDict)
		{
			
			
			string sParms = "";
			string sVal = "";
			
			foreach (string S in ParmDict.Keys)
			{
				sVal = (string) (ParmDict.Item(S));
				sParms = sParms + S + Strings.ChrW(253) + sVal + Strings.ChrW(254);
			}
			sParms.Replace("\'", "`");
			return sParms;
			
		}
		
		public void ReBuildParmDist(string ParmString, Dictionary<string, string> ParmDict)
		{
			
			ParmDict.Clear();
			string[] Parms;
			Parms = ParmString.Split(Strings.ChrW(254).ToString().ToCharArray());
			
			string[] ParmPair;
			
			
			string sKey = "";
			string sVal = "";
			
			foreach (string S in Parms)
			{
				ParmPair = S.Split(Strings.ChrW(253).ToString().ToCharArray());
				sKey = ParmPair[0];
				if (ParmPair.Count > 1)
				{
					sVal = ParmPair[1];
					if (! ParmDict.ContainsKey(sKey))
					{
						ParmDict.Add(sKey, sVal);
					}
				}
			}
			
		}
	}
	
}
