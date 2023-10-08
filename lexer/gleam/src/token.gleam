/// Supported token types
pub type Token {
    ILLEGAL 
    EOF 
    IDENT(id: String)
    INT(id: String)
    ASSIGN 
    PLUS 
    COMMA 
    SEMICOLON 
    LPAREN
    RPAREN
    LBRACE 
    RBRACE
    FUNCTION 
    LET 
} 

/// Create a new token with a token_type and literal
// pub type Token {
//     Token(token_type: TokenType, literal: String)
// }
