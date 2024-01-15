enum Token {
    Illegal(String),
    Eof(String),
    Ident(String),
    Int(String),
    Assign(String),
    Plus(String),
    Comma(String),
    Semicolon(String),
    LParen(String),
    RParen(String),
    LBrace(String),
    RBrace(String),
    Function(String),
    Let(String)
}

fn main() {
    println!("Hello, world!");
}

#[test]
fn test_add() {
    let x = 2 + 2;
    assert_eq!(x, 4);
}
