Imports System.Windows.Forms

'Now for how to use it, in the Form_Load Event you add a call to:

'    * GetLocation
'    * ResizeForm

'And set the FontSize property of your controls, like this:
'Private Sub Form_Load()
'    GetLocation(Me)
'    CenterForm(Me)
'    ResizeForm(Me)

'    lblInstructions.Font = SetFontSize()
'End Sub

'This Code Module also offers another feature. If someone 
'were the resize your form while having the application running, 
'if you put a call to ResizeControls in the Form_Resize Event, '
'this will take care of resizing everthing:

'CODE

'Private Sub Form_Resize()
'    ResizeControls(Me)
'    lblInstructions.FontSize = SetFontSize()
'End Sub


Module modResizeForm
    Private Structure ControlStruct
        Dim Index As Integer
        Dim Name As String
        Dim Left As Integer
        Dim Top As Integer
        Dim width As Integer
        Dim height As Integer
    End Structure

    Private List() As ControlStruct
    Private curr_obj As Object
    Private iHeight As Integer
    Private iWidth As Integer
    Private x_size As Double
    Private y_size As Double

    Dim sControls As ControlStruct()

    Public Sub ResizeForm(ByVal frm As Form, ByVal isMdiChild As Boolean)
        If isMdiChild = True Then
            'Set the forms height
            frm.Height = frm.Height / 2
            'Set the forms width
            frm.Width = frm.Width / 2
            'Resize all of the controls
            'based on the forms new size
        Else
            frm.Width = Screen.PrimaryScreen.Bounds.Width / 2
            frm.Height = Screen.PrimaryScreen.Bounds.Height / 2
        End If
        ''Set the forms height
        'frm.Height = Screen.height / 2
        ''Set the forms width
        'frm.Width = Screen.width / 2
        ''Resize all of the controls
        ''based on the forms new size
        ResizeControls(frm)
    End Sub
    Function CountOpenForms() As Integer
        Dim I As Integer = 0
        Dim frm As Form

        For Each frm In My.Application.OpenForms
            Console.WriteLine(frm.Name.ToString)
            I += 1
        Next
        Return I
    End Function
    Public Sub ResizeControls(ByRef frm As Form)
        '** WDM Put this back when perfected
        'Dim DoNotUse As Boolean = True
        'If DoNotUse = True Then
        '    Return
        'End If

        Dim NoResize As Boolean = True
        If NoResize = True Then
            Return
        End If

        Dim iForms As Integer = CountOpenForms()

        If iForms > 3 Then
            Return
        End If


        Dim i As Integer
        '   Get ratio of initial form size to current form size
        x_size = frm.Height / iHeight
        y_size = frm.Width / iWidth

        'Loop though all the objects on the form
        'Based on the upper bound of the # of controls
        For i = 0 To UBound(List)
            'Grad each control individually
            For Each curr_obj In frm.Controls
                'Check to make sure its the right control
                If curr_obj.TabIndex = List(i).Index Then
                    'Then resize the control
                    With curr_obj
                        .Left = List(i).Left * y_size
                        .width = List(i).width * y_size
                        .height = List(i).height * x_size
                        .Top = List(i).Top * x_size
                        'Console.WriteLine(.name + " @ " + .GetType.FullName.ToString)
                        Console.WriteLine(.name + " @ " + .GetType.Name.ToString)
Dim xType AS String  = .GetType.ToString 
                        If .GetType.Name.ToString.Equals("GroupBox") Then
                            'ResizeGroupBox(curr_obj)
                        Else
                            Try
                                'Me.RatesDataGridView.Font.Size=8
                                'me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
                                Dim NewFontSize As Integer = SetFontSize()
                                If NewFontSize = 0 Then
                                    NewFontSize = 8.5
                                End If
                                .font = New Font("Arial", NewFontSize, FontStyle.Regular)
                                Console.WriteLine("Set font for " + .name + " : ".GetType.ToString)
                            Catch ex As Exception
                                '** Nobody cares if the font is not resized
                                Console.WriteLine("Failed to set font for " + .name + " : ".GetType.ToString)
                            End Try
                        End If
                    End With
                End If
                'Get the next control
            Next curr_obj
        Next i
    End Sub
    Public Sub ResizeGroupBox(ByVal GRP As GroupBox)
        '** WDM Put this back when perfected
        'Dim DoNotUse As Boolean = True
        'If DoNotUse = True Then
        '    Return
        'End If

        Dim iForms As Integer = CountOpenForms()

        If iForms > 3 Then
            Return
        End If


        Dim i As Integer
        '   Get ratio of initial form size to current form size
        x_size = GRP.Height / iHeight
        y_size = GRP.Width / iWidth

        'Loop though all the objects on the form
        'Based on the upper bound of the # of controls
        For i = 0 To UBound(List)
            'Grad each control individually
            For Each curr_obj In GRP.Controls
                'Check to make sure its the right control
                If curr_obj.TabIndex = List(i).Index Then
                    'Then resize the control
                    With curr_obj
                        .Left = List(i).Left * y_size
                        .width = List(i).width * y_size
                        .height = List(i).height * x_size
                        .Top = List(i).Top * x_size
                        Console.WriteLine(.name + " : ".GetType.ToString)
                        Try
                            'Me.RatesDataGridView.Font.Size=8
                            'me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
                            Dim NewFontSize As Integer = SetFontSize()
                            If NewFontSize = 0 Then
                                NewFontSize = 8.5
                            End If
                            .font = New Font("Arial", NewFontSize, FontStyle.Regular)
                            Console.WriteLine("Set font for " + .name + " : ".GetType.ToString)
                        Catch ex As Exception
                            '** Nobody cares if the font is not resized
                            Console.WriteLine("Failed to set font for " + .name + " : ".GetType.ToString)
                        End Try

                    End With
                End If
                'Get the next control
            Next curr_obj
        Next i
    End Sub
    Public Sub GetLocation(ByVal frm As Form)
        Dim i As Integer
        ReDim List(0)
        '   Load the current positions of each object into a user defined type array.
        '   This information will be used to rescale them in the Resize function.

        'Loop through each control
        Try
            For Each curr_obj In frm.Controls
                'Resize the Array by 1, and preserve
                'the original objects in the array
                ReDim Preserve List(i)
                With List(i)
                    .Name = curr_obj.name
                    .Index = curr_obj.TabIndex
                    .Left = curr_obj.Left
                    .Top = curr_obj.Top
                    .width = curr_obj.Width
                    .height = curr_obj.Height
                    'Console.WriteLine(frm.Name + " : " + .Name + " : " + .GetType.ToString)
                    'If Mid(.Name, 1, 2).Equals("dg") Then
                    '    Console.WriteLine("DataGridView")
                    'End If
                End With
                i = i + 1
            Next curr_obj

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        
        '   This is what the object sizes will be compared to on rescaling.
        iHeight = frm.Height
        iWidth = frm.Width
    End Sub


    Public Function SetFontSize() As Integer
        'Make sure x_size is greater than 0
        If Int(x_size) > 0 Then
            'Set the font size
            SetFontSize = Int(x_size * 8)
        Else
            Return 10
        End If
    End Function


End Module
