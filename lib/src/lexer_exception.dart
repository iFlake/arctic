library arctic.lexer_exception;

class LexerException implements Exception
{
    final String message;

    final int line;
    final int column;

    ///Initializes a lexer exception with a message and a location.
    const LexerException(String message, {int line, int column})
    :   message    = message,
        line       = line,
        column     = column;
    
    ///Converts this exception into a string.
    String toString() => "Lexer: ${message} at ${line}:${column}";
}
