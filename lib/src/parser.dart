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

    expression:
        : "(" expression ")"
        | f-q-identifier

    f-q-identifier:
        : identifier
        | identifier "." fq-identifier
        | identifier "[" expression "]"
*/

class Parser
{
    List<Lexeme> input;
    AstNode output;

    @protected int position;

    Parser(this.input);

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
