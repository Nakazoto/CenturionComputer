/*
 *	CC6303:  A C compiler for the 6803/6303 processors
 *	(C) 2019 Alan Cox
 *
 *	This compiler is built out of a much modified CC65 and all new code
 *	is placed under the same licence as the original. Please direct all
 *	cc6303 bugs to the author not to the cc65 developers unless you find
 *	a bug that is also present in cc65.
 */
/*
** expr.h
**
** Ullrich von Bassewitz, 21.06.1998
*/



#ifndef EXPR_H
#define EXPR_H



/* cc65 */
#include "datatype.h"
#include "exprdesc.h"



/*****************************************************************************/
/*                                   code                                    */
/*****************************************************************************/



void ExprWithCheck (void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Call an expression function with checks. */

void MarkedExprWithCheck (void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Call an expression function with checks and record start and end of the
** generated code.
*/

void PushAddr (const ExprDesc* Expr);
/* If the expression contains an address that was somehow evaluated,
** push this address on the stack. This is a helper function for all
** sorts of implicit or explicit assignment functions where the lvalue
** must be saved if it's not constant, before evaluating the rhs.
*/

void Store (ExprDesc* Expr, const Type* StoreType);
/* Store the primary register into the location denoted by lval. If StoreType
** is given, use this type when storing instead of lval->Type. If StoreType
** is NULL, use lval->Type instead.
*/

int evalexpr (unsigned flags, void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Will evaluate an expression via the given function. If the result is a
** constant, 0 is returned and the value is put in the Expr struct. If the
** result is not constant, LoadExpr is called to bring the value into the
** primary register and 1 is returned.
*/

void Expression0 (ExprDesc* Expr);
/* Evaluate an expression via hie0 and put the result into the primary register */

void ConstExpr (void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Will evaluate an expression via the given function. If the result is not
** a constant of some sort, a diagnostic will be printed, and the value is
** replaced by a constant one to make sure there are no internal errors that
** result from this input error.
*/

void BoolExpr (void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Will evaluate an expression via the given function. If the result is not
** something that may be evaluated in a boolean context, a diagnostic will be
** printed, and the value is replaced by a constant one to make sure there
** are no internal errors that result from this input error.
*/

void ConstAbsIntExpr (void (*Func) (ExprDesc*), ExprDesc* Expr);
/* Will evaluate an expression via the given function. If the result is not
** a constant numeric integer value, a diagnostic will be printed, and the
** value is replaced by a constant one to make sure there are no internal
** errors that result from this input error.
*/

void hie10 (ExprDesc* lval);
/* Handle ++, --, !, unary - etc. */

void hie8 (ExprDesc* Expr);
/* Process + and - binary operators. */

void hie1 (ExprDesc* lval);
/* Parse first level of expression hierarchy. */

void hie0 (ExprDesc* Expr);
/* Parse comma operator. */


void NotViaX(void);
/* Tell the evaluator to give up doing this via X */

int XFailed(void);
/* Check if we were unable to do this via X */

extern int XFailure;

/* End of expr.h */

#endif
