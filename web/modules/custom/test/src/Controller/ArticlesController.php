<?php

namespace Drupal\test\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

class ArticlesController extends ControllerBase {

    public function listAll() {
        $query = $this->entityTypeManager()->getStorage('node')->getQuery();
        $articlesIds = $query->condition('type', 'article')->accessCheck(TRUE)->execute();

        $articles = $this->entityTypeManager()->getStorage('node')->loadMultiple($articlesIds);

        $view_builder = $this->entityTypeManager()->getViewBuilder('node');
        $items = [];
        foreach($articles as $article) {
            $items[] = $view_builder->view($article, 'teaser');
        }

        return [
            '#theme' => 'item_list',
            '#items' => $items,
        ];
    }
}