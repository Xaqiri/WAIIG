use std::io;

use crate::{lexer::Lexer, token::Token};

pub fn run() {
    let mut inp = "".to_string();
    // let mut i = inp.trim().to_string();
    while inp.trim().to_string() != "exit".to_string() {
        inp = "".to_string();
        io::stdin().read_line(&mut inp).unwrap();
        let i = inp.trim().to_string();
        let mut l = Lexer::new(i);
        let mut tok = l.next_token();
        while tok != Token::Eof("".to_string()) {
            println!("{:?}", tok);
            tok = l.next_token();
        }
    }
}
