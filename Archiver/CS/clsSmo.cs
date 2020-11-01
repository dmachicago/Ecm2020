// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using Microsoft.SqlServer.Management.Smo;


namespace EcmArchiveClcSetup
{
	public class clsSmo
	{
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		
		//Public Sub smoLoadDatabases(ByVal ServerName , ByRef CB As Windows.Forms.ComboBox)
		
		//    Dim FoundDatabases As Boolean = False
		//    Dim i As Integer = 0
		//    CB.Items.Clear()
		//    Try
		//        Dim srv As New Server(ServerName)
		//        Dim db As Database
		//        For Each db In srv.Databases
		//            FoundDatabases = True
		//            'Trace.WriteLine(db.Name)
		//            'Trace.Indent()
		//            CB.Items.Add(db.Name)
		//            For Each tbl As Table In db.Tables
		//                Trace.WriteLine(tbl.Name)
		//            Next
		//            Trace.Unindent()
		//        Next
		//    Catch ex As Exception
		//        CB.Items.Clear()
		//        CB.Items.Add(ex.Message.Trim)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 777 : " + ex.Message)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 799 : " + ex.Message)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabases : 814 : " + ex.Message)
		//    End Try
		//    If FoundDatabases = False Then
		//        CB.Items.Add("FOUND NONE")
		//    End If
		//End Sub
		
		//Public Sub smoLoadDatabaseTables(ByVal ServerName , ByVal DatabaseName , ByVal UserID , ByVal PW , ByRef CB As Windows.Forms.ComboBox)
		
		//    Dim FoundDatabases As Boolean = False
		//    Dim i As Integer = 0
		//    CB.Items.Clear()
		//    Try
		//        Dim srv As New Server(".")
		//        Dim db As Database
		//        For Each db In srv.Databases
		//            FoundDatabases = True
		//            'Trace.WriteLine(db.Name)
		//            'Trace.Indent()
		//            If db.Name.Equals(DatabaseName ) Then
		//                For Each tbl As Table In db.Tables
		//                    Trace.WriteLine(tbl.Name)
		//                    CB.Items.Add(tbl.Name)
		//                Next
		//            End If
		//            'Trace.Unindent()
		//        Next
		//    Catch ex As Exception
		//        CB.Items.Clear()
		//        CB.Items.Add(ex.Message.Trim)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 797 : " + ex.Message)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 820 : " + ex.Message)
		//        log.WriteToArchiveLog("clsDma : smoLoadDatabaseTables : 836 : " + ex.Message)
		//    End Try
		//    If FoundDatabases = False Then
		//        CB.Items.Add("FOUND NONE")
		//    End If
		//End Sub
	}
	
}
