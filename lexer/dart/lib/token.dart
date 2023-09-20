// ignore_for_file: constant_identifier_names

enum TokenType {
  ILLEGAL(id: ''),
  EOF(id: ''),
  IDENT(id: ''),
  INT(id: ''),
  STRING(id: ''),
  ASSIGN(id: '='),
  EQ(id: '=='),
  NOT_EQ(id: '!='),
  PLUS_EQ(id: '+='),
  MINUS_EQ(id: '-='),
  PLUS(id: '+'),
  MINUS(id: '-'),
  BANG(id: '!'),
  ASTERISK(id: '*'),
  SLASH(id: '/'),
  LT(id: '<'),
  GT(id: '>'),
  COMMA(id: ','),
  SEMICOLON(id: ';'),
  SQUOTE(id: '\''),
  LPAREN(id: '('),
  RPAREN(id: ')'),
  LBRACE(id: '{'),
  RBRACE(id: '}'),
  FUNCTION(id: 'fn'),
  LET(id: 'let'),
  TRUE(id: 'true'),
  FALSE(id: 'false'),
  IF(id: 'if'),
  ELSE(id: 'else'),
  RETURN(id: 'return');

  final String id;

  const TokenType({required this.id});
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
