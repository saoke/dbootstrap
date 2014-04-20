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
        'dbootstrap',
    ],
    layers: {
        'dojo/dojo': {
            include: [
                'dojo/dojo',
                'dojo/i18n',
                'dojo/domReady',
                'dojo/selector/lite'
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
            ]
        }
    },

    staticHasFeatures: {
        'dojo-trace-api': 0,
        'dojo-log-api': 0,
        'dojo-publish-privates': 0,
        'dojo-sync-loader': 0,
        'dojo-xhr-factory': 0,
        'dojo-test-sniff': 0
    }
};
