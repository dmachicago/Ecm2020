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
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1726")]
    public partial class LoginForm1 : Form
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

        internal PictureBox LogoPictureBox;
        internal Label UsernameLabel;
        internal Label PasswordLabel;
        internal TextBox txtLoginID;
        internal TextBox PasswordTextBox;
        private Button _OK;

        internal Button OK
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _OK;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_OK != null)
                {
                    _OK.Click -= OK_Click;
                }

                _OK = value;
                if (_OK != null)
                {
                    _OK.Click += OK_Click;
                }
            }
        }

        private Button _Cancel;

        internal Button Cancel
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Cancel;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Cancel != null)
                {
                    _Cancel.Click -= Cancel_Click;
                }

                _Cancel = value;
                if (_Cancel != null)
                {
                    _Cancel.Click += Cancel_Click;
                }
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(LoginForm1));
            LogoPictureBox = new PictureBox();
            UsernameLabel = new Label();
            PasswordLabel = new Label();
            txtLoginID = new TextBox();
            PasswordTextBox = new TextBox();
            _OK = new Button();
            _OK.Click += new EventHandler(OK_Click);
            _Cancel = new Button();
            _Cancel.Click += new EventHandler(Cancel_Click);
            TT = new ToolTip(components);
            _btnChgPW = new Button();
            _btnChgPW.Click += new EventHandler(btnChgPW_Click);
            lblRepo = new Label();
            _ckDisableListener = new CheckBox();
            _ckDisableListener.CheckedChanged += new EventHandler(ckDisableListener_CheckedChanged);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            _ckSaveAsDefaultLogin = new CheckBox();
            _ckSaveAsDefaultLogin.CheckedChanged += new EventHandler(ckSaveAsDefaultLogin_CheckedChanged);
            lblAttachedMachineName = new Label();
            lblCurrUserGuidID = new Label();
            lblServerInstanceName = new Label();
            lblLocalIP = new Label();
            lblServerMachineName = new Label();
            SB = new TextBox();
            Panel2 = new Panel();
            _ckAutoExecute = new CheckBox();
            _ckAutoExecute.CheckedChanged += new EventHandler(ckAutoExecute_CheckedChanged);
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            lblNetworkID = new Label();
            _ckCancelAutoLogin = new CheckBox();
            _ckCancelAutoLogin.CheckedChanged += new EventHandler(ckCancelAutoLogin_CheckedChanged);
            lblMsg = new Label();
            _Timer2 = new Timer(components);
            _Timer2.Tick += new EventHandler(Timer2_Tick);
            Label4 = new Label();
            Label5 = new Label();
            Label6 = new Label();
            _PictureBox1 = new PictureBox();
            _PictureBox1.MouseEnter += new EventHandler(PictureBox1_MouseEnter);
            _PictureBox1.MouseLeave += new EventHandler(PictureBox1_MouseLeave);
            lblExecTime = new Label();
            _btnStopExec = new Button();
            _btnStopExec.Click += new EventHandler(btnStopExec_Click);
            _Timer3 = new Timer(components);
            _Timer3.Tick += new EventHandler(Timer3_Tick);
            ((System.ComponentModel.ISupportInitialize)LogoPictureBox).BeginInit();
            Panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)_PictureBox1).BeginInit();
            SuspendLayout();
            // 
            // LogoPictureBox
            // 
            LogoPictureBox.Image = (Image)resources.GetObject("LogoPictureBox.Image");
            LogoPictureBox.Location = new Point(16, 0);
            LogoPictureBox.Margin = new Padding(4);
            LogoPictureBox.Name = "LogoPictureBox";
            LogoPictureBox.Size = new Size(129, 96);
            LogoPictureBox.TabIndex = 0;
            LogoPictureBox.TabStop = false;
            // 
            // UsernameLabel
            // 
            UsernameLabel.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            UsernameLabel.ForeColor = Color.Maroon;
            UsernameLabel.Location = new Point(19, 0);
            UsernameLabel.Margin = new Padding(4, 0, 4, 0);
            UsernameLabel.Name = "UsernameLabel";
            UsernameLabel.Size = new Size(293, 28);
            UsernameLabel.TabIndex = 0;
            UsernameLabel.Text = "Login ID";
            UsernameLabel.TextAlign = ContentAlignment.MiddleLeft;
            // 
            // PasswordLabel
            // 
            PasswordLabel.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            PasswordLabel.ForeColor = Color.Maroon;
            PasswordLabel.Location = new Point(316, 0);
            PasswordLabel.Margin = new Padding(4, 0, 4, 0);
            PasswordLabel.Name = "PasswordLabel";
            PasswordLabel.Size = new Size(247, 28);
            PasswordLabel.TabIndex = 2;
            PasswordLabel.Text = "&Password";
            PasswordLabel.TextAlign = ContentAlignment.MiddleLeft;
            // 
            // txtLoginID
            // 
            txtLoginID.BackColor = Color.Gainsboro;
            txtLoginID.Location = new Point(19, 32);
            txtLoginID.Margin = new Padding(4);
            txtLoginID.Name = "txtLoginID";
            txtLoginID.Size = new Size(292, 22);
            txtLoginID.TabIndex = 1;
            // 
            // PasswordTextBox
            // 
            PasswordTextBox.BackColor = Color.Gainsboro;
            PasswordTextBox.Location = new Point(320, 32);
            PasswordTextBox.Margin = new Padding(4);
            PasswordTextBox.Name = "PasswordTextBox";
            PasswordTextBox.PasswordChar = '*';
            PasswordTextBox.Size = new Size(241, 22);
            PasswordTextBox.TabIndex = 3;
            // 
            // OK
            // 
            _OK.Location = new Point(437, 98);
            _OK.Margin = new Padding(4);
            _OK.Name = "_OK";
            _OK.Size = new Size(125, 28);
            _OK.TabIndex = 4;
            _OK.Text = "&Login";
            // 
            // Cancel
            // 
            _Cancel.DialogResult = DialogResult.Cancel;
            _Cancel.Location = new Point(237, 98);
            _Cancel.Margin = new Padding(4);
            _Cancel.Name = "_Cancel";
            _Cancel.Size = new Size(125, 28);
            _Cancel.TabIndex = 5;
            _Cancel.Text = "&Cancel";
            // 
            // btnChgPW
            // 
            _btnChgPW.Location = new Point(19, 98);
            _btnChgPW.Margin = new Padding(4);
            _btnChgPW.Name = "_btnChgPW";
            _btnChgPW.Size = new Size(125, 28);
            _btnChgPW.TabIndex = 22;
            _btnChgPW.Text = "&Password";
            TT.SetToolTip(_btnChgPW, "Press to change your password.");
            // 
            // lblRepo
            // 
            lblRepo.AutoSize = true;
            lblRepo.Location = new Point(665, 199);
            lblRepo.Margin = new Padding(4, 0, 4, 0);
            lblRepo.Name = "lblRepo";
            lblRepo.Size = new Size(76, 17);
            lblRepo.TabIndex = 28;
            lblRepo.Text = "Repository";
            TT.SetToolTip(lblRepo, "Selected repository from Gateway");
            // 
            // ckDisableListener
            // 
            _ckDisableListener.AutoSize = true;
            _ckDisableListener.BackColor = Color.DarkRed;
            _ckDisableListener.ForeColor = Color.Yellow;
            _ckDisableListener.Location = new Point(19, 134);
            _ckDisableListener.Name = "_ckDisableListener";
            _ckDisableListener.Size = new Size(139, 21);
            _ckDisableListener.TabIndex = 25;
            _ckDisableListener.Text = "Disable Listeners";
            TT.SetToolTip(_ckDisableListener, "Disable listener processing for this run only.");
            _ckDisableListener.UseVisualStyleBackColor = false;
            // 
            // Timer1
            // 
            // 
            // ckSaveAsDefaultLogin
            // 
            _ckSaveAsDefaultLogin.AutoSize = true;
            _ckSaveAsDefaultLogin.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckSaveAsDefaultLogin.ForeColor = Color.Maroon;
            _ckSaveAsDefaultLogin.Location = new Point(19, 64);
            _ckSaveAsDefaultLogin.Margin = new Padding(4);
            _ckSaveAsDefaultLogin.Name = "_ckSaveAsDefaultLogin";
            _ckSaveAsDefaultLogin.Size = new Size(286, 21);
            _ckSaveAsDefaultLogin.TabIndex = 6;
            _ckSaveAsDefaultLogin.Text = "Save as default login for auto-login";
            _ckSaveAsDefaultLogin.UseVisualStyleBackColor = true;
            // 
            // lblAttachedMachineName
            // 
            lblAttachedMachineName.AutoSize = true;
            lblAttachedMachineName.Location = new Point(665, 17);
            lblAttachedMachineName.Margin = new Padding(4, 0, 4, 0);
            lblAttachedMachineName.Name = "lblAttachedMachineName";
            lblAttachedMachineName.Size = new Size(102, 17);
            lblAttachedMachineName.TabIndex = 16;
            lblAttachedMachineName.Text = "Machine Name";
            // 
            // lblCurrUserGuidID
            // 
            lblCurrUserGuidID.AutoSize = true;
            lblCurrUserGuidID.Location = new Point(665, 46);
            lblCurrUserGuidID.Margin = new Padding(4, 0, 4, 0);
            lblCurrUserGuidID.Name = "lblCurrUserGuidID";
            lblCurrUserGuidID.Size = new Size(55, 17);
            lblCurrUserGuidID.TabIndex = 17;
            lblCurrUserGuidID.Text = "User ID";
            // 
            // lblServerInstanceName
            // 
            lblServerInstanceName.AutoSize = true;
            lblServerInstanceName.Location = new Point(665, 108);
            lblServerInstanceName.Margin = new Padding(4, 0, 4, 0);
            lblServerInstanceName.Name = "lblServerInstanceName";
            lblServerInstanceName.Size = new Size(102, 17);
            lblServerInstanceName.TabIndex = 19;
            lblServerInstanceName.Text = "Instance Name";
            // 
            // lblLocalIP
            // 
            lblLocalIP.AutoSize = true;
            lblLocalIP.Location = new Point(665, 80);
            lblLocalIP.Margin = new Padding(4, 0, 4, 0);
            lblLocalIP.Name = "lblLocalIP";
            lblLocalIP.Size = new Size(58, 17);
            lblLocalIP.TabIndex = 18;
            lblLocalIP.Text = "Local IP";
            // 
            // lblServerMachineName
            // 
            lblServerMachineName.AutoSize = true;
            lblServerMachineName.Location = new Point(665, 140);
            lblServerMachineName.Margin = new Padding(4, 0, 4, 0);
            lblServerMachineName.Name = "lblServerMachineName";
            lblServerMachineName.Size = new Size(91, 17);
            lblServerMachineName.TabIndex = 20;
            lblServerMachineName.Text = "Server Name";
            // 
            // SB
            // 
            SB.BackColor = Color.WhiteSmoke;
            SB.Location = new Point(13, 280);
            SB.Margin = new Padding(4);
            SB.Name = "SB";
            SB.Size = new Size(916, 22);
            SB.TabIndex = 21;
            // 
            // Panel2
            // 
            Panel2.BorderStyle = BorderStyle.Fixed3D;
            Panel2.Controls.Add(_ckDisableListener);
            Panel2.Controls.Add(_ckAutoExecute);
            Panel2.Controls.Add(_Button1);
            Panel2.Controls.Add(_btnChgPW);
            Panel2.Controls.Add(_ckSaveAsDefaultLogin);
            Panel2.Controls.Add(_Cancel);
            Panel2.Controls.Add(_OK);
            Panel2.Controls.Add(PasswordTextBox);
            Panel2.Controls.Add(txtLoginID);
            Panel2.Controls.Add(PasswordLabel);
            Panel2.Controls.Add(UsernameLabel);
            Panel2.Location = new Point(16, 100);
            Panel2.Margin = new Padding(4);
            Panel2.Name = "Panel2";
            Panel2.Size = new Size(603, 163);
            Panel2.TabIndex = 24;
            // 
            // ckAutoExecute
            // 
            _ckAutoExecute.AutoSize = true;
            _ckAutoExecute.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckAutoExecute.ForeColor = Color.Maroon;
            _ckAutoExecute.Location = new Point(320, 64);
            _ckAutoExecute.Margin = new Padding(4);
            _ckAutoExecute.Name = "_ckAutoExecute";
            _ckAutoExecute.Size = new Size(126, 21);
            _ckAutoExecute.TabIndex = 24;
            _ckAutoExecute.Text = "Auto-Execute";
            _ckAutoExecute.UseVisualStyleBackColor = true;
            // 
            // Button1
            // 
            _Button1.DialogResult = DialogResult.Cancel;
            _Button1.Location = new Point(438, 127);
            _Button1.Margin = new Padding(4);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(125, 28);
            _Button1.TabIndex = 23;
            _Button1.Text = "Show CS";
            _Button1.Visible = false;
            // 
            // lblNetworkID
            // 
            lblNetworkID.AutoSize = true;
            lblNetworkID.Location = new Point(665, 171);
            lblNetworkID.Margin = new Padding(4, 0, 4, 0);
            lblNetworkID.Name = "lblNetworkID";
            lblNetworkID.Size = new Size(91, 17);
            lblNetworkID.TabIndex = 25;
            lblNetworkID.Text = "Server Name";
            // 
            // ckCancelAutoLogin
            // 
            _ckCancelAutoLogin.AutoSize = true;
            _ckCancelAutoLogin.Location = new Point(440, 33);
            _ckCancelAutoLogin.Margin = new Padding(4);
            _ckCancelAutoLogin.Name = "_ckCancelAutoLogin";
            _ckCancelAutoLogin.Size = new Size(141, 21);
            _ckCancelAutoLogin.TabIndex = 26;
            _ckCancelAutoLogin.Text = "Cancel Auto-login";
            _ckCancelAutoLogin.UseVisualStyleBackColor = true;
            // 
            // lblMsg
            // 
            lblMsg.AutoSize = true;
            lblMsg.Font = new Font("Microsoft Sans Serif", 9.75f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            lblMsg.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(192)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)));
            lblMsg.Location = new Point(436, 10);
            lblMsg.Margin = new Padding(4, 0, 4, 0);
            lblMsg.Name = "lblMsg";
            lblMsg.Size = new Size(84, 20);
            lblMsg.TabIndex = 27;
            lblMsg.Text = "Message";
            // 
            // Timer2
            // 
            _Timer2.Interval = 1000;
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(665, 246);
            Label4.Name = "Label4";
            Label4.Size = new Size(40, 17);
            Label4.TabIndex = 29;
            Label4.Text = "3.2.3";
            // 
            // Label5
            // 
            Label5.AutoSize = true;
            Label5.Font = new Font("Microsoft Sans Serif", 24.0f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            Label5.ForeColor = Color.Navy;
            Label5.Location = new Point(153, 2);
            Label5.Margin = new Padding(4, 0, 4, 0);
            Label5.Name = "Label5";
            Label5.Size = new Size(112, 46);
            Label5.TabIndex = 30;
            Label5.Text = "ECM";
            // 
            // Label6
            // 
            Label6.AutoSize = true;
            Label6.Font = new Font("Microsoft Sans Serif", 21.75f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            Label6.ForeColor = Color.Navy;
            Label6.Location = new Point(203, 48);
            Label6.Margin = new Padding(4, 0, 4, 0);
            Label6.Name = "Label6";
            Label6.Size = new Size(139, 42);
            Label6.TabIndex = 31;
            Label6.Text = "Library";
            // 
            // PictureBox1
            // 
            _PictureBox1.Image = (Image)resources.GetObject("PictureBox1.Image");
            _PictureBox1.Location = new Point(840, 2);
            _PictureBox1.Margin = new Padding(4);
            _PictureBox1.Name = "_PictureBox1";
            _PictureBox1.Size = new Size(109, 52);
            _PictureBox1.SizeMode = PictureBoxSizeMode.StretchImage;
            _PictureBox1.TabIndex = 32;
            _PictureBox1.TabStop = false;
            // 
            // lblExecTime
            // 
            lblExecTime.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            lblExecTime.ForeColor = Color.Maroon;
            lblExecTime.Location = new Point(88, 314);
            lblExecTime.Margin = new Padding(4, 0, 4, 0);
            lblExecTime.Name = "lblExecTime";
            lblExecTime.Size = new Size(292, 31);
            lblExecTime.TabIndex = 25;
            lblExecTime.Text = "Executing in 0 Secs.";
            lblExecTime.TextAlign = ContentAlignment.MiddleLeft;
            lblExecTime.Visible = false;
            // 
            // btnStopExec
            // 
            _btnStopExec.DialogResult = DialogResult.Cancel;
            _btnStopExec.Location = new Point(13, 315);
            _btnStopExec.Margin = new Padding(4);
            _btnStopExec.Name = "_btnStopExec";
            _btnStopExec.Size = new Size(67, 28);
            _btnStopExec.TabIndex = 33;
            _btnStopExec.Text = "STOP";
            // 
            // Timer3
            // 
            _Timer3.Interval = 1000;
            // 
            // LoginForm1
            // 
            AcceptButton = _OK;
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = SystemColors.ButtonHighlight;
            BackgroundImageLayout = ImageLayout.Stretch;
            CancelButton = _Cancel;
            ClientSize = new Size(949, 356);
            Controls.Add(_btnStopExec);
            Controls.Add(lblExecTime);
            Controls.Add(_PictureBox1);
            Controls.Add(Label6);
            Controls.Add(Label5);
            Controls.Add(Label4);
            Controls.Add(lblRepo);
            Controls.Add(lblMsg);
            Controls.Add(_ckCancelAutoLogin);
            Controls.Add(lblNetworkID);
            Controls.Add(Panel2);
            Controls.Add(SB);
            Controls.Add(lblServerMachineName);
            Controls.Add(lblServerInstanceName);
            Controls.Add(lblLocalIP);
            Controls.Add(lblCurrUserGuidID);
            Controls.Add(lblAttachedMachineName);
            Controls.Add(LogoPictureBox);
            DoubleBuffered = true;
            FormBorderStyle = FormBorderStyle.Fixed3D;
            HelpButton = true;
            Margin = new Padding(4);
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "LoginForm1";
            SizeGripStyle = SizeGripStyle.Hide;
            StartPosition = FormStartPosition.CenterParent;
            Text = "ECM Archive Login Screen";
            ((System.ComponentModel.ISupportInitialize)LogoPictureBox).EndInit();
            Panel2.ResumeLayout(false);
            Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)_PictureBox1).EndInit();
            Load += new EventHandler(LoginForm1_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal ToolTip TT;
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

        private CheckBox _ckSaveAsDefaultLogin;

        internal CheckBox ckSaveAsDefaultLogin
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckSaveAsDefaultLogin;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckSaveAsDefaultLogin != null)
                {
                    _ckSaveAsDefaultLogin.CheckedChanged -= ckSaveAsDefaultLogin_CheckedChanged;
                }

                _ckSaveAsDefaultLogin = value;
                if (_ckSaveAsDefaultLogin != null)
                {
                    _ckSaveAsDefaultLogin.CheckedChanged += ckSaveAsDefaultLogin_CheckedChanged;
                }
            }
        }

        internal Label lblAttachedMachineName;
        internal Label lblCurrUserGuidID;
        internal Label lblServerInstanceName;
        internal Label lblLocalIP;
        internal Label lblServerMachineName;
        internal TextBox SB;
        private Button _btnChgPW;

        internal Button btnChgPW
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnChgPW;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnChgPW != null)
                {
                    _btnChgPW.Click -= btnChgPW_Click;
                }

                _btnChgPW = value;
                if (_btnChgPW != null)
                {
                    _btnChgPW.Click += btnChgPW_Click;
                }
            }
        }

        internal Panel Panel2;
        internal Label lblNetworkID;
        private CheckBox _ckCancelAutoLogin;

        internal CheckBox ckCancelAutoLogin
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckCancelAutoLogin;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckCancelAutoLogin != null)
                {
                    _ckCancelAutoLogin.CheckedChanged -= ckCancelAutoLogin_CheckedChanged;
                }

                _ckCancelAutoLogin = value;
                if (_ckCancelAutoLogin != null)
                {
                    _ckCancelAutoLogin.CheckedChanged += ckCancelAutoLogin_CheckedChanged;
                }
            }
        }

        internal Label lblMsg;
        private Timer _Timer2;

        internal Timer Timer2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Timer2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Timer2 != null)
                {
                    _Timer2.Tick -= Timer2_Tick;
                }

                _Timer2 = value;
                if (_Timer2 != null)
                {
                    _Timer2.Tick += Timer2_Tick;
                }
            }
        }

        internal Label lblRepo;
        internal Label Label4;
        internal Label Label5;
        internal Label Label6;
        private PictureBox _PictureBox1;

        internal PictureBox PictureBox1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _PictureBox1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_PictureBox1 != null)
                {
                    _PictureBox1.MouseEnter -= PictureBox1_MouseEnter;
                    _PictureBox1.MouseLeave -= PictureBox1_MouseLeave;
                }

                _PictureBox1 = value;
                if (_PictureBox1 != null)
                {
                    _PictureBox1.MouseEnter += PictureBox1_MouseEnter;
                    _PictureBox1.MouseLeave += PictureBox1_MouseLeave;
                }
            }
        }

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

        private CheckBox _ckAutoExecute;

        internal CheckBox ckAutoExecute
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckAutoExecute;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckAutoExecute != null)
                {
                    _ckAutoExecute.CheckedChanged -= ckAutoExecute_CheckedChanged;
                }

                _ckAutoExecute = value;
                if (_ckAutoExecute != null)
                {
                    _ckAutoExecute.CheckedChanged += ckAutoExecute_CheckedChanged;
                }
            }
        }

        private Button _btnStopExec;

        internal Button btnStopExec
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnStopExec;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnStopExec != null)
                {
                    _btnStopExec.Click -= btnStopExec_Click;
                }

                _btnStopExec = value;
                if (_btnStopExec != null)
                {
                    _btnStopExec.Click += btnStopExec_Click;
                }
            }
        }

        internal Label lblExecTime;
        private Timer _Timer3;

        internal Timer Timer3
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Timer3;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Timer3 != null)
                {
                    _Timer3.Tick -= Timer3_Tick;
                }

                _Timer3 = value;
                if (_Timer3 != null)
                {
                    _Timer3.Tick += Timer3_Tick;
                }
            }
        }

        private CheckBox _ckDisableListener;

        internal CheckBox ckDisableListener
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisableListener;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisableListener != null)
                {
                    _ckDisableListener.CheckedChanged -= ckDisableListener_CheckedChanged;
                }

                _ckDisableListener = value;
                if (_ckDisableListener != null)
                {
                    _ckDisableListener.CheckedChanged += ckDisableListener_CheckedChanged;
                }
            }
        }
    }
}