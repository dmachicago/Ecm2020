using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmNotifyContact
    {
        public frmNotifyContact()
        {
            InitializeComponent();
        }

        public string Title = "CONTACTS";

        private void frmNotifyContact_Load(object sender, EventArgs e)
        {
            Text = Title;
        }
    }
}