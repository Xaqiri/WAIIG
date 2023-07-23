enum TokenType {
  ILLEGAL,
  EOF,
  IDENT,
  INT,
  ASSIGN,
  EQ,
  NOT_EQ,
  PLUS,
  MINUS,
  BANG,
  ASTERISK,
  SLASH,
  LT,
  GT,
  COMMA,
  SEMICOLON,
  LPAREN,
  RPAREN,
  LBRACE,
  RBRACE,
  FUNCTION,
  LET,
  TRUE,
  FALSE,
  IF,
  ELSE,
  RETURN,
}

var keywords = <String, TokenType>{
  "fn": TokenType.FUNCTION,
  "let": TokenType.LET,
  "true": TokenType.TRUE,
  "false": TokenType.FALSE,
  "if": TokenType.IF,
  "else": TokenType.ELSE,
  "return": TokenType.RETURN,
};

TokenType lookupIdent(String ident) {
  return keywords.containsKey(ident) ? keywords[ident]! : TokenType.IDENT;
}

class Token {
  TokenType type;
  String literal;
  Token({required this.type, required this.literal});

  @override
  String toString() {
    return '{$type \'$literal\'}';
  }
}
