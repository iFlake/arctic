library arctic.lexer.lexeme;

export "package:arctic/src/lexeme_type.dart";

class Lexeme
{
    final LexemeType type;
    final String value;
    
    final int line;
    final int character;

    Lexeme({this.type, this.value = null, this.line, this.column});
}
