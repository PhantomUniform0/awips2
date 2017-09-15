/*
** Generated by X-Designer
*/
/*
**LIBS: -lXm -lXt -lX11
*/

#include <stdlib.h>
#include <X11/Xatom.h>
#include <X11/Intrinsic.h>
#include <X11/Shell.h>

#include <Xm/Xm.h>
#include <Xm/DialogS.h>
#include <Xm/Form.h>
#include <Xm/Label.h>
#include <Xm/PushB.h>
#include <Xm/RowColumn.h>
#include <Xm/Scale.h>


#include "display7x7.h"

Widget display7x7DS = (Widget) NULL;
Widget display7x7FO = (Widget) NULL;
Widget sitelidLB = (Widget) NULL;
Widget hrapRC = (Widget) NULL;
Widget hrap1LB = (Widget) NULL;
Widget hrap2LB = (Widget) NULL;
Widget hrap3LB = (Widget) NULL;
Widget hrap4LB = (Widget) NULL;
Widget hrap5LB = (Widget) NULL;
Widget hrap6LB = (Widget) NULL;
Widget hrap7LB = (Widget) NULL;
Widget hrap8LB = (Widget) NULL;
Widget hrap9LB = (Widget) NULL;
Widget hrap10LB = (Widget) NULL;
Widget hrap11LB = (Widget) NULL;
Widget hrap12LB = (Widget) NULL;
Widget hrap13LB = (Widget) NULL;
Widget hrap14LB = (Widget) NULL;
Widget hrap15LB = (Widget) NULL;
Widget hrap16LB = (Widget) NULL;
Widget hrap17LB = (Widget) NULL;
Widget hrap18LB = (Widget) NULL;
Widget hrap19LB = (Widget) NULL;
Widget hrap20LB = (Widget) NULL;
Widget hrap21LB = (Widget) NULL;
Widget hrap22LB = (Widget) NULL;
Widget hrap23LB = (Widget) NULL;
Widget hrap24LB = (Widget) NULL;
Widget hrap25LB = (Widget) NULL;
Widget hrap26LB = (Widget) NULL;
Widget hrap27LB = (Widget) NULL;
Widget hrap28LB = (Widget) NULL;
Widget hrap29LB = (Widget) NULL;
Widget hrap30LB = (Widget) NULL;
Widget hrap31LB = (Widget) NULL;
Widget hrap32LB = (Widget) NULL;
Widget hrap33LB = (Widget) NULL;
Widget hrap34LB = (Widget) NULL;
Widget hrap35LB = (Widget) NULL;
Widget hrap36LB = (Widget) NULL;
Widget hrap37LB = (Widget) NULL;
Widget hrap38LB = (Widget) NULL;
Widget hrap39LB = (Widget) NULL;
Widget hrap40LB = (Widget) NULL;
Widget hrap41LB = (Widget) NULL;
Widget hrap42LB = (Widget) NULL;
Widget hrap43LB = (Widget) NULL;
Widget hrap44LB = (Widget) NULL;
Widget hrap45LB = (Widget) NULL;
Widget hrap46LB = (Widget) NULL;
Widget hrap47LB = (Widget) NULL;
Widget hrap48LB = (Widget) NULL;
Widget hrap49LB = (Widget) NULL;
Widget precipamountLB = (Widget) NULL;
Widget applyPB = (Widget) NULL;
Widget undoPB = (Widget) NULL;
Widget missingPB = (Widget) NULL;
Widget closePB = (Widget) NULL;
Widget editprecipSC = (Widget) NULL;
Widget badPB = (Widget) NULL;



void create_display7x7DS (Widget parent)
{
	Widget children[49];      /* Children to manage */
	Display *display = XtDisplay ( parent );
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XrmValue from_value, to_value; /* For resource conversion */
	XPointer to_address; /* For Thread-safe resource conversion */ 
	Pixel to_pixel; /* For Thread-safe resource conversion */ 
	XmFontList to_fontlist; /* For Thread-safe resource conversion */ 
	XtPointer tmp_value;             /* ditto */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNwidth, 450); ac++;
	XtSetArg(al[ac], XmNheight, 330); ac++;
	XtSetArg(al[ac], XmNallowShellResize, FALSE); ac++;
	XtSetArg(al[ac], XmNtitle, "Display 7 X 7 Gage Editing Utility"); ac++;
	XtSetArg(al[ac], XmNminWidth, 450); ac++;
	XtSetArg(al[ac], XmNminHeight, 330); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 450); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 330); ac++;
	display7x7DS = XmCreateDialogShell ( parent, (char *) "display7x7DS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 450); ac++;
	XtSetArg(al[ac], XmNheight, 310); ac++;
	XtSetArg(al[ac], XmNnoResize, TRUE); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	display7x7FO = XmCreateForm ( display7x7DS, (char *) "display7x7FO", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "AATC2", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	sitelidLB = XmCreateLabel ( display7x7FO, (char *) "sitelidLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 310); ac++;
	XtSetArg(al[ac], XmNheight, 165); ac++;
	XtSetArg(al[ac], XmNborderWidth, 0); ac++;
	XtSetArg(al[ac], XmNnumColumns, 7); ac++;
	XtSetArg(al[ac], XmNspacing, 5); ac++;
	XtSetArg(al[ac], XmNorientation, XmHORIZONTAL); ac++;
	XtSetArg(al[ac], XmNpacking, XmPACK_TIGHT); ac++;
	XtSetArg(al[ac], XmNentryAlignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNentryVerticalAlignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNadjustLast, TRUE); ac++;
	XtSetArg(al[ac], XmNadjustMargin, TRUE); ac++;
	XtSetArg(al[ac], XmNisAligned, TRUE); ac++;
	XtSetArg(al[ac], XmNisHomogeneous, FALSE); ac++;
	XtSetArg(al[ac], XmNradioAlwaysOne, TRUE); ac++;
	XtSetArg(al[ac], XmNradioBehavior, FALSE); ac++;
	XtSetArg(al[ac], XmNresizeHeight, FALSE); ac++;
	XtSetArg(al[ac], XmNresizeWidth, FALSE); ac++;
	hrapRC = XmCreateRowColumn ( display7x7FO, (char *) "hrapRC", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap1LB = XmCreateLabel ( hrapRC, (char *) "hrap1LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	if (DefaultDepthOfScreen(DefaultScreenOfDisplay(display)) != 1) {

		from_value.addr = "#c6c6b2b2a8a8" ;
		from_value.size = strlen( from_value.addr ) + 1;
		to_value.size = sizeof(Pixel);
		to_value.addr = (XPointer) &to_pixel;
		XtConvertAndStore (hrapRC, XmRString, &from_value, XmRPixel, &to_value);

		if ( to_value.addr ) {
			XtSetArg(al[ac], XmNbackground, (*((Pixel*) to_value.addr))); ac++;
		}
	}
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap2LB = XmCreateLabel ( hrapRC, (char *) "hrap2LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.01", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap3LB = XmCreateLabel ( hrapRC, (char *) "hrap3LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap4LB = XmCreateLabel ( hrapRC, (char *) "hrap4LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap5LB = XmCreateLabel ( hrapRC, (char *) "hrap5LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap6LB = XmCreateLabel ( hrapRC, (char *) "hrap6LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap7LB = XmCreateLabel ( hrapRC, (char *) "hrap7LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap8LB = XmCreateLabel ( hrapRC, (char *) "hrap8LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap9LB = XmCreateLabel ( hrapRC, (char *) "hrap9LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap10LB = XmCreateLabel ( hrapRC, (char *) "hrap10LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap11LB = XmCreateLabel ( hrapRC, (char *) "hrap11LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap12LB = XmCreateLabel ( hrapRC, (char *) "hrap12LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap13LB = XmCreateLabel ( hrapRC, (char *) "hrap13LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap14LB = XmCreateLabel ( hrapRC, (char *) "hrap14LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap15LB = XmCreateLabel ( hrapRC, (char *) "hrap15LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap16LB = XmCreateLabel ( hrapRC, (char *) "hrap16LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap17LB = XmCreateLabel ( hrapRC, (char *) "hrap17LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap18LB = XmCreateLabel ( hrapRC, (char *) "hrap18LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap19LB = XmCreateLabel ( hrapRC, (char *) "hrap19LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap20LB = XmCreateLabel ( hrapRC, (char *) "hrap20LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap21LB = XmCreateLabel ( hrapRC, (char *) "hrap21LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap22LB = XmCreateLabel ( hrapRC, (char *) "hrap22LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap23LB = XmCreateLabel ( hrapRC, (char *) "hrap23LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap24LB = XmCreateLabel ( hrapRC, (char *) "hrap24LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap25LB = XmCreateLabel ( hrapRC, (char *) "hrap25LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap26LB = XmCreateLabel ( hrapRC, (char *) "hrap26LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap27LB = XmCreateLabel ( hrapRC, (char *) "hrap27LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap28LB = XmCreateLabel ( hrapRC, (char *) "hrap28LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap29LB = XmCreateLabel ( hrapRC, (char *) "hrap29LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap30LB = XmCreateLabel ( hrapRC, (char *) "hrap30LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap31LB = XmCreateLabel ( hrapRC, (char *) "hrap31LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap32LB = XmCreateLabel ( hrapRC, (char *) "hrap32LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap33LB = XmCreateLabel ( hrapRC, (char *) "hrap33LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap34LB = XmCreateLabel ( hrapRC, (char *) "hrap34LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap35LB = XmCreateLabel ( hrapRC, (char *) "hrap35LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap36LB = XmCreateLabel ( hrapRC, (char *) "hrap36LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap37LB = XmCreateLabel ( hrapRC, (char *) "hrap37LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap38LB = XmCreateLabel ( hrapRC, (char *) "hrap38LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap39LB = XmCreateLabel ( hrapRC, (char *) "hrap39LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap40LB = XmCreateLabel ( hrapRC, (char *) "hrap40LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap41LB = XmCreateLabel ( hrapRC, (char *) "hrap41LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap42LB = XmCreateLabel ( hrapRC, (char *) "hrap42LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap43LB = XmCreateLabel ( hrapRC, (char *) "hrap43LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap44LB = XmCreateLabel ( hrapRC, (char *) "hrap44LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap45LB = XmCreateLabel ( hrapRC, (char *) "hrap45LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap46LB = XmCreateLabel ( hrapRC, (char *) "hrap46LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap47LB = XmCreateLabel ( hrapRC, (char *) "hrap47LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap48LB = XmCreateLabel ( hrapRC, (char *) "hrap48LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 32); ac++;
	XtSetArg(al[ac], XmNheight, 20); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.00", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_CENTER); ac++;
	XtSetArg(al[ac], XmNrecomputeSize, FALSE); ac++;
	hrap49LB = XmCreateLabel ( hrapRC, (char *) "hrap49LB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "0.02 in", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	precipamountLB = XmCreateLabel ( display7x7FO, (char *) "precipamountLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 100); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Set Value", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	applyPB = XmCreatePushButton ( display7x7FO, (char *) "applyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 100); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Undo Missing", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	undoPB = XmCreatePushButton ( display7x7FO, (char *) "undoPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 100); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Set Missing", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	missingPB = XmCreatePushButton ( display7x7FO, (char *) "missingPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 100); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Close", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	closePB = XmCreatePushButton ( display7x7FO, (char *) "closePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Edit Gage Value", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNtitleString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNshowValue, TRUE); ac++;
	XtSetArg(al[ac], XmNminimum, 0); ac++;
	XtSetArg(al[ac], XmNmaximum, 350); ac++;
	XtSetArg(al[ac], XmNvalue, 0); ac++;
	XtSetArg(al[ac], XmNorientation, XmHORIZONTAL); ac++;
	XtSetArg(al[ac], XmNdecimalPoints, 2); ac++;

	from_value.addr = "<Default>" ;
	from_value.size = strlen( from_value.addr ) + 1;
	to_value.size = sizeof(XmFontList);
	to_value.addr = (XPointer) &to_fontlist;
	XtConvertAndStore (display7x7FO, XmRString, &from_value, XmRFontList, &to_value);

	if ( to_value.addr ) {
		XtSetArg(al[ac], XmNfontList, (*((XmFontList*) to_value.addr))); ac++;
	}
	editprecipSC = XmCreateScale ( display7x7FO, (char *) "editprecipSC", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Set Bad", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	badPB = XmCreatePushButton ( display7x7FO, (char *) "badPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 30); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -60); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -84); ac++;
	XtSetValues ( sitelidLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 31); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -203); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 136); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -423); ac++;
	XtSetValues ( hrapRC, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 66); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -84); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -84); ac++;
	XtSetValues ( precipamountLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 96); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( applyPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 138); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( undoPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 180); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( missingPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 222); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 18); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( closePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 218); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -283); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 137); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -424); ac++;
	XtSetValues ( editprecipSC, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 264); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -292); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 19); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -120); ac++;
	XtSetValues ( badPB, al, ac );
	ac = 0;
	if ((children[ac] = hrap1LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap2LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap3LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap4LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap5LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap6LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap7LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap8LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap9LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap10LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap11LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap12LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap13LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap14LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap15LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap16LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap17LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap18LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap19LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap20LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap21LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap22LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap23LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap24LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap25LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap26LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap27LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap28LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap29LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap30LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap31LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap32LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap33LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap34LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap35LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap36LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap37LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap38LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap39LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap40LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap41LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap42LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap43LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap44LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap45LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap46LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap47LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap48LB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrap49LB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = sitelidLB) != (Widget) 0) { ac++; }
	if ((children[ac] = hrapRC) != (Widget) 0) { ac++; }
	if ((children[ac] = precipamountLB) != (Widget) 0) { ac++; }
	if ((children[ac] = applyPB) != (Widget) 0) { ac++; }
	if ((children[ac] = undoPB) != (Widget) 0) { ac++; }
	if ((children[ac] = missingPB) != (Widget) 0) { ac++; }
	if ((children[ac] = closePB) != (Widget) 0) { ac++; }
	if ((children[ac] = editprecipSC) != (Widget) 0) { ac++; }
	if ((children[ac] = badPB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;

/*  ==============  Statements containing RCS keywords:  */
{static char rcs_id1[] = "$Source$";
 static char rcs_id2[] = "$Id$";}
/*  ===================================================  */

}
