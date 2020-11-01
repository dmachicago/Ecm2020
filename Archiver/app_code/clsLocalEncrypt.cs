using global::System;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsLocalEncrypt
    {
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
                i = Strings.AscW(Convert.ToChar(253));
            }
            else
            {
                char c1 = Convert.ToChar(c);
                i = Strings.AscW(c1);
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
            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }

                cs = phrase.Substring(i, 1);
                es = encKey.Substring(j, 1);
                int ix = getAdddon(es);
                int i1 = Strings.AscW(Convert.ToChar(cs));
                i1 = i1 + ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j += 1;
            }

            string xChar = new string('ý', 1);
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
            string xChar = new string('ý', 1);
            string xphrase = phrase.Replace(xChar, "=");
            phrase = xphrase;
            string cs = "";
            string es = "";
            int j = 0;
            int k = encKey.Length;
            string RetStr = "";
            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }

                cs = phrase.Substring(i, 1);
                es = encKey.Substring(j, 1);
                int ix = getAdddon(es);
                int i1 = Strings.AscW(Convert.ToChar(cs));
                i1 = i1 - ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j += 1;
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
            string xChar = new string('ý', 1);
            string xphrase = phrase.Replace(xChar, "=");
            phrase = xphrase;
            string cs = "";
            string es = "";
            int j = 0;
            int k = strGuid.Length;
            string RetStr = "";
            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }

                cs = phrase.Substring(i, 1);
                es = strGuid.Substring(j, 1);
                int ix = getAdddon(es);
                int i1 = Strings.AscW(Convert.ToChar(cs));
                i1 = i1 - ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j += 1;
            }

            return RetStr;
        }

        public string LENCGUID(string phrase, string strGuid)
        {
            string cs = "";
            string es = "";
            int j = 0;
            int k = strGuid.Length;
            string RetStr = "";
            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                if (j >= k - 1)
                {
                    j = 0;
                }

                cs = phrase.Substring(i, 1);
                es = strGuid.Substring(j, 1);
                int ix = getAdddon(es);
                int i1 = Strings.AscW(Convert.ToChar(cs));
                i1 = i1 + ix;
                char xx = Convert.ToChar(i1);
                RetStr += xx.ToString();
                j += 1;
            }

            string xChar = new string('ý', 1);
            string xStr = RetStr.Replace("=", xChar);
            return xStr;
        }

        public string LENC(string phrase)
        {
            int IDX = 0;
            string cs = "";
            string es = "";
            // Char c = 'a';

            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Strings.AscW(Convert.ToChar(cs));
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
            // Char c = 'a';

            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Strings.AscW(Convert.ToChar(cs));
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
            // Char c = 'a';

            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Strings.AscW(Convert.ToChar(cs));
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
            // Char c = 'a';

            for (int i = 0, loopTo = phrase.Length - 1; i <= loopTo; i++)
            {
                IDX += 1;
                cs = phrase.Substring(i, 1);
                int ii = Strings.AscW(Convert.ToChar(cs));
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