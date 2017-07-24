library arctic.lexer_exception;

class LexerException implements Exception
{
    final String message;

    final int line;
    final int column;

    const LexerException(String message, {int line, int column})
    :   message    = message,
        line       = line,
        column     = column;
    
    String toString() => "Lexer: ${message} at ${line}:${column}";
}
