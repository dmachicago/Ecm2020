using System;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    public partial class frmLocalParameters
    {
        public frmLocalParameters()
        {
            // This call is required by the Windows Form Designer.
            InitializeComponent();
            _dgParms.Name = "dgParms";
        }

        public void LoadParms()
        {
        }

        public bool UpdateParm()
        {
            bool B = true;
            try
            {
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool DeleteParm()
        {
            bool B = true;
            try
            {
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        public bool AddParm()
        {
            bool B = true;
            try
            {
            }
            catch (Exception ex)
            {
                B = false;
            }

            return B;
        }

        private void DataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}