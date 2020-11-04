using System;
using global::System.IO;
// Imports Microsoft.Win32
using global::System.IO.Compression;
using MODI;

namespace EcmArchiver
{
    public class clsCompression
    {
        public byte[] StrToByteArray(string str)
        {
            var encoding = new global::System.Text.UTF8Encoding();
            return encoding.GetBytes(str);
        } // StrToByteArray

        public string ByteArrayToStr(byte[] dBytes)
        {
            string str;
            var enc = new System.Text.UTF8Encoding();
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
            var gzBuffer = CompressBuffer(CompressedDataBuffer);
            CompressedDataBuffer = gzBuffer;
            CompressedSize = CompressedDataBuffer.Length;
            return CompressedDataBuffer;
        }

        public string DeCompressBufferToString(byte[] CompressedDataBuffer, ref double OriginalSize, ref double CompressedSize)
        {
            CompressedSize = CompressedDataBuffer.Length;
            var DeCompressedDataBuffer = DeCompressBuffer(CompressedDataBuffer);
            OriginalSize = DeCompressedDataBuffer.Length;
            string S = ByteArrayToStr(DeCompressedDataBuffer);
            return S;
        }

        public byte[] CompressBuffer(byte[] BufferToCompress)
        {
            var ms = new MemoryStream();
            var zip = new GZipStream(ms, CompressionMode.Compress, true);
            zip.Write(BufferToCompress, 0, BufferToCompress.Length);
            zip.Close();
            ms.Position = 0L;
            var outStream = new MemoryStream();
            var compressed = new byte[(int)(ms.Length - 1L + 1)];
            ms.Read(compressed, 0, compressed.Length);
            var gzBuffer = new byte[compressed.Length + 3 + 1];
            Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length);
            Buffer.BlockCopy(BitConverter.GetBytes(BufferToCompress.Length), 0, gzBuffer, 0, 4);
            return gzBuffer;
        }

        public byte[] DeCompressBuffer(byte[] BufferToDecompress)
        {
            var ms = new MemoryStream();
            int msgLength = BitConverter.ToInt32(BufferToDecompress, 0);
            ms.Write(BufferToDecompress, 4, BufferToDecompress.Length - 4);
            var buffer = new byte[msgLength];
            ms.Position = 0L;
            var zip = new GZipStream(ms, CompressionMode.Decompress);
            zip.Read(buffer, 0, buffer.Length);
            return buffer;
        }
    }
}