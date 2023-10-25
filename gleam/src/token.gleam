/// Supported token types
pub type Token {
    Illegal 
    Eof 
    Ident(id: String)
    Int(id: String)
    Assign 
    Plus 
    Comma 
    Semicolon 
    LParen
    RParen
    LBrace 
    RBrace
    Bang
    Lt
    Gt
    Minus
    Slash
    Asterisk
    Function 
    Let 
    True
    False
    If
    Else
    Return
    Equal
    NotEqual
} 

pub type Keyword = String
// pub type Keyword {
//     "let" 
//     "fn"
//     "true"
//     "false"
//     "if"
//     "else"
//     "return"
// }

/// Create a new token with a token_type and literal
// pub type Token {
//     Token(token_type: TokenType, literal: String)
// }
