namespace ConfigSetup
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.txtEncConnstr = new System.Windows.Forms.TextBox();
            this.txtPw = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.btnTestEnc = new System.Windows.Forms.Button();
            this.SB = new System.Windows.Forms.TextBox();
            this.btnClipboard = new System.Windows.Forms.Button();
            this.lbFiles = new System.Windows.Forms.ListBox();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.lbFileContents = new System.Windows.Forms.ListBox();
            this.btnOpen = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnGetList = new System.Windows.Forms.Button();
            this.txtEncPW = new System.Windows.Forms.TextBox();
            this.btnReload = new System.Windows.Forms.Button();
            this.txtLine = new System.Windows.Forms.TextBox();
            this.tt = new System.Windows.Forms.ToolTip(this.components);
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.btnFind = new System.Windows.Forms.Button();
            this.btnDecrypt = new System.Windows.Forms.Button();
            this.btnApplyLine = new System.Windows.Forms.Button();
            this.btnApply = new System.Windows.Forms.Button();
            this.lblItemID = new System.Windows.Forms.Label();
            this.lblCurrFile = new System.Windows.Forms.Label();
            this.btnEdit = new System.Windows.Forms.Button();
            this.txtToken = new System.Windows.Forms.TextBox();
            this.ckCaseSensitive = new System.Windows.Forms.CheckBox();
            this.cbLocate = new System.Windows.Forms.ComboBox();
            this.lblRowLoc = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtEncConnstr
            // 
            this.txtEncConnstr.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtEncConnstr.Location = new System.Drawing.Point(40, 504);
            this.txtEncConnstr.Name = "txtEncConnstr";
            this.txtEncConnstr.Size = new System.Drawing.Size(887, 22);
            this.txtEncConnstr.TabIndex = 2;
            // 
            // txtPw
            // 
            this.txtPw.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.txtPw.Location = new System.Drawing.Point(40, 555);
            this.txtPw.Name = "txtPw";
            this.txtPw.Size = new System.Drawing.Size(231, 22);
            this.txtPw.TabIndex = 4;
            this.txtPw.TextChanged += new System.EventHandler(this.txtPw_TextChanged);
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(37, 537);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(69, 17);
            this.label3.TabIndex = 5;
            this.label3.Text = "Password";
            // 
            // btnTestEnc
            // 
            this.btnTestEnc.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnTestEnc.Location = new System.Drawing.Point(332, 555);
            this.btnTestEnc.Name = "btnTestEnc";
            this.btnTestEnc.Size = new System.Drawing.Size(90, 51);
            this.btnTestEnc.TabIndex = 8;
            this.btnTestEnc.Text = "Test";
            this.btnTestEnc.UseVisualStyleBackColor = true;
            this.btnTestEnc.Click += new System.EventHandler(this.btnTestEnc_Click);
            // 
            // SB
            // 
            this.SB.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.SB.BackColor = System.Drawing.SystemColors.ControlLight;
            this.SB.Location = new System.Drawing.Point(43, 629);
            this.SB.Name = "SB";
            this.SB.ReadOnly = true;
            this.SB.Size = new System.Drawing.Size(898, 22);
            this.SB.TabIndex = 10;
            // 
            // btnClipboard
            // 
            this.btnClipboard.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnClipboard.Location = new System.Drawing.Point(428, 555);
            this.btnClipboard.Name = "btnClipboard";
            this.btnClipboard.Size = new System.Drawing.Size(90, 51);
            this.btnClipboard.TabIndex = 11;
            this.btnClipboard.Text = "Apply";
            this.tt.SetToolTip(this.btnClipboard, "Apply Encrypted to selected item.");
            this.btnClipboard.UseVisualStyleBackColor = true;
            this.btnClipboard.Click += new System.EventHandler(this.btnClipboard_Click);
            // 
            // lbFiles
            // 
            this.lbFiles.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbFiles.FormattingEnabled = true;
            this.lbFiles.ItemHeight = 16;
            this.lbFiles.Location = new System.Drawing.Point(3, 3);
            this.lbFiles.Name = "lbFiles";
            this.lbFiles.Size = new System.Drawing.Size(426, 372);
            this.lbFiles.Sorted = true;
            this.lbFiles.TabIndex = 12;
            this.lbFiles.SelectedIndexChanged += new System.EventHandler(this.lbFiles_SelectedIndexChanged);
            // 
            // splitContainer1
            // 
            this.splitContainer1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.splitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer1.Location = new System.Drawing.Point(35, 68);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.lbFiles);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.lbFileContents);
            this.splitContainer1.Size = new System.Drawing.Size(897, 385);
            this.splitContainer1.SplitterDistance = 436;
            this.splitContainer1.TabIndex = 13;
            // 
            // lbFileContents
            // 
            this.lbFileContents.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbFileContents.FormattingEnabled = true;
            this.lbFileContents.ItemHeight = 16;
            this.lbFileContents.Location = new System.Drawing.Point(3, 3);
            this.lbFileContents.Name = "lbFileContents";
            this.lbFileContents.Size = new System.Drawing.Size(447, 372);
            this.lbFileContents.TabIndex = 0;
            this.lbFileContents.SelectedIndexChanged += new System.EventHandler(this.lbFileContents_SelectedIndexChanged);
            // 
            // btnOpen
            // 
            this.btnOpen.Location = new System.Drawing.Point(131, 22);
            this.btnOpen.Name = "btnOpen";
            this.btnOpen.Size = new System.Drawing.Size(90, 40);
            this.btnOpen.TabIndex = 14;
            this.btnOpen.Text = "Open";
            this.btnOpen.UseVisualStyleBackColor = true;
            this.btnOpen.Click += new System.EventHandler(this.btnOpen_Click);
            // 
            // btnSave
            // 
            this.btnSave.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSave.Location = new System.Drawing.Point(837, 22);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(90, 40);
            this.btnSave.TabIndex = 15;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnGetList
            // 
            this.btnGetList.Location = new System.Drawing.Point(35, 22);
            this.btnGetList.Name = "btnGetList";
            this.btnGetList.Size = new System.Drawing.Size(90, 40);
            this.btnGetList.TabIndex = 16;
            this.btnGetList.Text = "Locate";
            this.btnGetList.UseVisualStyleBackColor = true;
            this.btnGetList.Click += new System.EventHandler(this.btnGetList_Click);
            // 
            // txtEncPW
            // 
            this.txtEncPW.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.txtEncPW.Location = new System.Drawing.Point(40, 583);
            this.txtEncPW.Name = "txtEncPW";
            this.txtEncPW.ReadOnly = true;
            this.txtEncPW.Size = new System.Drawing.Size(231, 22);
            this.txtEncPW.TabIndex = 17;
            // 
            // btnReload
            // 
            this.btnReload.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnReload.Location = new System.Drawing.Point(741, 22);
            this.btnReload.Name = "btnReload";
            this.btnReload.Size = new System.Drawing.Size(90, 40);
            this.btnReload.TabIndex = 18;
            this.btnReload.Text = "Reload";
            this.btnReload.UseVisualStyleBackColor = true;
            // 
            // txtLine
            // 
            this.txtLine.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtLine.Location = new System.Drawing.Point(93, 471);
            this.txtLine.Name = "txtLine";
            this.txtLine.Size = new System.Drawing.Size(784, 22);
            this.txtLine.TabIndex = 19;
            // 
            // button1
            // 
            this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.button1.BackColor = System.Drawing.Color.Maroon;
            this.button1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.button1.Location = new System.Drawing.Point(524, 555);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(90, 51);
            this.button1.TabIndex = 25;
            this.button1.Text = "Apply ALL ENC PW";
            this.tt.SetToolTip(this.button1, "Apply Encrypted Password to ALL items in the shown files.");
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.button2.BackColor = System.Drawing.Color.Maroon;
            this.button2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.button2.Location = new System.Drawing.Point(730, 583);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(162, 40);
            this.button2.TabIndex = 27;
            this.button2.Text = "Apply ALL Tokens";
            this.tt.SetToolTip(this.button2, "Apply Encrypted Password to ALL items in the shown files.");
            this.button2.UseVisualStyleBackColor = false;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // btnFind
            // 
            this.btnFind.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnFind.Image = global::ConfigSetup.Properties.Resources.search_black;
            this.btnFind.Location = new System.Drawing.Point(669, 38);
            this.btnFind.Name = "btnFind";
            this.btnFind.Size = new System.Drawing.Size(33, 23);
            this.btnFind.TabIndex = 31;
            this.tt.SetToolTip(this.btnFind, "Apply pending change");
            this.btnFind.UseVisualStyleBackColor = true;
            this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
            // 
            // btnDecrypt
            // 
            this.btnDecrypt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnDecrypt.Image = global::ConfigSetup.Properties.Resources.forward_black;
            this.btnDecrypt.Location = new System.Drawing.Point(278, 583);
            this.btnDecrypt.Name = "btnDecrypt";
            this.btnDecrypt.Size = new System.Drawing.Size(33, 23);
            this.btnDecrypt.TabIndex = 21;
            this.tt.SetToolTip(this.btnDecrypt, "Decrypt");
            this.btnDecrypt.UseVisualStyleBackColor = true;
            this.btnDecrypt.Click += new System.EventHandler(this.btnDecrypt_Click);
            // 
            // btnApplyLine
            // 
            this.btnApplyLine.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnApplyLine.Image = global::ConfigSetup.Properties.Resources.edit_black;
            this.btnApplyLine.Location = new System.Drawing.Point(894, 471);
            this.btnApplyLine.Name = "btnApplyLine";
            this.btnApplyLine.Size = new System.Drawing.Size(33, 23);
            this.btnApplyLine.TabIndex = 20;
            this.tt.SetToolTip(this.btnApplyLine, "Apply pending change");
            this.btnApplyLine.UseVisualStyleBackColor = true;
            this.btnApplyLine.Click += new System.EventHandler(this.btnApplyLine_Click);
            // 
            // btnApply
            // 
            this.btnApply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnApply.Image = global::ConfigSetup.Properties.Resources.lock_black;
            this.btnApply.Location = new System.Drawing.Point(278, 555);
            this.btnApply.Name = "btnApply";
            this.btnApply.Size = new System.Drawing.Size(33, 23);
            this.btnApply.TabIndex = 9;
            this.tt.SetToolTip(this.btnApply, "Encrypt password");
            this.btnApply.UseVisualStyleBackColor = true;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
            // 
            // lblItemID
            // 
            this.lblItemID.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lblItemID.AutoSize = true;
            this.lblItemID.Location = new System.Drawing.Point(41, 474);
            this.lblItemID.Name = "lblItemID";
            this.lblItemID.Size = new System.Drawing.Size(46, 17);
            this.lblItemID.TabIndex = 22;
            this.lblItemID.Text = "label4";
            // 
            // lblCurrFile
            // 
            this.lblCurrFile.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lblCurrFile.AutoSize = true;
            this.lblCurrFile.Location = new System.Drawing.Point(40, 657);
            this.lblCurrFile.Name = "lblCurrFile";
            this.lblCurrFile.Size = new System.Drawing.Size(46, 17);
            this.lblCurrFile.TabIndex = 23;
            this.lblCurrFile.Text = "label1";
            // 
            // btnEdit
            // 
            this.btnEdit.Location = new System.Drawing.Point(227, 22);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(90, 40);
            this.btnEdit.TabIndex = 24;
            this.btnEdit.Text = "Edit";
            this.btnEdit.UseVisualStyleBackColor = true;
            this.btnEdit.Click += new System.EventHandler(this.btnEdit_Click);
            // 
            // txtToken
            // 
            this.txtToken.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtToken.Location = new System.Drawing.Point(696, 555);
            this.txtToken.Name = "txtToken";
            this.txtToken.Size = new System.Drawing.Size(231, 22);
            this.txtToken.TabIndex = 26;
            // 
            // ckCaseSensitive
            // 
            this.ckCaseSensitive.AutoSize = true;
            this.ckCaseSensitive.Checked = true;
            this.ckCaseSensitive.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ckCaseSensitive.Location = new System.Drawing.Point(741, 532);
            this.ckCaseSensitive.Name = "ckCaseSensitive";
            this.ckCaseSensitive.Size = new System.Drawing.Size(123, 21);
            this.ckCaseSensitive.TabIndex = 28;
            this.ckCaseSensitive.Text = "Case Sensitive";
            this.ckCaseSensitive.UseVisualStyleBackColor = true;
            // 
            // cbLocate
            // 
            this.cbLocate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.cbLocate.FormattingEnabled = true;
            this.cbLocate.Items.AddRange(new object[] {
            "*ALL",
            "EndPoint",
            "Data Source",
            "Password",
            "CUSTID",
            "SVRNAME",
            "DBNAME",
            "INSTANCENAME"});
            this.cbLocate.Location = new System.Drawing.Point(479, 38);
            this.cbLocate.Name = "cbLocate";
            this.cbLocate.Size = new System.Drawing.Size(184, 24);
            this.cbLocate.TabIndex = 29;
            // 
            // lblRowLoc
            // 
            this.lblRowLoc.AutoSize = true;
            this.lblRowLoc.Location = new System.Drawing.Point(477, 18);
            this.lblRowLoc.Name = "lblRowLoc";
            this.lblRowLoc.Size = new System.Drawing.Size(43, 17);
            this.lblRowLoc.TabIndex = 30;
            this.lblRowLoc.Text = "Row#";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(957, 683);
            this.Controls.Add(this.btnFind);
            this.Controls.Add(this.lblRowLoc);
            this.Controls.Add(this.cbLocate);
            this.Controls.Add(this.ckCaseSensitive);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.txtToken);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btnEdit);
            this.Controls.Add(this.lblCurrFile);
            this.Controls.Add(this.lblItemID);
            this.Controls.Add(this.btnDecrypt);
            this.Controls.Add(this.btnApplyLine);
            this.Controls.Add(this.txtLine);
            this.Controls.Add(this.btnReload);
            this.Controls.Add(this.txtEncPW);
            this.Controls.Add(this.btnGetList);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnOpen);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.btnClipboard);
            this.Controls.Add(this.SB);
            this.Controls.Add(this.btnApply);
            this.Controls.Add(this.btnTestEnc);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtPw);
            this.Controls.Add(this.txtEncConnstr);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frmMain";
            this.Text = "Configuration Setup";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.TextBox txtEncConnstr;
        private System.Windows.Forms.TextBox txtPw;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btnTestEnc;
        private System.Windows.Forms.Button btnApply;
        private System.Windows.Forms.TextBox SB;
        private System.Windows.Forms.Button btnClipboard;
        private System.Windows.Forms.ListBox lbFiles;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.ListBox lbFileContents;
        private System.Windows.Forms.Button btnOpen;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnGetList;
        private System.Windows.Forms.TextBox txtEncPW;
        private System.Windows.Forms.Button btnReload;
        private System.Windows.Forms.TextBox txtLine;
        private System.Windows.Forms.Button btnApplyLine;
        private System.Windows.Forms.ToolTip tt;
        private System.Windows.Forms.Button btnDecrypt;
        private System.Windows.Forms.Label lblItemID;
        private System.Windows.Forms.Label lblCurrFile;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox txtToken;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.CheckBox ckCaseSensitive;
        private System.Windows.Forms.ComboBox cbLocate;
        private System.Windows.Forms.Label lblRowLoc;
        private System.Windows.Forms.Button btnFind;
    }
}

