    /* cs152-miniL phase2 */
%{
void yyerror(const char *msg);
%}



%union{
  /* put your types here */
}

%define parse.error verbose
%locations

/* %start program */
%left FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY COLON INTEGER ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF ASSIGN IF THEN ENDIF ELSE WHILE BEGINLOOP ENDLOOP DO READ WRITE CONTINUE BREAK RETURN NOT EQ NEQ LT GT LTE GTE ADD L_PAREN R_PAREN COMMA SUB MULT DIV MOD

%start program

%% 

  /* write your rules here */
  program: | Functions 

  Functions : |Function 
              | Function Functions

  Function: FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY

  Declarations: | Declaration SEMICOLON Declarations

  Statements: Statement
              | Statement SEMICOLON Statements
            
  Declaration: IDENTIFIER COLON INTEGER
              | IDENTIFIER COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF
  
  Statement: variable ASSIGN Expression
             | IF Bool_Exp THEN Statements ENDIF
             | IF Bool_Exp THEN Statements ELSE Statements ENDIF
             | WHILE Bool_Exp BEGINLOOP Statements ENDLOOP
             | DO BEGINLOOP Statements ENDLOOP WHILE Bool_Exp
             | READ variable
             | WRITE variable
             | CONTINUE
             | BREAK
             | RETURN Expression
  
  Bool_Exp: Nots Expression Comp Expression

  Nots: | NOT Nots

  Comp: EQ
        | NEQ
        | LT
        | GT
        | LTE
        | GTE
  
  Expression: Mult_Expr
              | Mult_Expr ADD Mult_Expr
              | Mult_Expr SUB Mult_Expr
  
  Mult_Expr: Term
             | Term MULT Term
             | Term DIV Term
             | Term MOD Term

  Term: variable
        | NUMBER
        | L_PAREN Expression R_PAREN
        | IDENTIFIER L_PAREN Expression R_PAREN

  Expressions: Expression | Expression COMMA Expressions

  variable: IDENTIFIER
            | IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET
%% 

/*int main(int argc, char **argv) {
   yyparse();
   return 0;
}*/

void yyerror(const char *msg) {
    /* implement your error handling */
}