/*
	File:		rejectdata_show.c
	Date:		December 1999
	Author:		Russell Erb
        History:        Bryon Lawrence   June 8, 2001
                        Moved the declaration of the orderby_clause
                        global variable from this header file into
                        the rejectdata_show.c file.  This was done
                        to remedy duplicate symbol problems that
                        were being encountered while linking with 
                        the libTimeSeries.a library.
                            
	
	Purpose:	Function protype for the file "rejectdata_show.c"
*/

/*
    time_convert.h is to convert time to a certain format.
    rejectdata.h is generated by XDesigner.
    rejectdata_show.h is for the function protype for this program.
    DbmsUtils.h includes utility routins to work with the database.
    Xtools.h includes collection of usuful functions for X.
    ShefPe.h includes data structure of shefpe table.
 */

#ifndef rejectdata_show_h
#define rejectdata_show_h

#include "DbmsDefs.h"
#include "time_convert.h"
#include "Observation.h"
#include "Forecast.h"
#include "RejectedData.h"
#include "rejectdata.h"
#include "ShefPe.h"
#include "IngestFilter.h"
#include "LoadUnique.h"
#include "DbmsUtils.h"
#include "Xtools.h"
#include "QualityCode.h"

#define MAX_PHRASE 2500
#define PE_NAME_LEN 30
#define	HDRTRASH  "Location     Name                        PE  Dur    TS Ext      Value   ObsTime           BasisTime     RV  SQ  QC  User        Type    PostTime          Product       ProdTime"


/* Function prototypes */

void    rejectdata_show(Widget w, char *location);
void    add_rejectdata_cbs();
void    loadpeLI();
void    sched_strip(char *str_ptr); 
void    load_rejectdata_list(char *);
char    *get_time_format(char *);
char    *createFilterPE();
void    closeTrashBin_CB();
void    free_rejectdata();
void    trashBinFilterSort_CB(Widget, XtPointer, XtPointer);
void    emptyTrashBin_CB(Widget, XtPointer, XtPointer);
void    emptyTrashBin(Widget, XtPointer, XtPointer);
void    deleteTrash_CB(Widget, XtPointer, XtPointer);
void    deleteTrash(Widget, XtPointer, XtPointer);
void    repostTrash_CB(Widget, XtPointer, XtPointer);
void	rejectdata_question_cancel(Widget w, XtPointer ptr, XtPointer cbs);
void	createDeleteWhere(char *delete_where, RejectedData *rejdataPtr);
void	setRejectedData2Observation(RejectedData *trash, Observation *obs);
void	setRejectedData2Forecast(RejectedData *trash, Forecast *fcst);

/*  Global variables */

RejectedData    *RejDataHead;
UniqueList      *UHead;
ShefPe          *SHead;

#endif 