/*
    :copyright: Copyright 2012 Martin Pengelly-Phillips
    :license: See LICENSE.txt.
*/

var profile = {
    basePath: '../source/',
    action: 'release',
    cssOptimize: 'comments',
    mini: true,
    optimize: 'closure',
    layerOptimize: 'closure',
    stripConsole: 'all',
    selectorEngine: 'acme',

    packages: [
        'dojox',
        'dojo',
        'dijit',
        'xstyle',
        'backend',
        'dbootstrap',
    ],
    layers: {
        'dojo/dojo': {
            include: [
                'dojo/dojo',
                'dojo/i18n',
                'dojo/domReady',
                'dojo/selector/lite',
                "dojo/parser", 
                "dijit/layout/BorderContainer", 
                "dijit/layout/TabContainer", 
                "dijit/layout/AccordionContainer", 
                "dijit/layout/ContentPane", 
                "dijit/layout/AccordionPane",
                'backend/main',
            ],
            boot: true,
            customBase: true
        },
        'dbootstrap/main': {
            include: [
                'dbootstrap/main',
                'xstyle/load-css'
            ],
        },
        'backend/main': {
            include: [
                'backend/main',
                'backend/entry_point',
                'backend/Backend',
                'xstyle/load-css'
            ],
        },
        'backend/editor': {
        	include: [
	            'backend/editor',
            ],
        },
        'backend/file_upload': {
        	include: [
	            'backend/file_upload',
            ],
        },
        
    },
	prefixes: [
	   		[ "dijit", "../dijit" ],
	   		[ "dojox", "../dojox" ],
	   		[ "dojo", "../dojo" ],
	   		[ "backend", "../../../../module/Estate/public/backend" ]
	   	],
    staticHasFeatures: {
        'dojo-trace-api': 0,
        'dojo-log-api': 0,
        'dojo-publish-privates': 0,
        'dojo-sync-loader': 0,
        'dojo-xhr-factory': 0,
        'dojo-test-sniff': 0
    }
};
