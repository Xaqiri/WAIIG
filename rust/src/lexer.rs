use crate::token::Token;

pub struct Lexer {
    input: String,
    pos: usize,
    read_pos: usize,
    ch: char,
}

impl Lexer {
    pub fn new(input: String) -> Self {
        let mut l = Lexer {
            input,
            pos: 0,
            read_pos: 0,
            ch: ' ',
        };
        l.read_char();
        l
    }

    pub fn next_token(&mut self) -> Token {
        self.skip_whitespace();
        let t = match self.ch {
            '=' | '!' => return self.read_two_char_token(),
            '+' => Token::Plus(self.ch.to_string()),
            '-' => Token::Minus(self.ch.to_string()),
            '*' => Token::Asterisk(self.ch.to_string()),
            '/' => Token::Slash(self.ch.to_string()),
            '<' => Token::LT(self.ch.to_string()),
            '>' => Token::GT(self.ch.to_string()),
            '(' => Token::LParen(self.ch.to_string()),
            ')' => Token::RParen(self.ch.to_string()),
            '{' => Token::LBrace(self.ch.to_string()),
            '}' => Token::RBrace(self.ch.to_string()),
            ',' => Token::Comma(self.ch.to_string()),
            ';' => Token::Semicolon(self.ch.to_string()),
            '\0' => Token::Eof("".to_string()),
            _ => match (self.ch.is_alphabetic(), self.ch.is_numeric()) {
                (true, false) => return self.read_identifier(),
                (false, true) => return self.read_number(),
                _ => Token::Illegal(self.ch.to_string()),
            },
        };
        self.read_char();

        return t;
    }

    fn read_two_char_token(&mut self) -> Token {
        let c = self.peek_char();
        let t = match (self.ch, c) {
            ('=', '=') => {self.read_char(); Token::Eq("==".to_string())},
            ('!', '=') => {self.read_char(); Token::NotEq("!=".to_string())},
            ('=', _) => Token::Assign(self.ch.to_string()),
            ('!', _) => Token::Bang(self.ch.to_string()),
            _ => Token::Illegal(c.to_string())
        };
        self.read_char();
        return t
    }

    fn read_identifier(&mut self) -> Token {
        let pos = self.pos;
        while self.ch.is_alphabetic() {
            self.read_char();
        }
        let s = self.input[pos..self.pos].to_string();
        Token::lookup_ident(&s)
    }

    fn read_number(&mut self) -> Token {
        let pos = self.pos;
        while self.ch.is_numeric() {
            self.read_char();
        }
        let s = self.input[pos..self.pos].to_string();
        Token::Int(s)
    }

    fn read_char(&mut self) {
        if self.read_pos >= self.input.len() {
            self.ch = '\0';
        } else {
            self.ch = self.input.as_bytes()[self.read_pos] as char;
        }
        self.pos = self.read_pos;
        self.read_pos += 1;
    }

    fn peek_char(&mut self) -> char {
        if self.read_pos >= self.input.len() {
            return '\0';
        } else {
            return self.input.as_bytes()[self.read_pos] as char;
        }
    }

    fn skip_whitespace(&mut self) {
        while self.ch.is_whitespace() {
            self.read_char();
        }
    }
}
