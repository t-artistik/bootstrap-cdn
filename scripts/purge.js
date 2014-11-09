#!/usr/bin/env node
// Adding a simple script for now, possibiliy maturize later.
var fs       = require('fs');
var path     = require('path');
var maxpurge = require('maxcdn-purge');
var args     = require('subarg')(process.argv.slice(2));

if (args.h || args.help) {
    console.log('Usage: purge.js [opts] [FILES]');
    console.log('');
    console.log('Options:');
    console.log(' c: Custom configuration location.');
    console.log('');
    console.log('Example:');
    console.log('');
    console.log(' $ node purge.js -c ~/maxcdn.yml \'');
    console.log('      public/bootlint/latest/');
    console.log('');
    process.exit();
}

function bail(msg) {
    console.log('ERROR: ', msg);
    process.exit(1);
}

var paths = args._;
if (paths.length === 0) {
    bail('Requires a directory purge!');
}

// build file list
var targets = [];

paths.forEach(function (p) {
    function tree(loc) {
        // windows support
        var seg = loc.split(path.sep);

        // Allowing for tab completion or real cdn path becuase I can see using either;
        // - 'public/bootstrap/latest'
        // - 'bootstrap/latest'
        var diskLoc, realLoc;
        if (seg[0] === 'public') {
            diskLoc = seg.join(path.sep);
            realLoc = '/' + seg.slice(1).join(path.sep);
        } else {
            diskLoc = path.join('public', seg.join(path.sep));
            realLoc = '/' + seg.join(path.sep);
        }

        var files = fs.readdirSync(diskLoc);
        files.forEach(function(file) {
            var fileLoc = path.join(diskLoc, file);
            var stats   = fs.statSync(fileLoc);
            if (stats.isDirectory()) {
                tree(fileLoc);
            } else {
                targets.push(path.join(realLoc, file));
            }
        });
    }

    tree(p);
});

// do things
var maxconf;
if (args.c) {
    maxconf = require('maxconf.js')({ file: args.c });
} else {
    maxconf = require('maxconf.js')();
}

maxconf.file = targets;
console.dir(maxconf);

//maxpurge(maxconf);
