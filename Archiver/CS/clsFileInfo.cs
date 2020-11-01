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

using System.IO;
using Microsoft.VisualBasic.CompilerServices;


namespace EcmArchiveClcSetup
{
	public class clsFileInfo
	{
		
		string FileKey = "";
		
		public void RemoveBadChars(ref string FQN)
		{
			for (int i = 1; i <= FQN.Length; i++)
			{
				string CH = FQN.Substring(i - 1, 1);
				switch (CH)
				{
					case "/":
						StringType.MidStmtStr(ref FQN, i, 1, ".");
						break;
					case "\'":
						StringType.MidStmtStr(ref FQN, i, 1, ".");
						break;
					case " ":
						StringType.MidStmtStr(ref FQN, i, 1, ".");
						break;
					case ":":
						StringType.MidStmtStr(ref FQN, i, 1, ".");
						break;
				}
			}
		}
	}
	
}
