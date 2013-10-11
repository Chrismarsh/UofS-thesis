%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.7 - Modified by Chris Marsh 2012
% Changes:
%  - Added support for line numbers that work with AMS Math
%
% Version 1.6 - Modified by Chris Marsh 2012
% Changes:
%  - Added support for hyperref
%  - Added list of symbols
% 
% Version 1.5 - Modified by Eric Sampson 2004/10/18, created by Mark G. Eramian
%
% Changes:
% - Modified for use with Lyx as well as LaTeX 
% - Made class more general for use with any college/department
%
%
% Version 1.4.2
%
% Changes:
% - Fixed a bug that was introduced with the last bugfix.  By changing the figure environment
%   no optional arguments like [h] were being processed.  This was resolved by changing the
%   way floats are typeset rather than the actual float environment.  At the same time I also
%   added a fix for a future bug which ensures that footnotes are typeset single-spaced.
% - I used the 'caption' package to slightly modify the appearance of table and figure captions.
%   They are now slightly indented on both the left and right, making them easier to distinguish
%   from the text body.  The figure/table number and designation are now also in bold text.
%   It is supposed to be possible with this package to force table captions to be above the table
%   but I was unable to get this to work.
% 
%
% Version 1.4.1
% -------------
%
% Changes:  
% - Fixed a small problem where when double or 1.5 spacing is used, the multi-line 
%   figure and table captions also come out double or 1.5 spaced.  I Redefined the figure and table
%   environments to ensure that captions are always single-spaced.
%
%
% Version 1.4
% -----------
%
% 2004/09/13
%
% Changes:
% 
% - Redefined the 'quote' and 'quotation' environments so that the text is always single-spaced
%   according to CGSR guidelines.  Quotation spacing is now single-spaced regardless of
%   global spacing.  Text size of quotations should match base font size of thesis.
% - Modified the thesis_template.tex file so that the bibliography is single spaced.
% - The table of contents, list of figures, list of tables, and list of
%   abbreviations is now always single-spaced.
% - Changed the bibliographystile in thesis_template.tex to ``unsrt'' since CGSR
%   requires that references appear in the order in which they are first cited in the text.
%
% New features:
%
% - Added an option called 'singlespace'.  This option may be used ONLY if the 'proposal'
%   option is used.  It allows proposals to be printed using single-spacing to save on printing
%   costs for proposal drafts.  This option does not alter spacing of the title page.
%   This option is documented in the thesis.tex document.
%
% Thanks to David Fourney for most of the above suggestions.
%
%
% Version 1.3
% -----------
% 
% 2004/08/16
% 
% Changes:
% 
% - The entry in the table of contents for the table of contents now reads ``Contents'' instead 
%   of ``Table of Contents'' to match the title of the table of contents page.
% - Not really a class file issue, but I updated the thesis_template.tex file to prevent an
%   empty chapter from occuring when using BibTeX.  Also improved bibliography instructions in
%   the template file.
%
%
%
% Version 1.2
% -----------
%
% 2004/07/19
% 
% Changes:
% 
% - Now passes options through to the base report package by using \LoadClassWithOptions
%   Allows options like 12pt to be used.
% - Fixed spacing for pages with title headings.  The top margin was too large
% - Fixed some spacing in the chapter headings that CGSR was having issues with. 
%
%
%
% Version 1.1
% -----------
% 
% 2004/07/02
% 
% Changes:
% 
% - Fixed \ifx statement for nofigurelist option.
% - Added warning to read the CGSR guidelines to documentation and template.
% - Added frontmatter items to Table of Contents
% - Added support for list of abbreviations and added related documentation.
% 
% 2004/06/28 -- Original Version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2004/10/18 -- Thesis Style (v. 1.5), modified by Eric Sampson, created by Mark G. Eramian]

\newcounter{dummy}

%The idea with the PassOptionsToClass is to stop passing
%porposal to the report class as it has no idea what it is
%So in this case, only pass options it knows.
\DeclareOption{singlespace}{
\let\singlespace=Y
\PassOptionsToClass{\CurrentOption}{report}
}

\DeclareOption{proposal}{
\let\proposal=Y
}

\DeclareOption{notablelist}{
\let\notablelist=Y
\PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{nofigurelist}{
\let\nofigurelist=Y
\PassOptionsToClass{\CurrentOption}{report}
}

\DeclareOption{linenumber}{
\let\linenum=Y
}

%pass to baseclass *ONLY* the paramters it knows.
\ProcessOptions \relax
%this has been changed to hardcode 12pt font 
%as that is what is "suggested"
% http://www.usask.ca/cgsr/for_students/style.php
\LoadClass[12pt]{report}

\RequirePackage{tocloft}
\RequirePackage{titlesec}
\RequirePackage[tableposition=top]{caption}
\usepackage[title,titletoc]{appendix}

%2.54cm = 1in
%11in = 27.94cm
%8.5in = 21.59cm

%Set spacing


%Set up margins - Left margin is 4cm.  Remaining margins are 2.5cm
\flushbottom
%Left margin
\setlength{\oddsidemargin}{1.46cm}    % 2.54cm(1 inch) + 1.46cm = 4cm

%Top margin:  \headheight + \headsep + \topmargin = 2.5cm
\setlength{\headheight}{1cm}           
\setlength{\headsep}{1cm}
\setlength{\topmargin}{-2.04cm}        % 2.54cm(1 inch) - 2.04cm = 0.5cm 

%Bottom margin
%Total top and bottom margin is 5cm so \textheight should be 27.94(11in) - 5cm = 22.94cm
\setlength{\textheight}{22.94cm}

%Right margin
%Total left + right is 4+2.5 = 6.5cm so \textwidth should be 21.59(8.5in) - 6.5 = 15.09cm
\setlength{\textwidth}{15.09cm}

%Grad studies says it is permissable to have all page numbers at bottom center
%Roman numerals for frontmatter, arabic numerals beginning with Chapter 1.
%All pages are to be numbered consecutively.
\pagestyle{plain}

%Spacing should be 1.5 or 2 for a thesis.  Default is 1.5.
\renewcommand{\baselinestretch}{1.5}
%If the proposal option is selected, we allow the singlespace option.
%The purpose of this is to reduce printed pages for reviewing drafts.
\ifx\singlespace\undefined
    \relax
\else
    \ifx\proposal\undefined
        \ClassError{thesis}{The 'singlespace' option may only be used in conjuction with the 'proposal' option.}
    \else
        \renewcommand{\baselinestretch}{1}\normalize
    \fi
\fi

%enable line numbers
\ifx\linenum\undefined
    \relax
\else
   \usepackage{lineno}
   %uncomment if you want line numbers to restart on each page
  \setpagewiselinenumbers
   \def\linenumberfont{\normalfont\small\sffamily}


   %patch for Ams math environment
   %needs to be executed right before \begin{document}, and only if we are using amsmath
    %http://simon.bonners.ca/blog///blog5.php/2010/10/06/line-number-and-amsmath


      \AtBeginDocument
      {
          \@ifpackageloaded{amsmath}
          {
            \newcommand*\patchAmsMathEnvironmentForLineno[1]
            {
              \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
              \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
              \renewenvironment{#1}%
              {\linenomath\csname old#1\endcsname}%
              {\csname oldend#1\endcsname\endlinenomath}}% 
              \newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
              \patchAmsMathEnvironmentForLineno{#1}%
              \patchAmsMathEnvironmentForLineno{#1*}}%
              \AtBeginDocument{%
              \patchBothAmsMathEnvironmentsForLineno{equation}%
              \patchBothAmsMathEnvironmentsForLineno{align}%
              \patchBothAmsMathEnvironmentsForLineno{flalign}%
              \patchBothAmsMathEnvironmentsForLineno{alignat}%
              \patchBothAmsMathEnvironmentsForLineno{gather}%
              \patchBothAmsMathEnvironmentsForLineno{multline}%
            }
          }
    }
    {\relax}

\fi

% Customize the table of contents title fonts
\renewcommand{\cfttoctitlefont}{\vbox{}\vspace{-0.3cm}\hfill\LARGE\sc}
\renewcommand{\cftloftitlefont}{\vbox{}\vspace{-0.3cm}\hfill\LARGE\sc}
\renewcommand{\cftlottitlefont}{\vbox{}\vspace{-0.3cm}\hfill\LARGE\sc}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftafterlottitle}{\hfill}

% Font changes - chapter headings and so forth
%\allsectionsfont{\sc}
\titleformat{\chapter}[display]{\LARGE\sc\fillast}{Chapter \thechapter}{0pt}{}
\titlespacing{\chapter}{0pt}{1.4cm}{20pt}

% Redefine quote and quotation environments so that they are single spaced
% according to CGSR regulations.
\renewenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\renewcommand{\baselinestretch}{1}\normalsize\relax}
               {\endlist}
\renewenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\renewcommand{\baselinestretch}{1}\normalsize\relax}
               {\endlist}
% Increase the space between last line of text and footnote rule.
% This is a very untidy way to do it!

\skip\footins 20pt plus4pt minus4pt

% Reset baselinestretch within footnotes and floats. Originally stolen
% from Stanford thesis style.
%This breaks color hyperref and floats!!!


%\def\@xfloat#1[#2]{\ifhmode \@bsphack\@floatpenalty -\@Mii\else
%   \@floatpenalty-\@Miii\fi\def\@captype{#1}\ifinner
%      \@parmoderr\@floatpenalty\z@
%    \else\@next\@currbox\@freelist{\@tempcnta\csname ftype@#1\endcsname
%       \multiply\@tempcnta\@xxxii\advance\@tempcnta\sixt@@n
%       \@tfor \@tempa :=#2\do
%                        {\if\@tempa h\advance\@tempcnta \@ne\fi
%                         \if\@tempa t\advance\@tempcnta \tw@\fi
%                         \if\@tempa b\advance\@tempcnta 4\relax\fi
%                         \if\@tempa p\advance\@tempcnta 8\relax\fi
%         }\global\count\@currbox\@tempcnta}\@fltovf\fi
%    \global\setbox\@currbox\vbox\bgroup 
%    \def\baselinestretch{1}
%    \boxmaxdepth\z@
%    \hsize\columnwidth \@parboxrestore}

%from here http://www.latex-community.org/forum/viewtopic.php?f=4&t=507
\let\latex@xfloat=\@xfloat
\def\@xfloat #1[#2]{%
  \latex@xfloat #1[#2]%
  \def \baselinestretch {1}\@normalsize  %%  GT: need \@normalsize?
  \normalsize
}

\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}


%Make fancier table and figure captions -- from 'caption' package
\DeclareCaptionFormat{uofscaption}{#1#2#3}
\captionsetup{format=uofscaption,labelfont=bf,width=5in}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Things needed for the title page
%(author/title/date already exist)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\PhD}{Doctor of Philosophy}
\newcommand{\MSc}{Master of Science}

\newcommand{\degree}[1]{\gdef\@degree{#1}}
\newcommand{\convocationdate}[1]{\gdef\@convocationdate{#1}}
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\college}[1]{\gdef\@college{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\city}[1]{\gdef\@city{#1}}
\newcommand{\address}[1]{\gdef\@address{#1}}


\author{}
\title{}
\degree{}
\convocationdate{}
\university{}
\college{}
\department{}
\city{}
\address{}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAKETITLE definition
%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\maketitle}{

\ifx\linenum\undefined
  \relax
\else

  \linenumbers
\fi

\addcontentsline{toc}{chapter}{Title}
\refstepcounter{dummy}

%Check for needed definitions
\ifx \@author \@empty
\ClassError{thesis}{\protect\author{} is undefined}
\fi
\ifx \@university \@empty
\ClassError{thesis}{\protect\university{} is undefined}
\fi
\ifx \@college \@empty
\ClassError{thesis}{\protect\college{} is undefined}
\fi
\ifx \@department \@empty
\ClassError{thesis}{\protect\department{} is undefined}
\fi
\ifx \@city \@empty
\ClassError{thesis}{\protect\city{} is undefined}
\fi
\ifx \@address \@empty
\ClassError{thesis}{\protect\address{} is undefined}
\fi
\ifx \@title \@empty
\ClassError{thesis}{\protect\title{} is undefined}
\fi
\ifx \@degree \@empty
\ClassError{thesis}{\protect\degree{} is undefined.  Use \protect\degree{\protect\PhD}
or \protect\degree{\protect\MSc}}
\fi
\ifx \@convocationdate \@empty
\ClassError{thesis}{\protect\convocationdate{} is undefined.}
\fi
\thispagestyle{empty}
{\renewcommand{\baselinestretch}{1.5}
\LARGE
\vbox{}\vfil
\begin{center}
\ifx\proposal\undefined
        \relax
\else
        Thesis Proposal:\\
\fi
\textsc{\@title}\\
\strut\\
\Large
\ifx\proposal\undefined
A Thesis Submitted to the\\
\@college\\
in Partial Fulfillment of the Requirements\\
for the degree of \@degree\\
in the \@department\\
\@university\\
\@city\\
\strut\\
\fi
By\\
\@author\\
\ifx\proposal\undefined
\strut\\
\copyright \@author, \@convocationdate.  All rights reserved.
\fi
\end{center}
\vfil
}
\newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Things needed for the frontmatter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}
\abstract{}
\newcommand{\acknowledgements}[1]{\gdef\@acknowledgements{#1}}
\acknowledgements{}
\newcommand{\dedication}[1]{\gdef\@dedication{#1}}
\dedication{}
\newcommand{\loa}[1]{\gdef\@loa{#1}}
\loa{}

% Command to add an entry to the list of abbreviations.
\newcommand{\abbrev}[2]{#1& #2\\}

\newcommand{\los}[1]{\gdef\@los{#1}}
\los{}

% Command to add an entry to the list of abbreviations.
\newcommand{\addsym}[2]{#1& #2\\}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FRONTMATTER DEFINTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\frontmatter}{

%CHeck for required definitons
\ifx \@abstract \@empty
\ClassError{thesis}{\protect\abstract{} is undefined}
\fi

%Each item in the frontmatter is to be on a separate page.
\pagenumbering{roman}

% PERMISSION TO USE
\ifx\undefined\proposal
\vbox{}\vspace{1.1cm}
\refstepcounter{dummy}
\addcontentsline{toc}{chapter}{Permission to Use}

\begin{center}
\LARGE \sc Permission to Use
\end{center}
\vspace{1cm}
In presenting this thesis in partial fulfilment of the requirements for a Postgraduate degree from the \@university, I agree that the Libraries of this University may make it freely available for inspection. I further agree that permission for copying of this thesis in any manner, in whole or in part, for scholarly purposes may be granted by the professor or professors who supervised my thesis work or, in their absence, by the Head of the Department or the Dean of the College in which my thesis work was done. It is understood that any copying or publication or use of this thesis or parts thereof for financial gain shall not be allowed without my written permission. It is also understood that due recognition shall be given to me and to the \@university\ in any scholarly use which may be made of any material in my thesis.

Requests for permission to copy or to make other use of material in this thesis in whole or part should be addressed to:\\
\\\strut
\indent Head of the \@department

%\@university

\@address
\newpage
\fi

% ABSTRACT
\refstepcounter{dummy}
\addcontentsline{toc}{chapter}{Abstract}

\vbox{}\vspace{1.1cm}
\begin{center}
\LARGE\textsc{Abstract}\\
\end{center}
\strut\\
\@abstract
\newpage

%ACKNOWLEDGEMENTS (if any)
\ifx \@acknowledgements \@empty
\relax
\else
        \ifx\proposal\undefined
        \refstepcounter{dummy}
        \addcontentsline{toc}{chapter}{Acknowledgements}
       
        \vbox{}\vspace{1.1cm}
        \begin{center}
        \LARGE\sc Acknowledgements
        \end{center}
        \vspace{1cm}
        \@acknowledgements
        \newpage
        \fi
\fi

%DEDICATION (If any)
\ifx \@dedication \@empty
\relax
\else
        \ifx\proposal\undefined
        \vbox{}\vfil
        \@dedication
        \vfil
        \newpage
        \fi
\fi

%TABLE OF CONTENTS
\ifx\nofigurelist\undefined
\refstepcounter{dummy}
\addcontentsline{toc}{chapter}{Contents}

{\renewcommand{\baselinestretch}{1}\normalsize
\tableofcontents
}
\newpage
\fi

%LIST OF TABLES
\ifx\notablelist\undefined
\refstepcounter{dummy}
\addcontentsline{toc}{chapter}{List of Tables}

{\renewcommand{\baselinestretch}{1}\normalsize
\listoftables
}
\newpage
\fi

%LIST OF FIGURES
\ifx\nofigurelist\undefined
\refstepcounter{dummy}
\addcontentsline{toc}{chapter}{List of Figures}

{\renewcommand{\baselinestretch}{1}\normalsize
\listoffigures
}
\newpage
\fi

%LIST OF ABBREVIATIONS
\ifx \@loa \@empty
\relax
\else
        \refstepcounter{dummy}
        \addcontentsline{toc}{chapter}{List of Abbreviations}
        
        {\renewcommand{\baselinestretch}{1}\normalsize
          \vbox{}\vspace{1.1cm}
          \begin{center}
            {\LARGE\sc List of Abbreviations}
            \vbox{}\vspace{1cm}
            \begin{tabular}{lp{11cm}}
              \@loa   
            \end{tabular}
          \end{center}        
        }
        \newpage
\fi

%LIST OF symbols
\ifx \@los \@empty
\relax
\else
        \refstepcounter{dummy}
        \addcontentsline{toc}{chapter}{List of Symbols}
        
        {\renewcommand{\baselinestretch}{1}\normalsize
          \vbox{}\vspace{1.1cm}
          \begin{center}
            {\LARGE\sc List of Symbols}
            \vbox{}\vspace{1cm}
            \begin{tabular}{lp{11cm}}
              \@los   
            \end{tabular}
          \end{center}        
        }
        \newpage
\fi

\pagenumbering{arabic}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Appendix setup
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % This command is defined to simplify setup for the typesetting of appendices.
 
 \newcommand{\uofsappendix}{
 % Sets chapter counter to appendix mode (counts by letters instead of numbers)
\appendix
 
 % This next line is needed to change the appendix chapter titles from reading
 % "Chapter A" to "Appendix A".  This should not be necessary but it seems that
 % the titlesec package overrides the changes to the chapter headings that
 % the \appendix commands make.  We use the following workround:
 \titleformat{\chapter}[display]{\renewcommand{\baselinestretch}{1.5}\normalsize
 \LARGE\sc\fillast}{Appendix \thechapter}{0pt}{}
 
 
 % This is needed to put a one-inch top margin on the first page of
 % appendices -- this seems to be what CGSR wants.  If not, just comment
 % out the next line.
 \titlespacing{\chapter}{0pt}{-30pt}{20pt}
 
 % Appendices need to be single-spaced.  Reset spacing to single
 % regardless of global document spacing.
 \renewcommand{\baselinestretch}{1}\normalsize


 }