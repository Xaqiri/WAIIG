#[derive(Debug, PartialEq)]
pub enum Token {
    Illegal(String),
    Eof(String),
    Ident(String),
    Int(String),
    Eq(String),
    NotEq(String),
    Assign(String),
    Bang(String),
    Plus(String),
    Minus(String),
    Asterisk(String),
    Slash(String),
    Comma(String),
    Semicolon(String),
    LT(String),
    GT(String),
    LParen(String),
    RParen(String),
    LBrace(String),
    RBrace(String),
    Function(String),
    Let(String),
    True(String),
    False(String),
    If(String),
    Else(String),
    Return(String),
}

impl Token {
    pub fn lookup_ident(s: &str) -> Token {
        match s {
            "fn" => Token::Function(s.to_string()),
            "let" => Token::Let(s.to_string()),
            "true" => Token::True(s.to_string()),
            "false" => Token::False(s.to_string()),
            "if" => Token::If(s.to_string()),
            "else" => Token::Else(s.to_string()),
            "return" => Token::Return(s.to_string()),
            _ => Token::Ident(s.to_string())
        }
    }
}
