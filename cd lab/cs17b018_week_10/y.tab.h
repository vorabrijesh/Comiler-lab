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
    num = 258,
    fnum = 259,
    sq1 = 260,
    sq2 = 261,
    FLOAT = 262,
    INT = 263,
    CHAR = 264,
    doll = 265,
    comma = 266,
    ID = 267,
    cb1 = 268,
    cb2 = 269,
    eql = 270,
    pt1 = 271,
    ADD = 272,
    SUB = 273,
    mod = 274,
    DIV = 275,
    LP = 276,
    RP = 277,
    ELSE = 278,
    IF = 279,
    WHILE = 280,
    REL = 281,
    AND = 282,
    OR = 283,
    NOT = 284,
    REDUCE = 285,
    POLU = 286,
    GOLU = 287
  };
#endif
/* Tokens.  */
#define num 258
#define fnum 259
#define sq1 260
#define sq2 261
#define FLOAT 262
#define INT 263
#define CHAR 264
#define doll 265
#define comma 266
#define ID 267
#define cb1 268
#define cb2 269
#define eql 270
#define pt1 271
#define ADD 272
#define SUB 273
#define mod 274
#define DIV 275
#define LP 276
#define RP 277
#define ELSE 278
#define IF 279
#define WHILE 280
#define REL 281
#define AND 282
#define OR 283
#define NOT 284
#define REDUCE 285
#define POLU 286
#define GOLU 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
