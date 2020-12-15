' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="Settings.Designer.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************--

Option Strict On
Option Explicit On



''' <summary>
''' Class MySettings. This class cannot be inherited.
''' Implements the <see cref="System.Configuration.ApplicationSettingsBase" />
''' </summary>
''' <seealso cref="System.Configuration.ApplicationSettingsBase" />
<Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute(),
 Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "15.9.0.0"),
 Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>
Partial Friend NotInheritable Class MySettings
    Inherits Global.System.Configuration.ApplicationSettingsBase

    ''' <summary>
    ''' The default instance
    ''' </summary>
    Private Shared defaultInstance As MySettings = CType(Global.System.Configuration.ApplicationSettingsBase.Synchronized(New MySettings()), MySettings)

#Region "My.Settings Auto-Save Functionality"
#If _MyType = "WindowsForms" Then
    Private Shared addedHandler As Boolean

    Private Shared addedHandlerLockObject As New Object

    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute(), Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)> _
    Private Shared Sub AutoSaveSettings(sender As Global.System.Object, e As Global.System.EventArgs)
        If My.Application.SaveMySettingsOnExit Then
            My.Settings.Save()
        End If
    End Sub
#End If
#End Region

    ''' <summary>
    ''' Gets the default.
    ''' </summary>
    ''' <value>The default.</value>
    Public Shared ReadOnly Property [Default]() As MySettings
        Get

#If _MyType = "WindowsForms" Then
               If Not addedHandler Then
                    SyncLock addedHandlerLockObject
                        If Not addedHandler Then
                            AddHandler My.Application.Shutdown, AddressOf AutoSaveSettings
                            addedHandler = True
                        End If
                    End SyncLock
                End If
#End If
            Return defaultInstance
        End Get
    End Property
End Class

Namespace My

    ''' <summary>
    ''' Class MySettingsProperty.
    ''' </summary>
    <Global.Microsoft.VisualBasic.HideModuleNameAttribute(),
     Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),
     Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute()>
    Friend Module MySettingsProperty

        ''' <summary>
        ''' Gets the settings.
        ''' </summary>
        ''' <value>The settings.</value>
        <Global.System.ComponentModel.Design.HelpKeywordAttribute("My.Settings")>
        Friend ReadOnly Property Settings() As Global.ECMSearchWPF.MySettings
            Get
                Return Global.ECMSearchWPF.MySettings.Default
            End Get
        End Property
    End Module
End Namespace
