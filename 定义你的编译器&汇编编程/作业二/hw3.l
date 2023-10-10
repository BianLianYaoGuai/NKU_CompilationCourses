%{
#include "y.tab.h"
#include "hw3.h"
#include <math.h>
#undef yywrap

struct ident * identlook(char *s){
        char *p;
        struct ident *sp;
        for(int i=0;i<IDENTS;i++){
                sp=ident;
                if(sp->name && !strcmp(sp->name,s))
                        return sp;
                if(!sp->name){
                        sp->name=strdup(s);
                        return sp;
                }
                sp++;
        }
}
%}


%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)     {
                yylval.digitValue = atof(yytext);
                return NUMBER;
        }
[ \t] ;
[A-Za-z][A-Za-z0-9]*    {
                yylval.identPoint=identlook(yytext);
                return NAME;
        }
"$"     { return 0; }
\n      |
.       return yytext[0];
%%

int yywrap()
{
        return 1;
}


