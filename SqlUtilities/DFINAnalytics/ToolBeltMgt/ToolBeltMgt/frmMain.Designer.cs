namespace ToolBeltMgt
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
        protected override void Dispose (bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose ();
            }
            base.Dispose (disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent ()
        {
            this.components = new System.ComponentModel.Container();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.loginToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.jobsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.serverJobsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dgServers = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.cbGroups = new System.Windows.Forms.ComboBox();
            this.cbServers = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.ckIsAzure = new System.Windows.Forms.CheckBox();
            this.lblUser = new System.Windows.Forms.Label();
            this.txtUid = new System.Windows.Forms.TextBox();
            this.txtPwd = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.ckEnabled = new System.Windows.Forms.CheckBox();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.tsDatabaseStatus = new System.Windows.Forms.ToolStripStatusLabel();
            this.SB = new System.Windows.Forms.ToolStripStatusLabel();
            this.btnTest = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.cbDatabase = new System.Windows.Forms.ComboBox();
            this.btnDeleteSvr = new System.Windows.Forms.Button();
            this.btnGetDBs = new System.Windows.Forms.Button();
            this.cbDatabases = new System.Windows.Forms.CheckedListBox();
            this.btnAddSelectedDBs = new System.Windows.Forms.Button();
            this.btnSelectAll = new System.Windows.Forms.Button();
            this.btnDeselectAll = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.btnDeselectStd = new System.Windows.Forms.Button();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgServers)).BeginInit();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.loginToolStripMenuItem,
            this.jobsToolStripMenuItem,
            this.serverJobsToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(967, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            this.menuStrip1.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.menuStrip1_ItemClicked);
            // 
            // loginToolStripMenuItem
            // 
            this.loginToolStripMenuItem.Name = "loginToolStripMenuItem";
            this.loginToolStripMenuItem.Size = new System.Drawing.Size(49, 20);
            this.loginToolStripMenuItem.Text = "Login";
            this.loginToolStripMenuItem.Click += new System.EventHandler(this.loginToolStripMenuItem_Click);
            // 
            // jobsToolStripMenuItem
            // 
            this.jobsToolStripMenuItem.Name = "jobsToolStripMenuItem";
            this.jobsToolStripMenuItem.Size = new System.Drawing.Size(42, 20);
            this.jobsToolStripMenuItem.Text = "Jobs";
            this.jobsToolStripMenuItem.Click += new System.EventHandler(this.jobsToolStripMenuItem_Click);
            // 
            // serverJobsToolStripMenuItem
            // 
            this.serverJobsToolStripMenuItem.Name = "serverJobsToolStripMenuItem";
            this.serverJobsToolStripMenuItem.Size = new System.Drawing.Size(77, 20);
            this.serverJobsToolStripMenuItem.Text = "AssignJobs";
            this.serverJobsToolStripMenuItem.Click += new System.EventHandler(this.serverJobsToolStripMenuItem_Click);
            // 
            // dgServers
            // 
            this.dgServers.AllowUserToOrderColumns = true;
            this.dgServers.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgServers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgServers.Location = new System.Drawing.Point(12, 182);
            this.dgServers.Name = "dgServers";
            this.dgServers.Size = new System.Drawing.Size(657, 415);
            this.dgServers.TabIndex = 1;
            this.dgServers.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgServers_CellContentClick);
            this.dgServers.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgServers_RowEnter);
            this.dgServers.SelectionChanged += new System.EventHandler(this.dgServers_SelectionChanged);
            this.dgServers.UserAddedRow += new System.Windows.Forms.DataGridViewRowEventHandler(this.dgServers_UserAddedRow);
            this.dgServers.Enter += new System.EventHandler(this.dgServers_Enter);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(16, 44);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(36, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Group";
            // 
            // cbGroups
            // 
            this.cbGroups.FormattingEnabled = true;
            this.cbGroups.Location = new System.Drawing.Point(19, 62);
            this.cbGroups.Name = "cbGroups";
            this.cbGroups.Size = new System.Drawing.Size(198, 21);
            this.cbGroups.TabIndex = 3;
            this.cbGroups.SelectedIndexChanged += new System.EventHandler(this.cbGroups_SelectedIndexChanged);
            // 
            // cbServers
            // 
            this.cbServers.FormattingEnabled = true;
            this.cbServers.Location = new System.Drawing.Point(233, 62);
            this.cbServers.Name = "cbServers";
            this.cbServers.Size = new System.Drawing.Size(338, 21);
            this.cbServers.TabIndex = 5;
            this.cbServers.SelectedIndexChanged += new System.EventHandler(this.cbServers_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(230, 44);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(69, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Server Name";
            // 
            // ckIsAzure
            // 
            this.ckIsAzure.AutoSize = true;
            this.ckIsAzure.Location = new System.Drawing.Point(588, 86);
            this.ckIsAzure.Name = "ckIsAzure";
            this.ckIsAzure.Size = new System.Drawing.Size(102, 17);
            this.ckIsAzure.TabIndex = 6;
            this.ckIsAzure.Text = "Azure Database";
            this.ckIsAzure.UseVisualStyleBackColor = true;
            // 
            // lblUser
            // 
            this.lblUser.AutoSize = true;
            this.lblUser.Location = new System.Drawing.Point(47, 130);
            this.lblUser.Name = "lblUser";
            this.lblUser.Size = new System.Drawing.Size(43, 13);
            this.lblUser.TabIndex = 7;
            this.lblUser.Text = "User ID";
            // 
            // txtUid
            // 
            this.txtUid.Location = new System.Drawing.Point(96, 126);
            this.txtUid.Name = "txtUid";
            this.txtUid.Size = new System.Drawing.Size(195, 20);
            this.txtUid.TabIndex = 8;
            // 
            // txtPwd
            // 
            this.txtPwd.Location = new System.Drawing.Point(96, 156);
            this.txtPwd.Name = "txtPwd";
            this.txtPwd.Size = new System.Drawing.Size(195, 20);
            this.txtPwd.TabIndex = 10;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 160);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(78, 13);
            this.label3.TabIndex = 9;
            this.label3.Text = "User Password";
            // 
            // ckEnabled
            // 
            this.ckEnabled.AutoSize = true;
            this.ckEnabled.Location = new System.Drawing.Point(719, 86);
            this.ckEnabled.Name = "ckEnabled";
            this.ckEnabled.Size = new System.Drawing.Size(65, 17);
            this.ckEnabled.TabIndex = 11;
            this.ckEnabled.Text = "Enabled";
            this.ckEnabled.UseVisualStyleBackColor = true;
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsDatabaseStatus,
            this.SB});
            this.statusStrip1.Location = new System.Drawing.Point(0, 600);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(967, 22);
            this.statusStrip1.TabIndex = 12;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // tsDatabaseStatus
            // 
            this.tsDatabaseStatus.Name = "tsDatabaseStatus";
            this.tsDatabaseStatus.Size = new System.Drawing.Size(88, 17);
            this.tsDatabaseStatus.Text = "database status";
            // 
            // SB
            // 
            this.SB.Name = "SB";
            this.SB.Size = new System.Drawing.Size(98, 17);
            this.SB.Text = "system messages";
            // 
            // btnTest
            // 
            this.btnTest.Location = new System.Drawing.Point(297, 130);
            this.btnTest.Name = "btnTest";
            this.btnTest.Size = new System.Drawing.Size(75, 37);
            this.btnTest.TabIndex = 13;
            this.btnTest.Text = "&Test";
            this.btnTest.UseVisualStyleBackColor = true;
            this.btnTest.Click += new System.EventHandler(this.btnTest_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(880, 31);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 38);
            this.btnSave.TabIndex = 14;
            this.btnSave.Text = "&Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(19, 86);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(276, 13);
            this.label4.TabIndex = 15;
            this.label4.Text = "NOTE: No userid or pw indicates windows authentication";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(585, 44);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(84, 13);
            this.label5.TabIndex = 17;
            this.label5.Text = "Database Name";
            // 
            // cbDatabase
            // 
            this.cbDatabase.FormattingEnabled = true;
            this.cbDatabase.Location = new System.Drawing.Point(588, 62);
            this.cbDatabase.Name = "cbDatabase";
            this.cbDatabase.Size = new System.Drawing.Size(259, 21);
            this.cbDatabase.TabIndex = 18;
            this.cbDatabase.SelectedIndexChanged += new System.EventHandler(this.cbDatabase_SelectedIndexChanged);
            // 
            // btnDeleteSvr
            // 
            this.btnDeleteSvr.BackColor = System.Drawing.Color.Red;
            this.btnDeleteSvr.Location = new System.Drawing.Point(880, 74);
            this.btnDeleteSvr.Name = "btnDeleteSvr";
            this.btnDeleteSvr.Size = new System.Drawing.Size(75, 37);
            this.btnDeleteSvr.TabIndex = 19;
            this.btnDeleteSvr.Text = "Delete";
            this.btnDeleteSvr.UseVisualStyleBackColor = false;
            this.btnDeleteSvr.Click += new System.EventHandler(this.btnDeleteSvr_Click);
            // 
            // btnGetDBs
            // 
            this.btnGetDBs.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnGetDBs.Location = new System.Drawing.Point(675, 182);
            this.btnGetDBs.Name = "btnGetDBs";
            this.btnGetDBs.Size = new System.Drawing.Size(75, 23);
            this.btnGetDBs.TabIndex = 20;
            this.btnGetDBs.Text = "Get DBs";
            this.btnGetDBs.UseVisualStyleBackColor = true;
            this.btnGetDBs.Click += new System.EventHandler(this.btnGetDBs_Click);
            // 
            // cbDatabases
            // 
            this.cbDatabases.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cbDatabases.FormattingEnabled = true;
            this.cbDatabases.Location = new System.Drawing.Point(675, 212);
            this.cbDatabases.Name = "cbDatabases";
            this.cbDatabases.Size = new System.Drawing.Size(280, 349);
            this.cbDatabases.TabIndex = 21;
            // 
            // btnAddSelectedDBs
            // 
            this.btnAddSelectedDBs.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnAddSelectedDBs.Location = new System.Drawing.Point(879, 182);
            this.btnAddSelectedDBs.Name = "btnAddSelectedDBs";
            this.btnAddSelectedDBs.Size = new System.Drawing.Size(75, 23);
            this.btnAddSelectedDBs.TabIndex = 22;
            this.btnAddSelectedDBs.Text = "Apply";
            this.btnAddSelectedDBs.UseVisualStyleBackColor = true;
            this.btnAddSelectedDBs.Click += new System.EventHandler(this.btnAddSelectedDBs_Click);
            // 
            // btnSelectAll
            // 
            this.btnSelectAll.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSelectAll.Location = new System.Drawing.Point(675, 567);
            this.btnSelectAll.Name = "btnSelectAll";
            this.btnSelectAll.Size = new System.Drawing.Size(75, 23);
            this.btnSelectAll.TabIndex = 23;
            this.btnSelectAll.Text = "Select All";
            this.btnSelectAll.UseVisualStyleBackColor = true;
            this.btnSelectAll.Click += new System.EventHandler(this.btnSelectAll_Click);
            // 
            // btnDeselectAll
            // 
            this.btnDeselectAll.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDeselectAll.Location = new System.Drawing.Point(879, 567);
            this.btnDeselectAll.Name = "btnDeselectAll";
            this.btnDeselectAll.Size = new System.Drawing.Size(75, 23);
            this.btnDeselectAll.TabIndex = 24;
            this.btnDeselectAll.Text = "Deselect All";
            this.btnDeselectAll.UseVisualStyleBackColor = true;
            this.btnDeselectAll.Click += new System.EventHandler(this.btnDeselectAll_Click);
            // 
            // button1
            // 
            this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.button1.Location = new System.Drawing.Point(767, 182);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(95, 23);
            this.button1.TabIndex = 26;
            this.button1.Text = "MARK ALL";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // btnDeselectStd
            // 
            this.btnDeselectStd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDeselectStd.Location = new System.Drawing.Point(767, 567);
            this.btnDeselectStd.Name = "btnDeselectStd";
            this.btnDeselectStd.Size = new System.Drawing.Size(95, 23);
            this.btnDeselectStd.TabIndex = 27;
            this.btnDeselectStd.Text = "Deselect Std";
            this.toolTip1.SetToolTip(this.btnDeselectStd, "This will deslect msdb, master, model, TempDB, Report Servers");
            this.btnDeselectStd.UseVisualStyleBackColor = true;
            this.btnDeselectStd.Click += new System.EventHandler(this.btnDeselectStd_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.ClientSize = new System.Drawing.Size(967, 622);
            this.Controls.Add(this.btnDeselectStd);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btnDeselectAll);
            this.Controls.Add(this.btnSelectAll);
            this.Controls.Add(this.btnAddSelectedDBs);
            this.Controls.Add(this.cbDatabases);
            this.Controls.Add(this.btnGetDBs);
            this.Controls.Add(this.btnDeleteSvr);
            this.Controls.Add(this.cbDatabase);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnTest);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.ckEnabled);
            this.Controls.Add(this.txtPwd);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtUid);
            this.Controls.Add(this.lblUser);
            this.Controls.Add(this.ckIsAzure);
            this.Controls.Add(this.cbServers);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cbGroups);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgServers);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "frmMain";
            this.Text = "MAIN - Active Servers";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.frmMain_FormClosing);
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgServers)).EndInit();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem jobsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem serverJobsToolStripMenuItem;
        private System.Windows.Forms.DataGridView dgServers;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cbGroups;
        private System.Windows.Forms.ComboBox cbServers;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox ckIsAzure;
        private System.Windows.Forms.Label lblUser;
        private System.Windows.Forms.TextBox txtUid;
        private System.Windows.Forms.TextBox txtPwd;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.CheckBox ckEnabled;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripMenuItem loginToolStripMenuItem;
        private System.Windows.Forms.ToolStripStatusLabel tsDatabaseStatus;
        private System.Windows.Forms.ToolStripStatusLabel SB;
        private System.Windows.Forms.Button btnTest;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox cbDatabase;
        private System.Windows.Forms.Button btnDeleteSvr;
        private System.Windows.Forms.Button btnGetDBs;
        private System.Windows.Forms.CheckedListBox cbDatabases;
        private System.Windows.Forms.Button btnAddSelectedDBs;
        private System.Windows.Forms.Button btnSelectAll;
        private System.Windows.Forms.Button btnDeselectAll;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button btnDeselectStd;
        private System.Windows.Forms.ToolTip toolTip1;
    }
}

