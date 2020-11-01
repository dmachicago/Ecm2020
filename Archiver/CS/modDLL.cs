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

using System.Runtime.InteropServices;

//Imports Microsoft.Win32
//Imports Microsoft.VisualBasic

namespace EcmArchiveClcSetup
{
	sealed class modDLL
	{
		//Constants
		private const int FORMAT_MESSAGE_FROM_SYSTEM = 0x1000;
		private const int MAX_MESSAGE_LENGTH = 512;
		
		//API declarations
		[DllImport("kernel32",EntryPoint="LoadLibraryA", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long LoadLibrary(string lpLibFileName);
		[DllImport("kernel32", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long FreeLibrary(long hLibModule);
		
		static public bool ckDLLAvailable(string DllFilename)
		{
			long hModule;
			// attempt to load the module
			hModule = LoadLibrary(DllFilename);
			if (hModule > 32)
			{
				try
				{
					FreeLibrary(hModule); // decrement the DLL usage counter
				}
				catch (Exception)
				{
					FreeLibrary(hModule); // decrement the DLL usage counter
				}
				return true;
			}
			return false;
		}
		
		static public bool IsDLLAvailable(string DllFilename)
		{
			bool returnValue;
			long hModule;
			
			hModule = LoadLibrary(DllFilename); //attempt to load DLL
			if (hModule > 32)
			{
				FreeLibrary(hModule); //decrement the DLL usage counter
				returnValue = true; //Return true
			}
			else
			{
				returnValue = false; //Return False
			}
			return returnValue;
		}
		
		//Private Function GetAPIErrorMessageDescription(ByVal ErrNumber As Integer) As String
		//    'Purpose: To locate and return the error message definition per
		//    ' the systems message table.
		//    'Params: ErrNumber as the 32 bit message identifier.
		//    'Returns: Formatted error message.
		
		//    Dim sError As String = ""
		//    sError = sError.PadRight(MAX_MESSAGE_LENGTH)
		
		//    Dim lErrMsgLen As Integer '32 bit message identifier
		
		//    'Make API call to retrieve the system message
		//    lErrMsgLen = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, _
		//        0, ErrNumber, 0, sError, MAX_MESSAGE_LENGTH, 0)
		
		//    If lErrMsgLen > 0 Then 'check the length of the return buffer
		//        GetAPIErrorMessageDescription = sError 'return the error message
		//    End If
		//End Function
	}
	
}
