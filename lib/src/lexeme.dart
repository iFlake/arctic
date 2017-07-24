library arctic.lexer.lexeme;

import "lexeme_type.dart";
export "lexeme_type.dart";

class Lexeme
{
    final LexemeType type;
    final String value;
    
    final int line;
    final int column;

    ///Creates a lexeme with a type, optionally a value and a location.
    Lexeme({LexemeType type, String value = null, int line, int column})
    :   type      = type,
        value     = value,
        line      = line,
        column    = column;
}
