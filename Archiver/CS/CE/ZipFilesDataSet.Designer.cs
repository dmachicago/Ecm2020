// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports


//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.431
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------




///<summary>
///Represents a strongly typed in-memory cache of data.
///</summary>
namespace EcmArchiveClcSetup
{
	[global::System.Serializable(), global::System.ComponentModel.DesignerCategoryAttribute("code"), global::System.ComponentModel.ToolboxItem(true), global::System.Xml.Serialization.XmlSchemaProviderAttribute("GetTypedDataSetSchema"), global::System.Xml.Serialization.XmlRootAttribute("ZipFilesDataSet"), global::System.ComponentModel.Design.HelpKeywordAttribute("vs.data.DataSet")]public partial class ZipFilesDataSet : global::System.Data.DataSet
	{
		
		private global::System.Data.SchemaSerializationMode _schemaSerializationMode = global::System.Data.SchemaSerializationMode.IncludeSchema;
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]public ZipFilesDataSet()
		{
			this.BeginInit();
			this.InitClass();
			global::System.ComponentModel.CollectionChangeEventHandler schemaChangedHandler = new global::System.ComponentModel.CollectionChangeEventHandler(this.SchemaChanged);
			base.Tables.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler);
			base.Relations.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler);
			this.EndInit();
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected ZipFilesDataSet(global::System.Runtime.Serialization.SerializationInfo info, global::System.Runtime.Serialization.StreamingContext context) : base(info, context, false)
		{
			if (this.IsBinarySerialized(info, context) == true)
			{
				this.InitVars(false);
				global::System.ComponentModel.CollectionChangeEventHandler schemaChangedHandler1 = new global::System.ComponentModel.CollectionChangeEventHandler(this.SchemaChanged);
				this.Tables.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler1);
				this.Relations.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler1);
				return;
			}
			string strSchema = System.Convert.ToString(info.GetValue("XmlSchema", typeof(string)));
			if (this.DetermineSchemaSerializationMode(info, context) == global::System.Data.SchemaSerializationMode.IncludeSchema)
			{
				global::System.Data.DataSet ds = new global::System.Data.DataSet();
				ds.ReadXmlSchema(new global::System.Xml.XmlTextReader(new global::System.IO.StringReader(strSchema)));
				this.DataSetName = ds.DataSetName;
				this.Prefix = ds.Prefix;
				this.Namespace = ds.Namespace;
				this.Locale = ds.Locale;
				this.CaseSensitive = ds.CaseSensitive;
				this.EnforceConstraints = ds.EnforceConstraints;
				this.Merge(ds, false, global::System.Data.MissingSchemaAction.Add);
				this.InitVars();
			}
			else
			{
				this.ReadXmlSchema(new global::System.Xml.XmlTextReader(new global::System.IO.StringReader(strSchema)));
			}
			this.GetSerializationData(info, context);
			global::System.ComponentModel.CollectionChangeEventHandler schemaChangedHandler = new global::System.ComponentModel.CollectionChangeEventHandler(this.SchemaChanged);
			base.Tables.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler);
			this.Relations.CollectionChanged += new System.ComponentModel.CollectionChangeEventHandler(schemaChangedHandler);
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0"), global::System.ComponentModel.BrowsableAttribute(true), global::System.ComponentModel.DesignerSerializationVisibilityAttribute(global::System.ComponentModel.DesignerSerializationVisibility.Visible)]public override global::System.Data.SchemaSerializationMode SchemaSerializationMode
		{
			get
			{
				return this._schemaSerializationMode;
			}
			set
			{
				this._schemaSerializationMode = value;
			}
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0"), global::System.ComponentModel.DesignerSerializationVisibilityAttribute(global::System.ComponentModel.DesignerSerializationVisibility.Hidden)]public new global::System.Data.DataTableCollection Tables
		{
			get
			{
				return base.Tables;
			}
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0"), global::System.ComponentModel.DesignerSerializationVisibilityAttribute(global::System.ComponentModel.DesignerSerializationVisibility.Hidden)]public new global::System.Data.DataRelationCollection Relations
		{
			get
			{
				return base.Relations;
			}
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected override void InitializeDerivedDataSet()
		{
			this.BeginInit();
			this.InitClass();
			this.EndInit();
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]public override global::System.Data.DataSet Clone()
		{
			ZipFilesDataSet cln = (ZipFilesDataSet) (base.Clone());
			cln.InitVars();
			cln.SchemaSerializationMode = this.SchemaSerializationMode;
			return cln;
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected override bool ShouldSerializeTables()
		{
			return false;
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected override bool ShouldSerializeRelations()
		{
			return false;
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected override void ReadXmlSerializable(global::System.Xml.XmlReader reader)
		{
			if (this.DetermineSchemaSerializationMode(reader) == global::System.Data.SchemaSerializationMode.IncludeSchema)
			{
				this.Reset();
				global::System.Data.DataSet ds = new global::System.Data.DataSet();
				ds.ReadXml(reader);
				this.DataSetName = ds.DataSetName;
				this.Prefix = ds.Prefix;
				this.Namespace = ds.Namespace;
				this.Locale = ds.Locale;
				this.CaseSensitive = ds.CaseSensitive;
				this.EnforceConstraints = ds.EnforceConstraints;
				this.Merge(ds, false, global::System.Data.MissingSchemaAction.Add);
				this.InitVars();
			}
			else
			{
				this.ReadXml(reader);
				this.InitVars();
			}
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]protected override global::System.Xml.Schema.XmlSchema GetSchemaSerializable()
		{
			global::System.IO.MemoryStream stream = new global::System.IO.MemoryStream();
			this.WriteXmlSchema(new global::System.Xml.XmlTextWriter(stream, null));
			stream.Position = 0;
			return global::System.Xml.Schema.XmlSchema.Read(new global::System.Xml.XmlTextReader(stream), null);
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]internal void InitVars()
		{
			this.InitVars(true);
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]internal void InitVars(bool initTable)
		{
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]private void InitClass()
		{
			this.DataSetName = "ZipFilesDataSet";
			this.Prefix = "";
			this.Namespace = "http://tempuri.org/ZipFilesDataSet.xsd";
			this.EnforceConstraints = true;
			this.SchemaSerializationMode = global::System.Data.SchemaSerializationMode.IncludeSchema;
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]private void SchemaChanged(object sender, global::System.ComponentModel.CollectionChangeEventArgs e)
		{
			if (e.Action == global::System.ComponentModel.CollectionChangeAction.Remove)
			{
				this.InitVars();
			}
		}
		
		[global::System.Diagnostics.DebuggerNonUserCodeAttribute(), global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Design.TypedDataSetGenerator", "4.0.0.0")]public static global::System.Xml.Schema.XmlSchemaComplexType GetTypedDataSetSchema(global::System.Xml.Schema.XmlSchemaSet xs)
		{
			ZipFilesDataSet ds = new ZipFilesDataSet();
			global::System.Xml.Schema.XmlSchemaComplexType type = new global::System.Xml.Schema.XmlSchemaComplexType();
			global::System.Xml.Schema.XmlSchemaSequence sequence = new global::System.Xml.Schema.XmlSchemaSequence();
			global::System.Xml.Schema.XmlSchemaAny any = new global::System.Xml.Schema.XmlSchemaAny();
			any.Namespace = ds.Namespace;
			sequence.Items.Add(any);
			type.Particle = sequence;
			global::System.Xml.Schema.XmlSchema dsSchema = ds.GetSchemaSerializable();
			if (xs.Contains(dsSchema.TargetNamespace))
			{
				global::System.IO.MemoryStream s1 = new global::System.IO.MemoryStream();
				global::System.IO.MemoryStream s2 = new global::System.IO.MemoryStream();
				try
				{
					global::System.Xml.Schema.XmlSchema schema = null;
					dsSchema.Write(s1);
					global::System.Collections.IEnumerator schemas = xs.Schemas(dsSchema.TargetNamespace).GetEnumerator();
					while (schemas.MoveNext())
					{
						schema = (global::System.Xml.Schema.XmlSchema) schemas.Current;
						s2.SetLength(0);
						schema.Write(s2);
						if (s1.Length == s2.Length)
						{
							s1.Position = 0;
							s2.Position = 0;
							
							while ((s1.Position != s1.Length) && (s1.ReadByte() == s2.ReadByte()))
							{
								
								
							}
							if (s1.Position == s1.Length)
							{
								return type;
							}
						}
						
					}
				}
				finally
				{
					if ((s1) != null)
					{
						s1.Close();
					}
					if ((s2) != null)
					{
						s2.Close();
					}
				}
			}
			xs.Add(dsSchema);
			return type;
		}
	}
	
}
