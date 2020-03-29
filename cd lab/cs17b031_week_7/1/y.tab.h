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
    NUMBER = 258,
    ID = 259,
    PLUSPLUS = 260,
    MINUSMINUS = 261,
    PLUS = 262,
    MINUS = 263,
    MUL = 264,
    DIV = 265,
    XOR = 266,
    AND = 267,
    OR = 268,
    ANDAND = 269,
    OROR = 270,
    PERCENT = 271,
    LT = 272,
    GT = 273,
    LEQ = 274,
    GEQ = 275,
    EQEQ = 276,
    EQ = 277,
    NEQ = 278,
    NOT = 279,
    SCOL = 280
  };
#endif
/* Tokens.  */
#define NUMBER 258
#define ID 259
#define PLUSPLUS 260
#define MINUSMINUS 261
#define PLUS 262
#define MINUS 263
#define MUL 264
#define DIV 265
#define XOR 266
#define AND 267
#define OR 268
#define ANDAND 269
#define OROR 270
#define PERCENT 271
#define LT 272
#define GT 273
#define LEQ 274
#define GEQ 275
#define EQEQ 276
#define EQ 277
#define NEQ 278
#define NOT 279
#define SCOL 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
