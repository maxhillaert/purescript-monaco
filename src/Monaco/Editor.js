// Monaco editor uses AMD loader, which means you can't use require to get it to work
// One workaournd I got to work, was to load the monaco in the html file, and keep a reference
// to its require stuff into 'var monacoRequire' which I use here.
// I would really like to find a bette workaround, but haven't yet. Will reach out to the communitu.

exports.createImpl = function(options) {
    return function(el) {
        return new Promise(function(resolve, reject) {
            monacoRequire.config({ paths: { 'vs': '/monaco-editor/min/vs' }});
            monacoRequire(['vs/editor/editor.main'], function() {
            var editor = monaco.editor.create(el, options);
            resolve(editor);
            });
        });
    };
};

