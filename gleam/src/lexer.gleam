import gleam/string
import gleam/int
import gleam/list
import gleam/result
import token.{Token}

pub type Character {
  Letter
  Digit
  Illegal
}

pub fn lex(input: String) -> List(Token) {
  tokenize(input, [])
  |> list.reverse
}

pub fn tokenize(input: String, tokens: List(Token)) -> List(Token) {
  case input {
    "" -> [token.Eof, ..tokens]
    " " <> rest | "\n" <> rest | "\t" <> rest -> tokenize(rest, tokens)
    _ -> {
      let #(token, rest) = next_token(input)
      tokenize(rest, [token, ..tokens])
    }
  }
}

pub fn next_token(input: String) -> #(Token, String) {
  case input {
    "==" <> rest -> #(token.Equal, rest)
    "!=" <> rest -> #(token.NotEqual, rest)
    "=" <> rest -> #(token.Assign, rest)
    "!" <> rest -> #(token.Bang, rest)
    "-" <> rest -> #(token.Minus, rest)
    "+" <> rest -> #(token.Plus, rest)
    "," <> rest -> #(token.Comma, rest)
    ";" <> rest -> #(token.Semicolon, rest)
    "*" <> rest -> #(token.Asterisk, rest)
    "/" <> rest -> #(token.Slash, rest)
    "<" <> rest -> #(token.Lt, rest)
    ">" <> rest -> #(token.Gt, rest)
    "(" <> rest -> #(token.LParen, rest)
    ")" <> rest -> #(token.RParen, rest)
    "{" <> rest -> #(token.LBrace, rest)
    "}" <> rest -> #(token.RBrace, rest)
    _ -> {
      let split =
        string.pop_grapheme(input)
        |> result.unwrap(#("", ""))
      case get_character(split.0) {
        Letter -> create_ident(input)
        Digit -> create_number(input)
        Illegal -> #(token.Illegal, string.drop_left(input, 1))
      }
    }
  }
}

pub fn get_character(c: String) -> Character {
  case is_letter(c) {
    True -> Letter
    False -> {
      case is_digit(c) {
        True -> Digit
        False -> Illegal
      }
    }
  }
}

pub fn create_number(input: String) -> #(Token, String) {
  let n = get_string(input, "")
  let num =
    n.0
    |> string.reverse
  #(token.Int(num), n.1)
}

pub fn get_string(input: String, str: String) -> #(String, String) {
  let split =
    string.pop_grapheme(input)
    |> result.unwrap(#("", ""))
  let c = is_letter(split.0) || is_digit(split.0)
  case c {
    True -> get_string(split.1, split.0 <> str)
    False -> #(str, input)
  }
}

pub fn create_ident(input: String) -> #(Token, String) {
  let text = get_string(input, "")
  let ident =
    text.0
    |> string.reverse
  case ident {
    "let" -> #(token.Let, text.1)
    "fn" -> #(token.Function, text.1)
    "true" -> #(token.True, text.1)
    "false" -> #(token.False, text.1)
    "if" -> #(token.If, text.1)
    "else" -> #(token.Else, text.1)
    "return" -> #(token.Return, text.1)
    _ -> #(token.Ident(ident), text.1)
  }
}

pub fn is_letter(input: String) -> Bool {
  let a = case string.to_utf_codepoints("a") {
    [x] -> string.utf_codepoint_to_int(x)
  }
  let z = case string.to_utf_codepoints("z") {
    [x] -> string.utf_codepoint_to_int(x)
  }
  let cap_a = case string.to_utf_codepoints("A") {
    [x] -> string.utf_codepoint_to_int(x)
  }
  let cap_z = case string.to_utf_codepoints("Z") {
    [x] -> string.utf_codepoint_to_int(x)
  }
  let underscore = case string.to_utf_codepoints("_") {
    [x] -> string.utf_codepoint_to_int(x)
  }
  let char = case string.to_utf_codepoints(input) {
    [] -> 0
    [x] -> string.utf_codepoint_to_int(x)
  }
  { char >= a && char <= z } || { char >= cap_a && char <= cap_z } || char == underscore
}

pub fn is_digit(input: String) -> Bool {
  case int.parse(input) {
    Ok(_) -> True
    Error(_) -> False
  }
}
