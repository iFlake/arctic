library arctic.lexer.lexeme_type;

enum LexemeType
{
    text,
    tagStartOpen,
    tagEndOpen,
    tagClose,
    parenthesisOpen,
    parenthesisClose,
    listOpen,
    listClose,
    listSeparator,
    arithmeticAdd,
    arithmeticSubtract,
    arithmeticMultiply,
    arithmeticDivide,
    arithmeticExponent,
    bitwiseInclusiveOr,
    bitwiseExclusiveOr,
    bitwiseAnd,
    bitwiseShiftLeft,
    bitwiseShiftRight,
    tagOutput,
    child,
    tagBlock,
    tagExtend,
    tagPrepend,
    tagAppend,
    tagDelete,
    loopFor,
    loopForeach,
    loopForeachIn,
    loopForeachWith,
    conditionIf,
    conditionElseIf,
    conditionElse,
    identifier,
    literalNumber,
    literalString
}
