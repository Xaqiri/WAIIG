import 'package:dart/lexer.dart';
import 'package:dart/token.dart';
import 'package:test/test.dart';

void main() {
  test('lexer', () {
    var text = '''
      let five = 5;
      let ten = 10;

      let add = fn(x, y) {
          x + y;
      };
      let result = add(five, ten);
      !-/*5;
      5 < 10 > 5;

      if else return true false
      == != += -=
      'hello' ''
      "hello" ""
  ''';

    var lexer = Lexer(input: text);
    var tests = {
      {TokenType.LET, "let"},
      {TokenType.IDENT, "five"},
      {TokenType.ASSIGN, "="},
      {TokenType.INT, "5"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.LET, "let"},
      {TokenType.IDENT, "ten"},
      {TokenType.ASSIGN, "="},
      {TokenType.INT, "10"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.LET, "let"},
      {TokenType.IDENT, "add"},
      {TokenType.ASSIGN, "="},
      {TokenType.FUNCTION, "fn"},
      {TokenType.LPAREN, "("},
      {TokenType.IDENT, "x"},
      {TokenType.COMMA, ","},
      {TokenType.IDENT, "y"},
      {TokenType.RPAREN, ")"},
      {TokenType.LBRACE, "{"},
      {TokenType.IDENT, "x"},
      {TokenType.PLUS, "+"},
      {TokenType.IDENT, "y"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.RBRACE, "}"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.LET, "let"},
      {TokenType.IDENT, "result"},
      {TokenType.ASSIGN, "="},
      {TokenType.IDENT, "add"},
      {TokenType.LPAREN, "("},
      {TokenType.IDENT, "five"},
      {TokenType.COMMA, ","},
      {TokenType.IDENT, "ten"},
      {TokenType.RPAREN, ")"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.BANG, "!"},
      {TokenType.MINUS, "-"},
      {TokenType.SLASH, "/"},
      {TokenType.ASTERISK, "*"},
      {TokenType.INT, "5"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.INT, "5"},
      {TokenType.LT, "<"},
      {TokenType.INT, "10"},
      {TokenType.GT, ">"},
      {TokenType.INT, "5"},
      {TokenType.SEMICOLON, ";"},
      {TokenType.IF, 'if'},
      {TokenType.ELSE, 'else'},
      {TokenType.RETURN, 'return'},
      {TokenType.TRUE, 'true'},
      {TokenType.FALSE, 'false'},
      {TokenType.EQ, '=='},
      {TokenType.NOT_EQ, '!='},
      {TokenType.PLUS_EQ, '+='},
      {TokenType.MINUS_EQ, '-='},
      {TokenType.STRING, '\'hello\''},
      {TokenType.STRING, '\'\''},
      {TokenType.STRING, '"hello"'},
      {TokenType.STRING, '""'},
      {TokenType.EOF, ''},
    };

    for (var test in tests) {
      var tok = lexer.nextToken();
      expect({tok.type, tok.literal}, test);
    }
  });
}
