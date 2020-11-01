//VER 3.2.1 6.4.2013
using System;

namespace jQueryToWCF
{
    public class clsLocalEncrypt
    {
        public void testEncrypt()
        {
            string s = "This is a message to encrypt.";
            string K1 = "FACC24FA-D9CC-43E8-AD93-000080198401";
            string K2 = "4E7D9326-51F9-4386-8E92-891F84F783B6";
            string K3 = "39BCF86E-59BA-4B9F-9148-B99FA153EC94";
            string K4 = "D8E7FFB7-C562-4BD6-8317-F6A864411849";
            string sEnc = encryptString(s, K1, K2, K3, K4);
            string uEnc = decryptString(sEnc, K1, K2, K3, K4);
            Console.WriteLine(sEnc);
            Console.WriteLine(uEnc);
            Console.WriteLine("DONE...");
        }

        public string encryptString(string s, string K1, string K2, string K3, string K4)
        {
            string encStr = "";
            string ch = "";
            string ch1 = "";
            string ch2 = "";
            string ch3 = "";
            string ch4 = "";
            int i = 0;
            int i0 = 0;
            int i1 = 0;
            int i2 = 0;
            int i3 = 0;
            int i4 = 0;
            string hx = "";
            int ii = 0;
            int summed = 0;
            int tot = 0;

            for (i = 0; i < s.Length; i++)
            {
                ch = s.Substring(i, 1);
                ch1 = K1.Substring(ii, 1);
                ch2 = K2.Substring(ii, 1);
                ch3 = K3.Substring(ii, 1);
                ch4 = K4.Substring(ii, 1);

                char c = Convert.ToChar(ch);
                tot = c;

                i0 = c;
                i1 = getHexVal(ch1);
                i2 = getHexVal(ch2);
                i3 = getHexVal(ch3);
                i4 = getHexVal(ch4);

                summed = tot + i1 + i2 + i3 + i4;

                hx = toHexStr(summed);
                encStr += hx;
                ii++;

                if (ii > K1.Length || ii > K2.Length)
                {
                    ii = 0;
                }
            }
            return encStr;
        }

        public string decryptString(string s, string K1, string K2, string K3, string K4)
        {
            string encStr = "";
            string ch = "";
            string ch1 = "";
            string ch2 = "";
            string ch3 = "";
            string ch4 = "";
            int i = 0;
            int i0 = 0;
            int i1 = 0;
            int i2 = 0;
            int i3 = 0;
            int i4 = 0;
            string hx = "";
            int ii = 0;
            int diff = 0;
            int tot = 0;
            int iString = 0;

            for (i = 0; i < s.Length; i += 3)
            {
                ch = s.Substring(i, 3);
                ch1 = K1.Substring(ii, 1);
                ch2 = K2.Substring(ii, 1);
                ch3 = K3.Substring(ii, 1);
                ch4 = K4.Substring(ii, 1);

                iString = HexStringToInt(ch);
                i0 = iString;
                i1 = getHexVal(ch1);
                i2 = getHexVal(ch2);
                i3 = getHexVal(ch3);
                i4 = getHexVal(ch4);

                diff = i0 - i1 - i2 - i3 - i4;

                char converted = Convert.ToChar(diff);
                hx = converted.ToString();

                encStr += hx;
                ii++;
                if (ii > K1.Length || ii > K2.Length)
                {
                    ii = 0;
                }
            }
            return encStr;
        }

        //Convert a number to a min 3 hexadecimal string with:
        public string toHexStr(int i)
        {
            // Convert the decimal value to a hexadecimal value in string form.
            string hexString = String.Format("{0:X}", i);
            if (hexString.Length == 1)
            {
                hexString = "00" + hexString;
            }
            else if (hexString.Length == 2)
            {
                hexString = "0" + hexString;
            }
            return hexString;
        }

        public int HexStringToInt(string hexString)
        {
            int i = Convert.ToInt32(hexString, 16);
            return i;
        }

        public string GX()
        {
            string s = "";
            s += "A";
            s += "F";
            s += "6";
            s += "1";
            s += "D";
            s += "r";
            s += "y";
            s += "7";
            s += "4";
            s += "F";
            s += "G";
            s += "Q";
            s += "3";
            s += "B";
            s += "F";

            return s;
        }

        //clsIsolation ISO = new clsIsolation("");
        private int getAdddon(string c)
        {
            int i = 0;
            if (c.ToUpper().Equals("0"))
            {
                i = 50;
            }
            else if (c.ToUpper().Equals("1"))
            {
                i = 1;
            }
            else if (c.ToUpper().Equals("2"))
            {
                i = 2;
            }
            else if (c.ToUpper().Equals("3"))
            {
                i = 3;
            }
            else if (c.ToUpper().Equals("4"))
            {
                i = 4;
            }
            else if (c.ToUpper().Equals("5"))
            {
                i = 5;
            }
            else if (c.ToUpper().Equals("6"))
            {
                i = 6;
            }
            else if (c.ToUpper().Equals("7"))
            {
                i = 7;
            }
            else if (c.ToUpper().Equals("8"))
            {
                i = 8;
            }
            else if (c.ToUpper().Equals("9"))
            {
                i = 9;
            }
            else if (c.ToUpper().Equals("A"))
            {
                i = 10;
            }
            else if (c.ToUpper().Equals("B"))
            {
                i = 11;
            }
            else if (c.ToUpper().Equals("C"))
            {
                i = 12;
            }
            else if (c.ToUpper().Equals("D"))
            {
                i = 13;
            }
            else if (c.ToUpper().Equals("E"))
            {
                i = 14;
            }
            else if (c.ToUpper().Equals("F"))
            {
                i = 15;
            }
            else if (c.ToUpper().Equals("-"))
            {
                i = 16;
            }
            else if (c.ToUpper().Equals("="))
            {
                i = (char)253;
            }
            else
            {
                char c1 = Convert.ToChar(c);
                i = (int)c1;
            }
            return i;
        }

        private int getHexVal(string c)
        {
            int i = 0;
            if (c.ToUpper().Equals("0"))
            {
                i = 50;
            }
            else if (c.ToUpper().Equals("1"))
            {
                i = 1;
            }
            else if (c.ToUpper().Equals("2"))
            {
                i = 2;
            }
            else if (c.ToUpper().Equals("3"))
            {
                i = 3;
            }
            else if (c.ToUpper().Equals("4"))
            {
                i = 4;
            }
            else if (c.ToUpper().Equals("5"))
            {
                i = 5;
            }
            else if (c.ToUpper().Equals("6"))
            {
                i = 6;
            }
            else if (c.ToUpper().Equals("7"))
            {
                i = 7;
            }
            else if (c.ToUpper().Equals("8"))
            {
                i = 8;
            }
            else if (c.ToUpper().Equals("9"))
            {
                i = 9;
            }
            else if (c.ToUpper().Equals("A"))
            {
                i = 10;
            }
            else if (c.ToUpper().Equals("B"))
            {
                i = 11;
            }
            else if (c.ToUpper().Equals("C"))
            {
                i = 12;
            }
            else if (c.ToUpper().Equals("D"))
            {
                i = 13;
            }
            else if (c.ToUpper().Equals("E"))
            {
                i = 14;
            }
            else if (c.ToUpper().Equals("F"))
            {
                i = 15;
            }
            else if (c.ToUpper().Equals("-"))
            {
                i = 16;
            }
            else if (c.ToUpper().Equals("="))
            {
                i = (char)253;
            }
            else
            {
                char c1 = Convert.ToChar(c);
                i = (int)c1;
            }
            return i;
        }

        /// <summary>
        /// Encrypts the specified phrase.
        /// </summary>
        /// <param name="phrase">The phrase.</param>
        /// <param name="encKey">The enc key.</param>
        /// <returns></returns>
        public string Encrypt(string phrase, string encKey)
        {
            string cs = "";
            string es = "";
            int j = 0;
            int k = encKey.Length;
            string RetStr = "";

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }
                cs = phrase.Substring(i, 1);
                es = encKey.Substring(j, 1);
                int ix = getAdddon(es);

                int i1 = Convert.ToChar(cs);
                i1 = i1 + ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j++;
            }

            string xChar = new string((char)253, 1);
            string xStr = RetStr.Replace("=", xChar);

            return xStr;
        }

        /// <summary>
        /// Decrypts the specified phrase.
        /// </summary>
        /// <param name="phrase">The phrase.</param>
        /// <param name="encKey">The enc key.</param>
        /// <returns></returns>
        public string Decrypt(string phrase, string encKey)
        {
            string xChar = new string((char)253, 1);
            string xphrase = phrase.Replace(xChar, "=");
            phrase = xphrase;

            string cs = "";
            string es = "";
            int j = 0;
            int k = encKey.Length;
            string RetStr = "";

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }
                cs = phrase.Substring(i, 1);
                es = encKey.Substring(j, 1);
                int ix = getAdddon(es);

                int i1 = Convert.ToChar(cs);
                i1 = i1 - ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j++;
            }
            return RetStr;
        }

        /// <summary>
        /// LUNCGUIDs the specified phrase.
        /// </summary>
        /// <param name="phrase">The phrase.</param>
        /// <param name="strGuid">The STR GUID.</param>
        /// <returns></returns>
        public string LUNCGUID(string phrase, string strGuid)
        {
            string xChar = new string((char)253, 1);
            string xphrase = phrase.Replace(xChar, "=");
            phrase = xphrase;

            string cs = "";
            string es = "";
            int j = 0;
            int k = strGuid.Length;
            string RetStr = "";

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }
                cs = phrase.Substring(i, 1);
                es = strGuid.Substring(j, 1);
                int ix = getAdddon(es);

                int i1 = Convert.ToChar(cs);
                i1 = i1 - ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j++;
            }
            return RetStr;
        }

        /// <summary>
        /// LENCGUIDs the specified phrase.
        /// </summary>
        /// <param name="phrase">The phrase.</param>
        /// <param name="strGuid">The STR GUID.</param>
        /// <returns></returns>
        public string LENCGUID(string phrase, string strGuid)
        {
            string cs = "";
            string es = "";
            int j = 0;
            int k = strGuid.Length;
            string RetStr = "";

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }
                cs = phrase.Substring(i, 1);
                es = strGuid.Substring(j, 1);
                int ix = getAdddon(es);

                int i1 = Convert.ToChar(cs);
                i1 = i1 + ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j++;
            }

            string xChar = new string((char)253, 1);
            string xStr = RetStr.Replace("=", xChar);

            return xStr;
        }

        public string LENC(string phrase)
        {
            int IDX = 0;
            string cs = "";
            string es = "";
            //  Char c = 'a';

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Convert.ToChar(cs);
                ii = ii + 50 + IDX;
                if (IDX > 30)
                {
                    IDX = 0;
                }
                char xx = Convert.ToChar(ii);
                es += xx.ToString();
            }
            return es;
        }

        public string LUNC(string phrase)
        {
            int IDX = 0;
            string cs = "";
            string es = "";
            //  Char c = 'a';

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Convert.ToChar(cs);
                ii = ii - 50 - IDX;
                if (IDX > 30)
                {
                    IDX = 0;
                }
                char xx = Convert.ToChar(ii);
                es += xx.ToString();
            }

            return es;
        }

        public string strEncrypt(string phrase)
        {
            int IDX = 0;
            string cs = "";
            string es = "";
            //  Char c = 'a';

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Convert.ToChar(cs);
                ii = ii + 50 + IDX;
                if (IDX > 22)
                {
                    IDX = 0;
                }
                char xx = Convert.ToChar(ii);
                es += xx.ToString();
            }
            return es;
        }

        public string strDecrypt(string phrase)
        {
            int IDX = 0;
            string cs = "";
            string es = "";
            //  Char c = 'a';

            for (int i = 0; i <= (phrase.Length - 1); i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Convert.ToChar(cs);
                ii = ii - 50 - IDX;
                if (IDX > 22)
                {
                    IDX = 0;
                }
                char xx = Convert.ToChar(ii);
                es += xx.ToString();
            }

            return es;
        }
    }
}