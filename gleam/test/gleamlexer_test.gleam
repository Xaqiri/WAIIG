import gleeunit
import gleeunit/should
import token
import lexer

pub fn main() {
  gleeunit.main()
}

pub fn empty_input_test() {
    let text = ""
    let tests = [
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn single_token_test() {
    let text = "=+(){},;"
    let tests = [
        token.Assign, 
        token.Plus, 
        token.LParen, 
        token.RParen, 
        token.LBrace, 
        token.RBrace, 
        token.Comma, 
        token.Semicolon, 
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn whitespace_test() {
    let text = " "
    let tests = [
       token.Eof 
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn single_token_with_whitespace_test() {
    let text = " =+  () {},;    "
    let tests = [
        token.Assign, 
        token.Plus, 
        token.LParen, 
        token.RParen, 
        token.LBrace, 
        token.RBrace, 
        token.Comma, 
        token.Semicolon, 
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn keyword_test() {
    let text = "let fn"
    let tests = [
        token.Let,
        token.Function,
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn ident_test() {
    let text = "let fn _zero x y;"
    let tests = [
        token.Let,
        token.Function,
        token.Ident("_zero"),
        token.Ident("x"),
        token.Ident("y"),
        token.Semicolon,
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn number_test() {
    let text = "0 1 12 123"
    let tests = [
        token.Int("0"),
        token.Int("1"),
        token.Int("12"),
        token.Int("123"),
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn function_test() {
    let text = 
    "let add = fn(x, y) {
      x + y;
    };"

    let tests = [
        token.Let, 
        token.Ident("add"),
        token.Assign,
        token.Function,
        token.LParen,
        token.Ident("x"),
        token.Comma,
        token.Ident("y"),
        token.RParen,
        token.LBrace,
        token.Ident("x"),
        token.Plus,
        token.Ident("y"),
        token.Semicolon,
        token.RBrace,
        token.Semicolon,

        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
} 

pub fn longer_source_test() {
    let text = 
    "let five = 5;
    let ten = 10;

    let add = fn(x, y) {
      x + y;
    };

    let result = add(five, ten);
    !-/*5;
    5 < 10 > 5;"

    let tests = [
        token.Let, 
        token.Ident("five"),
        token.Assign,
        token.Int("5"),
        token.Semicolon,

        token.Let, 
        token.Ident("ten"),
        token.Assign,
        token.Int("10"),
        token.Semicolon,

        token.Let, 
        token.Ident("add"),
        token.Assign,
        token.Function,
        token.LParen,
        token.Ident("x"),
        token.Comma,
        token.Ident("y"),
        token.RParen,
        token.LBrace,
        token.Ident("x"),
        token.Plus,
        token.Ident("y"),
        token.Semicolon,
        token.RBrace,
        token.Semicolon,

        token.Let, 
        token.Ident("result"),
        token.Assign,
        token.Ident("add"),
        token.LParen,
        token.Ident("five"),
        token.Comma,
        token.Ident("ten"),
        token.RParen,
        token.Semicolon,

        token.Bang, 
        token.Minus, 
        token.Slash, 
        token.Asterisk, 
        token.Int("5"),
        token.Semicolon,

        token.Int("5"),
        token.Lt,
        token.Int("10"),
        token.Gt,
        token.Int("5"),
        token.Semicolon,


        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn conditional_test() {
    let text = "
    if (5 < 10) {
        return true;
    } else {
        return false;
    }
    "
    let tests = [
        token.If,
        token.LParen,
        token.Int("5"),
        token.Lt,
        token.Int("10"),
        token.RParen,
        token.LBrace,

        token.Return,
        token.True,
        token.Semicolon,

        token.RBrace,
        token.Else,
        token.LBrace,

        token.Return,
        token.False,
        token.Semicolon,

        token.RBrace,
        token.Eof
    ]

    lexer.lex(text)
    |> should.equal(tests)
}

pub fn multicharacter_token_test() {
    let text = "== !="
    let tests = [
        token.Equal,
        token.NotEqual,
        token.Eof
    ]
    lexer.lex(text)
    |> should.equal(tests)
}
