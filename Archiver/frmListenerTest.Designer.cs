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
    public partial class FrmListenerTest : Form
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
            txtDir = new TextBox();
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            _Button2 = new Button();
            _Button2.Click += new EventHandler(Button2_Click);
            lbOutput = new ListBox();
            ckStop = new CheckBox();
            SB = new TextBox();
            _btnViewLog = new Button();
            _btnViewLog.Click += new EventHandler(btnViewLog_Click);
            SuspendLayout();
            // 
            // txtDir
            // 
            txtDir.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            txtDir.Location = new Point(37, 76);
            txtDir.Name = "txtDir";
            txtDir.Size = new Size(676, 22);
            txtDir.TabIndex = 0;
            // 
            // Button1
            // 
            _Button1.Location = new Point(37, 35);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(123, 35);
            _Button1.TabIndex = 1;
            _Button1.Text = "Select DIR";
            _Button1.UseVisualStyleBackColor = true;
            // 
            // Button2
            // 
            _Button2.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _Button2.Location = new Point(166, 35);
            _Button2.Name = "_Button2";
            _Button2.Size = new Size(123, 35);
            _Button2.TabIndex = 2;
            _Button2.Text = "Start Listener";
            _Button2.UseVisualStyleBackColor = true;
            // 
            // lbOutput
            // 
            lbOutput.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            lbOutput.FormattingEnabled = true;
            lbOutput.ItemHeight = 16;
            lbOutput.Location = new Point(37, 155);
            lbOutput.Name = "lbOutput";
            lbOutput.Size = new Size(676, 372);
            lbOutput.TabIndex = 4;
            // 
            // ckStop
            // 
            ckStop.AutoSize = true;
            ckStop.Location = new Point(424, 43);
            ckStop.Name = "ckStop";
            ckStop.Size = new Size(178, 21);
            ckStop.TabIndex = 5;
            ckStop.Text = "Check To Stop Listener";
            ckStop.UseVisualStyleBackColor = true;
            // 
            // SB
            // 
            SB.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            SB.Location = new Point(37, 127);
            SB.Name = "SB";
            SB.ReadOnly = true;
            SB.Size = new Size(676, 22);
            SB.TabIndex = 6;
            // 
            // btnViewLog
            // 
            _btnViewLog.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnViewLog.Location = new Point(295, 35);
            _btnViewLog.Name = "_btnViewLog";
            _btnViewLog.Size = new Size(123, 35);
            _btnViewLog.TabIndex = 7;
            _btnViewLog.Text = "View Capture";
            _btnViewLog.UseVisualStyleBackColor = true;
            // 
            // FrmListenerTest
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(758, 565);
            Controls.Add(_btnViewLog);
            Controls.Add(SB);
            Controls.Add(ckStop);
            Controls.Add(lbOutput);
            Controls.Add(_Button2);
            Controls.Add(_Button1);
            Controls.Add(txtDir);
            Name = "FrmListenerTest";
            Text = "frmListenerTest";
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtDir;
        private Button _Button1;

        internal Button Button1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button1 != null)
                {
                    _Button1.Click -= Button1_Click;
                }

                _Button1 = value;
                if (_Button1 != null)
                {
                    _Button1.Click += Button1_Click;
                }
            }
        }

        private Button _Button2;

        internal Button Button2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button2 != null)
                {
                    _Button2.Click -= Button2_Click;
                }

                _Button2 = value;
                if (_Button2 != null)
                {
                    _Button2.Click += Button2_Click;
                }
            }
        }

        internal ListBox lbOutput;
        internal CheckBox ckStop;
        internal TextBox SB;
        private Button _btnViewLog;

        internal Button btnViewLog
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnViewLog;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnViewLog != null)
                {
                    _btnViewLog.Click -= btnViewLog_Click;
                }

                _btnViewLog = value;
                if (_btnViewLog != null)
                {
                    _btnViewLog.Click += btnViewLog_Click;
                }
            }
        }
    }
}