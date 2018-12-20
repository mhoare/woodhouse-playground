<?php

include_once ('../src/Router.php');
include_once ('../src/Method.php');
include_once ('../src/Route.php');

$router = new Router();

$route = new Route('/\/api\/hello\/([a-z]+)/', Method::Get(), function ($name) {
	return "Hello $name";
});

$postRoute = new Route('/\/api\/hello\/?/', Method::Post(), function ($body) {
    return "Hello {$body['name']}";
});

$router->addRoute($route);
$router->addRoute($postRoute);

$method = $_SERVER['REQUEST_METHOD'];
$url = $_SERVER['REQUEST_URI'];

$body = json_decode(file_get_contents('php://input'),true);

try {
    echo $router->resolve(Method::fromData($method), $url, $body);
}
catch (InvalidArgumentException $e) {
    http_response_code(404);
}
