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

#ifndef YY_YY_V3PARSEBISON_PRETMP_H_INCLUDED
# define YY_YY_V3PARSEBISON_PRETMP_H_INCLUDED
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
    yaFLOATNUM = 258,
    yaID__ETC = 259,
    yaID__LEX = 260,
    yaID__aPACKAGE = 261,
    yaID__aTYPE = 262,
    yaINTNUM = 263,
    yaTIMENUM = 264,
    yaSTRING = 265,
    yaSTRING__IGNORE = 266,
    yaTIMINGSPEC = 267,
    yaTABLELINE = 268,
    yaSCHDR = 269,
    yaSCINT = 270,
    yaSCIMP = 271,
    yaSCIMPH = 272,
    yaSCCTOR = 273,
    yaSCDTOR = 274,
    yVLT_COVERAGE_OFF = 275,
    yVLT_COVERAGE_ON = 276,
    yVLT_LINT_OFF = 277,
    yVLT_LINT_ON = 278,
    yVLT_TRACING_OFF = 279,
    yVLT_TRACING_ON = 280,
    yVLT_D_FILE = 281,
    yVLT_D_LINES = 282,
    yVLT_D_MSG = 283,
    yaD_IGNORE = 284,
    yaD_DPI = 285,
    yALWAYS = 286,
    yALWAYS_FF = 287,
    yALWAYS_COMB = 288,
    yALWAYS_LATCH = 289,
    yAND = 290,
    yASSERT = 291,
    yASSIGN = 292,
    yASSUME = 293,
    yAUTOMATIC = 294,
    yBEGIN = 295,
    yBIND = 296,
    yBIT = 297,
    yBREAK = 298,
    yBUF = 299,
    yBUFIF0 = 300,
    yBUFIF1 = 301,
    yBYTE = 302,
    yCASE = 303,
    yCASEX = 304,
    yCASEZ = 305,
    yCHANDLE = 306,
    yCLOCKING = 307,
    yCONST__ETC = 308,
    yCONST__LEX = 309,
    yCONST__REF = 310,
    yCMOS = 311,
    yCONTEXT = 312,
    yCONTINUE = 313,
    yCOVER = 314,
    yDEASSIGN = 315,
    yDEFAULT = 316,
    yDEFPARAM = 317,
    yDISABLE = 318,
    yDO = 319,
    yEDGE = 320,
    yELSE = 321,
    yEND = 322,
    yENDCASE = 323,
    yENDCLOCKING = 324,
    yENDFUNCTION = 325,
    yENDGENERATE = 326,
    yENDINTERFACE = 327,
    yENDMODULE = 328,
    yENDPACKAGE = 329,
    yENDPRIMITIVE = 330,
    yENDPROGRAM = 331,
    yENDPROPERTY = 332,
    yENDSPECIFY = 333,
    yENDTABLE = 334,
    yENDTASK = 335,
    yENUM = 336,
    yEXPORT = 337,
    yEXTERN = 338,
    yFINAL = 339,
    yFOR = 340,
    yFOREACH = 341,
    yFOREVER = 342,
    yFORKJOIN = 343,
    yFUNCTION = 344,
    yGENERATE = 345,
    yGENVAR = 346,
    yGLOBAL__CLOCKING = 347,
    yGLOBAL__LEX = 348,
    yIF = 349,
    yIFF = 350,
    yIMPORT = 351,
    yINITIAL = 352,
    yINOUT = 353,
    yINPUT = 354,
    yINSIDE = 355,
    yINT = 356,
    yINTEGER = 357,
    yINTERFACE = 358,
    yLOCALPARAM = 359,
    yLOGIC = 360,
    yLONGINT = 361,
    yMODPORT = 362,
    yMODULE = 363,
    yNAND = 364,
    yNEGEDGE = 365,
    yNMOS = 366,
    yNOR = 367,
    yNOT = 368,
    yNOTIF0 = 369,
    yNOTIF1 = 370,
    yOR = 371,
    yOUTPUT = 372,
    yPACKAGE = 373,
    yPACKED = 374,
    yPARAMETER = 375,
    yPMOS = 376,
    yPOSEDGE = 377,
    yPRIMITIVE = 378,
    yPRIORITY = 379,
    yPROGRAM = 380,
    yPROPERTY = 381,
    yPULLDOWN = 382,
    yPULLUP = 383,
    yPURE = 384,
    yRAND = 385,
    yRANDC = 386,
    yRCMOS = 387,
    yREAL = 388,
    yREALTIME = 389,
    yREF = 390,
    yREG = 391,
    yREPEAT = 392,
    yRESTRICT = 393,
    yRETURN = 394,
    yRNMOS = 395,
    yRPMOS = 396,
    yRTRAN = 397,
    yRTRANIF0 = 398,
    yRTRANIF1 = 399,
    ySCALARED = 400,
    ySHORTINT = 401,
    ySHORTREAL = 402,
    ySIGNED = 403,
    ySPECIFY = 404,
    ySPECPARAM = 405,
    ySTATIC = 406,
    ySTRING = 407,
    ySTRUCT = 408,
    ySUPPLY0 = 409,
    ySUPPLY1 = 410,
    yTABLE = 411,
    yTASK = 412,
    yTIME = 413,
    yTIMEPRECISION = 414,
    yTIMEUNIT = 415,
    yTRAN = 416,
    yTRANIF0 = 417,
    yTRANIF1 = 418,
    yTRI = 419,
    yTRI0 = 420,
    yTRI1 = 421,
    yTRUE = 422,
    yTYPE = 423,
    yTYPEDEF = 424,
    yUNION = 425,
    yUNIQUE = 426,
    yUNIQUE0 = 427,
    yUNSIGNED = 428,
    yVAR = 429,
    yVECTORED = 430,
    yVOID = 431,
    yWHILE = 432,
    yWIRE = 433,
    yWREAL = 434,
    yXNOR = 435,
    yXOR = 436,
    yD_ACOS = 437,
    yD_ACOSH = 438,
    yD_ASIN = 439,
    yD_ASINH = 440,
    yD_ATAN = 441,
    yD_ATAN2 = 442,
    yD_ATANH = 443,
    yD_BITS = 444,
    yD_BITSTOREAL = 445,
    yD_C = 446,
    yD_CEIL = 447,
    yD_CLOG2 = 448,
    yD_COS = 449,
    yD_COSH = 450,
    yD_COUNTONES = 451,
    yD_DIMENSIONS = 452,
    yD_DISPLAY = 453,
    yD_ERROR = 454,
    yD_EXP = 455,
    yD_FATAL = 456,
    yD_FCLOSE = 457,
    yD_FDISPLAY = 458,
    yD_FEOF = 459,
    yD_FFLUSH = 460,
    yD_FGETC = 461,
    yD_FGETS = 462,
    yD_FINISH = 463,
    yD_FLOOR = 464,
    yD_FOPEN = 465,
    yD_FREAD = 466,
    yD_FSCANF = 467,
    yD_FWRITE = 468,
    yD_HIGH = 469,
    yD_HYPOT = 470,
    yD_INCREMENT = 471,
    yD_INFO = 472,
    yD_ISUNKNOWN = 473,
    yD_ITOR = 474,
    yD_LEFT = 475,
    yD_LN = 476,
    yD_LOG10 = 477,
    yD_LOW = 478,
    yD_ONEHOT = 479,
    yD_ONEHOT0 = 480,
    yD_PAST = 481,
    yD_POW = 482,
    yD_RANDOM = 483,
    yD_READMEMB = 484,
    yD_READMEMH = 485,
    yD_REALTIME = 486,
    yD_REALTOBITS = 487,
    yD_RIGHT = 488,
    yD_RTOI = 489,
    yD_SFORMAT = 490,
    yD_SFORMATF = 491,
    yD_SIGNED = 492,
    yD_SIN = 493,
    yD_SINH = 494,
    yD_SIZE = 495,
    yD_SQRT = 496,
    yD_SSCANF = 497,
    yD_STIME = 498,
    yD_STOP = 499,
    yD_SWRITE = 500,
    yD_SYSTEM = 501,
    yD_TAN = 502,
    yD_TANH = 503,
    yD_TESTPLUSARGS = 504,
    yD_TIME = 505,
    yD_UNIT = 506,
    yD_UNPACKED_DIMENSIONS = 507,
    yD_UNSIGNED = 508,
    yD_VALUEPLUSARGS = 509,
    yD_WARNING = 510,
    yD_WRITE = 511,
    yD_WRITEMEMH = 512,
    yVL_CLOCK = 513,
    yVL_CLOCKER = 514,
    yVL_NO_CLOCKER = 515,
    yVL_CLOCK_ENABLE = 516,
    yVL_COVERAGE_BLOCK_OFF = 517,
    yVL_FULL_CASE = 518,
    yVL_INLINE_MODULE = 519,
    yVL_ISOLATE_ASSIGNMENTS = 520,
    yVL_NO_INLINE_MODULE = 521,
    yVL_NO_INLINE_TASK = 522,
    yVL_SC_BV = 523,
    yVL_SFORMAT = 524,
    yVL_PARALLEL_CASE = 525,
    yVL_PUBLIC = 526,
    yVL_PUBLIC_FLAT = 527,
    yVL_PUBLIC_FLAT_RD = 528,
    yVL_PUBLIC_FLAT_RW = 529,
    yVL_PUBLIC_MODULE = 530,
    yP_TICK = 531,
    yP_TICKBRA = 532,
    yP_OROR = 533,
    yP_ANDAND = 534,
    yP_NOR = 535,
    yP_XNOR = 536,
    yP_NAND = 537,
    yP_EQUAL = 538,
    yP_NOTEQUAL = 539,
    yP_CASEEQUAL = 540,
    yP_CASENOTEQUAL = 541,
    yP_WILDEQUAL = 542,
    yP_WILDNOTEQUAL = 543,
    yP_GTE = 544,
    yP_LTE = 545,
    yP_LTE__IGNORE = 546,
    yP_SLEFT = 547,
    yP_SRIGHT = 548,
    yP_SSRIGHT = 549,
    yP_POW = 550,
    yP_PLUSCOLON = 551,
    yP_MINUSCOLON = 552,
    yP_MINUSGT = 553,
    yP_MINUSGTGT = 554,
    yP_EQGT = 555,
    yP_ASTGT = 556,
    yP_ANDANDAND = 557,
    yP_POUNDPOUND = 558,
    yP_DOTSTAR = 559,
    yP_ATAT = 560,
    yP_COLONCOLON = 561,
    yP_COLONEQ = 562,
    yP_COLONDIV = 563,
    yP_ORMINUSGT = 564,
    yP_OREQGT = 565,
    yP_BRASTAR = 566,
    yP_BRAEQ = 567,
    yP_BRAMINUSGT = 568,
    yP_PLUSPLUS = 569,
    yP_MINUSMINUS = 570,
    yP_PLUSEQ = 571,
    yP_MINUSEQ = 572,
    yP_TIMESEQ = 573,
    yP_DIVEQ = 574,
    yP_MODEQ = 575,
    yP_ANDEQ = 576,
    yP_OREQ = 577,
    yP_XOREQ = 578,
    yP_SLEFTEQ = 579,
    yP_SRIGHTEQ = 580,
    yP_SSRIGHTEQ = 581,
    yP_LOGIFF = 582,
    prUNARYARITH = 583,
    prREDUCTION = 584,
    prNEGATION = 585,
    prLOWER_THAN_ELSE = 586
  };
#endif

/* Value type.  */


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_V3PARSEBISON_PRETMP_H_INCLUDED  */
