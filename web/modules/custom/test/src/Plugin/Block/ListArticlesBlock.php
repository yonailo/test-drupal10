<?php

namespace Drupal\test\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;

/**
 * Provides a 'List Articles' block.
 *
 * @Block(
 *  id = "test_list_block",
 *  admin_label = @Translation("List All Articles")
 * )
 */
class ListArticlesBlock extends BlockBase implements ContainerFactoryPluginInterface {

    /**
     * The entity type manager.
     *
     * @var \Drupal\Core\Entity\EntityTypeManagerInterface
     */
    protected $entityTypeManager;

    /**
     * {@inheritdoc}
     */
    public function __construct(array $configuration, $plugin_id, $plugin_definition, EntityTypeManagerInterface $entityTypeManager) {
        parent::__construct($configuration, $plugin_id, $plugin_definition);

        $this->entityTypeManager = $entityTypeManager;
    }

    /**
     * {@inheritdoc}
     */
    public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
        return new static(
            $configuration,
            $plugin_id,
            $plugin_definition,
            $container->get('entity_type.manager')
        );
    }

    /**
     * {@inheritdoc}
     */
    public function build() {
        $query = $this->entityTypeManager->getStorage('node')->getQuery();
        $articlesIds = $query->condition('type', 'article')->accessCheck(TRUE)->execute();

        $articles = $this->entityTypeManager->getStorage('node')->loadMultiple($articlesIds);

        $view_builder = $this->entityTypeManager->getViewBuilder('node');
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