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
using System.IO.Compression;

//Imports Microsoft.Win32
namespace EcmArchiveClcSetup
{
	public class clsCompression
	{
		public byte[] StrToByteArray(string str)
		{
			System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
			return encoding.GetBytes(str);
		} //StrToByteArray
		public string ByteArrayToStr(byte[] dBytes)
		{
			string str;
			System.Text.UTF8Encoding enc = new System.Text.UTF8Encoding();
			str = enc.GetString(dBytes);
			return str;
		}
		
		public byte[] CompressStringToBuffer(string tgtStr, ref double OriginalSize, ref double CompressedSize)
		{
			
			byte[] CompressedDataBuffer;
			CompressedDataBuffer = StrToByteArray(tgtStr);
			
			if (CompressedDataBuffer.Length == 0)
			{
				CompressedDataBuffer = null;
				return CompressedDataBuffer;
			}
			
			OriginalSize = CompressedDataBuffer.Length;
			
			byte[] gzBuffer = CompressBuffer(CompressedDataBuffer);
			
			CompressedDataBuffer = gzBuffer;
			CompressedSize = CompressedDataBuffer.Length;
			return CompressedDataBuffer;
			
		}
		
		public string DeCompressBufferToString(byte[] CompressedDataBuffer, ref double OriginalSize, ref double CompressedSize)
		{
			CompressedSize = CompressedDataBuffer.Length;
			byte[] DeCompressedDataBuffer = DeCompressBuffer(CompressedDataBuffer);
			OriginalSize = DeCompressedDataBuffer.Length;
			string S = ByteArrayToStr(DeCompressedDataBuffer);
			return S;
		}
		
		public byte[] CompressBuffer(byte[] BufferToCompress)
		{
			MemoryStream ms = new MemoryStream();
			GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true);
			zip.Write(BufferToCompress, 0, BufferToCompress.Length);
			zip.Close();
			ms.Position = 0;
			
			MemoryStream outStream = new MemoryStream();
			
			byte[] compressed = new byte[ms.Length - 1+ 1];
			ms.Read(compressed, 0, compressed.Length);
			
			byte[] gzBuffer = new byte[compressed.Length + 3+ 1];
			Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length);
			Buffer.BlockCopy(BitConverter.GetBytes(BufferToCompress.Length), 0, gzBuffer, 0, 4);
			return gzBuffer;
			
		}
		public byte[] DeCompressBuffer(byte[] BufferToDecompress)
		{
			MemoryStream ms = new MemoryStream();
			int msgLength = BitConverter.ToInt32(BufferToDecompress, 0);
			ms.Write(BufferToDecompress, 4, BufferToDecompress.Length - 4);
			
			byte[] buffer = new byte[msgLength - 1+ 1];
			
			ms.Position = 0;
			GZipStream zip = new GZipStream(ms, CompressionMode.Decompress);
			zip.Read(buffer, 0, buffer.Length);
			
			return buffer;
		}
	}
	
}
