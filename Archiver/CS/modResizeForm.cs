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

using Microsoft.VisualBasic.CompilerServices;


//Now for how to use it, in the Form_Load Event you add a call to:

//    * GetLocation
//    * ResizeForm

//And set the FontSize property of your controls, like this:
//Private Sub Form_Load()
//    GetLocation(Me)
//    CenterForm(Me)
//    ResizeForm(Me)

//    lblInstructions.Font = SetFontSize()
//End Sub

//This Code Module also offers another feature. If someone
//were the resize your form while having the application running,
//if you put a call to ResizeControls in the Form_Resize Event, '
//this will take care of resizing everthing:

//CODE

//Private Sub Form_Resize()
//    ResizeControls(Me)
//    lblInstructions.FontSize = SetFontSize()
//End Sub


namespace EcmArchiveClcSetup
{
	sealed class modResizeForm
	{
		private struct ControlStruct
		{
			private int Index;
			private string Name;
			private int Left;
			private int Top;
			private int width;
			private int height;
		}
		
		private static ControlStruct[] List;
		private static object curr_obj;
		private static int iHeight;
		private static int iWidth;
		private static double x_size;
		private static double y_size;
		
		static ControlStruct[] sControls;
		
		public static void ResizeForm(Form frm, bool isMdiChild)
		{
			if (isMdiChild == true)
			{
				//Set the forms height
				frm.Height = frm.Height / 2;
				//Set the forms width
				frm.Width = frm.Width / 2;
				//Resize all of the controls
				//based on the forms new size
			}
			else
			{
				frm.Width = Screen.PrimaryScreen.Bounds.Width / 2;
				frm.Height = Screen.PrimaryScreen.Bounds.Height / 2;
			}
			//'Set the forms height
			//frm.Height = Screen.height / 2
			//'Set the forms width
			//frm.Width = Screen.width / 2
			//'Resize all of the controls
			//'based on the forms new size
			ResizeControls(frm);
		}
		static public int CountOpenForms()
		{
			int I = 0;
			
			
			foreach (Form frm in (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).OpenForms)
			{
				Console.WriteLine(frm.Name.ToString());
				I++;
			}
			return I;
		}
		public static void ResizeControls(Form frm)
		{
			//** WDM Put this back when perfected
			//Dim DoNotUse As Boolean = True
			//If DoNotUse = True Then
			//    Return
			//End If
			
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
			//   Get ratio of initial form size to current form size
			x_size = frm.Height / iHeight;
			y_size = frm.Width / iWidth;
			
			//Loop though all the objects on the form
			//Based on the upper bound of the # of controls
			for (i = 0; i <= (List.Length - 1); i++)
			{
				//Grad each control individually
				foreach (object tempLoopVar_curr_obj in frm.Controls)
				{
					curr_obj = tempLoopVar_curr_obj;
					//Check to make sure its the right control
					if (curr_obj.TabIndex == List[i].Index)
					{
						//Then resize the control
						object with_1 = curr_obj;
						with_1.Left = List[i].Left * y_size;
						with_1.width = List[i].width * y_size;
						with_1.height = List[i].height * x_size;
						with_1.Top = List[i].Top * x_size;
						//Console.WriteLine(.name + " @ " + .GetType.FullName.ToString)
						Console.WriteLine(with_1.name + " @ " + with_1.GetType().Name.ToString());
						string xType = with_1.GetType().ToString();
						if (with_1.GetType().Name.ToString().Equals("GroupBox"))
						{
							//ResizeGroupBox(curr_obj)
						}
						else
						{
							try
							{
								//Me.RatesDataGridView.Font.Size=8
								//me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
								int NewFontSize = SetFontSize();
								if (NewFontSize == 0)
								{
									NewFontSize = (int) 8.5;
								}
								with_1.font = new Font("Arial", NewFontSize, FontStyle.Regular);
								Console.WriteLine("Set font for " + with_1.name + " : ".GetType().ToString());
							}
							catch (Exception)
							{
								//** Nobody cares if the font is not resized
								Console.WriteLine("Failed to set font for " + with_1.name + " : ".GetType().ToString());
							}
						}
					}
					//Get the next control
				}
			}
		}
		public static void ResizeGroupBox(GroupBox GRP)
		{
			//** WDM Put this back when perfected
			//Dim DoNotUse As Boolean = True
			//If DoNotUse = True Then
			//    Return
			//End If
			
			int iForms = CountOpenForms();
			
			if (iForms > 3)
			{
				return;
			}
			
			
			int i;
			//   Get ratio of initial form size to current form size
			x_size = GRP.Height / iHeight;
			y_size = GRP.Width / iWidth;
			
			//Loop though all the objects on the form
			//Based on the upper bound of the # of controls
			for (i = 0; i <= (List.Length - 1); i++)
			{
				//Grad each control individually
				foreach (object tempLoopVar_curr_obj in GRP.Controls)
				{
					curr_obj = tempLoopVar_curr_obj;
					//Check to make sure its the right control
					if (curr_obj.TabIndex == List[i].Index)
					{
						//Then resize the control
						object with_1 = curr_obj;
						with_1.Left = List[i].Left * y_size;
						with_1.width = List[i].width * y_size;
						with_1.height = List[i].height * x_size;
						with_1.Top = List[i].Top * x_size;
						Console.WriteLine(with_1.name + " : ".GetType().ToString());
						try
						{
							//Me.RatesDataGridView.Font.Size=8
							//me.ratesdatagridview.font = new Font("Arial", 10, FontStyle.Bold) (the enum might be wrong, can't remember).
							int NewFontSize = SetFontSize();
							if (NewFontSize == 0)
							{
								NewFontSize = (int) 8.5;
							}
							with_1.font = new Font("Arial", NewFontSize, FontStyle.Regular);
							Console.WriteLine("Set font for " + with_1.name + " : ".GetType().ToString());
						}
						catch (Exception)
						{
							//** Nobody cares if the font is not resized
							Console.WriteLine("Failed to set font for " + with_1.name + " : ".GetType().ToString());
						}
						
					}
					//Get the next control
				}
			}
		}
		public static void GetLocation(Form frm)
		{
			int i;
			List = new modResizeForm.ControlStruct[1];
			//   Load the current positions of each object into a user defined type array.
			//   This information will be used to rescale them in the Resize function.
			
			//Loop through each control
			try
			{
				foreach (object tempLoopVar_curr_obj in frm.Controls)
				{
					curr_obj = tempLoopVar_curr_obj;
					//Resize the Array by 1, and preserve
					//the original objects in the array
					Array.Resize(ref List, i + 1);
					modResizeForm.ControlStruct with_1 = List[i];
					with_1.Name = (string) curr_obj.name;
					with_1.Index = System.Convert.ToInt32(curr_obj.TabIndex);
					with_1.Left = System.Convert.ToInt32(curr_obj.Left);
					with_1.Top = System.Convert.ToInt32(curr_obj.Top);
					with_1.width = System.Convert.ToInt32(curr_obj.Width);
					with_1.height = System.Convert.ToInt32(curr_obj.Height);
					//Console.WriteLine(frm.Name + " : " + .Name + " : " + .GetType.ToString)
					//If Mid(.Name, 1, 2).Equals("dg") Then
					//    Console.WriteLine("DataGridView")
					//End If
					i++;
				}
				
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
			//   This is what the object sizes will be compared to on rescaling.
			iHeight = frm.Height;
			iWidth = frm.Width;
		}
		
		
		public static int SetFontSize()
		{
			int returnValue;
			//Make sure x_size is greater than 0
			if (Conversion.Int(x_size) > 0)
			{
				//Set the font size
				returnValue = (int) (Conversion.Int(x_size * 8));
			}
			else
			{
				return 10;
			}
			return returnValue;
		}
		
		
	}
	
}
