<?php

final class Method {
	
	/** @var string */
	private $method;

	private function __construct($method)
	{
		$this->method = $method;
	}

	public static function fromData(string $method)
    {
        switch ($method) {
            case 'GET':
                return self::Get();
            case 'PUT':
                return self::Put();
            case 'POST':
                return self::Post();
            case 'DELETE':
                return self::Delete();
            default:
                throw new InvalidArgumentException();
        }
    }

	public static function Get() : Method
	{
		return new Method('GET');
	}

	public static function Put() : Method
	{
		return new Method('PUT');
	}

	public static function Post() : Method
	{
		return new Method('POST');
	}

	public static function Delete() : Method
	{
		return new Method('DELETE');
	}

	public function __toString()
	{
		return $this->method;
	}
}
