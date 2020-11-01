using System.Runtime.InteropServices;
using Microsoft.Office.Interop.Word;
using Microsoft.Office.Interop;
using Microsoft.Office.Interop.Excel;
using System.Windows.Forms;
using EcmArchiveClcSetup;

public class clsMsWord
{
    clsATTRIBUTES ATTR = new clsATTRIBUTES();
    clsSOURCEATTRIBUTE sAttr = new clsSOURCEATTRIBUTE();
    clsDatabase DB = new clsDatabase();
    bool ddebug = false;
    clsValidateCodes DFLT = new clsValidateCodes();
    clsDma DMA = new clsDma();
    clsLogging LOG = new clsLogging();
    clsUtility UTIL = new clsUtility();
    int Office2007 = 1;

    /// Captures the metadata embedded within a word document for both 2003 and 2007
    public void getWordDocMetaData(string FQN)
    {


        Microsoft.Office.Interop.Word.Application oWord;
        Microsoft.Office.Interop.Word.Document oDoc;
        object oBuiltInProps = null;
        object oCustomProps = null;

        //Dim oProp As DocumentProperty


        //Start Word and open the document template.
        oWord = new Microsoft.Office.Interop.Word.Application();
        oWord.Visible = true;
        //oDoc = oWord.Documents.Add
        oDoc = oWord.Documents.Open(FQN);

        try
        {
            //Get the Built-in Document Properties collection.
            oBuiltInProps = oDoc.BuiltInDocumentProperties;            
            string strValue = "";
            //Dim Prop As DocumentProperty            
            foreach (object oProp in oDoc.BuiltInDocumentProperties)
            {                
                console.writeline(oProp.Name + " = ");
                Console.writeline(oProp.Value);
            }
        }
        catch (System.Exception ex)
        {
            MessageBox.Show("Error 8273.1 : Could not open document \'" + FQN + "\'" + "\r\n" + ex.Message);
            LOG.WriteToArchiveLog("clsMsWord : getMetaData : 17 : " + ex.Message);
        }
    }
    public void initWordDocMetaData(string FQN, string DocGuid, string OriginalFileType)
    {

        string fName = (string)(DMA.getFileName(FQN));

        if (fName.Trim().Length > 0)
        {
            if (fName.Substring(0, 1) == "~")
            {
                LOG.WriteToArchiveLog("initWordDocMetaData: " + fName + ", appears to be a temp file - no metadata available.");
                return;
            }
        }

        bool bExit = false;
        string SS = "";
        bool B = false;

        //** Dale Added this 7/14/2009 to stop deletion of already existing metadata.
        bool DoThis = false;
        if (DoThis == true)
        {
            SS = "delete FROM [SourceAttribute] where [SourceGuid] = \'" + DocGuid + "\'";
            B = System.Convert.ToBoolean(DB.ExecuteSqlNewConn(SS, false));
        }

        Microsoft.Office.Interop.Word.Application oWord;
        Microsoft.Office.Interop.Word.Document oDoc;
        object oBuiltInProps = null;
        object oCustomProps = null;

        try
        {
            //Dim oProp As DocumentProperty
            //Start Word and open the document template.
            oWord = new Microsoft.Office.Interop.Word.Application();
            oWord.Visible = false;
            //oDoc = oWord.Documents.Add
            oDoc = oWord.Documents.Open(FQN);
            //Make the application invisible
            oWord.Visible = false;
        }
        catch (System.Exception ex)
        {
            DB.xTrace(23977, SS, "Error 23977 : Could not process WORD document \'" + FQN, ex);
            LOG.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 32 : " + ex.Message + "\r\n" + FQN);
            return;
        }


        try
        {
            //Get the Built-in Document Properties collection.
            oBuiltInProps = oDoc.BuiltInDocumentProperties;
            string strValue = (string)(oBuiltInProps.Item("Author").Value);
            if (ddebug)
            {
                Debug.Print(strValue);
            }
            strValue = (string)(oBuiltInProps.Item("Subject").Value);
            if (ddebug)
            {
                Debug.Print(strValue);
            }
            strValue = (string)(oBuiltInProps.Item(2).Value);
            if (ddebug)
            {
                Debug.Print(strValue);
            }

            //For Each O As Object In oBuiltInProps
            //    Try
            //        Console.WriteLine(O.name + " : " + O.value.ToString)
            //    Catch ex As Exception
            //        Console.WriteLine(ex.Message)
            //    End Try
            //Next

            for (int i = 1; i <= 34; i++)
            {

                try
                {
                    string strValue2 = "";
                    if (oBuiltInProps.Item(i).name == null)
                    {
                        strValue = "";
                    }
                    else
                    {
                        strValue = (string)(oBuiltInProps.Item(i).name);
                    }

                    if (oBuiltInProps.Item(i).Value == null)
                    {
                        strValue2 = "";
                    }
                    else
                    {
                        strValue2 = (string)(oBuiltInProps.Item(i).Value.ToString());
                    }

                    if (ddebug)
                    {
                        Console.WriteLine(i.ToString() + " : " + strValue + ":" + strValue2);
                    }
                    if (strValue.Length > 0 && strValue2.Length > 0)
                    {
                        sAttr.setAttributename(strValue);
                        sAttr.setAttributevalue(strValue2);
                        sAttr.setSourceguid(DocGuid);
                        sAttr.setDatasourceowneruserid(gCurrUserGuidID);
                        sAttr.setSourcetypecode(OriginalFileType);
                        bool bb = System.Convert.ToBoolean(DB.ItemExists("Attributes", "AttributeName", strValue, "C"));
                        if (bb == false)
                        {
                            DFLT.addDefaultAttributes(strValue, "", "Auto added: initWordDocMetaData", "MS Word");
                        }
                        int iCnt = System.Convert.ToInt32(sAttr.cnt_PK35(strValue, gCurrUserGuidID, DocGuid));
                        if (iCnt > 0)
                        {
                            string WC = (string)(sAttr.wc_PK35(strValue, gCurrUserGuidID, DocGuid));
                            sAttr.Update(WC);
                        }
                        else
                        {
                            sAttr.Insert();
                        }

                    }
                }
                catch (Exception ex)
                {
                    if (ddebug)
                    {
                        Console.WriteLine("Error 23977.1 : " + strValue + " : " + ex.Message);
                    }
                    //DB.xTrace(23946, "Error 23977.1 : ABORT - Document Issue.", "Failed to add Metedata for: " + FQN, ex)
                    //log.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 58 : " + ex.Message)
                }
            }


        }
        catch (Exception ex)
        {
            if (ddebug)
            {
                Debug.Print("Error 8273.1 : Could not open document \'" + FQN + "\'" + "\r\n" + ex.Message);
            }
            DB.xTrace(23947, "Error 23977.1 : ABORT - Document Issue.", "Error 8273.1 : Could not open document \'" + FQN, ex);
        }
        finally
        {
            try
            {
                //oDoc.Application.Quit(False, Nothing, Nothing)
                oDoc.Close(false, null, null);
            }
            catch (Exception ex)
            {
                Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("ERROR: clsMsWord : initWordDocMetaData : 65a : " + ex.Message);
            }

            try
            {
                oWord.Application.Quit(false, null, null);
                oWord = null;
                oCustomProps = null;
                oBuiltInProps = null;
                oDoc = null;
                oWord = null;
            }
            catch (Exception ex)
            {
                Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("ERROR: clsMsWord : initWordDocMetaData : 65b : " + ex.Message);
            }

        }


    }
    public void initExcelMetaData(string FQN, string DocGuid, string OriginalFileType)
	{
		//Open the workbook\
		
		if (Office2007 == 0)
		{
		}
		else
		{
			LOG.WriteToArchiveLog("WARNING: METADATA CAPTURE DOES NOT WORK IN OFFICE 2003: " + FQN);
			return;
		}
		
		int LL = 0;
		LL = 1;
		//Dim oExcelApp As New Excel.Application 'remove this, you're setting them to nothing= New Excel.Application
		Excel.Application oExcelApp = new Excel.Application(); //remove this, you're setting them to nothing= New Excel.Application
		LL = 2;
		//Dim oWorkbook As New Microsoft.Office.Interop.Excel.Workbook 'remove this, you're setting them to nothing= Nothing
		Microsoft.Office.Interop.Excel.Workbook oWorkbook; //remove this, you're setting them to nothing= Nothing
		LL = 3;
		object oBuiltInProps = null;
		LL = 4;
		
		try
		{
			
			string strValue = "";
			
			//#If Office2007 Then
			oWorkbook = oExcelApp.Workbooks.Open(FQN,, false);
			LL = 5;
			oBuiltInProps = oWorkbook.BuiltinDocumentProperties;
			int II = 34;
			
			for (int i = 1; i <= II; i++)
			{
				try
				{
					LL = 6;
					string strValue2 = "";
					if (oBuiltInProps.item(i).name == null)
					{
						strValue = "";
					}
					else
					{
						strValue = (string) (oBuiltInProps.Item(i).name.ToString());
					}
					
					if (oBuiltInProps.Item(i).Value == null)
					{
						strValue2 = "";
					}
					else
					{
						strValue2 = (string) (oBuiltInProps.Item(i).Value.ToString());
					}
					if (ddebug)
					{
						Debug.Print(i.ToString() + ":" + strValue + ":" + strValue2);
					}
					LL = 7;
					if (strValue.Length > 0 && strValue2.Length > 0)
					{
						sAttr.setAttributename(strValue);
						sAttr.setAttributevalue(strValue2);
						sAttr.setSourceguid(DocGuid);
						sAttr.setDatasourceowneruserid(gCurrUserGuidID);
						sAttr.setSourcetypecode(OriginalFileType);
						LL = 8;
						int iCnt = System.Convert.ToInt32(sAttr.cnt_PK35(strValue, gCurrUserGuidID, DocGuid));
						LL = 9;
						if (iCnt == 0)
						{
							sAttr.Insert();
						}
						else
						{
							string WC = (string) (sAttr.wc_PK35(strValue, gCurrUserGuidID, DocGuid));
							sAttr.Update(WC);
						}
					}
					LL = 10;
				}
				catch (Exception ex)
				{
					//If ddebug Then
					
					//End If
					Console.WriteLine("NOTICE 23988.1 : ABORT - Document Issue: \'" + FQN + "\'" + "\r\n" + ex.Message);
					//Return
				}
				
			}
			if (oBuiltInProps != null)
			{
				oBuiltInProps = null;
			}
		}
		catch (Exception ex)
		{
			LOG.WriteToArchiveLog("NOTIFICATION: clsMsWord : initExcelMetaData : 94 -No metadata available- : LL = " + LL.ToString() + " : " + FQN + " :ErrMsg- " + ex.Message + "\r\n" + FQN);
		}
		finally
		{
			oExcelApp.Application.Quit();
			oExcelApp.Quit();
			oExcelApp = null;
			Process PP;
			//For Each PP In Process.GetProcesses
			//    Console.WriteLine(PP)
			//Next
			foreach (var RunningProcess in Process.GetProcessesByName("Excel"))
			{
				RunningProcess.Kill();
			}
		}
	}
    public void listProps(string FQN)
    {
        if (Office2007 == 1)
        {
            Microsoft.Office.Interop.Word.Application oWord;
            Microsoft.Office.Interop.Word.Document oDoc;
            object oBuiltInProps;
            object oCustomProps;
            //Dim oProp As Object
            string strValue;


            //Create an instance of Word and make it visible.
            oWord = CreateObject("Word.Application");
            oWord.Visible = true;
            //Create a new document
            oDoc = oWord.Documents.Open(FQN);


            //Get the Built-in Document Properties collection.
            oBuiltInProps = oDoc.BuiltInDocumentProperties;
            //Get the value of the Author property and display it
            strValue = (string)(oBuiltInProps.Item("Author").Value);
            MessageBox.Show("The author of this document is " + strValue);


            //Set the value of the Subject property.
            strValue = (string)(oBuiltInProps.Item("Subject").Value);


            //Get the Custom Document Properties collection.
            //oCustomProps = oDoc.CustomDocumentProperties


            //Display a message box to give the user a chance to verify the
            //properties.
            MsgBox("Select Properties from the File menu " + "to view the changes." + '\n' + "Select the Summary tab to view " + "the Subject and the Custom tab to view the Custom " + "properties.", MsgBoxStyle.Information, "Check File Properties");


            //Clean up. We'll leave Word running.
            oCustomProps = null;
            oBuiltInProps = null;
            oDoc = null;
            oWord = null;
        }
        else
        {
            LOG.WriteToArchiveLog("WARNING: OBJECT PROPERTIES DO NOT WORK IN OFFICE 2003.");
        }
    }
}