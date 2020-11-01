namespace ENCTest
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
            this.txtPlain = new System.Windows.Forms.TextBox();
            this.txtEncrypted = new System.Windows.Forms.TextBox();
            this.txtPhrase = new System.Windows.Forms.TextBox();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.ckAes = new System.Windows.Forms.CheckBox();
            this.btnEncrypt = new System.Windows.Forms.Button();
            this.btnDecrypt = new System.Windows.Forms.Button();
            this.ckDecryptStd = new System.Windows.Forms.CheckBox();
            this.ckTripleDes = new System.Windows.Forms.CheckBox();
            this.btnClipboard = new System.Windows.Forms.Button();
            this.ckFips = new System.Windows.Forms.CheckBox();
            this.ckSha3 = new System.Windows.Forms.CheckBox();
            this.ckAES3 = new System.Windows.Forms.CheckBox();
            this.ckAES256 = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // txtPlain
            // 
            this.txtPlain.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtPlain.Location = new System.Drawing.Point(27, 143);
            this.txtPlain.Multiline = true;
            this.txtPlain.Name = "txtPlain";
            this.txtPlain.Size = new System.Drawing.Size(674, 189);
            this.txtPlain.TabIndex = 0;
            // 
            // txtEncrypted
            // 
            this.txtEncrypted.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtEncrypted.Location = new System.Drawing.Point(27, 355);
            this.txtEncrypted.Multiline = true;
            this.txtEncrypted.Name = "txtEncrypted";
            this.txtEncrypted.Size = new System.Drawing.Size(674, 189);
            this.txtEncrypted.TabIndex = 1;
            // 
            // txtPhrase
            // 
            this.txtPhrase.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtPhrase.Location = new System.Drawing.Point(157, 25);
            this.txtPhrase.Name = "txtPhrase";
            this.txtPhrase.Size = new System.Drawing.Size(697, 22);
            this.txtPhrase.TabIndex = 2;
            // 
            // txtPassword
            // 
            this.txtPassword.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtPassword.Location = new System.Drawing.Point(157, 53);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.Size = new System.Drawing.Size(399, 22);
            this.txtPassword.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(56, 29);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 17);
            this.label1.TabIndex = 4;
            this.label1.Text = "Phrase";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(56, 53);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(73, 17);
            this.label2.TabIndex = 5;
            this.label2.Text = "PassWord";
            // 
            // ckAes
            // 
            this.ckAes.AutoSize = true;
            this.ckAes.Location = new System.Drawing.Point(31, 104);
            this.ckAes.Name = "ckAes";
            this.ckAes.Size = new System.Drawing.Size(57, 21);
            this.ckAes.TabIndex = 6;
            this.ckAes.Text = "AES";
            this.ckAes.UseVisualStyleBackColor = true;
            // 
            // btnEncrypt
            // 
            this.btnEncrypt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnEncrypt.Location = new System.Drawing.Point(719, 143);
            this.btnEncrypt.Name = "btnEncrypt";
            this.btnEncrypt.Size = new System.Drawing.Size(135, 46);
            this.btnEncrypt.TabIndex = 7;
            this.btnEncrypt.Text = "Encrypt";
            this.btnEncrypt.UseVisualStyleBackColor = true;
            this.btnEncrypt.Click += new System.EventHandler(this.btnEncrypt_Click);
            // 
            // btnDecrypt
            // 
            this.btnDecrypt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDecrypt.Location = new System.Drawing.Point(719, 355);
            this.btnDecrypt.Name = "btnDecrypt";
            this.btnDecrypt.Size = new System.Drawing.Size(135, 46);
            this.btnDecrypt.TabIndex = 8;
            this.btnDecrypt.Text = "Decrypt";
            this.btnDecrypt.UseVisualStyleBackColor = true;
            this.btnDecrypt.Click += new System.EventHandler(this.btnDecrypt_Click);
            // 
            // ckDecryptStd
            // 
            this.ckDecryptStd.AutoSize = true;
            this.ckDecryptStd.Location = new System.Drawing.Point(249, 104);
            this.ckDecryptStd.Name = "ckDecryptStd";
            this.ckDecryptStd.Size = new System.Drawing.Size(159, 21);
            this.ckDecryptStd.TabIndex = 9;
            this.ckDecryptStd.Text = "Standard Encryption";
            this.ckDecryptStd.UseVisualStyleBackColor = true;
            // 
            // ckTripleDes
            // 
            this.ckTripleDes.AutoSize = true;
            this.ckTripleDes.Location = new System.Drawing.Point(413, 104);
            this.ckTripleDes.Name = "ckTripleDes";
            this.ckTripleDes.Size = new System.Drawing.Size(98, 21);
            this.ckTripleDes.TabIndex = 10;
            this.ckTripleDes.Text = "Triple DES";
            this.ckTripleDes.UseVisualStyleBackColor = true;
            // 
            // btnClipboard
            // 
            this.btnClipboard.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnClipboard.Location = new System.Drawing.Point(719, 498);
            this.btnClipboard.Name = "btnClipboard";
            this.btnClipboard.Size = new System.Drawing.Size(135, 46);
            this.btnClipboard.TabIndex = 11;
            this.btnClipboard.Text = "Clipboard";
            this.btnClipboard.UseVisualStyleBackColor = true;
            this.btnClipboard.Click += new System.EventHandler(this.btnClipboard_Click);
            // 
            // ckFips
            // 
            this.ckFips.AutoSize = true;
            this.ckFips.Location = new System.Drawing.Point(516, 104);
            this.ckFips.Name = "ckFips";
            this.ckFips.Size = new System.Drawing.Size(59, 21);
            this.ckFips.TabIndex = 12;
            this.ckFips.Text = "FIPS";
            this.ckFips.UseVisualStyleBackColor = true;
            // 
            // ckSha3
            // 
            this.ckSha3.AutoSize = true;
            this.ckSha3.Location = new System.Drawing.Point(580, 104);
            this.ckSha3.Name = "ckSha3";
            this.ckSha3.Size = new System.Drawing.Size(66, 21);
            this.ckSha3.TabIndex = 13;
            this.ckSha3.Text = "SHA3";
            this.ckSha3.UseVisualStyleBackColor = true;
            // 
            // ckAES3
            // 
            this.ckAES3.AutoSize = true;
            this.ckAES3.Location = new System.Drawing.Point(93, 104);
            this.ckAES3.Name = "ckAES3";
            this.ckAES3.Size = new System.Drawing.Size(65, 21);
            this.ckAES3.TabIndex = 14;
            this.ckAES3.Text = "AES3";
            this.ckAES3.UseVisualStyleBackColor = true;
            // 
            // ckAES256
            // 
            this.ckAES256.AutoSize = true;
            this.ckAES256.Location = new System.Drawing.Point(163, 104);
            this.ckAES256.Name = "ckAES256";
            this.ckAES256.Size = new System.Drawing.Size(81, 21);
            this.ckAES256.TabIndex = 15;
            this.ckAES256.Text = "AES256";
            this.ckAES256.UseVisualStyleBackColor = true;
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(866, 558);
            this.Controls.Add(this.ckAES256);
            this.Controls.Add(this.ckAES3);
            this.Controls.Add(this.ckSha3);
            this.Controls.Add(this.ckFips);
            this.Controls.Add(this.btnClipboard);
            this.Controls.Add(this.ckTripleDes);
            this.Controls.Add(this.ckDecryptStd);
            this.Controls.Add(this.btnDecrypt);
            this.Controls.Add(this.btnEncrypt);
            this.Controls.Add(this.ckAes);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPassword);
            this.Controls.Add(this.txtPhrase);
            this.Controls.Add(this.txtEncrypted);
            this.Controls.Add(this.txtPlain);
            this.Name = "frmMain";
            this.Text = "Encryption Demo";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtPlain;
        private System.Windows.Forms.TextBox txtEncrypted;
        private System.Windows.Forms.TextBox txtPhrase;
        private System.Windows.Forms.TextBox txtPassword;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox ckAes;
        private System.Windows.Forms.Button btnEncrypt;
        private System.Windows.Forms.Button btnDecrypt;
        private System.Windows.Forms.CheckBox ckDecryptStd;
        private System.Windows.Forms.CheckBox ckTripleDes;
        private System.Windows.Forms.Button btnClipboard;
        private System.Windows.Forms.CheckBox ckFips;
        private System.Windows.Forms.CheckBox ckSha3;
        private System.Windows.Forms.CheckBox ckAES3;
        private System.Windows.Forms.CheckBox ckAES256;
    }
}

