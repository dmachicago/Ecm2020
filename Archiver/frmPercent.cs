using MODI;

namespace EcmArchiver
{
    public partial class frmPercent
    {
        public double fSize = 0d;

        public frmPercent()
        {
            // This call is required by the designer.
            InitializeComponent();

            // Add any initialization after the InitializeComponent() call.

            if (fSize == 0d)
            {
                Label1.Visible = false;
            }
            else
            {
                Label1.Text = "Loading File of Size: " + fSize;
            }
        }
    }
}