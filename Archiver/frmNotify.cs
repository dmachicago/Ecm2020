using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmNotify
    {
        public frmNotify()
        {
            InitializeComponent();
        }

        public string Title = "EMAIL";

        private void frmNotify_Load(object sender, EventArgs e)
        {
            Text = Title;
        }
    }
}