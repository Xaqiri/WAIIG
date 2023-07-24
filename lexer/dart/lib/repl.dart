import 'dart:io';

import 'package:dart/lexer.dart';
import 'package:dart/token.dart';

final PROMPT = '>> ';

void start() {
  while (true) {
    stdout.write(PROMPT);
    var line = stdin.readLineSync()!.trim();
    if (line == 'exit') return;
    var lexer = Lexer(input: line);
    var tok = lexer.nextToken();
    for (tok; tok.type != TokenType.EOF; tok = lexer.nextToken()) {
      stdout.writeln(tok);
    }
  }
}
