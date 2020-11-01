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
using System.Runtime.InteropServices;
using System.ComponentModel;



namespace EcmArchiveClcSetup
{
	public class clsWMAID3Tag
	{
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		// This class will read all the attributes from the ContextBlock and ExtendedContextBlock in a WMA file
		// It makes available the attributes that are most interesting directly, and allows the retrieval on any string attribute by name.
		// Could easily be extended to allow the retrieval of non-string attributes, I just didn't need them.
		// I couldn't find an easy way to have a resumable enumeration over a hash table (there's not items() array) I didn't
		// implement an enumerator.  It wouldn't be hard to do, just clumsy.
		public string FQN = "";
		public string title;
		public string artist;
		public string album;
		public string genre;
		public string copyright;
		public string description;
		public string rating;
		public int year;
		public int track;
		private FileStream stream;
		private BinaryReader binRead;
		private Hashtable attrs = new Hashtable();
		private ArrayList attrValues = new ArrayList();
		private struct value
		{
			public short dataType;
			public int index;
		}
		// WMA GUIDs
		private Guid hdrGUID = new Guid("75B22630-668E-11CF-A6D9-00AA0062CE6C");
		private Guid contentGUID = new Guid("75B22633-668E-11CF-A6D9-00AA0062CE6C");
		private Guid extendedContentGUID = new Guid("D2D0A440-E307-11D2-97F0-00A0C95EA850");
		
		
		public clsWMAID3Tag(string fn)
		{
			
			
			Guid g;
			bool CBDone;
			bool ECBDone;
			long sizeBlock;
			string s;
			int i;
			
			
			try
			{
				stream = new FileStream(fn, FileMode.Open, FileAccess.Read);
				binRead = new BinaryReader(stream);
			}
			catch (Exception ex)
			{
				MessageBox.Show("Could not open " + fn);
				LOG.WriteToArchiveLog((string) ("clsWMAID3Tag : New : 9 : " + ex.Message));
				return;
			}
			
			
			readGUID(ref g);
			if (! Guid.op_Equality(g, hdrGUID))
			{
				// throw an exception
				Debug.Print("Invalid WMA file format, skipping file.");
				stream.Close();
				return;
			}
			binRead.ReadInt64(); // the size of the entire block
			binRead.ReadInt32(); // the number of entries
			binRead.ReadBytes(2); // two reserved bytes
			// Process all the GUIDs until you get both the contextblock and the extendedcontextblock
			while (readGUID(ref g))
			{
				sizeBlock = binRead.ReadInt64(); // this is the size of the block
				// shouldn't happen, but at least fail gracefully
				if (binRead.BaseStream.Position + sizeBlock > stream.Length)
				{
					break;
				}
				if (Guid.op_Equality(g, contentGUID))
				{
					processContentBlock();
					if (ECBDone)
					{
						break;
					}
					CBDone = true;
				}
				else if (Guid.op_Equality(g, extendedContentGUID))
				{
					processExtendedContentBlock();
					if (CBDone)
					{
						break;
					}
					ECBDone = true;
				}
				else
				{
					// not one we're interested in, skip it
					sizeBlock -= 24; // already read the guid header info
					binRead.BaseStream.Position += sizeBlock;
				}
			}
			
			
			// Get the attributes we're interested in
			album = getStringAttribute("WM/AlbumTitle");
			genre = getStringAttribute("WM/Genre");
			s = getStringAttribute("WM/Year");
			if (Information.IsNumeric(s))
			{
				year = int.Parse(s);
			}
			s = getStringAttribute("WM/TrackNumber");
			// could be n/<total>
			i = s.IndexOf("/");
			if (i != -1)
			{
				s = s.Substring(0, i);
			}
			if (Information.IsNumeric(s))
			{
				track = int.Parse(s);
			}
			else
			{
				s = getStringAttribute("WM/Track");
				i = s.IndexOf("/");
				if (i != -1)
				{
					s = s.Substring(0, i);
				}
				if (Information.IsNumeric(s))
				{
					track = int.Parse(s);
				}
			}
		}
		private string readUnicodeString(short len)
		{
			//Can't use .NET functions, since they expect the length field to be a single byte for strings < 256 chars
			char[] ch;
			int i;
			short k;
			
			
			ch = new char[len - 2 + 1];
			for (i = 0; i <= len - 2; i++)
			{
				k = binRead.ReadInt16();
				ch[i] = Strings.ChrW(k);
			}
			k = binRead.ReadInt16();
			return new string(ch);
		}
		private string readUnicodeString()
		{
			short datalen;
			short len;
			//Can't use .NET functions, since they expect the length field to be a single byte for strings < 256 chars
			datalen = binRead.ReadInt16();
			len = datalen / 2; // length in Unicode characters
			return readUnicodeString(len);
			
			
		}
		private void processExtendedContentBlock()
		{
			short numAttrs;
			short dataType;
			short dataLen;
			short sValue;
			string attrName;
			string strValue;
			byte[] bValue;
			bool boolValue;
			int i;
			int iValue;
			int index;
			long lValue;
			value valueObject;
			char[] ch;
			
			
			numAttrs = binRead.ReadInt16();
			for (i = 0; i <= numAttrs - 1; i++)
			{
				attrName = readUnicodeString();
				dataType = binRead.ReadInt16();
				switch (dataType)
				{
					case 0:
						strValue = readUnicodeString();
						valueObject.dataType = 0;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(strValue);
						index++;
						break;
						
						
					case 1:
						dataLen = binRead.ReadInt16();
						bValue = new byte[dataLen - 1 + 1];
						bValue = binRead.ReadBytes(dataLen);
						valueObject.dataType = 1;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(bValue);
						index++;
						break;
						
						
					case 2:
						dataLen = binRead.ReadInt16();
						iValue = binRead.ReadInt32();
						if (iValue == 0)
						{
							boolValue = false;
						}
						else
						{
							boolValue = true;
						}
						valueObject.dataType = 2;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(boolValue);
						index++;
						break;
						
						
					case 3:
						dataLen = binRead.ReadInt16();
						iValue = binRead.ReadInt32();
						valueObject.dataType = 3;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(iValue);
						index++;
						break;
						
						
					case 4:
						dataLen = binRead.ReadInt16();
						lValue = binRead.ReadInt64();
						valueObject.dataType = 4;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(lValue);
						index++;
						break;
						
						
					case 5:
						dataLen = binRead.ReadInt16();
						sValue = binRead.ReadInt16();
						valueObject.dataType = 5;
						valueObject.index = index;
						attrs.Add(attrName, valueObject);
						attrValues.Add(sValue);
						index++;
						break;
						
						
					default:
						throw (new Exception("Bad value for datatype in Extended Content Block. Value = " + dataType));
						break;
				}
			}
		}
		private void processContentBlock()
		{
			short lTitle;
			short lAuthor;
			short lCopyright;
			short lDescription;
			short lRating;
			short i;
			char[] ch;
			
			
			lTitle = binRead.ReadInt16();
			lAuthor = binRead.ReadInt16();
			lCopyright = binRead.ReadInt16();
			lDescription = binRead.ReadInt16();
			lRating = binRead.ReadInt16();
			if (lTitle > 0)
			{
				i = lTitle / 2;
				title = readUnicodeString(i);
			}
			if (lAuthor > 0)
			{
				i = lAuthor / 2;
				artist = readUnicodeString(i);
			}
			if (lCopyright > 0)
			{
				i = lCopyright / 2;
				copyright = readUnicodeString(i);
			}
			if (lDescription > 0)
			{
				i = lDescription / 2;
				description = readUnicodeString(i);
			}
			if (lRating > 0)
			{
				i = lRating / 2;
				rating = readUnicodeString(i);
			}
		}
		private bool readGUID(ref Guid g)
		{
			int int1;
			short shrt1;
			short shrt2;
			byte[] b = new byte[7];
			
			
			try
			{
				int1 = binRead.ReadInt32();
				if (int1 == -1)
				{
					return false;
				}
				shrt1 = binRead.ReadInt16();
				shrt2 = binRead.ReadInt16();
				b = binRead.ReadBytes(8);
				g = new Guid(int1, shrt1, shrt2, b);
				return true;
			}
			catch (Exception ex)
			{
				throw (new Exception("Invalid WMA format."));
				LOG.WriteToArchiveLog((string) ("clsWMAID3Tag : readGUID : 180 : " + ex.Message));
			}
		}
		public string getStringAttribute(string name)
		{
			string s = "";
			value v;
			
			
			if (! attrs.Contains(name))
			{
				return "";
			}
			v = (value) (attrs[name]);
			if (v.dataType != 0)
			{
				// it's not a string type
				return "";
			}
			else
			{
				return System.Convert.ToString(attrValues[v.index]);
			}
		}
		
		
		
		
	}
	
}
