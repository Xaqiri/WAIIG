import 'package:dart/token.dart';

class Lexer {
  String input;
  int position = 0;
  int readPosition = 0;
  String ch = '';
  Lexer({required this.input}) {
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
    return Token(type: type, literal: literal);
  }

  Token getNumber() {
    var type = TokenType.INT;
    var literal = readNumber();
    return Token(type: type, literal: literal);
  }

  Token getString() {
    var pos = position;
    // Skip the first '
    readChar();
    // Read the entire string within ''
    while (ch != '\'' && ch != '"') {
      readChar();
    }
    // Skip the last '
    readChar();
    var literal = input.substring(pos, position);
    return Token(type: TokenType.STRING, literal: literal);
  }

  Token createToken(TokenType type, {String literal = ''}) {
    readChar();
    return Token(type: type, literal: literal == '' ? type.id : literal);
  }

  Token handleTwoCharToken() {
    var literal = ch;
    if (peekChar() == '=') {
      readChar();
      literal += ch;
    }
    return switch (literal) {
      '==' => createToken(TokenType.EQ),
      '!=' => createToken(TokenType.NOT_EQ),
      '+=' => createToken(TokenType.PLUS_EQ),
      '-=' => createToken(TokenType.MINUS_EQ),
      '=' => createToken(TokenType.ASSIGN),
      '+' => createToken(TokenType.PLUS),
      '-' => createToken(TokenType.MINUS),
      '!' => createToken(TokenType.BANG),
      '/' => createToken(TokenType.SLASH),
      '*' => createToken(TokenType.ASTERISK),
      '<' => createToken(TokenType.LT),
      '>' => createToken(TokenType.GT),
      _ => createToken(TokenType.ILLEGAL, literal: ch),
    };
  }

  Token handleString(String ch) {
    return !(isLetter(peekChar()) || isDigit(peekChar())) &&
            (peekChar() != '\'' && peekChar() != '"')
        ? (ch == '\''
            ? createToken(TokenType.SQUOTE)
            : createToken(TokenType.DQUOTE))
        : getString();
  }

  Token nextToken() {
    skipWhiteSpace();
    return switch (ch) {
      '=' ||
      '!' ||
      '+' ||
      '-' ||
      '/' ||
      '*' ||
      '<' ||
      '>' =>
        handleTwoCharToken(),
      '\'' || '"' => handleString(ch),
      '(' => createToken(TokenType.LPAREN),
      ')' => createToken(TokenType.RPAREN),
      '{' => createToken(TokenType.LBRACE),
      '}' => createToken(TokenType.RBRACE),
      ',' => createToken(TokenType.COMMA),
      ';' => createToken(TokenType.SEMICOLON),
      '' => createToken(TokenType.EOF),
      _ => isLetter(ch)
          ? checkIdentOrKeyword()
          : isDigit(ch)
              ? getNumber()
              : createToken(TokenType.ILLEGAL, literal: ch),
    };
  }
}
