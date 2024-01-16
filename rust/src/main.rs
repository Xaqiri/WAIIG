use rust::repl;

fn main() {
    repl::run();
}

#[cfg(test)]
use rust::lexer::Lexer;
use rust::token::Token;

#[test]
fn test_two_char_tokens() {
    let input = "== !=".to_string();
    let tests = vec![
        Token::Eq("==".to_string()),
        Token::NotEq("!=".to_string()),
        Token::Eof("".to_string())
    ];
    let mut l = Lexer::new(input);
    for i in tests {
        let tok = l.next_token();
        assert_eq!(i, tok);
    }
}

#[test]
fn test_keywords() {
    let input = "fn if else return true false".to_string();
    let tests = vec![
        Token::Function(("fn").to_string()),
        Token::If(("if").to_string()),
        Token::Else(("else").to_string()),
        Token::Return(("return").to_string()),
        Token::True(("true").to_string()),
        Token::False(("false").to_string()),
        Token::Eof(("").to_string())
    ];
    let mut l = Lexer::new(input);
    for i in tests {
        let tok = l.next_token();
        assert_eq!(i, tok);
    }
}

#[test]
fn test_let_statement() {
    let input = "let five = 5;
let ten = 10;

let add = fn(x, y) {
  x + y;
};

let result = add(five, ten);"
        .to_string();
    let tests = vec![
        Token::Let(("let").to_string()),
        Token::Ident(("five").to_string()),
        Token::Assign(("=").to_string()),
        Token::Int(("5").to_string()),
        Token::Semicolon((";").to_string()),
        Token::Let(("let").to_string()),
        Token::Ident(("ten").to_string()),
        Token::Assign(("=").to_string()),
        Token::Int(("10").to_string()),
        Token::Semicolon((";").to_string()),
        Token::Let(("let").to_string()),
        Token::Ident(("add").to_string()),
        Token::Assign(("=").to_string()),
        Token::Function(("fn").to_string()),
        Token::LParen(("(").to_string()),
        Token::Ident(("x").to_string()),
        Token::Comma((",").to_string()),
        Token::Ident(("y").to_string()),
        Token::RParen((")").to_string()),
        Token::LBrace(("{").to_string()),
        Token::Ident(("x").to_string()),
        Token::Plus(("+").to_string()),
        Token::Ident(("y").to_string()),
        Token::Semicolon((";").to_string()),
        Token::RBrace(("}").to_string()),
        Token::Semicolon((";").to_string()),
        Token::Let(("let").to_string()),
        Token::Ident(("result").to_string()),
        Token::Assign(("=").to_string()),
        Token::Ident(("add").to_string()),
        Token::LParen(("(").to_string()),
        Token::Ident(("five").to_string()),
        Token::Comma((",").to_string()),
        Token::Ident(("ten").to_string()),
        Token::RParen((")").to_string()),
        Token::Semicolon((";").to_string()),
        Token::Eof(("").to_string()),
    ];
    let mut l = Lexer::new(input);
    for i in tests {
        let tok = l.next_token();
        assert_eq!(i, tok);
    }
}

#[test]
fn test_next_token() {
    let input = "=+(){},;-*/<>!".to_string();
    let tests = vec![
        Token::Assign("=".to_string()),
        Token::Plus("+".to_string()),
        Token::LParen(("(").to_string()),
        Token::RParen((")").to_string()),
        Token::LBrace(("{").to_string()),
        Token::RBrace(("}").to_string()),
        Token::Comma((",").to_string()),
        Token::Semicolon((";").to_string()),
        Token::Minus(("-").to_string()),
        Token::Asterisk(("*").to_string()),
        Token::Slash(("/").to_string()),
        Token::LT(("<").to_string()),
        Token::GT((">").to_string()),
        Token::Bang(("!").to_string()),
        Token::Eof(("").to_string()),
    ];
    let mut l = Lexer::new(input);
    for i in tests {
        let tok = l.next_token();
        assert_eq!(i, tok);
    }
}
