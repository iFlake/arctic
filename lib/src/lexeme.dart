library arctic.lexer.lexeme;

export "package:arctic/src/lexeme_type.dart";

class Lexeme
{
    final LexemeType type;
    final String value;

    Lexeme({this.type, this.value = null});
}
