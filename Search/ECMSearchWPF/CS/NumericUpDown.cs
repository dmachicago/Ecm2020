// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.Windows.Controls.Primitives;

// Follow steps 1a or 1b and then 2 to use this custom control in a XAML file.
//
// Step 1a) Using this custom control in a XAML file that exists in the current project.
// Add this XmlNamespace attribute to the root element of the markup file where it is
// to be used:
//
//     xmlns:MyNamespace="clr-namespace:ECMSearchWPF"
//
//
// Step 1b) Using this custom control in a XAML file that exists in a different project.
// Add this XmlNamespace attribute to the root element of the markup file where it is
// to be used:
//
//     xmlns:MyNamespace="clr-namespace:ECMSearchWPF;assembly=ECMSearchWPF"
//
// You will also need to add a project reference from the project where the XAML file lives
// to this project and Rebuild to avoid compilation errors:
//
//     Right click on the target project in the Solution Explorer and
//     "Add Reference"->"Projects"->[Browse to and select this project]
//
//
// Step 2)
// Go ahead and use your control in the XAML file. Note that Intellisense in the
// XML editor does not currently work on custom controls and its child elements.
//
//     <MyNamespace:NumericUpDown/>
//



namespace ECMSearchWPF
{
	public class NumericUpDown : System.Windows.Controls.Control
	{
		
		static NumericUpDown()
		{
			//This OverrideMetadata call tells the system that this element wants to provide a style that is different than its base class.
			//This style is defined in themes\generic.xaml
			DefaultStyleKeyProperty.OverrideMetadata(typeof(NumericUpDown), new FrameworkPropertyMetadata(typeof(NumericUpDown)));
		}
		
	}
	
}
