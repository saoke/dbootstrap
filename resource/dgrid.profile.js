var profile = (function () {
    // 只复制的文件（不过滤、不压缩）
    var copyOnlyMids = {
        'dgrid/Gruntfile': 1,
        'dgrid/package': 1
    };
    // 构建时排除的文件
    var miniExcludeMids = {
        'dgrid/CHANGES.md': 1,
        'dgrid/LICENSE': 1,
        'dgrid/README.md': 1,
        'dgrid/Gruntfile': 1,
        'dgrid/package': 1
    };
    var amdRegex = /\.js$/;
    var isDemoRegex = /\/demos\//;
    var isStylusRegex = /\.styl$/;
    var isTestRegex = /\/test\//;

    return {
        // 资源标签，决定每个文件的处理方式
        resourceTags: {
            // 只复制不过滤的文件
            copyOnly: function (filename, mid) {
                return (mid in copyOnlyMids) || isDemoRegex.test(filename) || isTestRegex.test(filename);
            },
            // 测试文件
            test: function (filename, mid) {
                return isTestRegex.test(filename);
            },
            // 构建时排除的文件
            miniExclude: function (filename, mid) {
                return isDemoRegex.test(filename) ||
                    isStylusRegex.test(filename) ||
                    isTestRegex.test(filename) ||
                    mid in miniExcludeMids;
            },
            // AMD模块
            amd: function (filename, mid) {
                return amdRegex.test(filename);
            }
        },

        // 遍历目录，排除隐藏目录、临时文件、node_modules等
        trees: [
            [ '.', '.', /(?:\/\.)|(?:~$)|(?:(?:html-report|node_modules|nib|nodes)\/)/ ]
        ],

        // 可选：指定包信息（适合多包项目）
        packages: [
            { name: "dojo", location: "dojo" },
            { name: "dstore", location: "dstore" },
            { name: "dgrid", location: "dgrid" }
        ],

        // 可选：静态特性开关
        // staticHasFeatures: {
        //     'dojo-firebug': 0,
        //     'dojo-debug-messages': 0
        // },

        // 可选：自定义构建优化参数
        // optimize: "uglify",
        // layerOptimize: "uglify",
        // useSourceMaps: false
    };
})();