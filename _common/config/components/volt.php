<?php

$di->set('volt', function($view, $di) use ($config) {
    $volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);

    $compile_always = ($config->state->development) ? true : false;

    $volt->setOptions([
        'compiledPath'      => '../app/views/compiled_templates/',
        'compiledSeparator' => '_',
        'compileAlways'     => $compile_always
    ]);

    $volt->getCompiler()->addFilter('datesubstr', function($res_args, $expr_args) {
        return 'VoltExtend::datesubstr(' . $res_args . ')';
    });

    $volt->getCompiler()->addFilter('count', function($res_args, $expr_args) {
        return 'VoltExtend::count(' . $res_args . ')';
    });

    $volt->getCompiler()->addFunction('static', function($res_args) {
        return str_replace('\'', '', $res_args);
    });

    return $volt;
}, true);

// view component
$di->set('view', function() use ($config) {
    $view = new \Phalcon\Mvc\View();

    $view->setViewsDir('../app/views/');

    $view->registerEngines([
        '.volt' => 'volt'
    ]);

    return $view;
});