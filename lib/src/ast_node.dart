library arctic.ast_node;

import 'ast_node_type.dart';
export 'ast_node_type.dart';
import "lexeme.dart";

class AstNode
{
    final AstNodeType type;
    final Lexeme lexeme;
    List<AstNode> node;

    AstNode({type, lexeme = null, node = null})
    :   type      = type,
        lexeme    = lexeme,
        node      = node;
}
