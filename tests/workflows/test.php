<?php

/**
 * Mock class for testing.
 */
class Mock
{
    public const string ERROR_MSG = 'oh no!';

    public function __construct(protected string $message)
    {
    }

    public function getMessage(): string
    {
        return $this->message;
    }

    /**
     * This should be called on error.
     */
    protected function error(): never
    {
        throw new Exception(self::ERROR_MSG);
    }
}
