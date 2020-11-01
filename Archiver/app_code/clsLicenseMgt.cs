using System;
using System.Collections.Generic;
using global::System.Deployment.Application;
using System.Diagnostics;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsLicenseMgt : clsDatabaseARCH
    {
        private ECMEncrypt ENC = new ECMEncrypt();
        private bool localDebug = true;
        private clsDma DMA = new clsDma();
        // Dim DBARCH As New clsDatabaseARCH

        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsRemoteSupport RS = new clsRemoteSupport();

        public bool ParseLic(string S, bool ShowLicRules)
        {
            string tKey = "";
            string tVal = "";
            int I = 0;
            bool B = false;
            bool xTrv1 = true;
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                B = true;
                if (xTrv1)
                {
                    // For I = 0 To LicList.Count - 1
                    // Try
                    // If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                    // Catch ex As Exception
                    // Console.WriteLine(ex.Message)
                    // End Try
                    // Next I
                    string cbLicenseType = getEncryptedValue("cbLicenseType", modGlobals.LicList);
                    string cbState = getEncryptedValue("cbState", modGlobals.LicList);
                    string ckToClipboard = getEncryptedValue("ckToClipboard", modGlobals.LicList);
                    string ckToEmail = getEncryptedValue("ckToEmail", modGlobals.LicList);
                    string ckToFile = getEncryptedValue("ckToFile", modGlobals.LicList);
                    string dtExpire = getEncryptedValue("dtExpire", modGlobals.LicList);
                    string dtMaintExpire = getEncryptedValue("dtMaintExpire", modGlobals.LicList);
                    string EndOfLicense = getEncryptedValue("EndOfLicense", modGlobals.LicList);
                    string rbNbrOfSeats = getEncryptedValue("rbNbrOfSeats", modGlobals.LicList);
                    string rbNbrOfUsers = getEncryptedValue("rbNbrOfUsers", modGlobals.LicList);
                    string rbSimultaneousUsers = getEncryptedValue("rbSimultaneousUsers", modGlobals.LicList);
                    string rbStandardLicense = getEncryptedValue("rbStandardLicense", modGlobals.LicList);
                    string txtCity = getEncryptedValue("txtCity", modGlobals.LicList);
                    string txtCompanyResetID = getEncryptedValue("txtCompanyResetID", modGlobals.LicList);
                    string txtContactEmail = getEncryptedValue("txtContactEmail", modGlobals.LicList);
                    string txtContactName = getEncryptedValue("txtContactName", modGlobals.LicList);
                    string txtContactPhone = getEncryptedValue("txtContactPhone", modGlobals.LicList);
                    string txtCustAddr = getEncryptedValue("txtCustAddr", modGlobals.LicList);
                    string txtCustCountry = getEncryptedValue("txtCustCountry", modGlobals.LicList);
                    string txtCustID = getEncryptedValue("txtCustID", modGlobals.LicList);
                    string txtCustName = getEncryptedValue("txtCustName", modGlobals.LicList);
                    string txtLicenGenDate = getEncryptedValue("txtLicenGenDate", modGlobals.LicList);
                    // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    string txtNbrSeats = getEncryptedValue("txtNbrSeats", modGlobals.LicList);
                    string txtNbrSimlSeats = getEncryptedValue("txtNbrSimlSeats", modGlobals.LicList);
                    string txtVersionNbr = getEncryptedValue("txtVersionNbr", modGlobals.LicList);
                    string txtZip = getEncryptedValue("txtZip", modGlobals.LicList);
                    string Sdk = getEncryptedValue("ckSdk", modGlobals.LicList);
                    if (Sdk.Length == 0)
                    {
                        Sdk = "False";
                    }

                    string Lease = getEncryptedValue("ckLease", modGlobals.LicList);
                    if (Lease.Length == 0)
                    {
                        Lease = "False";
                    }

                    string MaxClients = getEncryptedValue("txtMaxClients", modGlobals.LicList);
                    if (ShowLicRules == true)
                    {
                        string Msg = "";
                        Msg = Msg + "License Type:" + cbLicenseType + Constants.vbCrLf;
                        Msg = Msg + "State: " + cbState + Constants.vbCrLf;
                        // Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                        // Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                        // Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                        Msg = Msg + "License Expires: " + dtExpire + Constants.vbCrLf;
                        Msg = Msg + "Maint Expires  : " + dtMaintExpire + Constants.vbCrLf;
                        // Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                        // Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                        // Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                        // Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                        // Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                        Msg = Msg + "City: " + txtCity + Constants.vbCrLf;
                        // Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                        Msg = Msg + "Contact Email: " + txtContactEmail + Constants.vbCrLf;
                        Msg = Msg + "Contact Name: " + txtContactName + Constants.vbCrLf;
                        Msg = Msg + "Contact Phone: " + txtContactPhone + Constants.vbCrLf;
                        Msg = Msg + "Cust Addr: " + txtCustAddr + Constants.vbCrLf;
                        Msg = Msg + "Cust Country: " + txtCustCountry + Constants.vbCrLf;
                        Msg = Msg + "Cust ID: " + txtCustID + Constants.vbCrLf;
                        Msg = Msg + "Cust Name: " + txtCustName + Constants.vbCrLf;
                        Msg = Msg + "License Gen Date: " + txtLicenGenDate + Constants.vbCrLf;
                        // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                        Msg = Msg + "Nbr Seats: " + txtNbrSeats + Constants.vbCrLf;
                        Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + Constants.vbCrLf;
                        Msg = Msg + "Version Nbr: " + txtVersionNbr + Constants.vbCrLf;
                        Msg = Msg + "Type License: " + cbLicenseType + Constants.vbCrLf;
                        Msg = Msg + "SDK: " + Sdk + Constants.vbCrLf;
                        Msg = Msg + "Lease: " + Lease + Constants.vbCrLf;
                        if (MaxClients.Equals("0"))
                        {
                            MaxClients = "Unlimited";
                        }

                        Msg = Msg + "MaxClients: " + MaxClients + Constants.vbCrLf;
                        // MaxClients
                        MessageBox.Show(Msg);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.1: failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                B = false;
                LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message);
            }

            return B;
        }

        public string ParseLicCompanyName(string S, bool ShowLicRules)
        {
            string tKey = "";
            string tVal = "";
            int I = 0;
            bool B = false;
            bool xTrv1 = true;
            string CoName = "";
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                B = true;
                if (xTrv1)
                {
                    // For I = 0 To LicList.Count - 1
                    // Try
                    // If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                    // Catch ex As Exception
                    // Console.WriteLine(ex.Message)
                    // End Try
                    // Next I
                    string cbState = getEncryptedValue("cbState", modGlobals.LicList);
                    string ckToClipboard = getEncryptedValue("ckToClipboard", modGlobals.LicList);
                    string ckToEmail = getEncryptedValue("ckToEmail", modGlobals.LicList);
                    string ckToFile = getEncryptedValue("ckToFile", modGlobals.LicList);
                    string dtExpire = getEncryptedValue("dtExpire", modGlobals.LicList);
                    string dtMaintExpire = getEncryptedValue("dtMaintExpire", modGlobals.LicList);
                    string EndOfLicense = getEncryptedValue("EndOfLicense", modGlobals.LicList);
                    string rbNbrOfSeats = getEncryptedValue("rbNbrOfSeats", modGlobals.LicList);
                    string rbNbrOfUsers = getEncryptedValue("rbNbrOfUsers", modGlobals.LicList);
                    string rbSimultaneousUsers = getEncryptedValue("rbSimultaneousUsers", modGlobals.LicList);
                    string rbStandardLicense = getEncryptedValue("rbStandardLicense", modGlobals.LicList);
                    string txtCity = getEncryptedValue("txtCity", modGlobals.LicList);
                    string txtCompanyResetID = getEncryptedValue("txtCompanyResetID", modGlobals.LicList);
                    string txtContactEmail = getEncryptedValue("txtContactEmail", modGlobals.LicList);
                    string txtContactName = getEncryptedValue("txtContactName", modGlobals.LicList);
                    string txtContactPhone = getEncryptedValue("txtContactPhone", modGlobals.LicList);
                    string txtCustAddr = getEncryptedValue("txtCustAddr", modGlobals.LicList);
                    string txtCustCountry = getEncryptedValue("txtCustCountry", modGlobals.LicList);
                    string txtCustID = getEncryptedValue("txtCustID", modGlobals.LicList);
                    string txtCustName = getEncryptedValue("txtCustName", modGlobals.LicList);
                    string txtLicenGenDate = getEncryptedValue("txtLicenGenDate", modGlobals.LicList);
                    // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    string txtNbrSeats = getEncryptedValue("txtNbrSeats", modGlobals.LicList);
                    string txtNbrSimlSeats = getEncryptedValue("txtNbrSimlSeats", modGlobals.LicList);
                    string txtVersionNbr = getEncryptedValue("txtVersionNbr", modGlobals.LicList);
                    string txtZip = getEncryptedValue("txtZip", modGlobals.LicList);
                    string cbLicenseType = getEncryptedValue("cbLicenseType", modGlobals.LicList);
                    if (ShowLicRules == true)
                    {
                        string Msg = "";
                        Msg = Msg + "State: " + cbState + Constants.vbCrLf;
                        // Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                        // Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                        // Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                        Msg = Msg + "License Expires: " + dtExpire + Constants.vbCrLf;
                        Msg = Msg + "Maint Expires  : " + dtMaintExpire + Constants.vbCrLf;
                        // Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                        // Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                        // Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                        // Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                        // Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                        Msg = Msg + "City: " + txtCity + Constants.vbCrLf;
                        // Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                        Msg = Msg + "Contact Email: " + txtContactEmail + Constants.vbCrLf;
                        Msg = Msg + "Contact Name: " + txtContactName + Constants.vbCrLf;
                        Msg = Msg + "Contact Phone: " + txtContactPhone + Constants.vbCrLf;
                        Msg = Msg + "Cust Addr: " + txtCustAddr + Constants.vbCrLf;
                        Msg = Msg + "Cust Country: " + txtCustCountry + Constants.vbCrLf;
                        Msg = Msg + "Cust ID: " + txtCustID + Constants.vbCrLf;
                        Msg = Msg + "Cust Name: " + txtCustName + Constants.vbCrLf;
                        Msg = Msg + "License Gen Date: " + txtLicenGenDate + Constants.vbCrLf;
                        // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                        Msg = Msg + "Nbr Seats: " + txtNbrSeats + Constants.vbCrLf;
                        Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + Constants.vbCrLf;
                        Msg = Msg + "Version Nbr: " + txtVersionNbr + Constants.vbCrLf;
                        // Msg = Msg + "Zip: " + txtZip  + vbCrLf
                        CoName = txtCustName;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.1: failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                CoName = "";
                LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message);
            }

            return CoName;
        }

        public string ParseLicCustomerID(string S, bool ShowLicRules)
        {
            string tKey = "";
            string tVal = "";
            int I = 0;
            bool B = false;
            bool xTrv1 = true;
            string CustID = "";
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                B = true;
                if (xTrv1)
                {
                    // For I = 0 To LicList.Count - 1
                    // Try
                    // If localDebug Then Console.WriteLine(I.ToString + " : " + LicList.Keys(I).ToString + " : " + LicList.Values(I))
                    // Catch ex As Exception
                    // Console.WriteLine(ex.Message)
                    // End Try
                    // Next I
                    string cbState = getEncryptedValue("cbState", modGlobals.LicList);
                    string ckToClipboard = getEncryptedValue("ckToClipboard", modGlobals.LicList);
                    string ckToEmail = getEncryptedValue("ckToEmail", modGlobals.LicList);
                    string ckToFile = getEncryptedValue("ckToFile", modGlobals.LicList);
                    string dtExpire = getEncryptedValue("dtExpire", modGlobals.LicList);
                    string dtMaintExpire = getEncryptedValue("dtMaintExpire", modGlobals.LicList);
                    string EndOfLicense = getEncryptedValue("EndOfLicense", modGlobals.LicList);
                    string rbNbrOfSeats = getEncryptedValue("rbNbrOfSeats", modGlobals.LicList);
                    string rbNbrOfUsers = getEncryptedValue("rbNbrOfUsers", modGlobals.LicList);
                    string rbSimultaneousUsers = getEncryptedValue("rbSimultaneousUsers", modGlobals.LicList);
                    string rbStandardLicense = getEncryptedValue("rbStandardLicense", modGlobals.LicList);
                    string txtCity = getEncryptedValue("txtCity", modGlobals.LicList);
                    string txtCompanyResetID = getEncryptedValue("txtCompanyResetID", modGlobals.LicList);
                    string txtContactEmail = getEncryptedValue("txtContactEmail", modGlobals.LicList);
                    string txtContactName = getEncryptedValue("txtContactName", modGlobals.LicList);
                    string txtContactPhone = getEncryptedValue("txtContactPhone", modGlobals.LicList);
                    string txtCustAddr = getEncryptedValue("txtCustAddr", modGlobals.LicList);
                    string txtCustCountry = getEncryptedValue("txtCustCountry", modGlobals.LicList);
                    string txtCustID = getEncryptedValue("txtCustID", modGlobals.LicList);
                    string txtCustName = getEncryptedValue("txtCustName", modGlobals.LicList);
                    string txtLicenGenDate = getEncryptedValue("txtLicenGenDate", modGlobals.LicList);
                    // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                    string txtNbrSeats = getEncryptedValue("txtNbrSeats", modGlobals.LicList);
                    string txtNbrSimlSeats = getEncryptedValue("txtNbrSimlSeats", modGlobals.LicList);
                    string txtVersionNbr = getEncryptedValue("txtVersionNbr", modGlobals.LicList);
                    string txtZip = getEncryptedValue("txtZip", modGlobals.LicList);
                    string cbLicenseType = getEncryptedValue("cbLicenseType", modGlobals.LicList);
                    if (ShowLicRules == true)
                    {
                        string Msg = "";
                        Msg = Msg + "State: " + cbState + Constants.vbCrLf;
                        // Msg = Msg + " ckToClipboard : " + ckToClipboard  + vbCrLf
                        // Msg = Msg + " ckToEmail : " + ckToEmail  + vbCrLf
                        // Msg = Msg + " ckToFile : " + ckToFile  + vbCrLf
                        Msg = Msg + "License Expires: " + dtExpire + Constants.vbCrLf;
                        Msg = Msg + "Maint Expires  : " + dtMaintExpire + Constants.vbCrLf;
                        // Msg = Msg + " EndOfLicense: " + EndOfLicense  + vbCrLf
                        // Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats  + vbCrLf
                        // Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers  + vbCrLf
                        // Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers  + vbCrLf
                        // Msg = Msg + " rbStandardLicense: " + rbStandardLicense  + vbCrLf
                        Msg = Msg + "City: " + txtCity + Constants.vbCrLf;
                        // Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID  + vbCrLf
                        Msg = Msg + "Contact Email: " + txtContactEmail + Constants.vbCrLf;
                        Msg = Msg + "Contact Name: " + txtContactName + Constants.vbCrLf;
                        Msg = Msg + "Contact Phone: " + txtContactPhone + Constants.vbCrLf;
                        Msg = Msg + "Cust Addr: " + txtCustAddr + Constants.vbCrLf;
                        Msg = Msg + "Cust Country: " + txtCustCountry + Constants.vbCrLf;
                        Msg = Msg + "Cust ID: " + txtCustID + Constants.vbCrLf;
                        Msg = Msg + "Cust Name: " + txtCustName + Constants.vbCrLf;
                        Msg = Msg + "License Gen Date: " + txtLicenGenDate + Constants.vbCrLf;
                        // Dim txtMstrPw  = getEncryptedValue("txtMstrPw", LicList)
                        Msg = Msg + "Nbr Seats: " + txtNbrSeats + Constants.vbCrLf;
                        Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats + Constants.vbCrLf;
                        Msg = Msg + "Version Nbr: " + txtVersionNbr + Constants.vbCrLf;
                        // Msg = Msg + "Zip: " + txtZip  + vbCrLf
                        CustID = txtCustID;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.1: failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                CustID = "";
                LOG.WriteToArchiveLog("clsLicenseMgt : ParseLic : 24 : " + ex.Message);
            }

            return CustID;
        }

        public string LicenseType()
        {
            string tKey = "cbLicenseType";
            string S = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            string tVal = "";
            // Dim I As Integer = 0
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                tVal = getEncryptedValue(tKey, modGlobals.LicList);
                if (tVal.ToUpper().Equals("ENTERPRISE"))
                {
                    tVal = "Roaming";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.1b: - LicenseType - failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("clsLicenseMgt : LicenseType : 24 : " + ex.Message);
            }

            return tVal;
        }

        public bool SdkLicenseExists()
        {
            bool B = false;
            string tKey = "ckSdk";
            string S = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            string tVal = "";
            int I = 0;
            bool xTrv1 = true;
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                B = true;
                tVal = getEncryptedValue(tKey, modGlobals.LicList);
                if (tVal.ToUpper().Equals("TRUE"))
                {
                    B = true;
                }
                else
                {
                    B = false;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.21a: SdkLicenseExists - failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                B = false;
                LOG.WriteToArchiveLog("clsLicenseMgt : SdkLicenseExists : 24 : " + ex.Message);
            }

            return B;
        }

        public bool isLease()
        {
            bool B = false;
            int dDebug = 1;
            string tKey = "ckLease";
            string S = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID, dDebug);
            string tVal = "";
            int I = 0;
            bool xTrv1 = true;
            int ix = 0;
            try
            {
                ix = 1;
                modGlobals.LicList = ENC.xt001trc(S, 1);
                ix = 2;
                B = true;
                ix = 3;
                tVal = getEncryptedValue(tKey, modGlobals.LicList, dDebug);
                ix = 14;
                if (tVal.Length == 0)
                {
                    ix = 5;
                    B = true;
                }
                else if (tVal.ToUpper().Equals("TRUE"))
                {
                    ix = 6;
                    B = true;
                }
                else
                {
                    ix = 7;
                    B = false;
                }

                ix = 8;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.11a: isLease - failed to Parse License.  IX=" + ix.ToString() + Constants.vbCrLf + Constants.vbCrLf + ex.Message + Constants.vbCrLf + "Customer Name: " + modGlobals.gCustomerName + Constants.vbCrLf + "Customer ID: " + modGlobals.gCustomerID + Constants.vbCrLf + "Step# " + ix.ToString());
                B = false;
                LOG.WriteToTraceLog("clsLicenseMgt : isLease : 24  IX = " + ix.ToString() + Constants.vbCrLf + ex.Message);
            }

            return B;
        }

        public int getMaxClients()
        {
            string tKey = "txtMaxClients";
            string S = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            string tVal = "";
            int I = 0;
            bool xTrv1 = true;
            try
            {
                modGlobals.LicList = ENC.xt001trc(S);
                tVal = getEncryptedValue(tKey, modGlobals.LicList);
                if (tVal.Length > 0)
                {
                    I = (int)Conversion.Val(tVal);
                }
                else
                {
                    I = 0;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.01a: isLease - failed to Parse License." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                I = 0;
                LOG.WriteToArchiveLog("clsLicenseMgt : isLease : 24 : " + ex.Message);
            }

            return I;
        }

        public string ParseLic(string S, string tKey)
        {
            int ll = 0;
            string tVal = "";
            int I = 0;
            bool B = false;
            bool xTrv1 = true;
            int dDebug = 1;
            try
            {
                ll = 1;
                modGlobals.LicList = ENC.xt001trc(S);
                ll = 2;
                B = true;
                ll = 3;
                tVal = getEncryptedValue(tKey, modGlobals.LicList, dDebug);
                ll = 4;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 53.25.1: failed to Parse License. LL=" + ll.ToString() + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                B = false;
                LOG.WriteToTraceLog("clsLicenseMgt : ParseLic : 24 : LL=" + ll.ToString() + Constants.vbCrLf + ex.Message);
            }

            return tVal;
        }

        public string getEncryptedValue(string iKey, SortedList<string, string> A, int dDebug = 0)
        {
            string tVal = "";
            int iDx = A.IndexOfKey(iKey);
            int ll = 0;
            try
            {
                if (iDx >= 0)
                {
                    ll = 1;
                    tVal = A.Values[iDx].ToString();
                }
                else
                {
                    ll = 2;
                    tVal = "";
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToTraceLog("getEncryptedValue 20: " + "LL=" + ll.ToString() + Constants.vbCrLf + ex.Message);
            }

            return tVal;
        }

        public bool ckExpirationDate()
        {
            bool B = false;
            string tDate = getEncryptedValue("dtExpire", modGlobals.LicList);
            if (tDate.Trim().Length > 0)
            {
                DateTime ExpireDate = Conversions.ToDate(getEncryptedValue("dtExpire", modGlobals.LicList));
                int iDays = DetermineNumberofDays(ExpireDate);
                if (iDays <= 0)
                {
                    MessageBox.Show("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.");
                    Debugger.Break();
                    B = false;
                }
                else if (iDays <= 2)
                {
                    MessageBox.Show("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString() + " days. Please contact ECM Library  Customer support for permemant licensing.");
                    B = true;
                }
                else if (iDays <= 7)
                {
                    MessageBox.Show("NOTICE: Your evaluation will expire in " + iDays.ToString() + " days. Please contact ECM Library  Customer support for permemant licensing.");
                    B = true;
                }
                else if (iDays <= 30)
                {
                    MessageBox.Show("Your evaluation will expire in " + iDays.ToString() + " days. Please contact ECM Library  Customer support for permemant licensing.");
                    B = true;
                }
                else
                {
                    B = true;
                }

                return true;
            }

            return default;
        }

        private int DetermineNumberofDays(DateTime ExpireDate)
        {
            var dtStartDate = DateAndTime.Now;
            TimeSpan tsTimeSpan;
            int iNumberOfDays;
            tsTimeSpan = ExpireDate.Subtract(DateAndTime.Now);
            iNumberOfDays = tsTimeSpan.Days;
            return iNumberOfDays;
        }

        /// This one validates a bit differently than most. When failue, it sends back a string with the
    /// failure. Otherwise, a null string is returned.
        public string ValidateLicense()
        {
            string LicenseMessage = "";
            string cbLicenseType = "";
            string CustomerID = "";
            string LicenseID = "";
            DateTime ExpirationDate;
            string RemoteServerKey = "";
            string LT = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            try
            {
                ExpirationDate = Conversions.ToDate(ParseLic(LT, "dtExpire"));
                if (DateAndTime.Now > ExpirationDate)
                {
                    LicenseMessage += "We are very sorry to inform you, but your maintenance agreement has expired." + " Please contact ECM Library support.";
                    LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.");
                    return LicenseMessage;
                }

                CustomerID = ParseLic(LT, "txtCustID");
                LicenseID = ParseLic(LT, "txtVersionNbr");
                cbLicenseType = Conversion.Val(ParseLic(cbLicenseType, "cbLicenseType")).ToString();
                modGlobals.gLicenseType = cbLicenseType;
                string CurrentServer = getServerInstanceName();
                string LicensedServer = getServerIdentifier(CustomerID, LicenseID);
                if (LicensedServer.Length == 0)
                {
                    RemoteServerKey = RS.getClientLicenseServer(CustomerID, LicenseID);
                    if (RemoteServerKey.Trim().Length > 0 & RemoteServerKey.Equals("ECMNEWXX"))
                    {
                        // ** It needs to be defined to the remote system and to the new
                        bool BB = setServerIdentifier(CurrentServer, CustomerID, LicenseID);
                        if (!BB)
                        {
                            MessageBox.Show("Error 721.32a - Failed to set the server credentials to that of the specified server '" + CurrentServer + "'.");
                            return Conversions.ToString(false);
                        }

                        BB = RS.setClientLicenseServer(CustomerID, LicenseID, CurrentServer);
                        if (!BB)
                        {
                            MessageBox.Show("Error  721.32b - Failed to set the remote server credentials to that of the specified server '" + CurrentServer + "'.");
                            return Conversions.ToString(false);
                        }

                        return Conversions.ToString(true);
                    }
                    else if (RemoteServerKey.Trim().Length > 0)
                    {
                        if (RemoteServerKey.Equals(CurrentServer))
                        {
                            // ** Add the Server
                            bool BB = setServerIdentifier(CurrentServer, CustomerID, LicenseID);
                            return Conversions.ToString(true);
                        }
                        else
                        {
                            // ** Issue an error.
                            return Conversions.ToString(false);
                        }
                    }
                }
                else if (CurrentServer.Equals(LicensedServer))
                {
                    modGlobals.gValidated = true;
                    return "";
                }
                else
                {
                    LicenseMessage += "We are very sorry to inform you, but your license could not be validated." + Constants.vbCrLf + " Please contact ECM Library support or your administrator.";
                    LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.");
                    modGlobals.gValidated = false;
                    return LicenseMessage;
                }
            }
            catch (Exception ex)
            {
                LicenseMessage = "666.666 Unrecoverable Error 001: Failed to validate license, closing down.";
            }

            return LicenseMessage;
        }

        public bool isLicenseLocatedOnAssignedMachine(ref string ServerValText, ref string InstanceValText)
        {
            string LT = GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            string LicensedMachineName = ParseLic(LT, "txtServerName");
            string HostServerName = getServerMachineName();
            bool B = true;
            string SqlInstanceName = ParseLic(LT, "txtSSINstance");
            string currSqlInstanceName = getServerInstanceName();
            if (LicensedMachineName.ToUpper().Equals(HostServerName.ToUpper()))
            {
                ServerValText = ":Server Validated";
            }
            else
            {
                ServerValText = "WARNING: Server Name";
                B = false;
            }

            if (SqlInstanceName.ToUpper().Equals(currSqlInstanceName.ToUpper()))
            {
                InstanceValText += ":SQL Instance Validated";
            }
            else
            {
                InstanceValText += "WARNING: SQL Instance Name";
                B = false;
            }

            return B;
        }

        public int getMaintExpireDate()
        {
            object NumberOfDaysTillExpire;
            bool B = false;
            string tDate = getEncryptedValue("dtMaintExpire", modGlobals.LicList);
            if (tDate.Trim().Length > 0)
            {
                DateTime ExpireDate = Conversions.ToDate(tDate);
                NumberOfDaysTillExpire = DetermineNumberofDays(ExpireDate);
                // If iDays <= 0 Then
                // messagebox.show("IT'S OVER: Your evaluation has expired. Please contact ECM Library  Customer support for permemant licensing.")
                // ElseIf iDays <= 2 Then
                // messagebox.show("NOTICE NOTICE NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                // ElseIf iDays <= 7 Then
                // messagebox.show("NOTICE: Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                // ElseIf iDays <= 30 Then
                // messagebox.show("Your evaluation will expire in " + iDays.ToString + " days. Please contact ECM Library  Customer support for permemant licensing.")
                // Else
                // B = True
                // End If
                return Conversions.ToInteger(NumberOfDaysTillExpire);
            }

            return default;
        }

        // Create a new Windows Forms application using your preferred command-line or visual tools.
        // Create whatever button, menu item, or other user interface item you want your users to select to check for updates.
        // From that item's event handler, call the following method to check for and install updates.
        public bool isSoftwareUnderMaint()
        {
            var CurrDate = DateAndTime.Now;
            UpdateCheckInfo info = null;
            int NbrOfMaintDaysLeft = getMaintExpireDate();
            LOG.WriteToArchiveLog("Click Once #Days before Maint Expires = " + NbrOfMaintDaysLeft.ToString());
            if (NbrOfMaintDaysLeft > 1 & NbrOfMaintDaysLeft < 10)
            {
                MessageBox.Show("Your maintenance will expire within the next 10 days - no further updates after that. Please renew your maintenance subscription.");
            }

            if (NbrOfMaintDaysLeft < 1)
            {
                MessageBox.Show("Your maintenance has expired - no further updates after that. Please renew your maintenance subscription.");
                return false;
            }

            LOG.WriteToArchiveLog("Click Once update = " + ApplicationDeployment.IsNetworkDeployed.ToString());
            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var AD = ApplicationDeployment.CurrentDeployment;
                try
                {
                    info = AD.CheckForDetailedUpdate();
                }
                catch (DeploymentDownloadException dde)
                {
                    MessageBox.Show("The new version of the application cannot be downloaded at this time. " + Conversions.ToString(ControlChars.Lf) + ControlChars.Lf + "Please check your network connection, or try again later. Error: " + dde.Message);
                    return true;
                }
                catch (InvalidOperationException ioe)
                {
                    MessageBox.Show("This application cannot be updated. It is likely not a ClickOnce application. Error: " + ioe.Message);
                    return true;
                }

                if (info.UpdateAvailable)
                {
                    bool doUpdate = true;
                    if (!info.IsUpdateRequired)
                    {
                        var dr = MessageBox.Show("An update is available. Would you like to update the application now?", "Update Available", MessageBoxButtons.OKCancel);
                        if (!(DialogResult.OK == dr))
                        {
                            doUpdate = false;
                        }
                    }
                    else
                    {
                        // Display a message that the app MUST reboot. Display the minimum required version.
                        MessageBox.Show("This application has detected a mandatory update from your current " + "version to version " + info.MinimumRequiredVersion.ToString() + ". The application will now install the update and restart.", "Update Available", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }

                    if (doUpdate)
                    {
                        try
                        {
                            AD.Update();
                            MessageBox.Show("The application has been upgraded, please restart.");
                        }
                        // Application.Restart()
                        catch (DeploymentDownloadException dde)
                        {
                            MessageBox.Show("Cannot install the latest version of the application. " + ControlChars.Lf + ControlChars.Lf + "Please check your network connection, or try again later.");
                            return true;
                        }
                    }
                }
            }

            return default;
        }
    }
}