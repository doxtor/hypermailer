<?php

class FormattedViews extends BaseModel {

    public $formatted_view_id;
    public $datasource_id;
    public $name;
    public $query;

    public function initialize() {
        parent::initialize();

        $this->setSource('formatted_views');

        $this->hasOne('datasource_id', 'Datasources', 'datasource_id', [
            'alias' => 'datasource'
        ]);

        $this->hasMany('formatted_view_id', 'Renewals', 'formatted_view_id', [
            'alias' => 'renewals'
        ]);
    }

    static public function views_with_datasources() {
        $views = [];

        foreach (FormattedViews::find(['order' => 'datasource_id']) as $view) {
            $views[$view->formatted_view_id] = $view->datasource->name . ' - ' . $view->name;
        }

        return $views;
    }

}