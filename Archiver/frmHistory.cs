using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmHistory
    {
        public frmHistory()
        {
            InitializeComponent();
            _lbHistory.Name = "lbHistory";
        }

        private void frmHistory_Load(object sender, EventArgs e)
        {
            AddHistoryItems();
        }

        public void AddHistoryItems()
        {
            lbHistory.Items.Clear();
            lbHistory.Items.Add("2010.12.27 - Force a backup of contacts if outlook is installed. (ECM)");
            lbHistory.Items.Add("2010.12.07 - Added the PDF OCR Extraction and text extraction functionality back into the standard license. (ECM)");
            lbHistory.Items.Add("2010.12.07 - Removed all references to Crystal Reports as Microsoft sold the rights. (ECM)");
            lbHistory.Items.Add("2010.11.30 - Allowed the EMAIL folder display window to expand. (Advent)");
            lbHistory.Items.Add("2010.11.25 - Created as a standalone applciation. (ECM)");
        }

        private void lbHistory_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
    }
}