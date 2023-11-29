<?php

/**
 * Mock class for testing.
 */
class Mock
{
    /**
     * @var string
     */
    protected string $message;

    /**
     * @param string $message
     */
    public function __construct(string $message)
    {
        $this->message = $message;
    }

    /**
     * @return string
     */
    public function getMessage(): string
    {
        return $this->message;
    }
}
