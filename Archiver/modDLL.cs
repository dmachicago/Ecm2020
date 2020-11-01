// Imports Microsoft.Win32
// Imports Microsoft.VisualBasic

using System;
using System.Runtime.InteropServices;
using MODI;

namespace EcmArchiver
{
    static class modDLL
    {
        // Constants
        private const int FORMAT_MESSAGE_FROM_SYSTEM = 0x1000;
        private const int MAX_MESSAGE_LENGTH = 512;

        // API declarations
        [DllImport("kernel32", EntryPoint = "LoadLibraryA")]
        private static extern long LoadLibrary(string lpLibFileName);
        [DllImport("kernel32")]
        private static extern long FreeLibrary(long hLibModule);

        public static bool ckDLLAvailable(string DllFilename)
        {
            long hModule;
            // attempt to load the module
            hModule = modDLL.LoadLibrary(ref DllFilename);
            if (hModule > 32L)
            {
                try
                {
                    FreeLibrary(hModule); // decrement the DLL usage counter
                }
                catch (Exception ex)
                {
                    FreeLibrary(hModule);
                } // decrement the DLL usage counter

                return true;
            }

            return false;
        }

        public static bool IsDLLAvailable(string DllFilename)
        {
            bool IsDLLAvailableRet = default;
            long hModule;
            hModule = modDLL.LoadLibrary(ref DllFilename); // attempt to load DLL
            if (hModule > 32L)
            {
                FreeLibrary(hModule); // decrement the DLL usage counter
                IsDLLAvailableRet = true; // Return true
            }
            else
            {
                IsDLLAvailableRet = false;
            } // Return False

            return IsDLLAvailableRet;
        }

        // Private Function GetAPIErrorMessageDescription(ByVal ErrNumber As Integer) As String
        // 'Purpose: To locate and return the error message definition per
        // ' the systems message table.
        // 'Params: ErrNumber as the 32 bit message identifier.
        // 'Returns: Formatted error message.

        // Dim sError As String = ""
        // sError = sError.PadRight(MAX_MESSAGE_LENGTH)

        // Dim lErrMsgLen As Integer '32 bit message identifier

        // 'Make API call to retrieve the system message
        // lErrMsgLen = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, _
        // 0, ErrNumber, 0, sError, MAX_MESSAGE_LENGTH, 0)

        // If lErrMsgLen > 0 Then 'check the length of the return buffer
        // GetAPIErrorMessageDescription = sError 'return the error message
        // End If
        // End Function
    }
}