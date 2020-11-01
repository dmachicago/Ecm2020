using System;
using System.Collections;
using System.Diagnostics;
using System.Windows.Forms;
using global::Microsoft.Office.Interop.Excel;
using global::Microsoft.Office.Interop.Word;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsMsWord
    {
        private clsATTRIBUTES ATTR = new clsATTRIBUTES();
        private clsSOURCEATTRIBUTE sAttr = new clsSOURCEATTRIBUTE();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private bool ddebug = false;
        private clsValidateCodes DFLT = new clsValidateCodes();
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private int Office2007 = 1;

        /// Captures the metadata embedded within a word document for both 2003 and 2007
        public void getWordDocMetaData(string FQN)
        {
            Microsoft.Office.Interop.Word.Application oWord;
            Document oDoc;
            object oBuiltInProps = null;

            // Dim oProp As DocumentProperty
            object oCustomProps = null;

            // Start Word and open the document template.
            oWord = new Microsoft.Office.Interop.Word.Application();
            oWord.Visible = true;
            // oDoc = oWord.Documents.Add
            object argFileName = FQN;
            oDoc = oWord.Documents.Open(ref argFileName);
            try
            {
                // Get the Built-in Document Properties collection.
                oBuiltInProps = oDoc.BuiltInDocumentProperties;
                string strValue = "";
                // Dim Prop As DocumentProperty
                object Prop;
                foreach (var oProp in (IEnumerable)oDoc.BuiltInDocumentProperties)
                {
                    Debug.Print(Conversions.ToString(Operators.ConcatenateObject(oProp.Name, " = ")));
                    Debug.Print(Conversions.ToString(oProp.Value));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 8273.1 : Could not open document '" + FQN + "'" + Microsoft.VisualBasic.Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("clsMsWord : getMetaData : 17 : " + ex.Message);
            }
        }

        public void initWordDocMetaData(string FQN, string DocGuid, string OriginalFileType)
        {
            string fName = DMA.getFileName(FQN);
            if (fName.Trim().Length > 0)
            {
                if (Strings.Mid(fName, 1, 1) == "~")
                {
                    LOG.WriteToArchiveLog("initWordDocMetaData: " + fName + ", appears to be a temp file - no metadata available.");
                    return;
                }
            }

            bool bExit = false;
            string SS = "";
            bool B = false;

            // ** Dale Added this 7/14/2009 to stop deletion of already existing metadata.
            bool DoThis = false;
            if (DoThis == true)
            {
                SS = "delete FROM [SourceAttribute] where [SourceGuid] = '" + DocGuid + "'";
                B = DBARCH.ExecuteSqlNewConn(SS, false);
            }

            Microsoft.Office.Interop.Word.Application oWord;
            Document oDoc;
            object oBuiltInProps = null;
            object oCustomProps = null;
            try
            {
                // Dim oProp As DocumentProperty
                // Start Word and open the document template.
                oWord = (Microsoft.Office.Interop.Word.Application)Interaction.CreateObject("Word.Application");
                oWord.Visible = false;
                // oDoc = oWord.Documents.Add
                object argFileName = FQN;
                oDoc = oWord.Documents.Open(ref argFileName);
                if (ddebug)
                    Debug.Print(oDoc.FullName);
                // Make the application invisible
                oWord.Visible = false;
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Debug.Print("Error 23977.1 : ABORT - Document Issue: '" + FQN + "'" + Microsoft.VisualBasic.Constants.vbCrLf + ex.Message);
                DBARCH.xTrace(23977, SS, "Error 23977 : Could not process WORD document '" + FQN + "'" + Microsoft.VisualBasic.Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 32 : " + ex.Message + Microsoft.VisualBasic.Constants.vbCrLf + FQN);
                return;
            }

            try
            {
                // Get the Built-in Document Properties collection.            
                oBuiltInProps = oDoc.BuiltInDocumentProperties;
                string strValue = Conversions.ToString(oBuiltInProps.Item("Author").Value);
                if (ddebug)
                    Debug.Print(strValue);
                strValue = Conversions.ToString(oBuiltInProps.Item("Subject").Value);
                if (ddebug)
                    Debug.Print(strValue);
                strValue = Conversions.ToString(oBuiltInProps.Item((object)2).Value);
                if (ddebug)
                    Debug.Print(strValue);

                // For Each O As Object In oBuiltInProps
                // Try
                // Console.WriteLine(O.name + " : " + O.value.ToString)
                // Catch ex As Exception
                // Console.WriteLine(ex.Message)
                // End Try
                // Next

                for (int i = 1; i <= 34; i++)
                {
                    try
                    {
                        string strValue2 = "";
                        if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(oBuiltInProps.Item(i).name, null, false)))
                        {
                            strValue = "";
                        }
                        else
                        {
                            strValue = Conversions.ToString(oBuiltInProps.Item(i).name);
                        }

                        if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(oBuiltInProps.Item(i).Value, null, false)))
                        {
                            strValue2 = "";
                        }
                        else
                        {
                            strValue2 = oBuiltInProps.Item(i).Value.ToString();
                        }

                        if (ddebug)
                            Console.WriteLine(i.ToString() + " : " + strValue + ":" + strValue2);
                        if (strValue.Length > 0 & strValue2.Length > 0)
                        {
                            sAttr.setAttributename(ref strValue);
                            sAttr.setAttributevalue(ref strValue2);
                            sAttr.setSourceguid(ref DocGuid);
                            sAttr.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                            sAttr.setSourcetypecode(ref OriginalFileType);
                            bool bb = DBARCH.ItemExists("Attributes", "AttributeName", strValue, "C");
                            if (bb == false)
                            {
                                DFLT.addDefaultAttributes(strValue, "", "Auto added: initWordDocMetaData", "MS Word");
                            }

                            int iCnt = sAttr.cnt_PK35(strValue, modGlobals.gCurrUserGuidID, DocGuid);
                            if (iCnt > 0)
                            {
                                string WC = sAttr.wc_PK35(strValue, modGlobals.gCurrUserGuidID, DocGuid);
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
                            Console.WriteLine("Error 23977.1 : " + strValue + " : " + ex.Message);
                        // DBARCH.xTrace(23946, "Error 23977.1 : ABORT - Document Issue.", "Failed to add Metedata for: " + FQN, ex)
                        // log.WriteToArchiveLog("clsMsWord : initWordDocMetaData : 58 : " + ex.Message)
                    }
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Debug.Print("Error 8273.1 : Could not open document '" + FQN + "'" + Microsoft.VisualBasic.Constants.vbCrLf + ex.Message);
                DBARCH.xTrace(23947, "InitWordDocMetaData", "ABORT - Document Issue: Could not open document '" + FQN + "' : " + ex.Message.ToString());
            }
            finally
            {
                try
                {
                    // oDoc.Application.Quit(False, Nothing, Nothing)
                    object argSaveChanges = false;
                    object argOriginalFormat = null;
                    object argRouteDocument = null;
                    oDoc.Close(ref argSaveChanges, ref argOriginalFormat, ref argRouteDocument);
                }
                catch (Exception ex)
                {
                    Debug.Print(ex.Message);
                    LOG.WriteToArchiveLog("ERROR: clsMsWord : initWordDocMetaData : 65a : " + ex.Message);
                }

                try
                {
                    object argSaveChanges1 = false;
                    object argOriginalFormat1 = null;
                    object argRouteDocument1 = null;
                    oWord.Application.Quit(ref argSaveChanges1, ref argOriginalFormat1, ref argRouteDocument1);
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
            // Open the workbook\

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
            // Dim oExcelApp As New Excel.Application 'remove this, you're setting them to nothing= New Excel.Application
            var oExcelApp = new Microsoft.Office.Interop.Excel.Application(); // remove this, you're setting them to nothing= New Excel.Application
            LL = 2;
            // Dim oWorkbook As New Microsoft.Office.Interop.Excel.Workbook 'remove this, you're setting them to nothing= Nothing
            Workbook oWorkbook; // remove this, you're setting them to nothing= Nothing
            LL = 3;
            object oBuiltInProps = null;
            LL = 4;
            try
            {
                string strValue = "";

                // #If Office2007 Then
                oWorkbook = oExcelApp.Workbooks.Open(FQN, ReadOnly: false);
                LL = 5;
                oBuiltInProps = oWorkbook.BuiltinDocumentProperties;
                int II = 34;
                for (int i = 1, loopTo = II; i <= loopTo; i++)
                {
                    try
                    {
                        LL = 6;
                        string strValue2 = "";
                        if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(oBuiltInProps.item(i).name, null, false)))
                        {
                            strValue = "";
                        }
                        else
                        {
                            strValue = oBuiltInProps.Item(i).name.ToString();
                        }

                        if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(oBuiltInProps.Item(i).Value, null, false)))
                        {
                            strValue2 = "";
                        }
                        else
                        {
                            strValue2 = oBuiltInProps.Item(i).Value.ToString();
                        }

                        if (ddebug)
                            Debug.Print(i.ToString() + ":" + strValue + ":" + strValue2);
                        LL = 7;
                        if (strValue.Length > 0 & strValue2.Length > 0)
                        {
                            sAttr.setAttributename(ref strValue);
                            sAttr.setAttributevalue(ref strValue2);
                            sAttr.setSourceguid(ref DocGuid);
                            sAttr.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                            sAttr.setSourcetypecode(ref OriginalFileType);
                            LL = 8;
                            int iCnt = sAttr.cnt_PK35(strValue, modGlobals.gCurrUserGuidID, DocGuid);
                            LL = 9;
                            if (iCnt == 0)
                            {
                                sAttr.Insert();
                            }
                            else
                            {
                                string WC = sAttr.wc_PK35(strValue, modGlobals.gCurrUserGuidID, DocGuid);
                                sAttr.Update(WC);
                            }
                        }

                        LL = 10;
                    }
                    catch (Exception ex)
                    {
                        // If ddebug Then

                        // End If
                        Console.WriteLine("NOTICE 23988.1 : ABORT - Document Issue: '" + FQN + "'" + Microsoft.VisualBasic.Constants.vbCrLf + ex.Message);
                        // Return
                    }
                }

                if (oBuiltInProps is object)
                {
                    oBuiltInProps = null;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTIFICATION: clsMsWord : initExcelMetaData : 94 -No metadata available- : LL = " + LL.ToString() + " : " + FQN + " :ErrMsg- " + ex.Message + Microsoft.VisualBasic.Constants.vbCrLf + FQN);
            }
            finally
            {
                oExcelApp.Application.Quit();
                oExcelApp.Quit();
                oExcelApp = null;
                Process PP;
                // For Each PP In Process.GetProcesses
                // Console.WriteLine(PP)
                // Next
                foreach (var RunningProcess in Process.GetProcessesByName("Excel"))
                    RunningProcess.Kill();
            }
        }

        public void listProps(string FQN)
        {
            if (Office2007 == 1)
            {
                Microsoft.Office.Interop.Word.Application oWord;
                Document oDoc;
                object oBuiltInProps;
                object oCustomProps;
                // Dim oProp As Object
                string strValue;


                // Create an instance of Word and make it visible.
                oWord = (Microsoft.Office.Interop.Word.Application)Interaction.CreateObject("Word.Application");
                oWord.Visible = true;
                // Create a new document
                object argFileName = FQN;
                oDoc = oWord.Documents.Open(ref argFileName);


                // Get the Built-in Document Properties collection.
                oBuiltInProps = oDoc.BuiltInDocumentProperties;
                // Get the value of the Author property and display it
                strValue = Conversions.ToString(oBuiltInProps.Item("Author").Value);
                MessageBox.Show("The author of this document is " + strValue);


                // Set the value of the Subject property.
                strValue = Conversions.ToString(oBuiltInProps.Item("Subject").Value);


                // Get the Custom Document Properties collection.
                // oCustomProps = oDoc.CustomDocumentProperties


                // Display a message box to give the user a chance to verify the
                // properties.
                Interaction.MsgBox("Select Properties from the File menu " + "to view the changes." + '\n' + "Select the Summary tab to view " + "the Subject and the Custom tab to view the Custom " + "properties.", MsgBoxStyle.Information, "Check File Properties");






                // Clean up. We'll leave Word running.
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
}