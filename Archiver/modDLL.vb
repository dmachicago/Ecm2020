'Imports Microsoft.Win32
'Imports Microsoft.VisualBasic

Module modDLL
    'Constants
    Private Const FORMAT_MESSAGE_FROM_SYSTEM = &H1000
    Private Const MAX_MESSAGE_LENGTH = 512

    'API declarations
    Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
    Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long

    Function ckDLLAvailable(ByVal DllFilename As String) As Boolean
        Dim hModule As Long
        ' attempt to load the module
        hModule = LoadLibrary(DllFilename)
        If hModule > 32 Then
            Try
                FreeLibrary(hModule) ' decrement the DLL usage counter
            Catch ex As Exception
                FreeLibrary(hModule) ' decrement the DLL usage counter
            End Try
            Return True
        End If
        Return False
    End Function

    Function IsDLLAvailable(ByVal DllFilename As String) As Boolean
        Dim hModule As Long

        hModule = LoadLibrary(DllFilename) 'attempt to load DLL
        If hModule > 32 Then
            FreeLibrary(hModule) 'decrement the DLL usage counter
            IsDLLAvailable = True 'Return true
        Else
            IsDLLAvailable = False 'Return False
        End If
    End Function

    'Private Function GetAPIErrorMessageDescription(ByVal ErrNumber As Integer) As String
    '    'Purpose: To locate and return the error message definition per
    '    ' the systems message table.
    '    'Params: ErrNumber as the 32 bit message identifier.
    '    'Returns: Formatted error message.

    '    Dim sError As String = ""
    '    sError = sError.PadRight(MAX_MESSAGE_LENGTH)

    '    Dim lErrMsgLen As Integer '32 bit message identifier

    '    'Make API call to retrieve the system message
    '    lErrMsgLen = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, _
    '        0, ErrNumber, 0, sError, MAX_MESSAGE_LENGTH, 0)

    '    If lErrMsgLen > 0 Then 'check the length of the return buffer
    '        GetAPIErrorMessageDescription = sError 'return the error message
    '    End If
    'End Function
End Module
