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
#include <Xm/List.h>
#include <Xm/PushB.h>
#include <Xm/ScrollBar.h>
#include <Xm/Separator.h>
#include <Xm/Text.h>
#include <Xm/ToggleB.h>


#include "filteroptions.h"

Widget hbsbfilterDS = (Widget) NULL;
Widget hbfiltermainFO = (Widget) NULL;
Widget hbsbfilterFO = (Widget) NULL;
Widget hbsbfhsaSL = (Widget) NULL;
Widget hbsbfhsaVSB = (Widget) NULL;
Widget hbsbfhsaLI = (Widget) NULL;
Widget hbsbLB = (Widget) NULL;
Widget hbpostTB = (Widget) NULL;
Widget hbnopostTB = (Widget) NULL;
Widget hbshefLB = (Widget) NULL;
Widget hblatlonfilterFO = (Widget) NULL;
Widget latfilterLB = (Widget) NULL;
Widget lonfilterLB = (Widget) NULL;
Widget offsetfilterLB = (Widget) NULL;
Widget latfilterTX = (Widget) NULL;
Widget lonfilterTX = (Widget) NULL;
Widget offsetlatTX = (Widget) NULL;
Widget centerLB = (Widget) NULL;
Widget offsetlonTX = (Widget) NULL;
Widget latlonTB = (Widget) NULL;
Widget latlonfilterLB = (Widget) NULL;
Widget hbsbfapplyPB = (Widget) NULL;
Widget hbsbfcancelPB = (Widget) NULL;



void create_hbsbfilterDS (Widget parent)
{
	Widget children[10];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XmString xmstrings[16];    /* temporary storage for XmStrings */
	Widget separator4 = (Widget)NULL;
	Widget separator1 = (Widget)NULL;
	Widget separator3 = (Widget)NULL;

	XtSetArg(al[ac], XmNwidth, 250); ac++;
	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "Station List Filter Options"); ac++;
	XtSetArg(al[ac], XmNminWidth, 395); ac++;
	XtSetArg(al[ac], XmNminHeight, 415); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 450); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 415); ac++;
	hbsbfilterDS = XmCreateDialogShell ( parent, "hbsbfilterDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 430); ac++;
	XtSetArg(al[ac], XmNheight, 415); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	hbfiltermainFO = XmCreateForm ( hbsbfilterDS, "hbfiltermainFO", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	hbsbfilterFO = XmCreateForm ( hbfiltermainFO, "hbsbfilterFO", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNselectionPolicy, XmMULTIPLE_SELECT); ac++;
	hbsbfhsaLI = XmCreateScrolledList ( hbsbfilterFO, "hbsbfhsaLI", al, ac );
	ac = 0;
	hbsbfhsaSL = XtParent ( hbsbfhsaLI );

	XtSetArg(al[ac], XmNverticalScrollBar, &hbsbfhsaVSB); ac++;
	XtGetValues(hbsbfhsaSL, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNselectionPolicy, XmMULTIPLE_SELECT); ac++;
	XtSetValues ( hbsbfhsaLI,al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Filter by HSA", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hbsbLB = XmCreateLabel ( hbsbfilterFO, "hbsbLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR ( "Show SHEF Post", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	hbpostTB = XmCreateToggleButton ( hbsbfilterFO, "hbpostTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR ( "Show SHEF No Post", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	hbnopostTB = XmCreateToggleButton ( hbsbfilterFO, "hbnopostTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNorientation, XmVERTICAL); ac++;
	separator4 = XmCreateSeparator ( hbsbfilterFO, "separator4", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Filter by SHEF Post Switch", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hbshefLB = XmCreateLabel ( hbsbfilterFO, "hbshefLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 400); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	hblatlonfilterFO = XmCreateForm ( hbfiltermainFO, "hblatlonfilterFO", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 25); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Latitude", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	latfilterLB = XmCreateLabel ( hblatlonfilterFO, "latfilterLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR ( "Longitude", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	lonfilterLB = XmCreateLabel ( hblatlonfilterFO, "lonfilterLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR ( "Offset", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	offsetfilterLB = XmCreateLabel ( hblatlonfilterFO, "offsetfilterLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 10); ac++;
	XtSetArg(al[ac], XmNcolumns, 12); ac++;
	XtSetArg(al[ac], XmNeditMode, XmSINGLE_LINE_EDIT); ac++;
	latfilterTX = XmCreateText ( hblatlonfilterFO, "latfilterTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNmaxLength, 10); ac++;
	XtSetArg(al[ac], XmNcolumns, 12); ac++;
	XtSetArg(al[ac], XmNeditMode, XmSINGLE_LINE_EDIT); ac++;
	lonfilterTX = XmCreateText ( hblatlonfilterFO, "lonfilterTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNmaxLength, 10); ac++;
	XtSetArg(al[ac], XmNcolumns, 12); ac++;
	offsetlatTX = XmCreateText ( hblatlonfilterFO, "offsetlatTX", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Center", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	centerLB = XmCreateLabel ( hblatlonfilterFO, "centerLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 10); ac++;
	XtSetArg(al[ac], XmNcolumns, 12); ac++;
	offsetlonTX = XmCreateText ( hblatlonfilterFO, "offsetlonTX", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Enable", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	latlonTB = XmCreateToggleButton ( hblatlonfilterFO, "latlonTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR ( "Filter by Lat/Lon", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	latlonfilterLB = XmCreateLabel ( hblatlonfilterFO, "latlonfilterLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 64); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Apply", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hbsbfapplyPB = XmCreatePushButton ( hbfiltermainFO, "hbsbfapplyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 64); ac++;
	XtSetArg(al[ac], XmNheight, 30); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Close", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hbsbfcancelPB = XmCreatePushButton ( hbfiltermainFO, "hbsbfcancelPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	separator1 = XmCreateSeparator ( hbfiltermainFO, "separator1", al, ac );
	separator3 = XmCreateSeparator ( hbfiltermainFO, "separator3", al, ac );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -160); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -430); ac++;
	XtSetValues ( hbsbfilterFO,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 170); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -350); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 0); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -430); ac++;
	XtSetValues ( hblatlonfilterFO,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 375); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 115); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbsbfapplyPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 375); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 235); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbsbfcancelPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNtopWidget, hbsbfilterFO); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNbottomWidget, hblatlonfilterFO); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 0); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -430); ac++;
	XtSetValues ( separator1,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNtopWidget, hblatlonfilterFO); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -365); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 0); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -430); ac++;
	XtSetValues ( separator3,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 25); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -145); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 25); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -153); ac++;
	XtSetValues ( hbsbfhsaSL,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNbottomWidget, hbsbfhsaSL); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 35); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbsbLB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 65); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNbottomWidget, hbnopostTB); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 210); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbpostTB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 95); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 210); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbnopostTB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 0); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -165); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 175); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -190); ac++;
	XtSetValues ( separator4,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 205); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hbshefLB,al, ac );
	ac = 0;
	XtManageChild(hbsbfhsaLI);
	children[ac++] = hbsbLB;
	children[ac++] = hbpostTB;
	children[ac++] = hbnopostTB;
	children[ac++] = separator4;
	children[ac++] = hbshefLB;
	XtManageChildren(children, ac);
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 60); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 160); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( latfilterLB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 120); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -145); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 160); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( lonfilterLB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 20); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNbottomWidget, offsetlatTX); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 310); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( offsetfilterLB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 55); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -90); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 15); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -145); ac++;
	XtSetValues ( latfilterTX,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 115); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -150); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 15); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -145); ac++;
	XtSetValues ( lonfilterTX,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 55); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -90); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 265); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -395); ac++;
	XtSetValues ( offsetlatTX,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 20); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_WIDGET); ac++;
	XtSetArg(al[ac], XmNbottomWidget, latfilterTX); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 55); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( centerLB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 115); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -150); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 265); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -395); ac++;
	XtSetValues ( offsetlonTX,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 150); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 160); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( latlonTB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 0); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 165); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( latlonfilterLB,al, ac );
	ac = 0;
	children[ac++] = latfilterLB;
	children[ac++] = lonfilterLB;
	children[ac++] = offsetfilterLB;
	children[ac++] = latfilterTX;
	children[ac++] = lonfilterTX;
	children[ac++] = offsetlatTX;
	children[ac++] = centerLB;
	children[ac++] = offsetlonTX;
	children[ac++] = latlonTB;
	children[ac++] = latlonfilterLB;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = hbsbfilterFO;
	children[ac++] = hblatlonfilterFO;
	children[ac++] = hbsbfapplyPB;
	children[ac++] = hbsbfcancelPB;
	children[ac++] = separator1;
	children[ac++] = separator3;
	XtManageChildren(children, ac);
	ac = 0;
}
