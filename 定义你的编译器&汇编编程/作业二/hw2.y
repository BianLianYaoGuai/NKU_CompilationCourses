%{
/*********************************************
将所有的词法分析功能均放在 yylex 函数内实现，为 +、-、*、\、(、 ) 每个运算符及整数分别定义一个单词类别，在 yylex 内实现代码，能
识别这些单词，并将单词类别返回给词法分析程序。
实现功能更强的词法分析程序，可识别并忽略空格、制表符、回车等
空白符，能识别多位十进制整数。
YACC file
**********************************************/
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

//TODO:给每个符号定义一个单词类别
%token ADD MINUS
%token MUL DIV
%token LP RP
%token NUMBER
%left ADD MINUS
%left MUL DIV
%right UMINUS         

%%


lines   :       lines expr ';' { printf("%s\n", $2); }
        |       lines ';'
        |
        ;
//TODO:完善表达式的规则
expr    :       expr ADD expr   { sprintf($$, "%s%s+", $1, $3);}
        |       expr MINUS expr   { sprintf($$, "%s%s-", $1, $3);}
        |       expr MUL expr   { sprintf($$, "%s%s*", $1, $3);}
        |       expr DIV expr   { sprintf($$, "%s%s/", $1, $3);}
        |       LP expr RP   { sprintf($$, "%s", $2);}
        |       MINUS expr %prec UMINUS   { sprintf($$, "%s-", $2);}
        |       NUMBER  { sprintf($$, "%s", $1);}
        ;

%%

// programs section

int yylex()
{
    char t;
    while(1){
        t=getchar();
        if(t==' '||t=='\t'||t=='\n'){
            //do noting
        }else if(isdigit(t)){
            //TODO:解析多位数字返回数字类型 
            yylval=(char*)malloc(100 * sizeof(char));
            while(isdigit(t)){
                sprintf(yylval, "%s%c", yylval, t);
                t=getchar();
            }
            ungetc(t,stdin);
            return NUMBER;
        }else if(t=='+'){
            yylval=(char*)malloc(2 * sizeof(char));
            sprintf(yylval, "+");
            return ADD;
        }
        else if(t=='-'){
            yylval=(char*)malloc(2 * sizeof(char));
            sprintf(yylval, "-");
            return MINUS;
        }else if(t=='*'){
            yylval=(char*)malloc(2 * sizeof(char));
            sprintf(yylval, "*");
            return MUL;
        }else if(t=='/'){
            yylval=(char*)malloc(2 * sizeof(char));
            sprintf(yylval, "/");
            return DIV;
        }else if(t=='('){
            return LP;
        }else if(t==')'){
            return RP;
        }
        //TODO:识别其他符号
        else{
            return t;
        }
    }
}

int main(void)
{
    yyin=stdin;
    do{
        yyparse();
    }while(!feof(yyin));
    return 0;
}
void yyerror(const char* s){
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}