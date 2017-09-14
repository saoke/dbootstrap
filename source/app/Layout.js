define([ "dojo/parser", "dijit/layout/BorderContainer",
		"dijit/layout/ContentPane", "dojo/domReady!", "dijit/form/Button",
		"dijit/layout/AccordionContainer", "dijit/form/TextBox",
		"dijit/form/SimpleTextarea", "dijit/Editor", "dojo/parser",
		"dojox/editor/plugins/PrettyPrint",
		"dojox/editor/plugins/PageBreak",
		"dojox/editor/plugins/ShowBlockNodes",
		"dojox/editor/plugins/Preview",
		"dojox/editor/plugins/Save",
		"dojox/editor/plugins/ToolbarLineBreak",
		"dojox/editor/plugins/NormalizeIndentOutdent",
		"dojox/editor/plugins/Breadcrumb",
		"dojox/editor/plugins/FindReplace",
		"dojox/editor/plugins/PasteFromWord",
		"dojox/editor/plugins/InsertAnchor",
		"dojox/editor/plugins/CollapsibleToolbar",
		"dojox/editor/plugins/TextColor",
		"dojox/editor/plugins/Blockquote",
		"dojox/editor/plugins/Smiley",
		"dojox/editor/plugins/UploadImage" ], function(parser) {
	parser.parse();
	demo.endLoading();
});