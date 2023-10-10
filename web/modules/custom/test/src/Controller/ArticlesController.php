<?php

namespace Drupal\test\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

class ArticlesController extends ControllerBase {


    public function listAll() {
        $output = <<<EOF
This controller does nothing because we have created a block that will output the articles instead.<br/> 
The block has been inserted into the <a href="/admin/structure/block">Block Layout</a> in the 'content' region.
EOF;

        return [
            '#type' => 'markup',
            '#markup' => $output
        ];
    }
}