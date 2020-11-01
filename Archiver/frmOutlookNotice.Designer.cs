using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmOutlookNotice : Form
    {

        // Form overrides dispose to clean up the component list.
        [DebuggerNonUserCode()]
        protected override void Dispose(bool disposing)
        {
            try
            {
                if (disposing && components is object)
                {
                    components.Dispose();
                }
            }
            finally
            {
                base.Dispose(disposing);
            }
        }

        // Required by the Windows Form Designer
        private System.ComponentModel.IContainer components;

        // NOTE: The following procedure is required by the Windows Form Designer
        // It can be modified using the Windows Form Designer.  
        // Do not modify it using the code editor.
        [DebuggerStepThrough()]
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            Label1 = new Label();
            Label2 = new Label();
            Label3 = new Label();
            Label4 = new Label();
            Label5 = new Label();
            _btnTerminate = new Button();
            _btnTerminate.Click += new EventHandler(btnTerminate_Click);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            StatusStrip1 = new StatusStrip();
            statElapsedTime = new ToolStripStatusLabel();
            PB = new ToolStripProgressBar();
            StatusStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Font = new Font("Microsoft Sans Serif", 15.75f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label1.Location = new Point(14, 16);
            Label1.Name = "Label1";
            Label1.Size = new Size(86, 25);
            Label1.TabIndex = 0;
            Label1.Text = "Notice:";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(14, 49);
            Label2.Name = "Label2";
            Label2.Size = new Size(307, 13);
            Label2.TabIndex = 1;
            Label2.Text = "Outlook is running. This can cause ECM to be unstable at time. ";
            // 
            // Label3
            // 
            Label3.AutoSize = true;
            Label3.Location = new Point(14, 70);
            Label3.Name = "Label3";
            Label3.Size = new Size(356, 13);
            Label3.TabIndex = 2;
            Label3.Text = "If this screen does not close in a few seconds, please terminate all running";
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(14, 91);
            Label4.Name = "Label4";
            Label4.Size = new Size(331, 13);
            Label4.TabIndex = 3;
            Label4.Text = "instances of Outlook by pressing the Terminate button and execution";
            // 
            // Label5
            // 
            Label5.AutoSize = true;
            Label5.Location = new Point(14, 112);
            Label5.Name = "Label5";
            Label5.Size = new Size(85, 13);
            Label5.TabIndex = 4;
            Label5.Text = "should continue.";
            // 
            // btnTerminate
            // 
            _btnTerminate.Location = new Point(265, 124);
            _btnTerminate.Name = "_btnTerminate";
            _btnTerminate.Size = new Size(105, 26);
            _btnTerminate.TabIndex = 5;
            _btnTerminate.Text = "Terminate";
            _btnTerminate.UseVisualStyleBackColor = true;
            // 
            // Timer1
            // 
            _Timer1.Enabled = true;
            _Timer1.Interval = 1000;
            // 
            // StatusStrip1
            // 
            StatusStrip1.Items.AddRange(new ToolStripItem[] { statElapsedTime, PB });
            StatusStrip1.Location = new Point(0, 163);
            StatusStrip1.Name = "StatusStrip1";
            StatusStrip1.Size = new Size(389, 22);
            StatusStrip1.TabIndex = 6;
            StatusStrip1.Text = "StatusStrip1";
            // 
            // statElapsedTime
            // 
            statElapsedTime.Name = "statElapsedTime";
            statElapsedTime.Size = new Size(77, 17);
            statElapsedTime.Text = "Elapsed Time";
            // 
            // PB
            // 
            PB.Name = "PB";
            PB.Size = new Size(100, 16);
            // 
            // frmOutlookNotice
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(389, 185);
            Controls.Add(StatusStrip1);
            Controls.Add(_btnTerminate);
            Controls.Add(Label5);
            Controls.Add(Label4);
            Controls.Add(Label3);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Name = "frmOutlookNotice";
            Text = "Notification       (frmOutlookNotice)";
            TopMost = true;
            StatusStrip1.ResumeLayout(false);
            StatusStrip1.PerformLayout();
            Load += new EventHandler(frmOutlookNotice_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal Label Label2;
        internal Label Label3;
        internal Label Label4;
        internal Label Label5;
        private Button _btnTerminate;

        internal Button btnTerminate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnTerminate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnTerminate != null)
                {
                    _btnTerminate.Click -= btnTerminate_Click;
                }

                _btnTerminate = value;
                if (_btnTerminate != null)
                {
                    _btnTerminate.Click += btnTerminate_Click;
                }
            }
        }

        private Timer _Timer1;

        internal Timer Timer1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Timer1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Timer1 != null)
                {
                    _Timer1.Tick -= Timer1_Tick;
                }

                _Timer1 = value;
                if (_Timer1 != null)
                {
                    _Timer1.Tick += Timer1_Tick;
                }
            }
        }

        internal StatusStrip StatusStrip1;
        internal ToolStripStatusLabel statElapsedTime;
        internal ToolStripProgressBar PB;
    }
}