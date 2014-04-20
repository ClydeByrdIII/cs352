package edu.purdue.cs352.minijava.parser;

import java.util.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.File;
import java.io.IOException;
import edu.purdue.cs352.minijava.parser.Tokens;

public class LexerManual {
    private int look;
    private LinkedList<Character> putBack;
    private int lineNum;
    private boolean inComments;
    private BufferedReader in;
    private Map<String, String> keywords;
    private Map<String, String> symbols;
    private ArrayList<Tokens> tokenList; 

    /* isSpace(int letter) checks if the character is a space, tab, newline, carriage return, or \f */
    public static boolean isSpace(int letter) {
        return (letter == ' ' || letter == '\t' || letter == '\r' || letter == '\f' || letter == '\n');
    } 

    /* fill the lexer's symbol table */
    private void fillSymbols() {
        symbols = new HashMap<String, String>();
        String[] reserved = "{ } ( ) [ ] ; = && || < <= == != > >= + - * / % ! . ,".split(" ");
        for(String word: reserved) 
            symbols.put(word, word);
    }

    /* Fill the keywords hashMap with all reserved words */
    private void fillKeyWords() {

        keywords = new HashMap<String, String>();
        String[] reserved = "class public static void main String extends return int boolean if else while true false this new System.out.println".split(" ");
        for(String word: reserved) 
            keywords.put(word, word);
    }

    /* read one char of input from input */
    private int getchar() {
        try {
            // if queue is empty take from buffer
            if(putBack.isEmpty()) 
                look = in.read();
            else 
                look = putBack.remove();

        } catch (IOException error) {
            System.out.println(error.getMessage());
            look = -1;
        }
        return look;
    }

    /* fill tokenlist with all tokens from input */
    public void tokenize() throws Exception {
        Tokens token;
        try {

            while(true) {
                token = scan();
                if(inComments == true && token == null) { // returned from ignoring comments
                    inComments = false;
                    continue;
                } else if(token == null) { // returned from reading all the input
                    inComments = false;
                    break;
                }

                tokenList.add(token);
                inComments = false;
            }

            in.close();
        } catch(IOException e) {
            System.out.println(e.getMessage());
        }
        
        // Print out all tokens 
        for(Tokens tok: tokenList)
            System.out.println(tok.toString());
    }

    /* Read in one Token */
    public Tokens scan() throws Exception {
        StringBuilder lexeme = new StringBuilder();
        Tokens token;
       
        // Skip space

        while(getchar() != 1) { 
            if(!isSpace(look))  
                break;
            else if((char)look == '\n')
                lineNum++;
        }

        // Skip comments

        if((char)look == '/'){ 
            // read second character 
            getchar();

            if((char)look == '/') { // if the character was a '/', single line comment
                
                while((char)look != '\n' && look != -1 ) {
                    getchar();
                }
                
                if((char) look == '\n') lineNum++;
                inComments = true;
                return null;
            
            } else if((char)look == '*') { // Multi line comment possbily
                // keep track of prev char
                int prev = -1;
               // keep track of all prev chars 
                StringBuilder string = new StringBuilder();
                string.append((char)look);
                
                getchar();
                // ignore input 
                while(true) {

                    // if closing */  or -1 was found break
                    if(((char)prev == '*' && (char)look == '/') || look == -1) break;
    
                    string.append((char)look);
                    prev = look;
                    // keep track of line number 
                    if((char)look == '\n') lineNum++;
                    getchar();

                }
                // if prev = * and look = / then we found closing */ return null so we can parse an actual token
                if((char)prev == '*' && (char)look == '/'){
                    inComments = true;
                    return null;
                } else { // else put all characters back on to the input and reset look to '/'
                    for(int i = 0; i< string.length(); i++)
                        putBack.add(string.charAt(i));      // not we use add() because we want all chars to go in order they came in 
                    look = '/';
                }
            
            } else { // Not a comment, put back char and reset look
                putBack.addFirst((char)look); 
                look = '/';
            }


        }


        // is it a digit?

        if(Character.isDigit((char)look)) {
            // while it's a digit keep adding to the string 
            while(Character.isDigit((char)look)) {
                lexeme.append((char)look);
                if(getchar() == -1) break;
            }
                
            // There is a guarantee to have been at least one, so pushBack anything not a digit, create token, and return; 
                putBack.addFirst((char)look);
                token = new Tokens(lexeme.toString(), Tokens.NUM);
                return token;
        }

        //   Is it an Identifier?
        if(Character.isLetter((char)look) || (char)look == '_') {
           
            while(Character.isLetter((char)look) || Character.isDigit((char)look) || (char)look == '_') {
                lexeme.append((char)look);
                if(getchar() == -1) break;
            }
            
            // if lexeme is equal to System and look == '.', be greedy and look for out.println
            if(lexeme.toString().equals("System") && (char)look == '.') {

                boolean different = false;
                String toMatch = "System.out.println";
                int i, begin = toMatch.indexOf('.'), len = toMatch.length() ;
                // Try to match it 
                for (i = begin ; look != -1 && i < len; i++, getchar()) {
                    lexeme.append((char)look);
                    if(toMatch.charAt(i) != (char) look) {
                        different = true;
                        break;
                    }
                }

                // They were different 
                if(different == true){
                    // add back all input taken up until the m 
                    for(int x = 0; x < (i - begin) + 1 ; x++) {
                        putBack.add(lexeme.charAt(begin+x));  // not add is used to keep it all in the same order 
                    }

                    lexeme.delete(begin, i+1); // leave only "System"

                } else { 
                    // They were the same; only put back the last char 
                    putBack.addFirst((char)look);
                }

            } else {
                    // Well it's not System.out.println so put back last char 
                putBack.addFirst((char)look);
            } 

            token = new Tokens(lexeme.toString(), Tokens.ID);
            return token;

        }

        // Is it a symbol? 
    
        switch (look) {
            case '&':
                if((char)getchar() == '&') {
                    token = new Tokens("&&", Tokens.SYM);
                    return token;
                } else {
                    // error 
                    throw new Exception("Lexer.scan line:" + lineNum + " Lexical error: &");
                }
            case '|':
                if((char)getchar() == '|') {
                    token = new Tokens("||", Tokens.SYM);
                    return token;
                } else {
                    // error
                    throw new Exception("Lexer.scan line:" + lineNum + " Lexical error: |");
                }
            case '<':
                if((char)getchar() == '=') {
                    token = new Tokens("<=", Tokens.SYM);
                    return token;
                } else {
                    putBack.addFirst((char)look);
                    token = new Tokens("<", Tokens.SYM);
                    return token;
                }
            case '=':
                if((char)getchar() == '=') {
                    token = new Tokens("==", Tokens.SYM);
                    return token;
                } else {
                    putBack.addFirst((char)look);
                    token = new Tokens("=", Tokens.SYM);
                    return token;
                }
            case '>':
                if((char)getchar() == '=') {
                    token = new Tokens(">=", Tokens.SYM);
                    return token;
                } else {
                    putBack.addFirst((char)look);
                    token = new Tokens(">", Tokens.SYM);
                    return token;
                }
            case '!':
                if((char)getchar() == '=') {
                    token = new Tokens("!=", Tokens.SYM);
                    return token;
                } else {
                    putBack.addFirst((char)look);
                    token = new Tokens("!", Tokens.SYM);
                    return token;
                }
            default:
                if(symbols.containsKey( String.valueOf( (char)look ) ) ) {
                    token = new Tokens(String.valueOf((char)look), Tokens.SYM);
                    return token;
                } else {
                    // if look is -1 we ran out of input otherwise ERROR
                    if(look == -1) return null;
                    throw new Exception("Lexer.scan line: " + lineNum + " Lexical error: " + (char)look);

                }
        }


    }

    public LexerManual(BufferedReader in) {
        this.in = in;
        lineNum = 1;
        inComments = false;
        putBack = new LinkedList<Character>();
        tokenList = new ArrayList<Tokens>();
        fillKeyWords();
        fillSymbols();
    }

    public static void main(String[] args) throws Exception {

        if(args.length != 1) {
            System.out.println("Use: LexerManual <input file>");
            return;
        }

        BufferedReader input;

        try {
            input = new BufferedReader(new FileReader(args[0]));
        
            LexerManual lexer = new LexerManual(input);
            lexer.tokenize();
        } catch(FileNotFoundException error) {
            System.out.println("File " + args[0] + " not found.");
            return;
        }
    }


}
