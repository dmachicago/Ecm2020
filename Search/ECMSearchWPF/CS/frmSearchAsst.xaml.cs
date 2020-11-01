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

using System.Text;
using System.IO;
using System.IO.IsolatedStorage;
using System.Configuration;


namespace ECMSearchWPF
{
	public partial class frmSearchAsst
	{
		
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim GVAR As App = App.Current
		string UserID = "";
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		string tempIsoDir; // VBConversions Note: Initial value of "ISO.getTempDir()" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		string GeneratedSearchText = "";
		string ThesaurusConnectionString = "";
		
		System.Collections.ObjectModel.ObservableCollection<string> ThesaurusWords = new System.Collections.ObjectModel.ObservableCollection<string>();
		System.Collections.ObjectModel.ObservableCollection<string> ExpandedWords = new System.Collections.ObjectModel.ObservableCollection<string>();
		object ObjExpandedWords = null;
		bool GenAndView = false;
		public string SearchCriteria = "";
		string SecureID = "-1";
		string UserGuidID = "";
		
		public frmSearchAsst(int iSecureID)
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			tempIsoDir = ISO.getTempDir();
			
			InitializeComponent();
			//EP.setSearchSvcEndPoint(proxy)
			
			string sVal = "";
			
			if (GLOBALS.dictMasterSearch != null)
			{
				foreach (var sKey in GLOBALS.dictMasterSearch.Keys)
				{
					sVal = (string) (GLOBALS.dictMasterSearch.Item(sKey));
					if (sKey.Equals("CurrentGuid"))
					{
						UserGuidID = (string) (GLOBALS.dictMasterSearch.Item(sKey));
					}
					else if (sKey.Equals("asst.txtAllOfTheseWords"))
					{
						if (sVal != null)
						{
							txtAllOfTheseWords.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.ckPhrase"))
					{
						if (sVal != null)
						{
							if (sVal.Equals("True"))
							{
								ckPhrase.IsChecked = true;
							}
							else
							{
								ckPhrase.IsChecked = false;
							}
						}
					}
					else if (sKey.Equals("asst.ckNear"))
					{
						if (sVal != null)
						{
							if (sVal.Equals("True"))
							{
								ckNear.IsChecked = true;
							}
							else
							{
								ckNear.IsChecked = false;
							}
						}
					}
					else if (sKey.Equals("asst.ckNone"))
					{
						if (sVal != null)
						{
							if (sVal.Equals("True"))
							{
								ckNone.IsChecked = true;
							}
							else
							{
								ckNone.IsChecked = false;
							}
						}
					}
					else if (sKey.Equals("asst.ckInflection"))
					{
						if (sVal != null)
						{
							if (sVal.Equals("True"))
							{
								ckInflection.IsChecked = true;
							}
							else
							{
								ckInflection.IsChecked = false;
							}
						}
					}
					else if (sKey.Equals("asst.ckClassonomy"))
					{
						if (sVal != null)
						{
							if (sVal.Equals("True"))
							{
								ckClassonomy.IsChecked = true;
							}
							else
							{
								ckClassonomy.IsChecked = false;
							}
						}
					}
					else if (sKey.Equals("asst.txtExactPhrase"))
					{
						if (sVal != null)
						{
							txtExactPhrase.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.txtAnyOfThese"))
					{
						if (sVal != null)
						{
							txtAnyOfThese.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.txtNoneOfThese"))
					{
						if (sVal != null)
						{
							txtNoneOfThese.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.txtInflection"))
					{
						if (sVal != null)
						{
							txtInflection.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.txtMsThesuarus"))
					{
						if (sVal != null)
						{
							txtMsThesuarus.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.txtEcmThesaurus"))
					{
						if (sVal != null)
						{
							txtEcmThesaurus.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.cbAvailThesauri"))
					{
						if (sVal != null)
						{
							cbAvailThesauri.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.cbSelectedThesauri"))
					{
						if (sVal != null)
						{
							cbSelectedThesauri.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.cbDateRange"))
					{
						if (sVal != null)
						{
							cbDateRange.Text = sVal;
						}
					}
					else if (sKey.Equals("asst.dtStart"))
					{
						if (sVal != null)
						{
							dtStart.SelectedDate = DateTime.Parse(sVal);
						}
					}
					else if (sKey.Equals("asst.dtEnd"))
					{
						if (sVal != null)
						{
							dtEnd.SelectedDate = DateTime.Parse(sVal);
						}
					}
				}
			}
			
			GLOBALS.ProxySearch.getSynonymsCompleted += new System.EventHandler(client_getSynonyms);
			GLOBALS.ProxySearch.ExpandInflectionTermsCompleted += new System.EventHandler(client_ExpandInflectionTerms);
			GLOBALS.ProxySearch.getThesaurusIDCompleted += new System.EventHandler(client_getThesaurusID);
			//EP.setSearchSvcEndPoint(proxy)
			
			UserID = GLOBALS._UserID;
			modGlobals.gCurrUserGuidID = GLOBALS._UserGuid;
			COMMON.SaveClick(3300, UserID);
			
			SecureID = iSecureID.ToString();
			cbDateRange.SelectedItem = "OFF";
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
			this.DialogResult = true;
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = false;
			//Me.Close()
		}
		
		public void GenerateSearchCriteria()
		{
			
			if (cbSelectedThesauri.Items.Count == 0)
			{
				var name2 = cbAvailThesauri.Text;
				if (name2 != null)
				{
					cbSelectedThesauri.Items.Add(name2);
					cbSelectedThesauri.Items.Add(cbAvailThesauri.Text);
					cbSelectedThesauri.Text = cbAvailThesauri.Text;
				}
			}
			
			
			modGlobals.ReformattedSearchString = "";
			object[] ArrayUseAllWords = null;
			object[] ArrayExactPhrases = null;
			object[] ArraySinglePhrase = null;
			object[] ArrayAnyOfTheseWords = null;
			object[] ArrayNoneOfTheseWords = null;
			object[] ArrayNearWords = null;
			
			object[] ArrayInflection = null;
			object[] ArrayMsThesaurus = null;
			object[] ArrayEcmThesaurus = null;
			
			
			var strUseAllWords = "";
			var strUseExactPhrase = "";
			var strUseAnyOfTheseWords = "";
			var strUseNoneOfTheseWords = "";
			var strUseNearWords = "";
			var strUseInflection = "";
			var strUseMsThesaurus = "";
			var strUseEcmThesaurus = "";
			
			var CH = "";
			
			txtInflection.Text = txtInflection.Text.Trim();
			txtMsThesuarus.Text = txtMsThesuarus.Text.Trim();
			
			RemoveDoubleQuotes(txtAllOfTheseWords.Text);
			RemoveDoubleQuotes(txtExactPhrase.Text);
			RemoveDoubleQuotes(txtAnyOfThese.Text);
			RemoveDoubleQuotes(txtNoneOfThese.Text);
			//RemoveDoubleQuotes(txtNear.Text)
			RemoveDoubleQuotes(txtInflection.Text);
			RemoveDoubleQuotes(txtMsThesuarus.Text);
			
			ArrayUseAllWords = txtAllOfTheseWords.Text.Trim().Split(' ');
			ArrayExactPhrases = txtExactPhrase.Text.Trim().Split(' ');
			ArrayAnyOfTheseWords = Strings.Split((string) this.txtAnyOfThese.Text.Trim, " ", -1, 0);
			ArrayNoneOfTheseWords = txtNoneOfThese.Text.Trim().Split(' ');
			
			//ArrayNearWords = Split(txtNear.Text.Trim, " ")
			ArrayNearWords = SplitNearWords(txtNear.Text.Trim());
			
			ArrayInflection = Strings.Split((string) this.txtInflection.Text.Trim, " ", -1, 0);
			ArrayMsThesaurus = Strings.Split((string) this.txtMsThesuarus.Text.Trim, " ", -1, 0);
			ArrayEcmThesaurus = Strings.Split((string) this.txtEcmThesaurus.Text.Trim, " ", -1, 0);
			
			RemoveKeyWords(ArrayUseAllWords, txtAllOfTheseWords.Text);
			RemoveKeyWords(ArrayExactPhrases, txtExactPhrase.Text);
			RemoveKeyWords(ArrayAnyOfTheseWords, txtAnyOfThese.Text);
			RemoveKeyWords(ArrayNoneOfTheseWords, txtNoneOfThese.Text);
			RemoveKeyWords(ArrayNearWords, txtNear.Text);
			
			RemoveKeyWords(ArrayInflection, txtInflection.Text);
			RemoveKeyWords(ArrayMsThesaurus, txtMsThesuarus.Text);
			//RemoveKeyWords(ArrayEcmThesaurus$, txtEcmThesaurus.Text)
			
			
			bool bAllOfTheseWords = false;
			bool bExactPhrase = false;
			bool bAnyOfThese = false;
			bool bNoneOfThese = false;
			bool bNear = false;
			bool bInflection = false;
			bool bMsThesaurus = false;
			bool bEcmThesaurus = false;
			
			if (txtAllOfTheseWords.Text.Trim().Length > 0)
			{
				bAllOfTheseWords = true;
			}
			if (txtExactPhrase.Text.Trim().Length > 0)
			{
				bExactPhrase = true;
			}
			if (txtAnyOfThese.Text.Trim().Length > 0)
			{
				bAnyOfThese = true;
			}
			if (txtNoneOfThese.Text.Trim().Length > 0)
			{
				bNoneOfThese = true;
			}
			if (txtNear.Text.Trim().Length > 0)
			{
				bNear = true;
			}
			if (txtInflection.Text.Trim().Length > 0)
			{
				bInflection = true;
			}
			if (txtMsThesuarus.Text.Trim().Length > 0)
			{
				bMsThesaurus = true;
			}
			if (txtEcmThesaurus.Text.Trim().Length > 0)
			{
				bEcmThesaurus = true;
			}
			
			
			int I = 0;
			
			if (bAllOfTheseWords)
			{
				var TempStr = "";
				for (I = 0; I <= (ArrayUseAllWords.Length - 1); I++)
				{
					strUseAllWords = "";
					if (ArrayUseAllWords(I).Trim.Length > 0)
					{
						TempStr = TempStr + " AND " + Strings.ChrW(34) + ArrayUseAllWords(I).ToString() + Strings.ChrW(34) + " ";
					}
					strUseAllWords = TempStr;
				}
				if (strUseAllWords.Equals("AND"))
				{
					strUseAllWords = "";
				}
				strUseAllWords = strUseAllWords.Trim();
				if (strUseAllWords.Length > 0)
				{
					//strUseAnyOfTheseWords$ = "(" + strUseAnyOfTheseWords$ + ")"
				}
			}
			
			if (bExactPhrase)
			{
				if (txtExactPhrase.Text.Trim().IndexOf(",") + 1 > 0)
				{
					strUseExactPhrase = "";
					ArraySinglePhrase = txtExactPhrase.Text.Trim().Split(',');
					for (int ii = 0; ii <= (ArraySinglePhrase.Length - 1); ii++)
					{
						ArrayExactPhrases = Strings.Split((string) (ArraySinglePhrase(ii)), " ", -1, 0);
						var TempPhrase = "";
						for (I = 0; I <= (ArrayExactPhrases.Length - 1); I++)
						{
							TempPhrase = TempPhrase + ArrayExactPhrases(I) + " ";
						}
						TempPhrase = TempPhrase.Trim();
						if ((ArrayExactPhrases.Length - 1) > 0)
						{
							strUseExactPhrase = strUseExactPhrase + Strings.ChrW(34) + TempPhrase + Strings.ChrW(34) + " AND ";
							//strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
						}
					}
					if (strUseExactPhrase.Length > 1)
					{
						strUseExactPhrase = strUseExactPhrase.Trim();
						strUseExactPhrase = strUseExactPhrase.Substring(0, strUseExactPhrase.Length - 3);
					}
				}
				else
				{
					for (I = 0; I <= (ArrayExactPhrases.Length - 1); I++)
					{
						if (ArrayExactPhrases(I).Trim.Length > 0)
						{
							strUseExactPhrase = strUseExactPhrase + ArrayExactPhrases(I) + " ";
						}
					}
					if ((ArrayExactPhrases.Length - 1) > 0)
					{
						strUseExactPhrase = strUseExactPhrase.Trim();
						strUseExactPhrase = (string) (Strings.ChrW(34) + strUseExactPhrase + Strings.ChrW(34));
						//strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
					}
				}
			}
			
			if (bAnyOfThese)
			{
				strUseAnyOfTheseWords = "";
				for (I = 0; I <= (ArrayAnyOfTheseWords.Length - 1); I++)
				{
					if (ArrayAnyOfTheseWords(I).Trim.Length > 0)
					{
						strUseAnyOfTheseWords = strUseAnyOfTheseWords + " OR " + Strings.ChrW(34) + ArrayAnyOfTheseWords(I) + Strings.ChrW(34) + " ";
					}
				}
				if (strUseAnyOfTheseWords.Equals("OR"))
				{
					strUseAnyOfTheseWords = "";
				}
				strUseAnyOfTheseWords = strUseAnyOfTheseWords.Trim();
				if (strUseAnyOfTheseWords.Length > 0)
				{
					//strUseAnyOfTheseWords$ = "(" + strUseAnyOfTheseWords$ + ")"
				}
			}
			
			if (bNoneOfThese)
			{
				
				for (I = 0; I <= (ArrayNoneOfTheseWords.Length - 1); I++)
				{
					if (ckNone.IsChecked == true)
					{
						if (ArrayNoneOfTheseWords(I).Trim.Length > 0)
						{
							strUseNoneOfTheseWords = strUseNoneOfTheseWords + " AND NOT " + Strings.ChrW(34) + ArrayNoneOfTheseWords(I) + Strings.ChrW(34) + " ";
						}
					}
					else
					{
						if (ArrayNoneOfTheseWords(I).Trim.Length > 0)
						{
							strUseNoneOfTheseWords = strUseNoneOfTheseWords + " OR NOT " + Strings.ChrW(34) + ArrayNoneOfTheseWords(I) + Strings.ChrW(34) + " ";
						}
					}
				}
				
				strUseNoneOfTheseWords = strUseNoneOfTheseWords.Trim();
				if (strUseNoneOfTheseWords.Equals("-"))
				{
					strUseNoneOfTheseWords = "";
				}
			}
			
			if (bNear)
			{
				
				for (I = 0; I <= (ArrayNearWords.Length - 1); I++)
				{
					if (! (ArrayNearWords(I) == null))
					{
						if (ArrayNearWords(I).Trim.Length > 0)
						{
							if ((ArrayNearWords.Length - 1) >= 1)
							{
								strUseNearWords = strUseNearWords + ArrayNearWords(I) + " NEAR ";
								//strUseNearWords$ = strUseNearWords$.Trim
							}
						}
					}
				}
				strUseNearWords = strUseNearWords.Trim();
				if (strUseNearWords.Equals("NEAR"))
				{
					strUseNearWords = "";
				}
				if (strUseNearWords.Trim().Trim().Length > 0)
				{
					strUseNearWords = strUseNearWords.Substring(0, strUseNearWords.Length - 5);
					strUseNearWords = strUseNearWords.Trim();
					//strUseNearWords = "(" + strUseNearWords + ")"
				}
				
			}
			
			if (bInflection)
			{
				for (I = 0; I <= (ArrayInflection.Length - 1); I++)
				{
					if (ckInflection.IsChecked)
					{
						if (ArrayInflection(I).Trim.Length > 0)
						{
							strUseInflection = strUseInflection + " And ^" + ArrayInflection(I) + " ";
						}
					}
					else
					{
						if (ArrayInflection(I).Trim.Length > 0)
						{
							strUseInflection = strUseInflection + " Or ^" + ArrayInflection(I) + " ";
						}
					}
				}
			}
			
			if (bMsThesaurus)
			{
				for (I = 0; I <= (ArrayMsThesaurus.Length - 1); I++)
				{
					if (ckClassonomy.IsChecked)
					{
						if (ArrayMsThesaurus(I).Trim.Length > 0)
						{
							strUseMsThesaurus = strUseMsThesaurus + " And ~" + ArrayMsThesaurus(I) + " ";
						}
					}
					else
					{
						if (ArrayMsThesaurus(I).Trim.Length > 0)
						{
							strUseMsThesaurus = strUseMsThesaurus + " Or ~" + ArrayMsThesaurus(I) + " ";
						}
					}
				}
			}
			
			if (bEcmThesaurus)
			{
				//gThesaurusSearchText = txtEcmThesaurus.Text.Trim
				I = cbSelectedThesauri.Items.Count;
				if (I > 0)
				{
					modGlobals.gThesauri.Clear();
					for (int k = 0; k <= cbSelectedThesauri.Items.Count - 1; k++)
					{
						var Tok = cbSelectedThesauri.Items[k].ToString();
						if (! modGlobals.gThesauri.Contains(Tok))
						{
							modGlobals.gThesauri.Add(Tok);
						}
					}
				}
			}
			else
			{
				//gThesaurusSearchText = ""
				modGlobals.gThesauri.Clear();
				//If InStr(1, txtEcmThesaurus.Text.Trim, ",") > 0 Then
				//    strUseExactPhrase$ = ""
				//    ArraySinglePhrase$ = Split(txtEcmThesaurus.Text.Trim, ",")
				//    For ii As Integer = 0 To UBound(ArraySinglePhrase)
				//        ArrayExactPhrases$ = Split(ArraySinglePhrase$(ii), " ")
				//        Dim TempPhrase$ = ""
				//        For I = 0 To UBound(ArrayExactPhrases )
				//            TempPhrase$ = TempPhrase$ + ArrayExactPhrases$(I) + " "
				//        Next
				//        TempPhrase$ = TempPhrase$.Trim
				//        If UBound(ArrayExactPhrases ) > 0 Then
				//            strUseExactPhrase$ = strUseExactPhrase$ + ChrW(34) + TempPhrase$ + ChrW(34) + " AND #"
				//            'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
				//        End If
				//    Next
				//    If strUseExactPhrase$.Length > 1 Then
				//        strUseExactPhrase$ = strUseExactPhrase$.Trim
				//        strUseExactPhrase$ = Mid(strUseExactPhrase$, 1, strUseExactPhrase$.Length - 3)
				//    End If
				//Else
				//    For I = 0 To UBound(ArrayExactPhrases )
				//        If ArrayExactPhrases$(I).Trim.Length > 0 Then
				//            strUseExactPhrase$ = strUseExactPhrase$ + ArrayExactPhrases$(I) + " "
				//        End If
				//    Next
				//    If UBound(ArrayExactPhrases ) > 0 Then
				//        strUseExactPhrase$ = strUseExactPhrase$.Trim
				//        strUseExactPhrase$ = ChrW(34) + strUseExactPhrase$ + ChrW(34)
				//        'strUseExactPhrase$ = "(" + ChrW(34) + strUseExactPhrase$ + ChrW(34) + ")"
				//    End If
				//End If
			}
			
			modGlobals.ReformattedSearchString = "";
			if (bAllOfTheseWords)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + strUseAllWords;
			}
			
			if (bExactPhrase && ckPhrase.IsChecked == true)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " AND " + strUseExactPhrase;
			}
			if (bExactPhrase && ckPhrase.IsChecked == false)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " OR " + strUseExactPhrase;
			}
			
			if (strUseAnyOfTheseWords.Equals("OR"))
			{
				strUseAnyOfTheseWords = "";
			}
			if (bAnyOfThese)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " " + strUseAnyOfTheseWords;
			}
			
			ValidateFirstWord(ref modGlobals.ReformattedSearchString);
			
			if (bNoneOfThese == true)
			{
				if (modGlobals.ReformattedSearchString.Trim().Length > 0)
				{
					modGlobals.ReformattedSearchString = "(" + modGlobals.ReformattedSearchString + ") ";
				}
			}
			
			if (bNoneOfThese && ckNone.IsChecked == true)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " " + strUseNoneOfTheseWords;
			}
			if (bNoneOfThese && ckNone.IsChecked == false)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " " + strUseNoneOfTheseWords;
			}
			
			if (bNear && ckNear.IsChecked == true)
			{
				if (strUseNearWords.Trim().Length > 0)
				{
					modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " and " + "(" + strUseNearWords + ")";
				}
			}
			if (bNear && ckNear.IsChecked == false)
			{
				if (strUseNearWords.Trim().Length > 0)
				{
					modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + " OR " + "(" + strUseNearWords + ")";
				}
			}
			
			if (bMsThesaurus == true)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + strUseMsThesaurus + " ";
			}
			if (bInflection == true)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString + strUseInflection + " ";
			}
			
			modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString.Trim();
			if (modGlobals.ReformattedSearchString.Length == 0)
			{
				modGlobals.ReformattedSearchString = " ";
			}
			CH = modGlobals.ReformattedSearchString.Substring(modGlobals.ReformattedSearchString.Length - 1, 1);
			StringBuilder builder = new StringBuilder(modGlobals.ReformattedSearchString);
			
			if (CH == "-")
			{
				builder.Insert(modGlobals.ReformattedSearchString.Length, " ");
			}
			if (CH == "+")
			{
				builder.Insert(modGlobals.ReformattedSearchString.Length, " ");
			}
			if (CH == "|")
			{
				builder.Insert(modGlobals.ReformattedSearchString.Length, " ");
			}
			
			CH = modGlobals.ReformattedSearchString.Substring(0, 1);
			if (CH == "-")
			{
				builder.Insert(1, " ");
			}
			if (CH == "+")
			{
				builder.Insert(1, " ");
			}
			if (CH == "|")
			{
				builder.Insert(1, " ");
			}
			modGlobals.ReformattedSearchString = builder.ToString();
			builder = null;
			
			modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString.Trim();
			
			if (modGlobals.ReformattedSearchString.Length > 3)
			{
				modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString.Trim();
				if (modGlobals.ReformattedSearchString.Substring(0, 4).ToUpper() == "AND ")
				{
					modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString.Substring(3);
				}
				if (modGlobals.ReformattedSearchString.Substring(0, 3).ToUpper() == "OR ")
				{
					modGlobals.ReformattedSearchString = modGlobals.ReformattedSearchString.Substring(2);
				}
			}
			
			SB.Text = modGlobals.ReformattedSearchString;
			
			var sDateKey = this.cbDateRange.Text.Trim;
			var eDate = "";
			var sDate = "";
			if (dtStart.Text.Length > 0)
			{
				sDate = (DateTime.Parse(dtStart.Text)).ToString();
			}
			if (dtEnd.Text.Length > 0)
			{
				eDate = (DateTime.Parse(dtEnd.Text)).ToString();
			}
			
			if ((string) sDateKey == "OFF")
			{
				SB2.Visibility = System.Windows.Visibility.Collapsed;
			}
			else if ((string) sDateKey == "Between")
			{
				SB2.Visibility = System.Windows.Visibility.Visible;
				SB2.Text = (string) ("Content create date will be between " + sDate + " and " + eDate);
			}
			else if ((string) sDateKey == "Before")
			{
				SB2.Visibility = System.Windows.Visibility.Collapsed;
				SB2.Text = (string) ("Content create date will be before " + sDate);
			}
			else if ((string) sDateKey == "After")
			{
				SB2.Visibility = System.Windows.Visibility.Visible;
				SB2.Text = (string) ("Content create date will be after " + sDate);
			}
			else if ((string) sDateKey == "Not Between")
			{
				SB2.Visibility = System.Windows.Visibility.Visible;
				SB2.Text = (string) ("Content create date will NOT be between " + sDate + " and " + eDate);
			}
			
			SaveCurrFields();
			
			GC.Collect();
			
			try
			{
				GeneratedSearchText = SB.Text;
				if (GenAndView)
				{
					MessageBox.Show(GeneratedSearchText);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
			SearchCriteria = modGlobals.ReformattedSearchString;
			
			bool B = false;
			
		}
		public void client_UserParmInsertUpdateCompleted(object sender, SVCSearch.UserParmInsertUpdateCompletedEventArgs e)
		{
			bool B = false;
			if (e.Error == null)
			{
				B = System.Convert.ToBoolean(e.RC);
				if (B)
				{
				}
				else
				{
					MessageBox.Show("ERROR client_ExpandInflectionTerms: Failed to process request for expansion.");
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth." + "\r\n" + e.Error.Message));
			}
		}
		
		public void btnExpInflection_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//SELECT * FROM sys.dm_fts_parser ('FORMSOF(INFLECTIONAL,run) or FORMSOF(INFLECTIONAL,deep)', 1033, 0, 0)
			if (txtInflection.Text.Trim().Length == 0)
			{
				MessageBox.Show("Text must be present to expand - aborting expansion.");
				return;
			}
			string sText = txtInflection.Text.Trim();
			var CH = "";
			List<string> tArray = new List<string>();
			
			sText = sText.Replace(",", " ");
			sText = sText.Replace(Strings.ChrW(34), " ");
			
			object[] A = new object[1];
			var Words = "";
			A = sText.Split(" ".ToCharArray());
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				if (! tArray.Contains(A[i].Trim))
				{
					tArray.Add(A[i].Trim);
					Words = (string) (A[i].Trim);
				}
			}
			var Qry = "Select display_term, source_term  as Expansion FROM sys.dm_fts_parser (\'";
			
			for (int i = 0; i <= tArray.Count - 1; i++)
			{
				var tWord = tArray(i).ToString();
				Qry = Qry + "\r\n" + "    " + "FORMSOF(INFLECTIONAL," + tWord + ") or ";
			}
			Qry = Qry.Trim();
			Qry = Qry.Substring(0, Qry.Length - 3);
			Qry = Qry + "\', 1033, 0, 0)" + "\r\n";
			Qry = Qry + " order by display_term, source_term " + "\r\n";
			
			
			
			GLOBALS.ProxySearch.RecordGrowthAsync(SecureID, Qry);
		}
		
		public void client_ExpandInflectionTerms(object sender, SVCSearch.ExpandInflectionTermsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result != null)
				{
					MessageBox.Show((string) e.Result);
				}
				else
				{
					MessageBox.Show("ERROR client_ExpandInflectionTerms: Failed to process request for expansion.");
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth." + "\r\n" + e.Error.Message));
			}
			GLOBALS.ProxySearch.ExpandInflectionTermsCompleted -= new System.EventHandler(client_ExpandInflectionTerms);
		}
		
		public void btnExpandThesaurus_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//SELECT * FROM sys.dm_fts_parser ('FORMSOF(INFLECTIONAL,run) or FORMSOF(INFLECTIONAL,deep)', 1033, 0, 0)
			if (txtMsThesuarus.Text.Trim().Length == 0)
			{
				MessageBox.Show("Text must be present to expand - aborting expansion.");
				return;
			}
			string sText = txtMsThesuarus.Text.Trim();
			var CH = "";
			List<string> tArray = new List<string>();
			
			sText.Replace(",", " ");
			sText.Replace(Strings.ChrW(34), " ");
			
			object[] A = new object[1];
			var Words = "";
			A = sText.Split(" ".ToCharArray());
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				if (! tArray.Contains(A[i].Trim))
				{
					tArray.Add(A[i].Trim);
					Words = (string) (A[i].Trim);
				}
			}
			
			var Qry = "";
			string DQ = Strings.ChrW(34);
			Qry = "Select display_term, source_term FROM sys.dm_fts_parser (\'FORMSOF( THESAURUS, " + DQ + txtMsThesuarus.Text.Trim() + DQ + ")\', 2057, 0, 0) order by display_term";
			
			Qry = "Select display_term, source_term FROM sys.dm_fts_parser (\'";
			
			//DMA.SayWords(Words )
			
			//** SELECT display_term, source_term FROM sys.dm_fts_parser ('
			//** FORMSOF(THESAURUS,"jump") or
			//** FORMSOF(THESAURUS,"XL") or
			//** FORMSOF(THESAURUS,"internet") or
			//** FORMSOF(THESAURUS, "internet explorer")
			//** ', 1033, 0, 0)  order by display_term, source_term
			
			for (int i = 0; i <= tArray.Count - 1; i++)
			{
				var tWord = tArray(i).ToString();
				Qry = Qry + "\r\n" + "    " + "FORMSOF(THESAURUS," + DQ + tWord + DQ + ") or ";
			}
			Qry = Qry.Trim();
			Qry = Qry.Substring(0, Qry.Length - 3);
			Qry = Qry + "\', 0, 0, 0)" + "\r\n";
			Qry = Qry + " order by display_term, source_term " + "\r\n";
			
			
			GLOBALS.ProxySearch.RecordGrowthAsync(SecureID, Qry);
			
		}
		
		public void btnExpand_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			var Words = "";
			var tgtPhrases = txtEcmThesaurus.Text;
			var ThesaurusName = "";
			object[] A = new object[1];
			
			if (cbSelectedThesauri.Items.Count == 0)
			{
				btnAddThesauri_Click(null, null);
				SB.Text = "No thesaurus was selected the default thesaurus is being used.";
			}
			else
			{
				SB.Text = "";
			}
			try
			{
				ExpandedWords.Clear();
				ThesaurusWords.Clear();
				
				A = tgtPhrases.Split(" ".ToCharArray());
				for (int i = 0; i <= (A.Length - 1); i++)
				{
					if (! ThesaurusWords.Contains(A[i].Trim))
					{
						ThesaurusWords.Add(A[i].Trim);
					}
				}
				
				//** Get and use the default Thesaurus
				for (int I = 0; I <= cbSelectedThesauri.Items.Count - 1; I++)
				{
					ThesaurusName = cbSelectedThesauri.Items[I].ToString();
					getThesaurusID(ThesaurusName);
				}
				
				string Msg = "";
				string Msg2 = "";
				
				
				//'DMA.SayWords(Words as string)
				
			}
			catch (Exception ex)
			{
				SB2.Text = ex.Message;
			}
		}
		public void getThesaurusID(string ThesaurusName)
		{
			
			GLOBALS.ProxySearch.getThesaurusIDAsync(SecureID, ThesaurusName);
		}
		public void client_getThesaurusID(object sender, SVCSearch.getThesaurusIDCompletedEventArgs e)
		{
			string TID = "";
			bool B = false;
			if (e.Error == null)
			{
				TID = (string) e.Result;
				if (TID.Length > 0)
				{
					foreach (string token in ThesaurusWords)
					{
						if (! ExpandedWords.Contains(token))
						{
							ExpandedWords.Add(token);
							bool BB = true;
							for (int ii = 0; ii <= lbWords.Items.Count - 1; ii++)
							{
								if (lbWords.Items[ii].Equals(token))
								{
									BB = false;
								}
							}
							if (BB)
							{
								lbWords.Items.Add(token);
							}
						}
						ObjExpandedWords = ExpandedWords;
						GLOBALS.ProxySearch.getSynonymsAsync(SecureID, TID, token, ObjExpandedWords, true);
					}
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR 100 client_ExpandInflectionTerms: Failed to update the associated DB Growth." + "\r\n" + e.Error.Message));
			}
			GLOBALS.ProxySearch.getThesaurusIDCompleted -= new System.EventHandler(client_getThesaurusID);
		}
		public void client_getSynonyms(object sender, SVCSearch.getSynonymsCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				for (int i = 0; i <= ExpandedWords.Count - 1; i++)
				{
					string Msg = "";
					string token = ExpandedWords[i].ToString();
					
					bool BB = true;
					for (int ii = 0; ii <= lbWords.Items.Count - 1; ii++)
					{
						if (lbWords.Items[ii].Equals(token))
						{
							BB = false;
						}
					}
					if (BB)
					{
						lbWords.Items.Add(token);
					}
					
					Msg += (string) (ExpandedWords[i].ToString() + "\r\n");
					MessageBox.Show(Msg, "Expanded Words", MessageBoxButton.OK);
				}
				MessageBox.Show((string) (e.Error.ToString()), "Error in expansion", MessageBoxButton.OK);
			}
			else
			{
				
			}
		}
		public void ValidateFirstWord(ref string ReformattedSearchString)
		{
			string S = ReformattedSearchString.Trim();
			
			int I = S.IndexOf(" ") + 1;
			if (I > 0)
			{
				var tWord = S.Substring(0, I);
				tWord = tWord.Trim();
				bool B = isKeyWord(tWord);
				if (B == true)
				{
					S = S.Substring(I - 1);
					S = S.Trim();
				}
			}
			
			ReformattedSearchString = S;
			
		}
		public bool isKeyWord(string KW)
		{
			bool B = false;
			KW = KW.ToUpper();
			switch (KW)
			{
				case "AND":
					return true;
				case "OR":
					return true;
				case "NOT":
					return true;
				case "NEAR":
					return true;
			}
			return B;
		}
		
		public void btnAddThesauri_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			int I = 0;
			for (I = 0; I <= cbSelectedThesauri.Items.Count - 1; I++)
			{
				var name1 = cbSelectedThesauri.Items[I].ToString();
				var name2 = cbAvailThesauri.Text;
				if (Strings.UCase(name1) == name2.ToUpper())
				{
					return;
				}
			}
			cbSelectedThesauri.Items.Add(cbAvailThesauri.Text);
			cbSelectedThesauri.Text = cbAvailThesauri.Text;
		}
		public void SaveCurrFields()
		{
			
			ISO.ZeroizeTempFile("AssistParms.dat");
			
			string AllOfTheseWords = txtAllOfTheseWords.Text.Trim();
			string ExactPhrase = txtExactPhrase.Text.Trim();
			string AnyOfThese = txtAnyOfThese.Text.Trim();
			string NoneOfThese = txtNoneOfThese.Text.Trim();
			string Near = txtNear.Text.Trim();
			string Inflection = txtInflection.Text.Trim();
			string Thesuarus = txtMsThesuarus.Text.Trim();
			string StartDt = dtStart.Text.ToString();
			string EndDt = dtEnd.Text.ToString();
			string DateRange = cbDateRange.Text;
			string sCheckBox1 = ckPhrase.IsChecked.ToString();
			string sCheckBox3 = ckNone.IsChecked.ToString();
			string sCheckBox4 = ckNear.IsChecked.ToString();
			string sckAndInflection = ckInflection.IsChecked.ToString();
			string sckAndThesaurus = ckClassonomy.IsChecked.ToString();
			string EcmThesaurus = txtEcmThesaurus.Text.Trim();
			
			string S = AllOfTheseWords;
			S = S + Strings.ChrW(254) + ExactPhrase;
			S = S + Strings.ChrW(254) + AnyOfThese;
			S = S + Strings.ChrW(254) + NoneOfThese;
			S = S + Strings.ChrW(254) + Near;
			S = S + Strings.ChrW(254) + Inflection;
			S = S + Strings.ChrW(254) + Thesuarus;
			S = S + Strings.ChrW(254) + StartDt;
			S = S + Strings.ChrW(254) + EndDt;
			S = S + Strings.ChrW(254) + DateRange;
			S = S + Strings.ChrW(254) + sCheckBox1;
			S = S + Strings.ChrW(254) + sCheckBox3;
			S = S + Strings.ChrW(254) + sCheckBox4;
			S = S + Strings.ChrW(254) + sckAndInflection;
			S = S + Strings.ChrW(254) + sckAndThesaurus;
			S = S + Strings.ChrW(254) + EcmThesaurus;
			
			WriteToAssistFile(S);
			
		}
		public void PopulateCurrFields(string msg)
		{
			object[] A = new object[1];
			A = msg.Split(Strings.ChrW(254).ToString().ToCharArray());
			if ((A.Length - 1) < 2)
			{
				return;
			}
			string S = "";
			
			txtAllOfTheseWords.Text = (string) (A[0]);
			txtExactPhrase.Text = (string) (A[1]);
			txtAnyOfThese.Text = (string) (A[2]);
			txtNoneOfThese.Text = (string) (A[3]);
			txtNear.Text = (string) (A[4]);
			txtInflection.Text = (string) (A[5]);
			txtMsThesuarus.Text = (string) (A[6]);
			dtStart.Text = (string) (A[7]);
			dtEnd.Text = (string) (A[8]);
			cbDateRange.Text = (string) (A[9]);
			
			S = (string) (A[10]);
			if (S.ToUpper().Equals("TRUE"))
			{
				ckPhrase.IsChecked = true;
			}
			else
			{
				ckPhrase.IsChecked = false;
			}
			
			S = (string) (A[11]);
			if (S.ToUpper().Equals("TRUE"))
			{
				ckNone.IsChecked = true;
			}
			else
			{
				ckNone.IsChecked = false;
			}
			
			S = (string) (A[12]);
			if (S.ToUpper().Equals("TRUE"))
			{
				ckNear.IsChecked = true;
			}
			else
			{
				ckNear.IsChecked = false;
			}
			
			S = (string) (A[13]);
			if (S.ToUpper().Equals("TRUE"))
			{
				ckInflection.IsChecked = true;
			}
			else
			{
				ckInflection.IsChecked = false;
			}
			
			S = (string) (A[14]);
			if (S.ToUpper().Equals("TRUE"))
			{
				ckClassonomy.IsChecked = true;
			}
			else
			{
				ckClassonomy.IsChecked = false;
			}
			
			S = (string) (A[15]);
			txtEcmThesaurus.Text = S;
			
		}
		public void WriteToAssistFile(string Msg)
		{
			try
			{
				string cPath = tempIsoDir;
				var tFQN = cPath + "\\AssistParms.dat";
				ISO.AppendTempFile("AssistParms.dat", Msg);
				using (StreamWriter sw = new StreamWriter(tFQN, false))
				{
					sw.WriteLine(Msg);
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				Console.WriteLine("frmSearchAssist : WriteToAssistFile : 688 : " + ex.Message);
			}
		}
		public void xReadAssistFile(ref string Msg)
		{
			try
			{
				string cPath = tempIsoDir;
				var tFQN = cPath + "\\AssistParms.dat";
				using (StreamReader sr = new StreamReader(tFQN))
				{
					Msg = sr.ReadLine();
					sr.Close();
				}
				
			}
			catch (Exception ex)
			{
				Console.WriteLine("frmSearchAssist : WriteToAssistFile : 688 : " + ex.Message);
			}
		}
		public void RemoveDoubleQuotes(string TgtStr)
		{
			TgtStr = TgtStr.Replace(Strings.ChrW(34), " ");
		}
		public void RemoveKeyWords(string[] aList, ref string CorrectedText)
		{
			CorrectedText = "";
			int I = 0;
			for (I = 0; I <= aList.Count - 1; I++)
			{
				if (aList[I] == null)
				{
					//Console.WriteLine("XXXX")
				}
				else
				{
					string W = aList[I].Trim();
					W = W.ToUpper();
					switch (W)
					{
						case "NEAR":
							aList[I] = "";
							break;
						case "AND":
							aList[I] = "";
							break;
						case "OR":
							aList[I] = "";
							break;
						case "NOT":
							aList[I] = "";
							break;
					}
					CorrectedText = CorrectedText + " " + aList[I];
				}
				
			}
		}
		private Array SplitNearWords(string S)
		{
			
			List<string> A = new List<string>();
			object[] AR = new object[1];
			
			S = S.Trim();
			string Token = "";
			int I = 0;
			var Dels = " ";
			var CH = "";
			
			for (I = 1; I <= S.Length; I++)
			{
				CH = S.Substring(I - 1, 1);
				if (CH.Equals(" "))
				{
					if (Token.Length > 0)
					{
						A.Add(Token);
						Token = "";
					}
				}
				else if (CH.Equals(Strings.ChrW(34)))
				{
					int K = S.IndexOf((Strings.ChrW(34)).ToString(), I + 1 - 1) + 1;
					var Phrase = S.Substring(I - 1, K - I + 1);
					if (Token.Length > 0)
					{
						A.Add(Token);
						I = K;
					}
					if (Phrase.Length > 0)
					{
						A.Add(Phrase);
						I = K;
					}
					I = K;
					Token = "";
					Phrase = "";
				}
				else
				{
					Token = Token + CH;
				}
			}
			if (Token.Length > 0)
			{
				A.Add(Token);
			}
			AR = new object[A.Count + 1];
			for (I = 0; I <= A.Count - 1; I++)
			{
				Console.WriteLine(A(I).ToString());
				AR[I] = A(I).ToString();
			}
			
			return AR;
			
		}
		
		public void SetCalendarWidgets()
		{
			if (cbDateRange.Text.ToUpper().Equals("OFF"))
			{
				dtStart.Visibility = System.Windows.Visibility.Collapsed;
				dtEnd.Visibility = System.Windows.Visibility.Collapsed;
				dtStart.SelectedDate = null;
				dtEnd.SelectedDate = null;
			}
			if (cbDateRange.Text.Equals("Between"))
			{
				dtStart.Visibility = System.Windows.Visibility.Visible;
				dtEnd.Visibility = System.Windows.Visibility.Visible;
				dtStart.SelectedDate = null;
				dtEnd.SelectedDate = null;
			}
			if (cbDateRange.Text.Equals("Not Between"))
			{
				dtStart.Visibility = System.Windows.Visibility.Visible;
				dtEnd.Visibility = System.Windows.Visibility.Visible;
				dtStart.SelectedDate = null;
				dtEnd.SelectedDate = null;
			}
			if (cbDateRange.Text.Equals("After/On"))
			{
				dtStart.Visibility = System.Windows.Visibility.Collapsed;
				dtEnd.Visibility = System.Windows.Visibility.Visible;
				dtStart.SelectedDate = null;
				dtEnd.SelectedDate = null;
			}
			if (cbDateRange.Text.Equals("Before/On"))
			{
				dtStart.Visibility = System.Windows.Visibility.Visible;
				dtEnd.Visibility = System.Windows.Visibility.Collapsed;
				dtStart.SelectedDate = null;
				dtEnd.SelectedDate = null;
			}
		}
		
		public void btnGen_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			GenAndView = true;
			GenerateSearchCriteria();
			GenAndView = false;
		}
		
		private void Button2_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
		}
		
		public void btnRemoveThesauri_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			int I = 0;
			var name1 = cbSelectedThesauri.Items[I].ToString();
			for (I = 0; I <= cbSelectedThesauri.Items.Count - 1; I++)
			{
				var name2 = cbSelectedThesauri.Text;
				if (Strings.UCase(name1) == name2.ToUpper())
				{
					cbSelectedThesauri.Items.RemoveAt(I);
					break;
				}
			}
		}
		~frmSearchAsst()
		{
			try
			{
				
			}
			finally
			{
				base.Finalize(); //define the destructor
				
				GLOBALS.ProxySearch.getSynonymsCompleted -= new System.EventHandler(client_getSynonyms);
				GLOBALS.ProxySearch.ExpandInflectionTermsCompleted -= new System.EventHandler(client_ExpandInflectionTerms);
				GLOBALS.ProxySearch.getThesaurusIDCompleted -= new System.EventHandler(client_getThesaurusID);
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void ChildWindow_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
		public void AddDictItems()
		{
			
			UpdateSearchDict("asst.txtAllOfTheseWords", txtAllOfTheseWords.Text.Trim());
			UpdateSearchDict("asst.ckPhrase", ckPhrase.ToString());
			UpdateSearchDict("asst.ckNear", ckNear.ToString());
			UpdateSearchDict("asst.ckNone", ckNone.ToString());
			UpdateSearchDict("asst.ckInflection", ckPhrase.ToString());
			UpdateSearchDict("asst.ckClassonomy", ckPhrase.ToString());
			UpdateSearchDict("asst.txtExactPhrase", txtExactPhrase.Text.Trim());
			UpdateSearchDict("asst.txtAnyOfThese", txtAnyOfThese.Text.Trim());
			UpdateSearchDict("asst.txtNear", txtNear.Text.Trim());
			UpdateSearchDict("asst.txtNoneOfThese", txtNoneOfThese.Text.Trim());
			UpdateSearchDict("asst.txtInflection", txtInflection.Text.Trim());
			UpdateSearchDict("asst.txtMsThesuarus", txtMsThesuarus.Text.Trim());
			UpdateSearchDict("asst.txtEcmThesaurus", txtEcmThesaurus.Text.Trim());
			UpdateSearchDict("asst.cbAvailThesauri", cbAvailThesauri.Text.Trim());
			UpdateSearchDict("asst.cbSelectedThesauri", cbSelectedThesauri.Text.Trim());
			
			UpdateSearchDict("asst.cbDateRange", cbDateRange.Text.Trim());
			UpdateSearchDict("asst.dtStart", dtStart.SelectedDate.ToString());
			UpdateSearchDict("asst.dtEnd", dtEnd.SelectedDate.ToString());
			
		}
		
		public void UpdateSearchDict(string tKey, string tValue)
		{
			//If Not formLoaded Then
			//    Return
			//End If
			
			if (tKey.IndexOf("content.") + 1 == 0)
			{
				tKey = (string) ("content." + tKey);
			}
			
			if (GLOBALS.dictMasterSearch.ContainsKey(tKey))
			{
				GLOBALS.dictMasterSearch.Item(tKey) = tValue;
				SB.Text = tKey + " updated";
			}
			else
			{
				GLOBALS.dictMasterSearch.Add(tKey, tValue);
				SB.Text = tKey + " added";
			}
		}
		
		public void txtAllOfTheseWords_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtExactPhrase_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtAnyOfThese_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtNear_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtNoneOfThese_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtInflection_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtMsThesuarus_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void txtEcmThesaurus_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckPhrase_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckPhrase_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckNear_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckNear_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckNone_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckNone_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckInflection_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckInflection_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckClassonomy_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void ckClassonomy_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//GenerateSearchCriteria()
		}
		
		public void cbDateRange_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			SetCalendarWidgets();
		}
	}
	
}
