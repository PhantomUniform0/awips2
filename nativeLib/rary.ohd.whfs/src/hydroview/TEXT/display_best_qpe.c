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
#include <Xm/ArrowB.h>
#include <Xm/DialogS.h>
#include <Xm/Form.h>
#include <Xm/Label.h>
#include <Xm/List.h>
#include <Xm/PushB.h>
#include <Xm/RowColumn.h>
#include <Xm/Scale.h>
#include <Xm/ScrollBar.h>
#include <Xm/TextF.h>
#include <Xm/ToggleB.h>
#include <Xm/ToggleBG.h>
#include <Xm/ComboBox.h>


#include "display_best_qpe.h"

Widget bestqpeDS = (Widget) NULL;
Widget bestqpeFO = (Widget) NULL;
Widget dayadjLB = (Widget) NULL;
Widget houradjLB = (Widget) NULL;
Widget qpetimeTX = (Widget) NULL;
Widget acclapseRB = (Widget) NULL;
Widget accumTB = (Widget) NULL;
Widget lapseTB = (Widget) NULL;
Widget dayupAB = (Widget) NULL;
Widget daydownAB = (Widget) NULL;
Widget hourupAB = (Widget) NULL;
Widget hourdownAB = (Widget) NULL;
Widget showdataPB = (Widget) NULL;
Widget cleardataPB = (Widget) NULL;
Widget closeqpePB = (Widget) NULL;
Widget idsTB = (Widget) NULL;
Widget labelsTB = (Widget) NULL;
Widget maxaccumLB = (Widget) NULL;
Widget maxlapseLB = (Widget) NULL;
Widget annotateLB = (Widget) NULL;
Widget durationLB = (Widget) NULL;
Widget durationSCL = (Widget) NULL;
Widget displayCBX = (Widget) NULL;
Widget displayTX = (Widget) NULL;
Widget displaySL = (Widget) NULL;
Widget displaySB = (Widget) NULL;
Widget displayLI = (Widget) NULL;
Widget displayLB = (Widget) NULL;
Widget endlapsePB = (Widget) NULL;
Widget restartPB = (Widget) NULL;
Widget firstframePB = (Widget) NULL;
Widget stepbackPB = (Widget) NULL;
Widget stepforwardPB = (Widget) NULL;
Widget lastframePB = (Widget) NULL;
Widget sourceLB = (Widget) NULL;
Widget sourceRB = (Widget) NULL;
Widget localTB = (Widget) NULL;
Widget rfcTB = (Widget) NULL;



void create_bestqpeDS (Widget parent)
{
	Widget children[28];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XtPointer tmp_value;             /* ditto */
	Pixel fg, bg;                    /* colour values for pixmaps */ 
	XmString *list_items[2];          /* For list items */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNx, 245); ac++;
	XtSetArg(al[ac], XmNy, 335); ac++;
	XtSetArg(al[ac], XmNwidth, 325); ac++;
	XtSetArg(al[ac], XmNheight, 300); ac++;
	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "Display Best Estimate QPE"); ac++;
	XtSetArg(al[ac], XmNminWidth, 325); ac++;
	XtSetArg(al[ac], XmNminHeight, 300); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 325); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 300); ac++;
	XtSetArg(al[ac], XmNbaseWidth, 325); ac++;
	XtSetArg(al[ac], XmNbaseHeight, 300); ac++;
	bestqpeDS = XmCreateDialogShell ( parent, (char *) "bestqpeDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 325); ac++;
	XtSetArg(al[ac], XmNheight, 300); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	bestqpeFO = XmCreateForm ( bestqpeDS, (char *) "bestqpeFO", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Day\nAdjust", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dayadjLB = XmCreateLabel ( bestqpeFO, (char *) "dayadjLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Hour\nAdjust", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	houradjLB = XmCreateLabel ( bestqpeFO, (char *) "houradjLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNeditable, FALSE); ac++;
	qpetimeTX = XmCreateTextField ( bestqpeFO, (char *) "qpetimeTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNorientation, XmHORIZONTAL); ac++;
	XtSetArg(al[ac], XmNradioAlwaysOne, TRUE); ac++;
	acclapseRB = XmCreateRadioBox ( bestqpeFO, (char *) "acclapseRB", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Accumulate", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNset, XmSET); ac++;
	accumTB = XmCreateToggleButtonGadget ( acclapseRB, (char *) "accumTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Time Lapse", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNset, XmUNSET); ac++;
	lapseTB = XmCreateToggleButtonGadget ( acclapseRB, (char *) "lapseTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dayupAB = XmCreateArrowButton ( bestqpeFO, (char *) "dayupAB", al, ac );
	XtSetArg(al[ac], XmNarrowDirection, XmARROW_DOWN); ac++;
	daydownAB = XmCreateArrowButton ( bestqpeFO, (char *) "daydownAB", al, ac );
	ac = 0;
	hourupAB = XmCreateArrowButton ( bestqpeFO, (char *) "hourupAB", al, ac );
	XtSetArg(al[ac], XmNarrowDirection, XmARROW_DOWN); ac++;
	hourdownAB = XmCreateArrowButton ( bestqpeFO, (char *) "hourdownAB", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 70); ac++;
	XtSetArg(al[ac], XmNheight, 25); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Show Data", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	showdataPB = XmCreatePushButton ( bestqpeFO, (char *) "showdataPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 70); ac++;
	XtSetArg(al[ac], XmNheight, 25); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Clear Data", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	cleardataPB = XmCreatePushButton ( bestqpeFO, (char *) "cleardataPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 70); ac++;
	XtSetArg(al[ac], XmNheight, 25); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Close", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	closeqpePB = XmCreatePushButton ( bestqpeFO, (char *) "closeqpePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "ids", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	idsTB = XmCreateToggleButton ( bestqpeFO, (char *) "idsTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "labels", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	labelsTB = XmCreateToggleButton ( bestqpeFO, (char *) "labelsTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "(max 72 hours)", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	maxaccumLB = XmCreateLabel ( bestqpeFO, (char *) "maxaccumLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "(max 24 hours)", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	maxlapseLB = XmCreateLabel ( bestqpeFO, (char *) "maxlapseLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Annotate:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	annotateLB = XmCreateLabel ( bestqpeFO, (char *) "annotateLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Duration:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	durationLB = XmCreateLabel ( bestqpeFO, (char *) "durationLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNshowValue, TRUE); ac++;
	XtSetArg(al[ac], XmNminimum, 1); ac++;
	XtSetArg(al[ac], XmNmaximum, 72); ac++;
	XtSetArg(al[ac], XmNvalue, 1); ac++;
	XtSetArg(al[ac], XmNorientation, XmHORIZONTAL); ac++;
	XtSetArg(al[ac], XmNdecimalPoints, 0); ac++;
	XtSetArg(al[ac], XmNscaleMultiple, 1); ac++;
	XtSetArg(al[ac], XmNeditable, TRUE); ac++;
	XtSetArg(al[ac], XmNslidingMode, XmSLIDER); ac++;
	durationSCL = XmCreateScale ( bestqpeFO, (char *) "durationSCL", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNitemCount, 4); ac++;
	list_items [0] = (XmString *) XtMalloc ( sizeof (XmString) * 5 );
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	list_items[0][0] = XmStringGenerate((XtPointer) "Grid", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	list_items[0][0] = XmStringCreateLtoR("Grid", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	list_items[0][1] = XmStringGenerate((XtPointer) "Basin", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	list_items[0][1] = XmStringCreateLtoR("Basin", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	list_items[0][2] = XmStringGenerate((XtPointer) "County", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	list_items[0][2] = XmStringCreateLtoR("County", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	list_items[0][3] = XmStringGenerate((XtPointer) "Zone", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	list_items[0][3] = XmStringCreateLtoR("Zone", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	list_items[0][4] = NULL;
	XtSetArg(al[ac], XmNitems, list_items[0]); ac++;
	displayCBX = XmCreateDropDownComboBox ( bestqpeFO, (char *) "displayCBX", al, ac );
	ac = 0;
	while ( list_items[0][ac] )
		XmStringFree ( list_items[0][ac++] );
	ac = 0;
	XtFree ( (char *) list_items[0] );
	displayTX = XtNameToWidget ( displayCBX, (char *) "*Text" );
	displayLI = XtNameToWidget ( displayCBX, (char *) "*List" );
	displaySL = XtParent ( displayLI );

	XtSetArg(al[ac], XmNverticalScrollBar, &displaySB); ac++;
	XtGetValues(displaySL, al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Display As:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	displayLB = XmCreateLabel ( bestqpeFO, (char *) "displayLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 70); ac++;
	XtSetArg(al[ac], XmNheight, 25); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "End Lapse", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	endlapsePB = XmCreatePushButton ( bestqpeFO, (char *) "endlapsePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 23); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	XtSetArg(al[ac], XmNmarginTop, 0); ac++;
	XtSetArg(al[ac], XmNmarginBottom, 0); ac++;
	XtSetArg(al[ac], XmNlabelType, XmPIXMAP); ac++;
	restartPB = XmCreatePushButton ( bestqpeFO, (char *) "restartPB", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNforeground, &fg ); ac++;
	XtSetArg(al[ac], XmNbackground, &bg ); ac++;
	XtGetValues(restartPB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNlabelPixmap, XmGetPixmap ( XtScreen ( restartPB ), "/fs/home/lawrence/image/restart_timelapse.xpm", fg, bg )); ac++;
	if (restartPB)
		XtSetValues ( restartPB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 30); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "|<<", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	firstframePB = XmCreatePushButton ( bestqpeFO, (char *) "firstframePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 20); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	XtSetArg(al[ac], XmNlayoutDirection, XmBOTTOM_TO_TOP); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "<", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	XtSetArg(al[ac], XmNlabelType, XmSTRING); ac++;
	stepbackPB = XmCreatePushButton ( bestqpeFO, (char *) "stepbackPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 20); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) ">", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	stepforwardPB = XmCreatePushButton ( bestqpeFO, (char *) "stepforwardPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 30); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) ">>|", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	lastframePB = XmCreatePushButton ( bestqpeFO, (char *) "lastframePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "QPE source", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	sourceLB = XmCreateLabel ( bestqpeFO, (char *) "sourceLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNorientation, XmHORIZONTAL); ac++;
	sourceRB = XmCreateRadioBox ( bestqpeFO, (char *) "sourceRB", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Local", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNset, XmSET); ac++;
	localTB = XmCreateToggleButtonGadget ( sourceRB, (char *) "localTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "RFC", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	rfcTB = XmCreateToggleButtonGadget ( sourceRB, (char *) "rfcTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 37); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 1); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dayadjLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 34); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 274); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( houradjLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 35); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -68); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 64); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -245); ac++;
	XtSetValues ( qpetimeTX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 76); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 3); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( acclapseRB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 32); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 42); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dayupAB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 54); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 42); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( daydownAB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 32); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 249); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hourupAB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 53); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 249); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( hourdownAB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 266); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 4); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( showdataPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 263); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 164); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( cleardataPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 262); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 241); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( closeqpePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 228); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 84); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( idsTB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 228); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 173); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( labelsTB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 112); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 6); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( maxaccumLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 111); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 101); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( maxlapseLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 234); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 11); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( annotateLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 148); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 4); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( durationLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 137); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -173); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 71); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -263); ac++;
	XtSetValues ( durationSCL, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 183); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 76); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( displayCBX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 193); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 1); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( displayLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 264); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 84); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( endlapsePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 74); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -106); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 296); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -322); ac++;
	XtSetValues ( restartPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 74); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -106); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 196); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -220); ac++;
	XtSetValues ( firstframePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 74); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -106); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 220); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -243); ac++;
	XtSetValues ( stepbackPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 74); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -106); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 244); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -270); ac++;
	XtSetValues ( stepforwardPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 74); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -106); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 271); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -296); ac++;
	XtSetValues ( lastframePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -22); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 2); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -77); ac++;
	XtSetValues ( sourceLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 2); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 88); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( sourceRB, al, ac );
	ac = 0;
	if ((children[ac] = accumTB) != (Widget) 0) { ac++; }
	if ((children[ac] = lapseTB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = localTB) != (Widget) 0) { ac++; }
	if ((children[ac] = rfcTB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = dayadjLB) != (Widget) 0) { ac++; }
	if ((children[ac] = houradjLB) != (Widget) 0) { ac++; }
	if ((children[ac] = qpetimeTX) != (Widget) 0) { ac++; }
	if ((children[ac] = acclapseRB) != (Widget) 0) { ac++; }
	if ((children[ac] = dayupAB) != (Widget) 0) { ac++; }
	if ((children[ac] = daydownAB) != (Widget) 0) { ac++; }
	if ((children[ac] = hourupAB) != (Widget) 0) { ac++; }
	if ((children[ac] = hourdownAB) != (Widget) 0) { ac++; }
	if ((children[ac] = showdataPB) != (Widget) 0) { ac++; }
	if ((children[ac] = cleardataPB) != (Widget) 0) { ac++; }
	if ((children[ac] = closeqpePB) != (Widget) 0) { ac++; }
	if ((children[ac] = idsTB) != (Widget) 0) { ac++; }
	if ((children[ac] = labelsTB) != (Widget) 0) { ac++; }
	if ((children[ac] = maxaccumLB) != (Widget) 0) { ac++; }
	if ((children[ac] = maxlapseLB) != (Widget) 0) { ac++; }
	if ((children[ac] = annotateLB) != (Widget) 0) { ac++; }
	if ((children[ac] = durationLB) != (Widget) 0) { ac++; }
	if ((children[ac] = durationSCL) != (Widget) 0) { ac++; }
	if ((children[ac] = displayCBX) != (Widget) 0) { ac++; }
	if ((children[ac] = displayLB) != (Widget) 0) { ac++; }
	if ((children[ac] = endlapsePB) != (Widget) 0) { ac++; }
	if ((children[ac] = restartPB) != (Widget) 0) { ac++; }
	if ((children[ac] = firstframePB) != (Widget) 0) { ac++; }
	if ((children[ac] = stepbackPB) != (Widget) 0) { ac++; }
	if ((children[ac] = stepforwardPB) != (Widget) 0) { ac++; }
	if ((children[ac] = lastframePB) != (Widget) 0) { ac++; }
	if ((children[ac] = sourceLB) != (Widget) 0) { ac++; }
	if ((children[ac] = sourceRB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
}
