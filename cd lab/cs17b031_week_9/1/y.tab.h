/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    FNUM = 259,
    sq1 = 260,
    sq2 = 261,
    FLOAT = 262,
    INT = 263,
    CHAR = 264,
    SCOL = 265,
    COMMA = 266,
    ID = 267,
    cb1 = 268,
    cb2 = 269,
    LP = 270,
    RP = 271,
    NUMBER = 272,
    ADD = 273,
    SUB = 274,
    MUL = 275,
    DIV = 276,
    ASGN = 277
  };
#endif
/* Tokens.  */
#define NUM 258
#define FNUM 259
#define sq1 260
#define sq2 261
#define FLOAT 262
#define INT 263
#define CHAR 264
#define SCOL 265
#define COMMA 266
#define ID 267
#define cb1 268
#define cb2 269
#define LP 270
#define RP 271
#define NUMBER 272
#define ADD 273
#define SUB 274
#define MUL 275
#define DIV 276
#define ASGN 277

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 57 "lab8.y" /* yacc.c:1909  */

	 int dval;
	 char lexeme[20];
	struct Snode *snode;

#line 104 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
