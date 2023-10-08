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
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn single_token_test() {
    let text = "=+(){},;"
    let tests = [
        token.ASSIGN, 
        token.PLUS, 
        token.LPAREN, 
        token.RPAREN, 
        token.LBRACE, 
        token.RBRACE, 
        token.COMMA, 
        token.SEMICOLON, 
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn whitespace_test() {
    let text = " "
    let tests = [
       token.EOF 
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn single_token_with_whitespace_test() {
    let text = " =+  () {},;    "
    let tests = [
        token.ASSIGN, 
        token.PLUS, 
        token.LPAREN, 
        token.RPAREN, 
        token.LBRACE, 
        token.RBRACE, 
        token.COMMA, 
        token.SEMICOLON, 
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn keyword_test() {
    let text = "let fn"
    let tests = [
        token.LET,
        token.FUNCTION,
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn ident_test() {
    let text = "let fn x y"
    let tests = [
        token.LET,
        token.FUNCTION,
        token.IDENT("x"),
        token.IDENT("y"),
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}

pub fn number_test() {
    let text = "1 12 123"
    let tests = [
        token.INT("1"),
        token.INT("12"),
        token.INT("123"),
        token.EOF
    ]
    lexer.lex(text)
    |> should.equal(tests)
}
