library arctic.lexer.lexeme_type;

enum LexemeType
{
    ///Represents text outside a tag.
    text,
    ///Represents a start tag being opened: `<:`.
    tagStartOpen,
    ///Represents an end tag being opened: `<:/`.
    tagEndOpen,
    ///Represents any tag being closed: `>`.
    tagClose,
    ///Represents an opening parenthesis: `(`.
    parenthesisOpen,
    ///Represents a closing parenthesis: `)`.
    parenthesisClose,
    ///Represents an opening map: `{`.
    mapOpen,
    ///Represents a closing map: `}`.
    mapClose,
    ///Represents an opening list: `[`.
    listOpen,
    ///Represents a closing list: `]`.
    listClose,
    ///Represents a list separator: `,`.
    listSeparator,
    ///Represents arithmetic addition: `+`.
    arithmeticAdd,
    ///Represents arithmetic subtraction: `-`.
    arithmeticSubtract,
    ///Represents arithmetic multiplication: `*`.
    arithmeticMultiply,
    ///Represents arithmetic division: `/`.
    arithmeticDivide,
    ///Represents arithmetic exponentation: `^^`.
    arithmeticExponent,
    ///Represents bitwise inclusive OR: `|`.
    bitwiseInclusiveOr,
    ///Represents bitwise exclusive OR: `^`.
    bitwiseExclusiveOr,
    ///Represents bitwise AND: `&`.
    bitwiseAnd,
    ///Represents bitwise left shift: `<<`.
    bitwiseShiftLeft,
    ///Represents bitwise right shift: `>>`.
    bitwiseShiftRight,
    ///Represents a child member: `.`.
    child,
    ///Represents an output tag: `$`.
    tagOutput,
    ///Represents a block tag: `block`.
    tagBlock,
    ///Represents an extend tag: `extend`.
    tagExtend,
    ///Represents a prepend tag: `prepend`.
    tagPrepend,
    ///Represents an append tag: `append`.
    tagAppend,
    ///Represents a delete tag: `delete`.
    tagDelete,
    ///Represents a for loop: `for`.
    loopFor,
    ///Represents a foreach loop: `foreach`.
    loopForeach,
    ///Represents an in clause in a foreach loop: `in`.
    loopForeachIn,
    ///Represents a with clause in a foreach loop: `with`.
    loopForeachWith,
    ///Represents a condition: `if`.
    conditionIf,
    ///Represents a condition which does not occur if the previous condition occurred: `elseif`.
    conditionElseIf,
    ///Represents a condition which occurs if none of the previous conditions occurred: `else`.
    conditionElse,
    ///Represents an identifier: `/[A-Za-z_][A-Za-z_0-9]*/`.
    identifier,
    ///Represents a literal number: `/[0-9][0-9]*/`.
    literalNumber,
    ///Represents a literal string.
    literalString,
    ///Represents a literal boolean with the value true: `true`.
    literalBooleanTrue,
    ///Represents a literal boolean with the value false: `false`.
    literalBooleanFalse
}
