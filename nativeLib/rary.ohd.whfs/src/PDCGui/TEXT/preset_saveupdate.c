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
#include <Xm/Frame.h>
#include <Xm/Label.h>
#include <Xm/PushB.h>
#include <Xm/Text.h>
#include <Xm/TextF.h>


#include "preset_saveupdate.h"

Widget saveasnewDS = (Widget) NULL;
Widget saveasnewFO = (Widget) NULL;
Widget ok_saveasnewPB = (Widget) NULL;
Widget cancel_saveasnewPB = (Widget) NULL;
Widget saveupdate_curFR = (Widget) NULL;
Widget saveupdate_curFO = (Widget) NULL;
Widget saveupdate_curidTX = (Widget) NULL;
Widget saveupdate_curidLB = (Widget) NULL;
Widget saveupdate_curdesLB = (Widget) NULL;
Widget saveupdate_currankTX = (Widget) NULL;
Widget saveupdate_currankLB = (Widget) NULL;
Widget saveupdate_curdesTX = (Widget) NULL;
Widget savedefs_curLB = (Widget) NULL;
Widget saveupdate_newFR = (Widget) NULL;
Widget saveupdate_newFO = (Widget) NULL;
Widget saveupdate_idTX = (Widget) NULL;
Widget saveupdate_idLB = (Widget) NULL;
Widget saveupdate_desLB = (Widget) NULL;
Widget saveupdate_rankLB = (Widget) NULL;
Widget saveupdate_rankTX = (Widget) NULL;
Widget saveupdate_desTX = (Widget) NULL;
Widget savdefs_newLB = (Widget) NULL;



void create_saveasnewDS (Widget parent)
{
	Widget children[6];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XtPointer tmp_value;             /* ditto */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNwidth, 650); ac++;
	XtSetArg(al[ac], XmNheight, 240); ac++;
	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "Save Preset Options"); ac++;
	XtSetArg(al[ac], XmNminWidth, 650); ac++;
	XtSetArg(al[ac], XmNminHeight, 240); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 650); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 240); ac++;
	XtSetArg(al[ac], XmNbaseWidth, 650); ac++;
	XtSetArg(al[ac], XmNbaseHeight, 240); ac++;
	XtSetArg(al[ac], XmNdeleteResponse, XmDO_NOTHING); ac++;
	saveasnewDS = XmCreateDialogShell ( parent, (char *) "saveasnewDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 650); ac++;
	XtSetArg(al[ac], XmNheight, 240); ac++;
	XtSetArg(al[ac], XmNdialogStyle, XmDIALOG_PRIMARY_APPLICATION_MODAL); ac++;
	XtSetArg(al[ac], XmNresizePolicy, XmRESIZE_GROW); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	saveasnewFO = XmCreateForm ( saveasnewDS, (char *) "saveasnewFO", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Ok", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	ok_saveasnewPB = XmCreatePushButton ( saveasnewFO, (char *) "ok_saveasnewPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Cancel", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	cancel_saveasnewPB = XmCreatePushButton ( saveasnewFO, (char *) "cancel_saveasnewtPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	saveupdate_curFR = XmCreateFrame ( saveasnewFO, (char *) "saveupdate_curFR", al, ac );
	saveupdate_curFO = XmCreateForm ( saveupdate_curFR, (char *) "saveupdate_curFO", al, ac );
	XtSetArg(al[ac], XmNwidth, 50); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	XtSetArg(al[ac], XmNcolumns, 12); ac++;
	XtSetArg(al[ac], XmNeditable, FALSE); ac++;
	saveupdate_curidTX = XmCreateText ( saveupdate_curFO, (char *) "saveupdate_curidTX", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "UniqueId:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	saveupdate_curidLB = XmCreateLabel ( saveupdate_curFO, (char *) "saveupdate_curidLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Description:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	saveupdate_curdesLB = XmCreateLabel ( saveupdate_curFO, (char *) "saveupdate_curdesLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 5); ac++;
	XtSetArg(al[ac], XmNcolumns, 5); ac++;
	XtSetArg(al[ac], XmNeditable, FALSE); ac++;
	saveupdate_currankTX = XmCreateTextField ( saveupdate_curFO, (char *) "saveupdate_currankTX", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Rank:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	saveupdate_currankLB = XmCreateLabel ( saveupdate_curFO, (char *) "saveupdate_currankLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 200); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	XtSetArg(al[ac], XmNmaxLength, 30); ac++;
	XtSetArg(al[ac], XmNcolumns, 20); ac++;
	XtSetArg(al[ac], XmNeditable, FALSE); ac++;
	saveupdate_curdesTX = XmCreateTextField ( saveupdate_curFO, (char *) "saveupdate_curdesTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNframeChildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Current Information", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	savedefs_curLB = XmCreateLabel ( saveupdate_curFR, (char *) "savedefs_curLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	saveupdate_newFR = XmCreateFrame ( saveasnewFO, (char *) "saveupdate_newFR", al, ac );
	saveupdate_newFO = XmCreateForm ( saveupdate_newFR, (char *) "saveupdate_newFO", al, ac );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	XtSetArg(al[ac], XmNcolumns, 8); ac++;
	XtSetArg(al[ac], XmNresizeWidth, TRUE); ac++;
	saveupdate_idTX = XmCreateTextField ( saveupdate_newFO, (char *) "saveupdate_idTX", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "UniqueId:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	saveupdate_idLB = XmCreateLabel ( saveupdate_newFO, (char *) "saveupdate_idLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Description:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	saveupdate_desLB = XmCreateLabel ( saveupdate_newFO, (char *) "saveupdate_desLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Rank:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	saveupdate_rankLB = XmCreateLabel ( saveupdate_newFO, (char *) "saveupdate_rankLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 5); ac++;
	XtSetArg(al[ac], XmNcolumns, 5); ac++;
	saveupdate_rankTX = XmCreateTextField ( saveupdate_newFO, (char *) "saveupdate_rankTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNmaxLength, 30); ac++;
	XtSetArg(al[ac], XmNcolumns, 30); ac++;
	saveupdate_desTX = XmCreateTextField ( saveupdate_newFO, (char *) "saveupdate_desTX", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNframeChildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "New Information", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	savdefs_newLB = XmCreateLabel ( saveupdate_newFR, (char *) "savdefs_newLB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 186); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -222); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 192); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -288); ac++;
	XtSetValues ( ok_saveasnewPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 186); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -222); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 342); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -438); ac++;
	XtSetValues ( cancel_saveasnewPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 10); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -84); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -642); ac++;
	XtSetValues ( saveupdate_curFR, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 97); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -174); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -642); ac++;
	XtSetValues ( saveupdate_newFR, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -41); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 96); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -194); ac++;
	XtSetValues ( saveupdate_curidTX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 6); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -84); ac++;
	XtSetValues ( saveupdate_curidLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 204); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -294); ac++;
	XtSetValues ( saveupdate_curdesLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -41); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 564); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -626); ac++;
	XtSetValues ( saveupdate_currankTX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 516); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -558); ac++;
	XtSetValues ( saveupdate_currankLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -46); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 306); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -510); ac++;
	XtSetValues ( saveupdate_curdesTX, al, ac );
	ac = 0;
	if ((children[ac] = saveupdate_curidTX) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_curidLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_curdesLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_currankTX) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_currankLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_curdesTX) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = saveupdate_curFO) != (Widget) 0) { ac++; }
	if ((children[ac] = savedefs_curLB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 96); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -192); ac++;
	XtSetValues ( saveupdate_idTX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -36); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 12); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -84); ac++;
	XtSetValues ( saveupdate_idLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 204); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -294); ac++;
	XtSetValues ( saveupdate_desLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -41); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 516); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -556); ac++;
	XtSetValues ( saveupdate_rankLB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -41); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 564); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( saveupdate_rankTX, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 6); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -42); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 306); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -511); ac++;
	XtSetValues ( saveupdate_desTX, al, ac );
	ac = 0;
	if ((children[ac] = saveupdate_idTX) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_idLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_desLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_rankLB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_rankTX) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_desTX) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = saveupdate_newFO) != (Widget) 0) { ac++; }
	if ((children[ac] = savdefs_newLB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = ok_saveasnewPB) != (Widget) 0) { ac++; }
	if ((children[ac] = cancel_saveasnewPB) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_curFR) != (Widget) 0) { ac++; }
	if ((children[ac] = saveupdate_newFR) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
}
