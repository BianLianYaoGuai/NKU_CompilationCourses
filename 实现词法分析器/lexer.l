%{
// 定义段
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 定义结构体
typedef struct {
    char name[50];
    unsigned int id;
} ident;

// 定义数组结构体
typedef struct {
    ident* data;  // 指向结构体数组的指针
    size_t size;  // 数组的当前大小
    size_t capacity;  // 数组的容量
} identArray;

identArray arr;
int count = 0;
%}


Ident         [a-zA-Z_]([a-zA-Z_]|[0-9])*
DecConst      [1-9]([0-9])*
OctConst      0([0-7]*)
HexConst      0x([0-9a_f]*)|0X([0-9a_f]*)
CONST         const
INT           int
IF            if
ELSE          else
WHILE         while
BREAK         break
CONTINUE      continue
RETURN        return
MAIN          main
Space         " "
Tab           "\t"
LineBreak     "\n"
Plus          "+" 
Minus         "-"    
Multiply      "*"   
Divide        "/"  
Modulo        "%"  
LessThan      "<"   
GreaterThan   ">"  
GreaterThanEqual ">="   
LessThanEqual "<="    
Equal         "=="   
NotEqual      "!="  
Not           "!"     
And           "&&"    
Or            "||"   
Assign        "=" 


LeftParenthesis   "("
RightParenthesis  ")"
LeftBrace         "{"
RightBrace        "}"
Semicolon         ";"


%%
{CONST}             printf("CONST \t\t\t %s \n", yytext);
{INT}               printf("INT \t\t\t %s \n", yytext);
{IF}                printf("IF \t\t\t %s \n", yytext);
{ELSE}              printf("ELSE \t\t\t %s \n", yytext);
{WHILE}             printf("WHILE \t\t\t %s \n", yytext);
{BREAK}             printf("BREAK \t\t\t %s \n", yytext);
{CONTINUE}          printf("CONTINUE \t\t %s \n", yytext);
{RETURN}            printf("RETURN \t\t\t %s \n", yytext);
{MAIN}              printf("MAIN \t\t\t %s \n", yytext);

{Ident}             {
    if (findByName(&arr, yytext) == -1) {
        addident(&arr, yytext, count++);
        printf("Ident \t\t\t %s \t\t %d\n", yytext, count-1);
    } else {
        printf("Ident \t\t\t %s \t\t %d\n", yytext, findByName(&arr, yytext));
    }
}

{DecConst}          {
    int dec = 0;
    for (int i = 0; i < strlen(yytext); i++) {
        dec = dec * 10 + yytext[i] - '0';
    }
    printf("(Dec)NUMBER \t\t %s \t\t %d\n", yytext, dec);
}

{OctConst}          {
    int Oct = 0;
    for (int i = 1; i < strlen(yytext); i++) {
        Oct = Oct * 8 + yytext[i] - '0';
    }
    printf("(Oct)NUMBER \t\t %s \t\t %d\n", yytext, Oct);
}

{HexConst}          {
    int Hex = 0;
    for (int i = 2; i < strlen(yytext); i++) {
        if (yytext[i] >= '0' && yytext[i] <= '9')
            Hex = Hex * 16 + yytext[i] - '0';
        else
            Hex = Hex * 16 + yytext[i] - 'a' + 10;
    }
    printf("(Hex)NUMBER \t\t %s \t\t %d\n", yytext, Hex);
}

{Plus}              printf("Plus \t\t\t %s \n", yytext);
{Minus}             printf("Minus \t\t\t %s \n", yytext);
{Multiply}          printf("Multiply \t\t %s \n", yytext);
{Divide}            printf("Divide \t\t %s \n", yytext);
{Modulo}            printf("Modulo \t\t %s \n", yytext);
{LessThan}          printf("LessThan \t\t %s \n", yytext);
{GreaterThan}       printf("GreaterThan \t\t %s \n", yytext);
{GreaterThanEqual}  printf("GreaterThanEqual \t %s \n", yytext);
{LessThanEqual}     printf("LessThanEqual \t\t %s \n", yytext);
{Equal}             printf("Equal \t\t\t %s \n", yytext);
{NotEqual}          printf("NotEqual \t\t %s \n", yytext);
{Not}               printf("Not \t\t\t %s \n", yytext);
{And}               printf("And \t\t\t %s \n", yytext);
{Or}                printf("Or \t\t\t %s \n", yytext);
{Assign}            printf("Assign \t\t\t %s \n", yytext);

{LeftParenthesis}   printf("LeftParenthesis \t %s \n", yytext);
{RightParenthesis}  printf("RightParenthesis \t %s \n", yytext);
{LeftBrace}         printf("LeftBrace \t\t %s \n", yytext);
{RightBrace}        printf("RightBrace \t\t %s \n", yytext);
{Semicolon}         printf("Semicolon \t\t %s \n", yytext);

{Space}             {}
{Tab}               {}
{LineBreak}         {}

.         printf("未识别的字符: %s\n", yytext);



%%

// 初始化数组
void init(identArray* arr) {
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

// 添加元素到数组
void addident(identArray* arr, const char* name, unsigned int id) {
    // 检查数组容量是否足够，如果不够则进行扩容
    if (arr->size >= arr->capacity) {
        arr->capacity = arr->capacity == 0 ? 1 : arr->capacity * 2;
        arr->data = realloc(arr->data, arr->capacity * sizeof(ident));
    }
    
    // 分配内存并复制字符串
    ident* newIdent = malloc(sizeof(ident));
    strncpy(newIdent->name, name, sizeof(newIdent->name) - 1);
    newIdent->name[sizeof(newIdent->name) - 1] = '\0';  // 确保字符串以'\0'结尾
    newIdent->id = id;
    
    // 将新元素添加到数组
    arr->data[arr->size++] = *newIdent;
    
    // 释放临时分配的内存
    free(newIdent);
}

// 查找数组中指定编号的元素
int findByName(identArray* arr, const char* name) {
    int found = 0;
    for (size_t i = 0; i < arr->size; i++) {
        if (strcmp( arr->data[i].name , name) == 0) {
            found = arr->data[i].id;
            return found;
        }
    }
    return -1;
}

// 释放数组占用的内存
void cleanup(identArray* arr) {
    free(arr->data);
    arr->data = NULL;
    arr->size = 0;
    arr->capacity = 0;
}

/*
int main() {
    init(&arr);
    yylex();
    cleanup(&arr);
    return 0;
}
*/
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("请提供输入文件名作为命令行参数\n");
        return 1;
    }
    
    FILE *input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        printf("无法打开输入文件\n");
        return 1;
    }
    
    yyin = input_file;  // 将输入文件设置为Lex的输入
    
    yylex();  // 执行词法分析
    
    fclose(input_file);  // 关闭输入文件
    
    return 0;
}