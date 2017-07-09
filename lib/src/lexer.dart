library arctic.lexer;

import "package:meta/meta.dart";

import "package:arctic/src/lexeme.dart";
import "package:arctic/src/lexer_flags.dart";

class Lexer
{
    final String input;
    List<Lexeme> output        = [];
    
    @protected int position    = 0;
    @protected int length      = 1;

    @protected bool inText     = false;
    
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

    void lexTag()
    {
        while (true)
        {
            if (nextIs(">", jump: true))
                output.add(new Lexeme(type: LexemeType.tagStartClose));
            else if (nextIs("(", jump: true))
                output.add(new Lexeme(type: LexemeType.parenthesisOpen));
            else if (nextIs(")", jump: true))
                output.add(new Lexeme(type: LexemeType.parenthesisClose));
            else if (nextIs(",", jump: true))
                output.add(new Lexeme(type: LexemeType.listSeparator));
            else
                //todo
        }
    }

    bool nextIs(String what, {bool jump})
    {
        if (input.substring(position, position + what.length) == what)
            return true;
        else
            return false;
    }

    int find(String what)
    {
        int maximumLength = input.length - what.length;

        for (int position; position < maximumLength; ++position)
        {
            if (readChars(what.length) == what)
                return position;
        }

        return null;
    }

    bool findAndJump(String what)
    {
        int location = find(what);

        if (location == null)
            return false;

        position = location;
        return true;
    }

    void retreat(int lengths)
    {
        this.position -= length;
    }

    String readChars(int length)
    {
        return input.substring(position, position + length);
    }

    String readUntil(int until)
    {
        return input.substring(position, until);
    }

    String readUntilEnd()
    {
        return input.substring(position, input.length);
    }
}
