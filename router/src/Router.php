<?php

class Router {

    private $routes = array(
        'GET'=>array(),
        'PUT'=>array(),
        'POST'=>array(),
        'DELETE'=>array(),
    );

    public function addRoute(Route $route)
    {
        $this->routes[(string)$route->getMethod()][] = $route;
    }

    public function resolve(Method $method, string $url, $body = null)
    {
       foreach ($this->routes[(string)($method)] as $route) {
           if ($route->match($url))
               return $route->run($url, $body);
       }
       throw new InvalidArgumentException();
    }
}
