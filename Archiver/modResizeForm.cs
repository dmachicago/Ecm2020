using System;
using System.Drawing;
using global::System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{

    // Now for how to use it, in the Form_Load Event you add a call to:

    // * GetLocation
    // * ResizeForm

    // And set the FontSize property of your controls, like this:
    // Private Sub Form_Load()
    // GetLocation(Me)
    // CenterForm(Me)
    // ResizeForm(Me)

    // lblInstructions.Font = SetFontSize()
    // End Sub

    // This Code Module also offers another feature. If someone 
    // were the resize your form while having the application running, 
    // if you put a call to ResizeControls in the Form_Resize Event, '
    // this will take care of resizing everthing:

    // CODE

    // Private Sub Form_Resize()
    // ResizeControls(Me)
    // lblInstructions.FontSize = SetFontSize()
    // End Sub


    static class modResizeForm
    {
        private struct ControlStruct
        {
            public int Index;
            public string Name;
            public int Left;
            public int Top;
            public int width;
            public int height;
        }

        private static ControlStruct[] List;
        private static object curr_obj;
        private static int iHeight;
        private static int iWidth;
        private static double x_size;
        private static double y_size;
        private static ControlStruct[] sControls;

        public static void ResizeForm(Form frm, bool isMdiChild)
        {
            if (isMdiChild == true)
            {
                // Set the forms height
                frm.Height = (int)(frm.Height / 2d);
                // Set the forms width
                frm.Width = (int)(frm.Width / 2d);
            }
            // Resize all of the controls
            // based on the forms new size
            else
            {
                frm.Width = (int)(Screen.PrimaryScreen.Bounds.Width / 2d);
                frm.Height = (int)(Screen.PrimaryScreen.Bounds.Height / 2d);
            }
            // 'Set the forms height
            // frm.Height = Screen.height / 2
            // 'Set the forms width
            // frm.Width = Screen.width / 2
            // 'Resize all of the controls
            // 'based on the forms new size
            ResizeControls(ref frm);
        }

        public static int CountOpenForms()
        {
            int I = 0;
            foreach (Form frm in My.MyProject.Application.OpenForms)
            {
                Console.WriteLine(frm.Name.ToString());
                I += 1;
            }

            return I;
        }

        public static void ResizeControls(ref Form frm)
        {
            // ** WDM Put this back when perfected
            // Dim DoNotUse As Boolean = True
            // If DoNotUse = True Then
            // Return
            // End If

            bool NoResize = true;
            if (NoResize == true)
            {
                return;
            }

            int iForms = CountOpenForms();
            if (iForms > 3)
            {
                return;
            }

            int i;
            // Get ratio of initial form size to current form size
            x_size = frm.Height / (double)iHeight;
            y_size = frm.Width / (double)iWidth;

            // Loop though all the objects on the form
            // Based on the upper bound of the # of controls
            var loopTo = Information.UBound(List);
            for (i = 0; i <= loopTo; i++)
            {
                // Grad each control individually
                foreach (var currentCurr_obj in frm.Controls)
                {
                    curr_obj = currentCurr_obj;
                    // Check to make sure its the right control
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(curr_obj.TabIndex, List[i].Index, false)))
                    {
                        // Then resize the control
                        {
                            var withBlock = curr_obj;
                            withBlock.Left = List[i].Left * y_size;
                            withBlock.width = List[i].width * y_size;
                            withBlock.height = List[i].height * x_size;
                            withBlock.Top = List[i].Top * x_size;
                            // Console.WriteLine(.name + " @ " + .GetType.FullName.ToString)
                            Console.WriteLine(Operators.AddObject(Operators.AddObject(withBlock.name, " @ "), withBlock.GetType().Name.ToString()));
                            string xType = withBlock.GetType().ToString();
                            if (withBlock.GetType().Name.ToString().Equals("GroupBox"))
                            {
                            }
                            // ResizeGroupBox(curr_obj)
                            else
                            {
                                try
                                {
                                    // Me.RatesDataGridView.Font.Size=8
                                    // me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
                                    int NewFontSize = SetFontSize();
                                    if (NewFontSize == 0)
                                    {
                                        NewFontSize = 8.5;
                                    }

                                    withBlock.font = new Font("Arial", NewFontSize, FontStyle.Regular);
                                    Console.WriteLine(Operators.AddObject(Operators.AddObject("Set font for ", withBlock.name), " : ".GetType().ToString()));
                                }
                                catch (Exception ex)
                                {
                                    // ** Nobody cares if the font is not resized
                                    Console.WriteLine(Operators.AddObject(Operators.AddObject("Failed to set font for ", withBlock.name), " : ".GetType().ToString()));
                                }
                            }
                        }
                    }
                    // Get the next control
                }
            }
        }

        public static void ResizeGroupBox(GroupBox GRP)
        {
            // ** WDM Put this back when perfected
            // Dim DoNotUse As Boolean = True
            // If DoNotUse = True Then
            // Return
            // End If

            int iForms = CountOpenForms();
            if (iForms > 3)
            {
                return;
            }

            int i;
            // Get ratio of initial form size to current form size
            x_size = GRP.Height / (double)iHeight;
            y_size = GRP.Width / (double)iWidth;

            // Loop though all the objects on the form
            // Based on the upper bound of the # of controls
            var loopTo = Information.UBound(List);
            for (i = 0; i <= loopTo; i++)
            {
                // Grad each control individually
                foreach (var currentCurr_obj in GRP.Controls)
                {
                    curr_obj = currentCurr_obj;
                    // Check to make sure its the right control
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(curr_obj.TabIndex, List[i].Index, false)))
                    {
                        // Then resize the control
                        {
                            var withBlock = curr_obj;
                            withBlock.Left = List[i].Left * y_size;
                            withBlock.width = List[i].width * y_size;
                            withBlock.height = List[i].height * x_size;
                            withBlock.Top = List[i].Top * x_size;
                            Console.WriteLine(Operators.AddObject(withBlock.name, " : ".GetType().ToString()));
                            try
                            {
                                // Me.RatesDataGridView.Font.Size=8
                                // me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
                                int NewFontSize = SetFontSize();
                                if (NewFontSize == 0)
                                {
                                    NewFontSize = 8.5;
                                }

                                withBlock.font = new Font("Arial", NewFontSize, FontStyle.Regular);
                                Console.WriteLine(Operators.AddObject(Operators.AddObject("Set font for ", withBlock.name), " : ".GetType().ToString()));
                            }
                            catch (Exception ex)
                            {
                                // ** Nobody cares if the font is not resized
                                Console.WriteLine(Operators.AddObject(Operators.AddObject("Failed to set font for ", withBlock.name), " : ".GetType().ToString()));
                            }
                        }
                    }
                    // Get the next control
                }
            }
        }

        public static void GetLocation(Form frm)
        {
            var i = default(int);
            List = new ControlStruct[1];
            // Load the current positions of each object into a user defined type array.
            // This information will be used to rescale them in the Resize function.

            // Loop through each control
            try
            {
                foreach (var currentCurr_obj in frm.Controls)
                {
                    curr_obj = currentCurr_obj;
                    // Resize the Array by 1, and preserve
                    // the original objects in the array
                    Array.Resize(ref List, i + 1);
                    {
                        var withBlock = List[i];
                        withBlock.Name = Conversions.ToString(curr_obj.name);
                        withBlock.Index = Conversions.ToInteger(curr_obj.TabIndex);
                        withBlock.Left = Conversions.ToInteger(curr_obj.Left);
                        withBlock.Top = Conversions.ToInteger(curr_obj.Top);
                        withBlock.width = Conversions.ToInteger(curr_obj.Width);
                        withBlock.height = Conversions.ToInteger(curr_obj.Height);
                        // Console.WriteLine(frm.Name + " : " + .Name + " : " + .GetType.ToString)
                        // If Mid(.Name, 1, 2).Equals("dg") Then
                        // Console.WriteLine("DataGridView")
                        // End If
                    }

                    i = i + 1;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            // This is what the object sizes will be compared to on rescaling.
            iHeight = frm.Height;
            iWidth = frm.Width;
        }

        public static int SetFontSize()
        {
            int SetFontSizeRet = default;
            // Make sure x_size is greater than 0
            if (Conversion.Int(x_size) > 0d)
            {
                // Set the font size
                SetFontSizeRet = (int)Conversion.Int(x_size * 8d);
            }
            else
            {
                return 10;
            }

            return SetFontSizeRet;
        }
    }
}