import gleam/string 
import gleam/int
import gleam/list 
import gleam/result
import gleam/order

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
        "" -> [token.EOF, ..tokens]
        " " <> rest -> tokenize(rest, tokens)
        _ -> {
            let #(token, rest) = next_token(input)
            tokenize(rest, [token, ..tokens])
        }
    }
}

pub fn next_token(input: String) -> #(Token, String) {
    case input {
        "=" <> rest -> #(token.ASSIGN, rest)
        "+" <> rest -> #(token.PLUS, rest)
        "," <> rest -> #(token.COMMA, rest)
        ";" <> rest -> #(token.SEMICOLON, rest)
        "(" <> rest -> #(token.LPAREN, rest)
        ")" <> rest -> #(token.RPAREN, rest)
        "{" <> rest -> #(token.LBRACE, rest)
        "}" <> rest -> #(token.RBRACE, rest)
        _ -> {
            let split = string.pop_grapheme(input) |> result.unwrap(#("", ""))
            case get_character(split.0) {
                Letter -> create_ident(input)
                Digit -> create_number(input)
                Illegal -> #(token.ILLEGAL, string.drop_left(input, 1))
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
    let num = n.0 |> string.reverse
    #(token.INT(num), n.1)
}

pub fn get_string(input: String, str: String) -> #(String, String) {
    let split = string.pop_grapheme(input) |> result.unwrap(#("", ""))
    case split.0 {
        "" | " " -> #(str, split.1)
        _ -> get_string(split.1, split.0 <> str)
    }
}

pub fn create_ident(input: String) -> #(Token, String) {
    let text = get_string(input, "")
    let ident = text.0 |> string.reverse
    case ident {
        "let" -> #(token.LET, text.1)
        "fn" -> #(token.FUNCTION, text.1)
        _ -> #(token.IDENT(ident), text.1)
    }
}

pub fn is_letter(input: String) -> Bool {
    case string.compare(input, "a"), string.compare(input, "z"), string.compare(input, "A"), string.compare(input, "Z") {
        order.Gt, order.Lt, _, _ -> True
        _, _, order.Gt, order.Lt -> True 
        _, _, _, _ -> False
    }
}

pub fn is_digit(input: String) -> Bool {
    case int.parse(input) {
        Ok(_) -> True
        Error(_) -> False
    }
}

