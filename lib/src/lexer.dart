library arctic.lexer;

import "package:meta/meta.dart";

import "package:arctic/src/lexeme.dart";
import "package:arctic/src/lexer_flags.dart";

class Lexer
{
    final String input;
    List<Lexeme> output                   = [];
    
    @protected int position               = 0;
    @protected int length                 = 1;

    @protected int line                   = 1;
    @protected int column                 = 1;

    @protected bool inText                = false;

    @protected const identifierBegin      =
    [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "_"
    ];

    @protected const identifierPreceed    =
    [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "_"
    ];

    Lexer(this.input);

    void lex()
    {
        while (true)
        {
            int nextTag = find("<:");

            if (nextTag == null)
            {
                output.add(new Lexeme(type: LexemeType.text, value: readUntilEnd()));
                return;
            }
            else
            {
                output.add(new Lexeme(type: LexemeType.text, value: readUntil(nextTag)));
                lexTag();
            }
        }
    }

    @protected void lexTag()
    {
        while (true)
        {
            if (nextIs(">", jump: true))
                output.add(new Lexeme(type: LexemeType.tagStartClose, line: line, column: column));
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
            else if (nextIsIdentifier(preceeding: false))
                output.add(lexIdentifier());
        }
    }

    @protected bool nextIs(String what, {bool jump})
    {
        if (input.substring(position, position + what.length) == what)
        {
            if (jump == true)
                position += what.length;

            return true;
        }
        else
        {
            return false;
        }
    }

    @protected bool nextIsIdentifier({bool preceeding})
    {
        return (preceeding ? identifierPreceeding : identifierBegin)
            .indexOf(input.substring(position, position + 1)) != null;
    }

    @protected Lexeme lexIdentifier()
    {
        String identifier = "";
        
        identifier = readChars(1, jump: true);

        assert(identifierBegin.indexOf(identifier) != null);

        while (position < input.length)
        {
            String char = readChars(1, jump: false);

            if (identifierPreceed.indexOf(identifier) == null)
                return identifyIdentifier(identifier);
            
            identifier = "${identifier}${char}";
            ++position;
        }

        return identifyIdentifier(identifier);
    }

    @protected int find(String what)
    {
        int maximumLength = input.length - what.length;

        for (int position; position < maximumLength; ++position)
        {
            if (readChars(what.length) == what)
                return position;
        }

        return null;
    }

    @protected bool findAndJump(String what)
    {
        int location = find(what);

        if (location == null)
            return false;

        position = location;
        return true;
    }

    @protected void retreat(int lengths)
    {
        position -= length;
    }

    @protected String readChars(int length, {bool jump = false})
    {
        assert(position + length < input.length);

        String chars = input.substring(position, position + length);
    }

    @protected String readUntil(int until)
    {
        assert(until < input.length);

        return input.substring(position, until);
    }

    @protected String readUntilEnd()
    {
        return input.substring(position, input.length);
    }
}
