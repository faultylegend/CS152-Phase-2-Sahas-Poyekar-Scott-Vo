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
%start program

%% 

  /* write your rules here */
  program:  {printf("bruh\n");};


%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}