import 'package:dart/token.dart';

class Lexer {
  String input;
  int position = 0;
  int readPosition = 0;
  String ch = '';
  Lexer({
    required this.input,
  }) {
    readChar();
  }

  @override
  String toString() {
    return "($position, $readPosition, $ch)";
  }

  void readChar() {
    readPosition >= input.length ? ch = '' : ch = input[readPosition];
    position = readPosition;
    readPosition += 1;
  }

  String peekChar() {
    return readPosition >= input.length ? '' : input[readPosition];
  }

  bool isLetter(String ch) {
    return 'a'.codeUnitAt(0) <= ch.codeUnitAt(0) &&
            ch.codeUnitAt(0) <= 'z'.codeUnitAt(0) ||
        'A'.codeUnitAt(0) <= ch.codeUnitAt(0) &&
            ch.codeUnitAt(0) <= 'Z'.codeUnitAt(0) ||
        ch == '_';
  }

  bool isDigit(String ch) {
    return switch (int.tryParse(ch)) {
      null => false,
      _ => true,
    };
  }

  String readIdentifier() {
    var pos = position;
    while (isLetter(ch)) {
      readChar();
    }
    return input.substring(pos, position);
  }

  String readNumber() {
    var pos = position;
    while (isDigit(ch)) {
      readChar();
    }
    return input.substring(pos, position);
  }

  void skipWhiteSpace() {
    while (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r') {
      readChar();
    }
  }

  Token checkIdentOrKeyword() {
    var literal = readIdentifier();
    var type = lookupIdent(literal);
    return Token(
      literal: literal,
      type: type,
    );
  }

  Token getNumber() {
    var literal = readNumber();
    var type = TokenType.INT;
    return Token(literal: literal, type: type);
  }

  Token getString() {
    var pos = position;
    readChar();
    while (ch != '\'') {
      readChar();
    }
    readChar();
    var literal = input.substring(pos, position);
    return Token(type: TokenType.STRING, literal: literal);
  }

  Token createToken(TokenType type, String literal) {
    var tok = Token(type: type, literal: literal);
    readChar();
    return tok;
  }

  Token createTwoCharToken() {
    var char = ch;
    readChar();
    var literal = char + ch;
    return switch (char) {
      '=' => createToken(TokenType.EQ, literal),
      '!' => createToken(TokenType.NOT_EQ, literal),
      _ => createToken(TokenType.ILLEGAL, literal),
    };
  }

  Token nextToken() {
    skipWhiteSpace();
    return switch (ch) {
      '=' => peekChar() == '='
          ? createTwoCharToken()
          : createToken(TokenType.ASSIGN, '='),
      '+' => createToken(TokenType.PLUS, '+'),
      '-' => createToken(TokenType.MINUS, '-'),
      '!' => peekChar() == '='
          ? createTwoCharToken()
          : createToken(TokenType.BANG, '!'),
      '/' => createToken(TokenType.SLASH, '/'),
      '*' => createToken(TokenType.ASTERISK, '*'),
      '<' => createToken(TokenType.LT, '<'),
      '>' => createToken(TokenType.GT, '>'),
      '(' => createToken(TokenType.LPAREN, '('),
      ')' => createToken(TokenType.RPAREN, ')'),
      '{' => createToken(TokenType.LBRACE, '{'),
      '}' => createToken(TokenType.RBRACE, '}'),
      ',' => createToken(TokenType.COMMA, ','),
      ';' => createToken(TokenType.SEMICOLON, ';'),
      '\'' =>
        !(isLetter(peekChar()) || isDigit(peekChar())) && peekChar() != '\''
            ? createToken(TokenType.SQUOTE, '\'')
            : getString(),
      '' => createToken(TokenType.EOF, ''),
      _ => isLetter(ch)
          ? checkIdentOrKeyword()
          : isDigit(ch)
              ? getNumber()
              : createToken(TokenType.ILLEGAL, ch),
    };
  }
}
