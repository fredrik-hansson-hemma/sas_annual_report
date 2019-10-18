ods path sashelp.tmplmst(read);

libname template "%sysfunc(pathname(WORK))";
ods path template.template(update) sashelp.tmplmst(read);

proc template;
   define style template.custom;
   parent = styles.rtf;
      style fonts / 'TitleFont' = ("Arial",12pt,Bold)   /* Titles from TITLE statements */
'TitleFont2' = ("Arial ",12pt,Bold) /* Procedure titles ("The _____ Procedure")*/
'StrongFont' = ("Arial ",10pt,Bold)         'EmphasisFont' = ("Arial ",10pt,Italic)     
'headingEmphasisFont' = ("Arial ",10pt,Bold Italic)
'headingFont' = ("Arial ",10pt,Bold)/* Table column and row headings */'docFont' = ("Arial ",10pt)                /* Data in table cells */'footFont' = ("Arial ",8pt, Italic)        /* Footnotes from FOOTNOTE statements */ 'FixedEmphasisFont' = ("Courier",9pt,Italic) 'FixedStrongFont' = ("Courier",9pt,Bold) 'FixedHeadingFont' = ("Courier",9pt,Bold) 'BatchFixedFont' = ("Courier",6.7pt) 'FixedFont' = ("Courier",9pt);
      style color_list / 'link' = blue             /* links */ 'bgH' = white/* row and column header background */ 'fg' = black              /* text color */ 'bg' = white;             /* page background color */;
             
      style Body from Document /
		bottommargin   =   _undef_
		topmargin   =   _undef_
		rightmargin   =   _undef_
		leftmargin   =   _undef_;

      style Table from Output /   frame = hsides    /* outside borders: void, box, above/below, vsides/hsides, lhs/rhs */  rules = groups    /* internal borders: none, all, cols, rows, groups */  cellpadding  =  5pt/* the space between table cell contents and the cell border */  cellspacing = 0pt /* the space between table cells, allows background to show */  borderwidth = 2pt /* the width of the borders and rules */;

      * Leave code below this line alone ;
      * style SystemFooter from SystemFooter /
		font   =   fonts("footFont");
 style SystemHeader from SystemHeader / borderbottomstyle=double bordercolor=bigy frameborder=on frame=below rules=rows textdecoration=underline;
 
 style SystemTitle from SystemTitle / borderbottomstyle=double borderbottomcolor=green /* bordercolor=bigy frameborder=on frame=below rules=rows textdecoration=underline */;

	  style SystemFooter from SystemFooter /          font = fonts("footFont")          protectspecialchars=off          posttext='\par page }{\field{\*\fldinst {\cs17  PAGE }}{\fldrslt {\cs17\lang1024 1}}}{\cs17  of }{\field{\*\fldinst {\cs17 NUMPAGES }}{\fldrslt {\cs17\lang1024 1}}}{\cs17  '; 
   end;
run;


ods path show;

ods _all_ close;
options nodate nonumber device=EMF nocenter;
ods noproctitle;
ods proclabel 'Frequencies';
ods rtf file='c:\tmp\sample2.rtf' style=template.Custom startpage=never;

title justify=left 'Thor 2018' justify=right 'Produktion';
footnote justify=center ' ' /* Skriver fotnot bara för att sidnumret ska skrivas ut i sidfoten */ ;


options bottommargin = 2.5cm
topmargin   =   2.5cm
rightmargin   =   2.5cm
leftmargin   =   2.5cm;

proc report data=sashelp.class nowd;
	column age height weight;
	define age / group;
	define height / mean f=8.;
	define weight / mean f=8.;
run;
ods rtf text='{\i\fs18 Footnote table 1}';

ods rtf style=science;

proc report data=sashelp.class nowd;
	column age height weight;
	define age / group;
	define height / mean f=8.;
	define weight / mean f=8.;
run;
ods rtf text='{\i\fs18 Footnote table 2}';


ods rtf close;

