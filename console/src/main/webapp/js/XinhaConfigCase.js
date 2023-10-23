xinha_editors = null;
xinha_init    = null;
xinha_config  = null;
xinha_plugins = null;

// This contains the names of textareas we will make into Xinha editors
xinha_init = xinha_init ? xinha_init : function()
{

  xinha_editors = xinha_editors ? xinha_editors :
  [
    'exams', 'report', 'criterion'
  ];

  xinha_plugins = xinha_plugins ? xinha_plugins :
  [
   'ContextMenu',
   'ListType'
  ];

  // THIS BIT OF JAVASCRIPT LOADS THE PLUGINS, NO TOUCHING  :)
  if(!Xinha.loadPlugins(xinha_plugins, xinha_init)) return;


  xinha_config = xinha_config ? xinha_config() : new Xinha.Config();
  xinha_config.width  = '500px';
  xinha_config.height = '150px';
  xinha_config.statusBar = false;

  //this is the standard toolbar, feel free to remove buttons as you like
  xinha_config.toolbar =
  [
    ["bold","italic","underline","strikethrough"],
    ["separator","justifyleft","justifycenter","justifyright","justifyfull"],
    ["separator","insertorderedlist","insertunorderedlist","outdent","indent"]
  ];


   // To adjust the styling inside the editor, we can load an external stylesheet like this
   // NOTE : YOU MUST GIVE AN ABSOLUTE URL

   //xinha_config.pageStyleSheets = [ _editor_url + "examples/full_example.css" ];

  xinha_editors   = Xinha.makeEditors(xinha_editors, xinha_config, xinha_plugins);

  Xinha.startEditors(xinha_editors);
}

Xinha._addEvent(window,'load', xinha_init); // this executes the xinha_init function on page load
                                            // and does not interfere with window.onload properties set by other scripts