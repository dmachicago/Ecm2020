namespace ToolBeltMgt
{
    partial class frmJobSteps
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
            this.lbJobs = new System.Windows.Forms.ListBox();
            this.tbCmd = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.SB = new System.Windows.Forms.ToolStripStatusLabel();
            this.btnApply = new System.Windows.Forms.Button();
            this.Remove = new System.Windows.Forms.Button();
            this.ckDisable = new System.Windows.Forms.CheckBox();
            this.ckAzure = new System.Windows.Forms.CheckBox();
            this.ckRunID = new System.Windows.Forms.CheckBox();
            this.txtNewStep = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.btnInsert = new System.Windows.Forms.Button();
            this.dgJobSteps = new System.Windows.Forms.DataGridView();
            this.nbrExecOrder = new System.Windows.Forms.NumericUpDown();
            this.label5 = new System.Windows.Forms.Label();
            this.statusStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgJobSteps)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nbrExecOrder)).BeginInit();
            this.SuspendLayout();
            // 
            // lbJobs
            // 
            this.lbJobs.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.lbJobs.FormattingEnabled = true;
            this.lbJobs.Location = new System.Drawing.Point(29, 35);
            this.lbJobs.Name = "lbJobs";
            this.lbJobs.Size = new System.Drawing.Size(339, 446);
            this.lbJobs.TabIndex = 0;
            this.lbJobs.SelectedIndexChanged += new System.EventHandler(this.lbJobs_SelectedIndexChanged);
            // 
            // tbCmd
            // 
            this.tbCmd.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbCmd.Location = new System.Drawing.Point(374, 342);
            this.tbCmd.Multiline = true;
            this.tbCmd.Name = "tbCmd";
            this.tbCmd.Size = new System.Drawing.Size(401, 139);
            this.tbCmd.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(29, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(62, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Active Jobs";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(372, 13);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "JobSteps";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(371, 326);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(121, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Stored Procedure Name";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.SB});
            this.statusStrip1.Location = new System.Drawing.Point(0, 514);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(947, 22);
            this.statusStrip1.TabIndex = 6;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // SB
            // 
            this.SB.Name = "SB";
            this.SB.Size = new System.Drawing.Size(58, 17);
            this.SB.Text = "Messages";
            // 
            // btnApply
            // 
            this.btnApply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnApply.Location = new System.Drawing.Point(798, 35);
            this.btnApply.Name = "btnApply";
            this.btnApply.Size = new System.Drawing.Size(75, 59);
            this.btnApply.TabIndex = 7;
            this.btnApply.Text = "Apply Grid Updates";
            this.btnApply.UseVisualStyleBackColor = true;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
            // 
            // Remove
            // 
            this.Remove.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Remove.Location = new System.Drawing.Point(798, 97);
            this.Remove.Name = "Remove";
            this.Remove.Size = new System.Drawing.Size(75, 59);
            this.Remove.TabIndex = 8;
            this.Remove.Text = "Remove";
            this.Remove.UseVisualStyleBackColor = true;
            this.Remove.Click += new System.EventHandler(this.Remove_Click);
            // 
            // ckDisable
            // 
            this.ckDisable.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.ckDisable.AutoSize = true;
            this.ckDisable.Location = new System.Drawing.Point(374, 296);
            this.ckDisable.Name = "ckDisable";
            this.ckDisable.Size = new System.Drawing.Size(61, 17);
            this.ckDisable.TabIndex = 9;
            this.ckDisable.Text = "Disable";
            this.ckDisable.UseVisualStyleBackColor = true;
            this.ckDisable.CheckedChanged += new System.EventHandler(this.ckDisable_CheckedChanged);
            // 
            // ckAzure
            // 
            this.ckAzure.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.ckAzure.AutoSize = true;
            this.ckAzure.Location = new System.Drawing.Point(441, 296);
            this.ckAzure.Name = "ckAzure";
            this.ckAzure.Size = new System.Drawing.Size(108, 17);
            this.ckAzure.TabIndex = 10;
            this.ckAzure.Text = "Azure Compatible";
            this.ckAzure.UseVisualStyleBackColor = true;
            this.ckAzure.CheckedChanged += new System.EventHandler(this.ckAzure_CheckedChanged);
            // 
            // ckRunID
            // 
            this.ckRunID.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.ckRunID.AutoSize = true;
            this.ckRunID.Location = new System.Drawing.Point(555, 296);
            this.ckRunID.Name = "ckRunID";
            this.ckRunID.Size = new System.Drawing.Size(103, 17);
            this.ckRunID.TabIndex = 11;
            this.ckRunID.Text = "RunID Required";
            this.ckRunID.UseVisualStyleBackColor = true;
            this.ckRunID.CheckedChanged += new System.EventHandler(this.ckRunID_CheckedChanged);
            // 
            // txtNewStep
            // 
            this.txtNewStep.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtNewStep.Location = new System.Drawing.Point(375, 268);
            this.txtNewStep.Name = "txtNewStep";
            this.txtNewStep.Size = new System.Drawing.Size(400, 20);
            this.txtNewStep.TabIndex = 12;
            this.txtNewStep.TextChanged += new System.EventHandler(this.txtNewStep_TextChanged);
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(374, 253);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(92, 13);
            this.label4.TabIndex = 13;
            this.label4.Text = "New Step To Add";
            // 
            // btnInsert
            // 
            this.btnInsert.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnInsert.Location = new System.Drawing.Point(798, 268);
            this.btnInsert.Name = "btnInsert";
            this.btnInsert.Size = new System.Drawing.Size(75, 23);
            this.btnInsert.TabIndex = 14;
            this.btnInsert.Text = "ADD Step";
            this.btnInsert.UseVisualStyleBackColor = true;
            this.btnInsert.Click += new System.EventHandler(this.btnInsert_Click);
            // 
            // dgJobSteps
            // 
            this.dgJobSteps.AllowUserToAddRows = false;
            this.dgJobSteps.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgJobSteps.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgJobSteps.Location = new System.Drawing.Point(377, 40);
            this.dgJobSteps.MultiSelect = false;
            this.dgJobSteps.Name = "dgJobSteps";
            this.dgJobSteps.Size = new System.Drawing.Size(401, 202);
            this.dgJobSteps.TabIndex = 15;
            this.dgJobSteps.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgJobSteps_CellContentClick);
            this.dgJobSteps.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgJobSteps_CellEndEdit);
            this.dgJobSteps.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgJobSteps_CellValueChanged);
            this.dgJobSteps.SelectionChanged += new System.EventHandler(this.dgJobSteps_SelectionChanged);
            // 
            // nbrExecOrder
            // 
            this.nbrExecOrder.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.nbrExecOrder.Location = new System.Drawing.Point(665, 293);
            this.nbrExecOrder.Name = "nbrExecOrder";
            this.nbrExecOrder.Size = new System.Drawing.Size(48, 20);
            this.nbrExecOrder.TabIndex = 16;
            this.nbrExecOrder.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nbrExecOrder.ValueChanged += new System.EventHandler(this.nbrExecOrder_ValueChanged);
            // 
            // label5
            // 
            this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(720, 297);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(60, 13);
            this.label5.TabIndex = 17;
            this.label5.Text = "Exec Order";
            // 
            // frmJobSteps
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Gainsboro;
            this.ClientSize = new System.Drawing.Size(947, 536);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.nbrExecOrder);
            this.Controls.Add(this.dgJobSteps);
            this.Controls.Add(this.btnInsert);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtNewStep);
            this.Controls.Add(this.ckRunID);
            this.Controls.Add(this.ckAzure);
            this.Controls.Add(this.ckDisable);
            this.Controls.Add(this.Remove);
            this.Controls.Add(this.btnApply);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbCmd);
            this.Controls.Add(this.lbJobs);
            this.Name = "frmJobSteps";
            this.Text = "frmJobSteps";
            this.Load += new System.EventHandler(this.frmJobSteps_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgJobSteps)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nbrExecOrder)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox lbJobs;
        private System.Windows.Forms.TextBox tbCmd;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel SB;
        private System.Windows.Forms.Button btnApply;
        private System.Windows.Forms.Button Remove;
        private System.Windows.Forms.CheckBox ckDisable;
        private System.Windows.Forms.CheckBox ckAzure;
        private System.Windows.Forms.CheckBox ckRunID;
        private System.Windows.Forms.TextBox txtNewStep;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnInsert;
        private System.Windows.Forms.DataGridView dgJobSteps;
        private System.Windows.Forms.NumericUpDown nbrExecOrder;
        private System.Windows.Forms.Label label5;
    }
}