library arctic.ast_node;

import 'ast_node_type.dart';
export 'ast_node_type.dart';
import "lexeme.dart";

class AstNode
{
    final AstNodeType type;
    final Lexeme lexeme;
    List<AstNode> node;

    ///Creates an abstract syntax tree node of the type [AstNodeType] with either a lexeme or a node.
    AstNode({type, lexeme = null, node = null})
    :   type      = type,
        lexeme    = lexeme,
        node      = node;
}
