<?php

class Route {

    /** @var string  */
	private $regex;
	/** @var Closure  */
	private $function;
	/** @var Method  */
	private $method;

	public function __construct(string $regex, Method $method, Closure $f)
	{
		$this->regex    = $regex;
		$this->method   = $method;
		$this->function = $f;
	}

	public function match(string $url) : bool
	{
		return (bool)preg_match($this->regex, $url);
	}

	public function run(string $url, $body = null)
	{
		$matches = array();
		preg_match($this->regex, $url, $matches);

		if (is_null($body))
        {
            return ($this->function)(...array_slice($matches, 1));
        }
		return ($this->function)($body, ...array_slice($matches, 1));
	}

	public function getMethod() : Method
    {
        return $this->method;
    }
}
