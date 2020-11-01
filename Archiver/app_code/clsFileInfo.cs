using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsFileInfo
    {
        private string FileKey = "";

        public void RemoveBadChars(ref string FQN)
        {
            for (int i = 1, loopTo = FQN.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(FQN, i, 1);
                switch (CH ?? "")
                {
                    case "/":
                        {
                            StringType.MidStmtStr(ref FQN, i, 1, ".");
                            break;
                        }

                    case "'":
                        {
                            StringType.MidStmtStr(ref FQN, i, 1, ".");
                            break;
                        }

                    case " ":
                        {
                            StringType.MidStmtStr(ref FQN, i, 1, ".");
                            break;
                        }

                    case ":":
                        {
                            StringType.MidStmtStr(ref FQN, i, 1, ".");
                            break;
                        }
                }
            }
        }
    }
}