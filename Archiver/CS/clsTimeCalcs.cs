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


namespace EcmArchiveClcSetup
{
	public class clsTimeCalcs
	{
		
		public double ElapsedTimeInMS(DateTime sTime, DateTime eTime)
		{
			
			TimeSpan elapsed_time = null;
			elapsed_time = eTime.Subtract(sTime);
			double txTotalTime = elapsed_time.Milliseconds;
			return txTotalTime;
			
		}
		
	}
	
}
