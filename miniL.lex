   /* cs152-miniL phase1 - adding text to create new commit message*/
   
%{   
   /* write your C code here for definitions of variables and including headers */
   int line = 1;
   int col = 1;
%}

   /* some common rules */
DIGIT    [0-9]
CHAR [a-z|A-Z]
UNDER [_]
IDENTIFIER {CHAR}({CHAR}|{DIGIT}|{UNDER})*
COMMENT {.}*

%%
   /* specific lexer rules in regex */
"function"	   printf("FUNCTION\n"); col += yyleng;
"beginparams"	printf("BEGIN_PARAMS\n"); col += yyleng;
"endparams"	   printf("END_PARAMS\n"); col += yyleng;
"beginlocals"	printf("BEGIN_LOCALS\n"); col += yyleng;
"endlocals"	   printf("END_LOCALS\n"); col += yyleng;
"beginbody"	   printf("BEGIN_BODY\n"); col += yyleng;
"endbody"	   printf("END_BODY\n"); col += yyleng;
"integer"	   printf("INTEGER\n"); col += yyleng;
"array"	      printf("ARRAY\n"); col += yyleng;
"of"	         printf("OF\n"); col += yyleng;
"if"	         printf("IF\n"); col += yyleng;
"then"	      printf("THEN\n"); col += yyleng;
"endif"	      printf("ENDIF\n"); col += yyleng;
"else"	      printf("ELSE\n"); col += yyleng;
"while"        printf("WHILE\n"); col += yyleng;
"do"	         printf("DO\n"); col += yyleng;
"beginloop"	   printf("BEGINLOOP\n"); col += yyleng;
"endloop"	   printf("ENDLOOP\n"); col += yyleng;
"continue"	   printf("CONTINUE\n"); col += yyleng;
"break"	      printf("BREAK\n"); col += yyleng;
"read"	      printf("READ\n"); col += yyleng;
"write"	      printf("WRITE\n"); col += yyleng;
"not"	         printf("NOT\n"); col += yyleng;
"true"	      printf("TRUE\n"); col += yyleng;
"false"	      printf("FALSE\n"); col += yyleng;
"return"	      printf("RETURN\n"); col += yyleng;


"-"	printf("SUB\n"); col += yyleng;
"+"	printf("ADD\n"); col += yyleng;
"*"	printf("MULT\n"); col += yyleng;
"/"	printf("DIV\n"); col += yyleng;
"%"	printf("MOD\n"); col += yyleng;
"##".*  ;


"=="	printf("EQ\n"); col += yyleng;
"<>"	printf("NEQ\n"); col += yyleng;
"<"	printf("LT\n"); col += yyleng;
">"	printf("GT\n"); col += yyleng;
"<="	printf("LTE\n"); col += yyleng;
">="	printf("GTE\n"); col += yyleng;


";"	printf("SEMICOLON\n"); col += yyleng;
":"	printf("COLON\n"); col += yyleng;
","	printf("COMMA\n"); col += yyleng;
"("	printf("L_PAREN\n"); col += yyleng;
")"	printf("R_PAREN\n"); col += yyleng;
"["	printf("L_SQUARE_BRACKET\n"); col += yyleng;
"]"	printf("R_SQUARE_BRACKET\n"); col += yyleng;
":="	printf("ASSIGN\n"); col += yyleng;

({DIGIT}|{UNDER}){IDENTIFIER} {
                                 printf("\nERROR at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, col, yytext);
                                 exit(1);
                              }

{IDENTIFIER}{UNDER} {
                        printf("\nERROR at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line, col, yytext);
                        exit(1);
                     }

{DIGIT}+{IDENTIFIER} {
                        printf("\nERROR at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, col, yytext);
                        exit(1);
                     }

{IDENTIFIER} printf("IDENT %s\n", yytext); col += yyleng;
{DIGIT}+    printf("NUMBER %s\n", yytext); col += yyleng;


" "   col++;
\t    col += 4;
\n    line++; col = 1; 

[^ ^\n^\t]     {
               printf("\nERROR at line %d, column %d: unrecognized symbol \"%s\"\n", line, col, yytext);
               exit(1);
            }

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{

   yylex();
}
