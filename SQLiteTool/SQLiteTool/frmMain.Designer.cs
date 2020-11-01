namespace SQLiteTool
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
            this.dgData = new System.Windows.Forms.DataGridView();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.rbZipFile = new System.Windows.Forms.RadioButton();
            this.rbOutlook = new System.Windows.Forms.RadioButton();
            this.rbMultiLocationFiles = new System.Windows.Forms.RadioButton();
            this.rbListener = new System.Windows.Forms.RadioButton();
            this.rbInventory = new System.Windows.Forms.RadioButton();
            this.rbFiles = new System.Windows.Forms.RadioButton();
            this.rbExchange = new System.Windows.Forms.RadioButton();
            this.rbDirectory = new System.Windows.Forms.RadioButton();
            this.rbContactsArchive = new System.Windows.Forms.RadioButton();
            this.txtSql = new System.Windows.Forms.TextBox();
            this.btnSql = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgData)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgData
            // 
            this.dgData.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgData.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.dgData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgData.Location = new System.Drawing.Point(12, 230);
            this.dgData.Name = "dgData";
            this.dgData.Size = new System.Drawing.Size(1056, 468);
            this.dgData.TabIndex = 0;
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.rbZipFile);
            this.groupBox1.Controls.Add(this.rbOutlook);
            this.groupBox1.Controls.Add(this.rbMultiLocationFiles);
            this.groupBox1.Controls.Add(this.rbListener);
            this.groupBox1.Controls.Add(this.rbInventory);
            this.groupBox1.Controls.Add(this.rbFiles);
            this.groupBox1.Controls.Add(this.rbExchange);
            this.groupBox1.Controls.Add(this.rbDirectory);
            this.groupBox1.Controls.Add(this.rbContactsArchive);
            this.groupBox1.Location = new System.Drawing.Point(12, 21);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1056, 74);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "SQLite Tables";
            // 
            // rbZipFile
            // 
            this.rbZipFile.AutoSize = true;
            this.rbZipFile.Location = new System.Drawing.Point(939, 36);
            this.rbZipFile.Name = "rbZipFile";
            this.rbZipFile.Size = new System.Drawing.Size(56, 17);
            this.rbZipFile.TabIndex = 8;
            this.rbZipFile.TabStop = true;
            this.rbZipFile.Text = "ZipFile";
            this.rbZipFile.UseVisualStyleBackColor = true;
            this.rbZipFile.CheckedChanged += new System.EventHandler(this.rbZipFile_CheckedChanged);
            // 
            // rbOutlook
            // 
            this.rbOutlook.AutoSize = true;
            this.rbOutlook.Location = new System.Drawing.Point(834, 36);
            this.rbOutlook.Name = "rbOutlook";
            this.rbOutlook.Size = new System.Drawing.Size(62, 17);
            this.rbOutlook.TabIndex = 7;
            this.rbOutlook.TabStop = true;
            this.rbOutlook.Text = "Outlook";
            this.rbOutlook.UseVisualStyleBackColor = true;
            this.rbOutlook.CheckedChanged += new System.EventHandler(this.rbOutlook_CheckedChanged);
            // 
            // rbMultiLocationFiles
            // 
            this.rbMultiLocationFiles.AutoSize = true;
            this.rbMultiLocationFiles.Location = new System.Drawing.Point(682, 36);
            this.rbMultiLocationFiles.Name = "rbMultiLocationFiles";
            this.rbMultiLocationFiles.Size = new System.Drawing.Size(109, 17);
            this.rbMultiLocationFiles.TabIndex = 6;
            this.rbMultiLocationFiles.TabStop = true;
            this.rbMultiLocationFiles.Text = "MultiLocationFiles";
            this.rbMultiLocationFiles.UseVisualStyleBackColor = true;
            this.rbMultiLocationFiles.CheckedChanged += new System.EventHandler(this.rbMultiLocationFiles_CheckedChanged);
            // 
            // rbListener
            // 
            this.rbListener.AutoSize = true;
            this.rbListener.Location = new System.Drawing.Point(577, 36);
            this.rbListener.Name = "rbListener";
            this.rbListener.Size = new System.Drawing.Size(62, 17);
            this.rbListener.TabIndex = 5;
            this.rbListener.TabStop = true;
            this.rbListener.Text = "Listener";
            this.rbListener.UseVisualStyleBackColor = true;
            this.rbListener.CheckedChanged += new System.EventHandler(this.rbListener_CheckedChanged);
            // 
            // rbInventory
            // 
            this.rbInventory.AutoSize = true;
            this.rbInventory.Location = new System.Drawing.Point(465, 36);
            this.rbInventory.Name = "rbInventory";
            this.rbInventory.Size = new System.Drawing.Size(69, 17);
            this.rbInventory.TabIndex = 4;
            this.rbInventory.TabStop = true;
            this.rbInventory.Text = "Inventory";
            this.rbInventory.UseVisualStyleBackColor = true;
            this.rbInventory.CheckedChanged += new System.EventHandler(this.rbInventory_CheckedChanged);
            // 
            // rbFiles
            // 
            this.rbFiles.AutoSize = true;
            this.rbFiles.Location = new System.Drawing.Point(376, 36);
            this.rbFiles.Name = "rbFiles";
            this.rbFiles.Size = new System.Drawing.Size(46, 17);
            this.rbFiles.TabIndex = 3;
            this.rbFiles.TabStop = true;
            this.rbFiles.Text = "Files";
            this.rbFiles.UseVisualStyleBackColor = true;
            this.rbFiles.CheckedChanged += new System.EventHandler(this.rbFiles_CheckedChanged);
            // 
            // rbExchange
            // 
            this.rbExchange.AutoSize = true;
            this.rbExchange.Location = new System.Drawing.Point(260, 36);
            this.rbExchange.Name = "rbExchange";
            this.rbExchange.Size = new System.Drawing.Size(73, 17);
            this.rbExchange.TabIndex = 2;
            this.rbExchange.TabStop = true;
            this.rbExchange.Text = "Exchange";
            this.rbExchange.UseVisualStyleBackColor = true;
            this.rbExchange.CheckedChanged += new System.EventHandler(this.rbExchange_CheckedChanged);
            // 
            // rbDirectory
            // 
            this.rbDirectory.AutoSize = true;
            this.rbDirectory.Location = new System.Drawing.Point(150, 36);
            this.rbDirectory.Name = "rbDirectory";
            this.rbDirectory.Size = new System.Drawing.Size(67, 17);
            this.rbDirectory.TabIndex = 1;
            this.rbDirectory.TabStop = true;
            this.rbDirectory.Text = "Directory";
            this.rbDirectory.UseVisualStyleBackColor = true;
            this.rbDirectory.CheckedChanged += new System.EventHandler(this.rbDirectory_CheckedChanged);
            // 
            // rbContactsArchive
            // 
            this.rbContactsArchive.AutoSize = true;
            this.rbContactsArchive.Location = new System.Drawing.Point(40, 36);
            this.rbContactsArchive.Name = "rbContactsArchive";
            this.rbContactsArchive.Size = new System.Drawing.Size(67, 17);
            this.rbContactsArchive.TabIndex = 0;
            this.rbContactsArchive.TabStop = true;
            this.rbContactsArchive.Text = "Contacts";
            this.rbContactsArchive.UseVisualStyleBackColor = true;
            this.rbContactsArchive.CheckedChanged += new System.EventHandler(this.rbContactsArchive_CheckedChanged);
            // 
            // txtSql
            // 
            this.txtSql.Location = new System.Drawing.Point(18, 109);
            this.txtSql.Multiline = true;
            this.txtSql.Name = "txtSql";
            this.txtSql.Size = new System.Drawing.Size(915, 86);
            this.txtSql.TabIndex = 2;
            // 
            // btnSql
            // 
            this.btnSql.Location = new System.Drawing.Point(951, 127);
            this.btnSql.Name = "btnSql";
            this.btnSql.Size = new System.Drawing.Size(75, 49);
            this.btnSql.TabIndex = 3;
            this.btnSql.Text = "Execute";
            this.btnSql.UseVisualStyleBackColor = true;
            this.btnSql.Click += new System.EventHandler(this.btnSql_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1080, 743);
            this.Controls.Add(this.btnSql);
            this.Controls.Add(this.txtSql);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.dgData);
            this.Name = "frmMain";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dgData)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgData;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton rbZipFile;
        private System.Windows.Forms.RadioButton rbOutlook;
        private System.Windows.Forms.RadioButton rbMultiLocationFiles;
        private System.Windows.Forms.RadioButton rbListener;
        private System.Windows.Forms.RadioButton rbInventory;
        private System.Windows.Forms.RadioButton rbFiles;
        private System.Windows.Forms.RadioButton rbExchange;
        private System.Windows.Forms.RadioButton rbDirectory;
        private System.Windows.Forms.RadioButton rbContactsArchive;
        private System.Windows.Forms.TextBox txtSql;
        private System.Windows.Forms.Button btnSql;
    }
}

