library arctic.parser;

import "package:meta/meta.dart";

import "lexeme.dart";
import "ast_node.dart";
export "ast_node.dart";

/*
Grammar:
    block
        : block1 block
    
    block1:
        : {text}
        | tag
    
    tag
        : "<:" tag-block
        | "<:" tag-extend
        | "<:" tag-if
    
    tag-block
        : "block" string-literal ">"
    
    tag-extend
        : "extend" {string-literal} ">" tag-extend2

    tag-extend2
        : "<:" "append" ">" block "<:/" "append" ">" tag-extend2
        | "<:" "prepend" ">" block "<:/" "prepend" ">" tag-extend2
        | "<:" "delete" ">" block "<:/" "delete" ">" tag-extend2
        | "<:/" "extend" ">"

    expression
        : "(" expression ")"
        | "{" map "}"
        | f-q-identifier
        | math

    map
        : pair
        | pair "," map
    
    pair
        : identifier ":" expression

    math
        : expression "+" expression
        | expression "-" expression
        | expression "*" expression
        | expression "/" expression
        | expression "^^" expression
        | expression "&" expression
        | expression "^" expression
        | expression "|" expression
        | expression "<<" expression
        | expression ">>" expression

    f-q-identifier
        : identifier
        | identifier "." fq-identifier
        | identifier "[" expression "]"
*/

class Parser
{
    List<Lexeme> input;
    AstNode output;

    @protected int position;

    ///Initializes a parser with an input lexeme list. A parser is meant to be used once.
    ///For example:
    ///```dart
    ///Parser parser = new Parser(new Lexer("<:if true>Hello world<:/if>")..lex().output);
    ///```
    Parser(this.input);

    ///Parses the [input].
    ///For example:
    ///```dart
    ///parser.parse();
    ///```
    void parse()
    {
        while (position < input.length)
        {
            if (!reduce())
                shift();

            ++position;
        }
    }


    @protected bool reduce()
    {

    }

    @protected void shift()
    {

    }


    @protected void pushToNode(AstNode node)
    {
    }
}
