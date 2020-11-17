namespace ToolBeltMgt
{
    partial class frmJobs
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.ckDisable = new System.Windows.Forms.CheckBox();
            this.label3 = new System.Windows.Forms.Label();
            this.cbJobs = new System.Windows.Forms.ComboBox();
            this.cbUnit = new System.Windows.Forms.ComboBox();
            this.txtUnitVal = new System.Windows.Forms.TextBox();
            this.btnApply = new System.Windows.Forms.Button();
            this.dgJobs = new System.Windows.Forms.DataGridView();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.SB = new System.Windows.Forms.ToolStripStatusLabel();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.jobStepsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.assignServersToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.lblLastRunDate = new System.Windows.Forms.Label();
            this.lblNextRunDate = new System.Windows.Forms.Label();
            this.btnDelete = new System.Windows.Forms.Button();
            this.nbrExecOrder = new System.Windows.Forms.NumericUpDown();
            this.label4 = new System.Windows.Forms.Label();
            this.ckOncePerSvr = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgJobs)).BeginInit();
            this.statusStrip1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nbrExecOrder)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 37);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(55, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Job Name";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(463, 37);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(26, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Unit";
            // 
            // ckDisable
            // 
            this.ckDisable.AutoSize = true;
            this.ckDisable.Location = new System.Drawing.Point(807, 57);
            this.ckDisable.Name = "ckDisable";
            this.ckDisable.Size = new System.Drawing.Size(81, 17);
            this.ckDisable.TabIndex = 2;
            this.ckDisable.Text = "Disable Job";
            this.ckDisable.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(558, 37);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Unit Value";
            // 
            // cbJobs
            // 
            this.cbJobs.FormattingEnabled = true;
            this.cbJobs.Location = new System.Drawing.Point(12, 53);
            this.cbJobs.Name = "cbJobs";
            this.cbJobs.Size = new System.Drawing.Size(441, 21);
            this.cbJobs.TabIndex = 4;
            this.cbJobs.SelectedIndexChanged += new System.EventHandler(this.cbJobs_SelectedIndexChanged);
            // 
            // cbUnit
            // 
            this.cbUnit.FormattingEnabled = true;
            this.cbUnit.Items.AddRange(new object[] {
            "Min",
            "Hour",
            "Month"});
            this.cbUnit.Location = new System.Drawing.Point(463, 53);
            this.cbUnit.Name = "cbUnit";
            this.cbUnit.Size = new System.Drawing.Size(81, 21);
            this.cbUnit.TabIndex = 5;
            // 
            // txtUnitVal
            // 
            this.txtUnitVal.Location = new System.Drawing.Point(558, 53);
            this.txtUnitVal.Name = "txtUnitVal";
            this.txtUnitVal.Size = new System.Drawing.Size(87, 20);
            this.txtUnitVal.TabIndex = 6;
            this.txtUnitVal.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // btnApply
            // 
            this.btnApply.BackColor = System.Drawing.Color.MidnightBlue;
            this.btnApply.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnApply.Location = new System.Drawing.Point(12, 98);
            this.btnApply.Name = "btnApply";
            this.btnApply.Size = new System.Drawing.Size(75, 23);
            this.btnApply.TabIndex = 8;
            this.btnApply.Text = "Apply";
            this.btnApply.UseVisualStyleBackColor = false;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
            // 
            // dgJobs
            // 
            this.dgJobs.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgJobs.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgJobs.Location = new System.Drawing.Point(12, 125);
            this.dgJobs.Name = "dgJobs";
            this.dgJobs.Size = new System.Drawing.Size(876, 456);
            this.dgJobs.TabIndex = 9;
            this.dgJobs.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgJobs_CellContentClick);
            this.dgJobs.SelectionChanged += new System.EventHandler(this.dgJobs_SelectionChanged);
            // 
            // statusStrip1
            // 
            this.statusStrip1.BackColor = System.Drawing.Color.Gainsboro;
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.SB});
            this.statusStrip1.Location = new System.Drawing.Point(0, 585);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(914, 22);
            this.statusStrip1.TabIndex = 10;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // SB
            // 
            this.SB.Name = "SB";
            this.SB.Size = new System.Drawing.Size(58, 17);
            this.SB.Text = "Messages";
            // 
            // btnRefresh
            // 
            this.btnRefresh.Location = new System.Drawing.Point(378, 98);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(75, 23);
            this.btnRefresh.TabIndex = 11;
            this.btnRefresh.Text = "Refresh";
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.jobStepsToolStripMenuItem,
            this.assignServersToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(914, 24);
            this.menuStrip1.TabIndex = 15;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // jobStepsToolStripMenuItem
            // 
            this.jobStepsToolStripMenuItem.Name = "jobStepsToolStripMenuItem";
            this.jobStepsToolStripMenuItem.Size = new System.Drawing.Size(68, 20);
            this.jobStepsToolStripMenuItem.Text = "&Job Steps";
            this.jobStepsToolStripMenuItem.Click += new System.EventHandler(this.jobStepsToolStripMenuItem_Click);
            // 
            // assignServersToolStripMenuItem
            // 
            this.assignServersToolStripMenuItem.Name = "assignServersToolStripMenuItem";
            this.assignServersToolStripMenuItem.Size = new System.Drawing.Size(94, 20);
            this.assignServersToolStripMenuItem.Text = "&Assign Servers";
            this.assignServersToolStripMenuItem.Click += new System.EventHandler(this.assignServersToolStripMenuItem_Click);
            // 
            // lblLastRunDate
            // 
            this.lblLastRunDate.AutoSize = true;
            this.lblLastRunDate.Location = new System.Drawing.Point(463, 86);
            this.lblLastRunDate.Name = "lblLastRunDate";
            this.lblLastRunDate.Size = new System.Drawing.Size(76, 13);
            this.lblLastRunDate.TabIndex = 16;
            this.lblLastRunDate.Text = "Last Run Date";
            // 
            // lblNextRunDate
            // 
            this.lblNextRunDate.AutoSize = true;
            this.lblNextRunDate.Location = new System.Drawing.Point(463, 108);
            this.lblNextRunDate.Name = "lblNextRunDate";
            this.lblNextRunDate.Size = new System.Drawing.Size(78, 13);
            this.lblNextRunDate.TabIndex = 17;
            this.lblNextRunDate.Text = "Next Run Date";
            // 
            // btnDelete
            // 
            this.btnDelete.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDelete.BackColor = System.Drawing.Color.Maroon;
            this.btnDelete.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnDelete.Location = new System.Drawing.Point(813, 98);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(75, 23);
            this.btnDelete.TabIndex = 18;
            this.btnDelete.Text = "Delete";
            this.btnDelete.UseVisualStyleBackColor = false;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // nbrExecOrder
            // 
            this.nbrExecOrder.Location = new System.Drawing.Point(652, 53);
            this.nbrExecOrder.Name = "nbrExecOrder";
            this.nbrExecOrder.Size = new System.Drawing.Size(63, 20);
            this.nbrExecOrder.TabIndex = 19;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(649, 37);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(60, 13);
            this.label4.TabIndex = 20;
            this.label4.Text = "Exec Order";
            // 
            // ckOncePerSvr
            // 
            this.ckOncePerSvr.AutoSize = true;
            this.ckOncePerSvr.Location = new System.Drawing.Point(720, 57);
            this.ckOncePerSvr.Name = "ckOncePerSvr";
            this.ckOncePerSvr.Size = new System.Drawing.Size(73, 17);
            this.ckOncePerSvr.TabIndex = 21;
            this.ckOncePerSvr.Text = "Once/Svr";
            this.ckOncePerSvr.UseVisualStyleBackColor = true;
            // 
            // frmJobs
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightGray;
            this.ClientSize = new System.Drawing.Size(914, 607);
            this.Controls.Add(this.ckOncePerSvr);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.nbrExecOrder);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.lblNextRunDate);
            this.Controls.Add(this.lblLastRunDate);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.Controls.Add(this.dgJobs);
            this.Controls.Add(this.btnApply);
            this.Controls.Add(this.txtUnitVal);
            this.Controls.Add(this.cbUnit);
            this.Controls.Add(this.cbJobs);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.ckDisable);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "frmJobs";
            this.Text = "frmJobs";
            this.Load += new System.EventHandler(this.frmJobs_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgJobs)).EndInit();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nbrExecOrder)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox ckDisable;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cbJobs;
        private System.Windows.Forms.ComboBox cbUnit;
        private System.Windows.Forms.TextBox txtUnitVal;
        private System.Windows.Forms.Button btnApply;
        private System.Windows.Forms.DataGridView dgJobs;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel SB;
        private System.Windows.Forms.Button btnRefresh;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem jobStepsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem assignServersToolStripMenuItem;
        private System.Windows.Forms.Label lblLastRunDate;
        private System.Windows.Forms.Label lblNextRunDate;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.NumericUpDown nbrExecOrder;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.CheckBox ckOncePerSvr;
    }
}