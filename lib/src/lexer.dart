library arctic.lexer;

import "package:meta/meta.dart";

import "package:arctic/src/lexeme.dart";
import "package:arctic/src/lexer_exception.dart";
export "package:arctic/src/lexer_exception.dart";

class Lexer
{
    final String input;
    List<Lexeme> output                          = [];
    
    @protected int position                      = 0;
    @protected int length                        = 1;

    @protected int line                          = 1;
    @protected int column                        = 1;

    @protected bool inText                       = false;

    @protected static const identifierBegin      = const
    [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "_"
    ];

    @protected static const identifierPreceed    = const
    [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "_"
    ];

    @protected static const number               = const
    [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
    ];

    @protected static const whitespace           = const
    [
        " ", "\t", "\n", "\r", "\0"
    ];

    Lexer(this.input);

    void lex()
    {
        String builder = "";

        while (position < input.length)
        {
            if (nextIs("<:"))
            {
                output.add(new Lexeme(type: LexemeType.text, value: builder, line: line, column: column));
                output.add(new Lexeme(type: LexemeType.tagStartOpen, line: line, column: column));

                increasePosition("<:".length);

                builder = "";

                lexTag();
            }
            else if (nextIs("</:"))
            {
                output.add(new Lexeme(type: LexemeType.text, value: builder, line: line, column: column));
                output.add(new Lexeme(type: LexemeType.tagEndOpen, line: line, column: column));

                increasePosition("</:".length);

                builder = "";

                lexTag();
            }
            else
            {
                builder = "${builder}${readChars(1, jump: true)}";
            }
        }

        if (builder != "")
            output.add(new Lexeme(type: LexemeType.text, value: builder, line: line, column: column));
    }

    @protected void lexTag()
    {
        while (!nextIs(">", jump: true))
        {
            if (position >= input.length) throw new LexerException("Excepted '>', reached EOF", line: line, column: column);;

            if (nextIsWhitespace(jump: true))
                continue;
            else if (nextIs("(", jump: true))
                output.add(new Lexeme(type: LexemeType.parenthesisOpen, line: line, column: column));
            else if (nextIs(")", jump: true))
                output.add(new Lexeme(type: LexemeType.parenthesisClose, line: line, column: column));
            else if (nextIs(",", jump: true))
                output.add(new Lexeme(type: LexemeType.listSeparator, line: line, column: column));
            else if (nextIs("+", jump: true))
                output.add(new Lexeme(type: LexemeType.arithmeticAdd, line: line, column: column));
            else if (nextIs("-", jump: true))
                output.add(new Lexeme(type: LexemeType.arithmeticSubtract, line: line, column: column));
            else if (nextIs("*", jump: true))
                output.add(new Lexeme(type: LexemeType.arithmeticMultiply, line: line, column: column));
            else if (nextIs("/", jump: true))
                output.add(new Lexeme(type: LexemeType.arithmeticDivide, line: line, column: column));
            else if (nextIs("^^", jump: true))
                output.add(new Lexeme(type: LexemeType.arithmeticExponent, line: line, column: column));
            else if (nextIs("|", jump: true))
                output.add(new Lexeme(type: LexemeType.bitwiseInclusiveOr, line: line, column: column));
            else if (nextIs("^", jump: true))
                output.add(new Lexeme(type: LexemeType.bitwiseExclusiveOr, line: line, column: column));
            else if (nextIs("&", jump: true))
                output.add(new Lexeme(type: LexemeType.bitwiseAnd, line: line, column: column));
            else if (nextIs("<<", jump: true))
                output.add(new Lexeme(type: LexemeType.bitwiseShiftLeft, line: line, column: column));
            else if (nextIs(">>", jump: true))
                output.add(new Lexeme(type: LexemeType.bitwiseShiftRight, line: line, column: column));
            else if (nextIs("\$", jump: true))
                output.add(new Lexeme(type: LexemeType.tagOutput, line: line, column: column));
            else if (nextIs(".", jump: true))
                output.add(new Lexeme(type: LexemeType.child, line: line, column: column));
            else if (nextIs("\"", jump: true))
                output.add(lexString());
            else if (nextIsNumber())
                output.add(lexNumber());
            else if (nextIsIdentifier(preceeding: false))
                output.add(lexIdentifier());
            else
                throw new LexerException("Unexpected character '${readChars(1)}'", line: line, column: column);
        }

        output.add(new Lexeme(type: LexemeType.tagClose, line: line, column: column));
    }

    @protected bool nextIs(String what, {bool jump})
    {
        if (position + what.length > input.length)
            return false;

        if (input.substring(position, position + what.length) == what)
        {
            if (jump == true)
                increasePosition(what.length);

            return true;
        }
        else
        {
            return false;
        }
    }

    @protected bool nextIsNumber()
    {
        if (position + 1 > input.length)
            return false;

        return number.indexOf(readChars(1)) != -1;
    }

    @protected bool nextIsIdentifier({bool preceeding = false})
    {
        if (position + 1 > input.length)
            return false;

        return (preceeding ? identifierPreceed : identifierBegin)
            .indexOf(readChars(1)) != -1;
    }

    @protected bool nextIsWhitespace({bool jump = false})
    {
        if (position + 1 > input.length)
            return false;

        String nextChar = readChars(1, jump: false);

        if (whitespace.indexOf(nextChar) != -1)
        {
            if (jump)
                increasePosition(1);
            
            return true;
        }
        else
        {
            return false;
        }
    }

    @protected Lexeme lexNumber()
    {
        String builder = "";

        while (position < input.length)
        {
            String nextChar = readChars(1);

            if (number.indexOf(nextChar) != -1)
                builder = "${builder}${nextChar}";
            else
                return new Lexeme(type: LexemeType.literalNumber, value: builder, line: line, column: column);

            increasePosition(1);
        }

        return new Lexeme(type: LexemeType.literalNumber, value: builder);
    }

    @protected Lexeme lexString()
    {
        String builder = "";

        while (position < input.length)
        {
            String nextChar = readChars(1, jump: true);

            switch (nextChar)
            {
                case "\"":
                    return new Lexeme(type: LexemeType.literalString, value: builder, line: line, column: column);
                    break;
                
                case "\\":
                    builder = "${builder}${readChars(1, jump: true)}";
                    break;
            }
        }

        throw new LexerException("Expected '\"', reached EOF", line: line, column: column);
    }

    @protected Lexeme lexIdentifier()
    {
        String identifier = "";
        
        identifier = readChars(1, jump: true);

        assert(identifierBegin.indexOf(identifier) != -1);

        while (position < input.length)
        {
            String char = readChars(1, jump: false);
            
            if (identifierPreceed.indexOf(identifier) == -1)
                return identifyIdentifier(identifier);
            
            identifier = "${identifier}${char}";
            ++position;
        }

        return identifyIdentifier(identifier);
    }

    @protected Lexeme identifyIdentifier(String identifier)
    {
        switch (identifier)
        {
            case "block":
                return new Lexeme(type: LexemeType.tagBlock, line: line, column: column);
                break;
            
            case "extend":
                return new Lexeme(type: LexemeType.tagExtend, line: line, column: column);
                break;
            
            case "prepend":
                return new Lexeme(type: LexemeType.tagPrepend, line: line, column: column);
                break;
            
            case "append":
                return new Lexeme(type: LexemeType.tagAppend, line: line, column: column);
                break;
            
            case "delete":
                return new Lexeme(type: LexemeType.tagDelete, line: line, column: column);
                break;
            

            case "for":
                return new Lexeme(type: LexemeType.loopFor, line: line, column: column);
                break;
            
            case "foreach":
                return new Lexeme(type: LexemeType.loopForeach, line: line, column: column);
                break;

            case "in":
                return new Lexeme(type: LexemeType.loopForeachIn, line: line, column: column);
                break;
            
            case "with":
                return new Lexeme(type: LexemeType.loopForeachWith, line: line, column: column);
                break;

            
            case "if":
                return new Lexeme(type: LexemeType.conditionIf, line: line, column: column);
                break;
            
            case "elseif":
                return new Lexeme(type: LexemeType.conditionElseIf, line: line, column: column);
                break;
            
            case "else":
                return new Lexeme(type: LexemeType.conditionElse, line: line, column: column);
                break;


            default:
                return new Lexeme(type: LexemeType.identifier, value: identifier, line: line, column: column);
                break;
        }
    }

    @protected int find(String what)
    {
        int maximumLength = input.length - what.length;

        for (int position = this.position; position < maximumLength; ++position)
        {
            if (input.substring(position, position + what.length) == what)
                return position;
        }

        return null;
    }

    @protected bool findAndJump(String what)
    {
        int location = find(what);

        if (location == null)
            return false;

        increasePosition(location - position);

        return true;
    }

    @protected String readChars(int length, {bool jump = false})
    {
        assert(position + length <= input.length);

        String chars = input.substring(position, position + length);

        if (jump)
            increasePosition(length);

        return chars;
    }

    @protected String readUntil(int until, {bool jump = false})
    {
        assert(until < input.length);

        String chars = input.substring(position, until);

        if (jump)
            increasePosition(until - position);

        return chars;
    }

    @protected String readUntilEnd()
    {
        return input.substring(position, input.length);
    }

    @protected void increasePosition(int length)
    {
        assert(position + length < input.length);

        for (int iterator = 0; iterator < length; ++iterator)
        {
            String char = readChars(1);

            if (char == "\n")
            {
                ++line;
                column = 1;
            }
            else
            {
                ++column;
            }

            ++position;
        }
    }
}

void main()
{
  Lexer lxr = new Lexer(
      """
      abc<:if xx>xboin
      dcd</:if -2.45166>xxxx """
    );
  lxr.lex();
  
  for (var output in lxr.output)
  {
    print("---");
    print("type: ${output.type}");
    print("value: ${output.value}");
    print("location: ${output.line}:${output.column}");
    print("---");
  }
}
