//------------------------------------------------------------------------------
// OrExpr :: toString - prints out an || expression.
//------------------------------------------------------------------------------
// Copyright:	See the COPYRIGHT file.
//------------------------------------------------------------------------------
// Notes:
//
//------------------------------------------------------------------------------
// History:
// 
// 19 Jan 1998	Matthew J. Rutherford, Riverside Technology, inc
//					Created initial version.
//------------------------------------------------------------------------------
// Variables:	I/O	Description		
//
//
//------------------------------------------------------------------------------
#include "OrExpr.h"

char* OrExpr :: toString()
{
	if( _left_op && _right_op ){
		sprintf( _string, "( %s %s %s )", _left_op->toString(), OR,
		_right_op->toString() );
	}
	return( _string );

/*  ==============  Statements containing RCS keywords:  */
/*  ===================================================  */


/*  ==============  Statements containing RCS keywords:  */
{static char rcs_id1[] = "$Source: /fs/hseb/ob81/ohd/ofs/src/resj_expression/RCS/OrExpr_toString.cxx,v $";
 static char rcs_id2[] = "$Id: OrExpr_toString.cxx,v 1.2 2006/10/26 15:28:43 hsu Exp $";}
/*  ===================================================  */

}