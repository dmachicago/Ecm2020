﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ToolBeltMgt
{
    public partial class frmLogin : Form
    {
                public frmLogin ()
        {
            InitializeComponent ();
        }

        private void frmLogin_Load (object sender, EventArgs e)
        {

        }

        private void button1_Click (object sender, EventArgs e)
        {

            DB.svrname = cbServer.Text;
            DB.uid = txtUid.Text;
            DB.pw = txtPw.Text;

            DB.svrConnected = DB.setConnection ();

            if (DB.svrConnected == 1)
            {
                tsLoginStatus.Text = "LOGGED IN";
                this.Close ();
            }
            else {
                tsLoginStatus.Text = "NOT LOGGED IN";
            }
        }
    }
}