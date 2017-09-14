/**
 * This file is a very simple example of a class declaration in Dojo. It defines the `app/Dialog` module as a new
 * class that extends a dijit Dialog and overrides the default title and content properties.
 */
define([ 'dojo/_base/declare', 'dijit/Dialog', "dojo/dom", "dojo/dom-style", "dojo/_base/fx" ], function (declare, Dialog, dom, domStyle, fx) {
	
    var Demo = declare(null, {
        overlayNode:null,
        constructor:function(){
            // save a reference to the overlay
            this.overlayNode = dom.byId("loadingOverlay");
        },
        // called to hide the loading overlay
        endLoading: function() {
            // fade the overlay gracefully
            fx.fadeOut({
                node: this.overlayNode,
                onEnd: function(node){
                    domStyle.set(node, 'display', 'none');
                }
            }).play();
        },
    });
    demo = new Demo();
    
	return declare(Dialog, {
		title: 'Hello World',
		content: 'Loaded successfully!'
	});
});
