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
	public class clsEncryptV2
	{
		
		public string EncryptPhrase(string Phrase)
		{
			string S = "";
			int I = 0;
			string CH = "";
			string SIC = "";
			int IC = 0;
			try
			{
				for (I = 0; I <= Phrase.Length - 1; I++)
				{
					IC = 0;
					CH = Phrase.Substring(I, 1);
					IC = Strings.AscW(CH);
					IC = IC + 88;
					SIC = IC.ToString();
					if (SIC.Length < 2)
					{
						SIC = (string) ("00" + SIC);
					}
					if (SIC.Length < 3)
					{
						SIC = (string) ("0" + SIC);
					}
					S += SIC;
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show(System.Convert.ToString(I.ToString() + Strings.ChrW(9) + CH + Strings.ChrW(9) + Phrase + Strings.ChrW(9) + SIC));
				MessageBox.Show((string) ("ERROR 100xx01: " + ex.Message));
			}
			
			return S;
		}
		public string Reverse(string value)
		{
			// Convert to char array.
			char[] arr = value.ToCharArray();
			// Use Array.Reverse function.
			Array.Reverse(arr);
			// Construct new string.
			return new string(arr);
		}
		public string EncryptPhrase(string Phrase, string shiftKey)
		{
			shiftKey = GLOBALS.ContractID;
			string S = "";
			int I = 0;
			int K = 0;
			string CH = "";
			string WCH = "";
			string KCH = "";
			string SIC = "";
			int IC = 0;
			int KIC = 0;
			string RevshiftKey = Reverse(shiftKey);
			decimal LL = 0;
			
			string sKey = shiftKey + RevshiftKey;
			try
			{
				for (I = 0; I <= Phrase.Length - 1; I++)
				{
					if (K >= sKey.Length - 1)
					{
						LL = 1;
						K = 0;
						LL = 5;
					}
					IC = 0;
					LL = 10;
					CH = Phrase.Substring(I, 1);
					LL = 15;
					KCH = sKey.Substring(K, 1);
					LL = 20;
					IC = Strings.AscW(CH);
					LL = 25;
					KIC = Strings.AscW(KCH);
					LL = 30;
					IC = IC + 88 + KIC;
					LL = 35;
					SIC = IC.ToString();
					LL = 40;
					WCH += Strings.ChrW(int.Parse(SIC));
					LL = 45;
					S += SIC;
					LL = 50;
					K++;
					LL = 55;
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("K: " + K.ToString() + "\r\n" + "LL: " + LL.ToString() + "\r\n" + I.ToString() + Strings.ChrW(9) + CH + Strings.ChrW(9) + Phrase + Strings.ChrW(9) + SIC));
				MessageBox.Show((string) ("ERROR 100xx02: " + ex.Message));
			}
			
			return WCH;
		}
		public string EncryptPhraseV1(string Phrase, string shiftKey)
		{
			string S = "";
			int I = 0;
			int K = 0;
			string CH = "";
			string KCH = "";
			string SIC = "";
			int IC = 0;
			int KIC = 0;
			string RevshiftKey = Reverse(shiftKey);
			shiftKey = shiftKey + RevshiftKey;
			try
			{
				for (I = 0; I <= Phrase.Length - 1; I++)
				{
					if (K >= shiftKey.Length)
					{
						K = 0;
					}
					IC = 0;
					CH = Phrase.Substring(I, 1);
					KCH = shiftKey.Substring(K, 1);
					IC = Strings.AscW(CH);
					KIC = Strings.AscW(KCH);
					IC = IC + 88 + KIC;
					SIC = IC.ToString();
					if (SIC.Length < 2)
					{
						SIC = (string) ("00" + SIC);
					}
					if (SIC.Length < 3)
					{
						SIC = (string) ("0" + SIC);
					}
					S += SIC;
					K++;
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show(System.Convert.ToString(I.ToString() + Strings.ChrW(9) + CH + Strings.ChrW(9) + Phrase + Strings.ChrW(9) + SIC));
				MessageBox.Show((string) ("ERROR 100xx03: " + ex.Message));
			}
			
			return S;
		}
		public string DecryptPhrase(string Phrase, string shiftKey)
		{
			shiftKey = GLOBALS.ContractID;
			string S = "";
			int I = 0;
			int K = 0;
			string CH = "";
			string KCH = "";
			int IC = 0;
			int IC2 = 0;
			string CHX = "";
			int KIC = 0;
			string RevshiftKey = Reverse(shiftKey);
			
			shiftKey = shiftKey + RevshiftKey;
			try
			{
				for (I = 0; I <= Phrase.Length - 1; I++)
				{
					if (K >= shiftKey.Length)
					{
						K = 0;
					}
					CH = Phrase.Substring(I, 1);
					KCH = shiftKey.Substring(K, 1);
					IC = Strings.AscW(CH);
					IC2 = Strings.AscW(KCH);
					IC = IC - 88 - IC2;
					CHX = Strings.ChrW(IC);
					S += CHX;
					K++;
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show(System.Convert.ToString(I.ToString() + Strings.ChrW(9) + CH + Strings.ChrW(9) + Phrase + Strings.ChrW(9) + CHX));
				MessageBox.Show((string) ("ERROR 100xx04: " + ex.Message));
			}
			
			return S;
		}
		public string DecryptPhrase(string Phrase)
		{
			string S = "";
			int I = 0;
			string CH = "";
			int IC = 0;
			string CHX = "";
			
			try
			{
				for (I = 0; I <= Phrase.Length - 1; I += 3)
				{
					CH = Phrase.Substring(I, 3);
					IC = int.Parse(val[CH]);
					IC = IC - 88;
					CHX = Strings.ChrW(IC);
					S += CHX;
					//I += 2
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show(System.Convert.ToString(I.ToString() + Strings.ChrW(9) + CH + Strings.ChrW(9) + Phrase + Strings.ChrW(9) + CHX));
				MessageBox.Show((string) ("ERROR 100xx05: " + ex.Message));
			}
			
			return S;
		}
		
	}
	
}
