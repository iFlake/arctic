library arctic.lexer.lexeme;

import "package:arctic/src/lexeme_type.dart";
export "package:arctic/src/lexeme_type.dart";

class Lexeme
{
    final LexemeType type;
    final String value;
    
    final int line;
    final int column;

    Lexeme({LexemeType type, String value = null, int line, int column})
    :   type      = type,
        value     = value,
        line      = line,
        column    = column;
}
