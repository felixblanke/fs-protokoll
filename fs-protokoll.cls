%%
%% Identification
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fs-protokoll}[2021/11/06 Protokollklasse fuer Protokolle der FS Mathematik]

%%
%% OPTIONS
%%

\RequirePackage{kvoptions}      % Allows Key-Value Options

\SetupKeyvalOptions{
    family=FS,
    prefix=FS@
}


% use option pair draft/final
\DeclareBoolOption{draft}
\DeclareComplementaryOption{final}{draft}

\DeclareBoolOption{wideoverview}

\DeclareBoolOption{raggedtitle}

\DeclareStringOption[-1.25cm]{TOPindent}

\DeclareBoolOption[false]{hyphens}

\DeclareStringOption[none]{gremium}

\DeclareStringOption[12]{DIV}
\DeclareStringOption[half]{parskip}
\DeclareStringOption[10pt]{fontsize}

% pass all other options to the document class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% process all options
\ProcessKeyvalOptions*

%%
%% LOADING PACKAGES
%%

% load the class "scrartcl" from the KoMa-Script bundle
\LoadClass[%
    a4paper
    ]{scrartcl}

\KOMAoptions{%
    DIV=\FS@DIV,%
    parskip=\FS@parskip,%
    fontsize=\FS@fontsize%
}

\RequirePackage{iftex}%       % check if one is using pdftex
\ifpdftex
  \wlog{PDF LaTeX detected}
  \RequirePackage[utf8]{inputenc}% Input-Encoding UTF-8
  \RequirePackage[T1]{fontenc}   % Font-Encoding
  \RequirePackage{lmodern}       % Latin Modern Font
\else                         % Lua/XeTex detected
  \RequirePackage{fontspec}      % Loads Latin Modern internally
\fi

\RequirePackage{babel}          % localization

\RequirePackage{xparse}         % allow improved definition of commands
\RequirePackage{mathtools}      % default math commands, loads amsmath internally
\RequirePackage{microtype}      % improved micro-typography: character protrusion and font expansion are enabled by default.

\RequirePackage[%               % for a more colorful life
    dvipsnames%                 %     give more colors a name
]{xcolor}
\RequirePackage{graphicx}       % allow embedding of images
\RequirePackage{pdfpages}       % allow embedding of pdf documents
\RequirePackage[%               % improved quotation marks
    autostyle%                  % use correct quotation mark style for each language
]{csquotes}                     % 

\RequirePackage{eurosym}        % allow use of official euro sign
\RequirePackage{soul}           % highlighting of text

\RequirePackage[%               % improved lists
    shortlabels%                %     allows shorthand notation (like enumerate package)
]{enumitem}

\RequirePackage{booktabs}       % improved tabulars
\RequirePackage{tabularx}       % tabulars with varying width

\RequirePackage{calc}           % allow specification of length via arithmetic expressions
\RequirePackage{etoolbox}       % more tools for writing a LaTeX class

\ifFS@hyphens
    % Pass option "hyphens" to the package url which is loaded internally in hyperref to allow url breaking after a hyphen.    
    \PassOptionsToPackage{hyphens}{url}
\fi

%%
%% TRANSLATIONS
%%

\newcommand*{\FS@lang@error}[1]{%
  \ClassError{fs-protokoll}{%
    current language not supported%
  }{%
    Currently fs-protokoll only supports languages ``ngerman'' and
    ``english''.\MessageBreak
    It seems, that you are using another language (maybe
    \languagename).\MessageBreak
    Because of this you have to define \string#1\space by
    yourself!\MessageBreak
  }%
  \textbf{??}%
}

\providecommand* \FS@drafttext                  {\FS@lang@error{\FS@drafttext}}

\providecommand* \FS@attendingmembers@title     {\FS@lang@error{\FS@attendingmembers@title}}
\providecommand* \FS@attending@title            {\FS@lang@error{\FS@attending@title}}
\providecommand* \FS@attending@titlewithmembers {\FS@lang@error{\FS@attending@titlewithmembers}}
\providecommand* \FS@head@title                 {\FS@lang@error{\FS@head@title}}
\providecommand* \FS@minutestaker@title         {\FS@lang@error{\FS@minutestaker@title}}
\providecommand* \FS@excmissing@title           {\FS@lang@error{\FS@excmissing@title}}
\providecommand* \FS@missing@title              {\FS@lang@error{\FS@missing@title}}
\providecommand* \FS@beginn@title               {\FS@lang@error{\FS@beginn@title}}
\providecommand* \FS@ende@title                 {\FS@lang@error{\FS@ende@title}}
\providecommand* \FS@date@prefix                {\FS@lang@error{\FS@date@prefix}}
\providecommand* \FS@minutes@title              {\FS@lang@error{\FS@minutes@title}}
\providecommand* \FS@session@title              {\FS@lang@error{\FS@session@title}}
\providecommand* \FS@session@shorttitle         {\FS@lang@error{\FS@session@shorttitle}}
\providecommand* \FS@session@regular            {\FS@lang@error{\FS@session@regular}}
\providecommand* \FS@session@special            {\FS@lang@error{\FS@session@special}}
\providecommand* \FS@session@prefix             {\FS@lang@error{\FS@session@prefix}}
\providecommand* \FS@fsr@prefix                 {\FS@lang@error{\FS@fsr@prefix}}
\providecommand* \FS@fsr@oldboard               {\FS@lang@error{\FS@fsr@oldboard}}
\providecommand* \FS@fsr@newboard               {\FS@lang@error{\FS@fsr@newboard}}
\providecommand* \FS@fsv@prefix                 {\FS@lang@error{\FS@fsv@prefix}}
\providecommand* \FS@top@abbrev                 {\FS@lang@error{\FS@top@abbrev}}
\providecommand* \FS@internetslogan             {\FS@lang@error{\FS@internetslogan}}
\providecommand* \FS@constituent                {\FS@lang@error{\FS@constituent}}


\DeclareStringOption[Alter FSR-Vorstand]{oldfsrprefix}
\DeclareStringOption[Neuer FSR-Vorstand]{newfsrprefix}

\AtBeginDocument{%
    \providecaptionname{ngerman}{\FS@drafttext}{Entwurf}%
    \providecaptionname{ngerman}{\FS@attendingmembers@title}{Anwesende Mitglieder:}%
    \providecaptionname{ngerman}{\FS@attending@title}{Anwesende:}%
    \providecaptionname{ngerman}{\FS@attending@titlewithmembers}{Weitere Anwesende:}%
    \providecaptionname{ngerman}{\FS@head@title}{Sitzungsleitung}%
    \providecaptionname{ngerman}{\FS@minutestaker@title}{Protokoll}%
    \providecaptionname{ngerman}{\FS@excmissing@title}{Entschuldigt Fehlende:}%
    \providecaptionname{ngerman}{\FS@missing@title}{Fehlende:}%
    \providecaptionname{ngerman}{\FS@beginn@title}{Beginn:}%
    \providecaptionname{ngerman}{\FS@ende@title}{Ende:}%
    \providecaptionname{ngerman}{\FS@date@prefix}{vom}%
    \providecaptionname{ngerman}{\FS@minutes@title}{Protokoll}%
    \providecaptionname{ngerman}{\FS@session@title}{Sitzung}%
    \providecaptionname{ngerman}{\FS@session@title}{Sitzung}%
    \providecaptionname{ngerman}{\FS@session@shorttitle}{-Sitzung}%
    \providecaptionname{ngerman}{\FS@session@regular}{ordentlichen}%
    \providecaptionname{ngerman}{\FS@session@special}{außerordentlichen}%
    \providecaptionname{ngerman}{\FS@session@prefix}{der}%
    \providecaptionname{ngerman}{\FS@fsr@prefix}{des}%
    \providecaptionname{ngerman}{\FS@fsr@oldboard}{Alter FSR-Vorstand}%
    \providecaptionname{ngerman}{\FS@fsr@newboard}{Neuer FSR-Vorstand}%
    \providecaptionname{ngerman}{\FS@fsv@prefix}{der}%
    \providecaptionname{ngerman}{\FS@top@abbrev}{TOP}%
    \providecaptionname{ngerman}{\FS@internetslogan}{Alle Protokolle\\im Internet:}%
    \providecaptionname{ngerman}{\FS@constituent}{konstituierenden}%
%
    \providecaptionname{english}{\FS@drafttext}{Draft}%
    \providecaptionname{english}{\FS@attendingmembers@title}{Present members:}%
    \providecaptionname{english}{\FS@attending@title}{Attendees:}%
    \providecaptionname{english}{\FS@attending@titlewithmembers}{Other attendees:}%
    \providecaptionname{english}{\FS@head@title}{Head of the meeting}%
    \providecaptionname{english}{\FS@minutestaker@title}{Keeper of the minutes}%
    \providecaptionname{english}{\FS@excmissing@title}{Absent with valid excuse:}%
    \providecaptionname{english}{\FS@missing@title}{Absent:}%
    \providecaptionname{english}{\FS@beginn@title}{Begin:}%
    \providecaptionname{english}{\FS@ende@title}{End:}%
    \providecaptionname{english}{\FS@date@prefix}{on}%
    \providecaptionname{english}{\FS@minutes@title}{Minutes}%
    \providecaptionname{english}{\FS@session@title}{session}%
    \providecaptionname{english}{\FS@session@shorttitle}{ session}%
    \providecaptionname{english}{\FS@session@regular}{regular}%
    \providecaptionname{english}{\FS@session@special}{special}%
    \providecaptionname{english}{\FS@session@prefix}{of the}%
    \providecaptionname{english}{\FS@fsr@prefix}{of the}%
    \providecaptionname{english}{\FS@fsr@oldboard}{Old FSR board}%
    \providecaptionname{english}{\FS@fsr@newboard}{New FSR board}%
    \providecaptionname{english}{\FS@fsv@prefix}{of the}%
    \providecaptionname{english}{\FS@top@abbrev}{AI}%
    \providecaptionname{english}{\FS@internetslogan}{All minutes\\on the internet:}%
    \providecaptionname{english}{\FS@constituent}{constituent}%
}

\ifFS@draft
    % draft watermark
    \RequirePackage{draftwatermark}
    \SetWatermarkText{\FS@drafttext}
    
    % Use draft mode of KoMa class
    \KOMAoptions{draft}
\fi

% loaded here to overwrite KOMAoption "draft"
\RequirePackage[%               % headers and footers
    draft=false%                % don't show draft info in header/footer
]{scrlayer-scrpage}

\RequirePackage{hyperref}       % links (in document as well as hyperlinks)


%
% Minutes layout
%

\newlength \TOPindent
\setlength \TOPindent{\FS@TOPindent}

\newlength \TOPindentcorrection
\ifFS@wideoverview
    \setlength \TOPindentcorrection{\TOPindent}
\else
    \setlength \TOPindentcorrection{0pt}
\fi

\addtolength{\oddsidemargin}{-\TOPindent}
\addtolength{\textwidth}{\TOPindent}

%%
%% CUSTOM MACROS
%%

\renewcommand*\url[1]{\href{https://#1}{\nolinkurl{#1}}}
% The original command does not work when #1 does not begin with "www".

\newcommand*\mail[1]{\href{mailto:#1}{\nolinkurl{#1}}}

%%
%% Custom Options
%%

\newif\ifkonsti
\konstifalse

\newif\ifuseordentliche
\useordentlichefalse

\newif\ifordentlichesitzung
\ordentlichesitzungtrue

\newif\ifmitgliederliste
\mitgliederlistetrue

\newif\ifleitung
\leitungtrue

\newif\ifunterschrift
\unterschriftfalse

\newif\iffusszeile
\fusszeiletrue

\newif\ifinternet
\internettrue

\newif\ifterminliste
\terminlistetrue

\newif\iftitel
\titeltrue

\newcommand \FS@date           {{\itshape Benutze {\normalfont \texttt{\textbackslash date}}, um das Sitzungsdatum zu setzen.}}
\newcommand \FS@leiter         {{\itshape Benutze {\normalfont \texttt{\textbackslash leiter}}, um den Leiter zu setzen.}}
\newcommand \FS@protokollant   {{\itshape Benutze {\normalfont \texttt{\textbackslash protokollant}}, um den Protokollanten zu setzen.}}
\newcommand \FS@mitglieder     {{\itshape Benutze {\normalfont \texttt{\textbackslash mitglieder}}, um die Mitglieder des Gremiums zu setzen oder nutze {\normalfont\texttt{\textbackslash mitgliederlistefalse}} um diese Zeile nicht anzuzeigen.}}
\newcommand \FS@anwesende      {{\itshape Benutze {\normalfont \texttt{\textbackslash anwesende}}, um die Anwesenden zu setzen.}}
\newcommand \FS@beginn         {{\itshape Benutze {\normalfont \texttt{\textbackslash beginn}}, um die den Beginn zu setzen.}}
\newcommand \FS@ende           {{\itshape Benutze {\normalfont \texttt{\textbackslash Ende}}, um das Ende zu setzen.}}
\newcommand \FS@sitzungsnr     {\texttt{\textbackslash sitzungsnr}}
\newcommand \FS@gremiums       {{\color{red}Wähle über die Option \texttt{gremiumflag=FSR} bzw. \texttt{gremiumflag=FSV} ein Gremium aus oder gib ein anderes an über \texttt{\textbackslash gremiums}}}
\newcommand \FS@oldfsr         {\texttt{\textbackslash oldfsr}}
\newcommand \FS@newfsr         {\texttt{\textbackslash newfsr}}
\newcommand \FS@fehlende       {\texttt{\textbackslash fehlende}}
\newcommand \FS@entfehlende    {\texttt{\textbackslash entfehlende}}


\NewDocumentCommand \leiter {o m} {%
	\renewcommand \FS@leiter {#2}%
	\IfValueT {#1} {%
        \renewcaptionname{\languagename}{\FS@head@title}{#1}%
    }%
}

\NewDocumentCommand \protokollant {o m} {%
	\renewcommand \FS@protokollant {#2}%
	\IfValueT {#1} {%
        \renewcaptionname{\languagename}{\FS@minutestaker@title}{#1}%
    }%
}

\NewDocumentCommand \mitglieder {o m} {%
	\renewcommand{\FS@mitglieder}{#2} %
	\IfValueT {#1} {%
	    \renewcaptionname{\languagename}{\FS@attendingmembers@title}{#1}%
	}%
%	\mitgliederlistetrue %
}
	
\NewDocumentCommand \anwesende {o m} {%
	\renewcommand{\FS@anwesende}{#2}%
	\IfValueT {#1} {%
	    \renewcaptionname{\languagename}{\FS@attending@title}{#1}%
	}%
}

\NewDocumentCommand \entfehlende {o m} {%
	\renewcommand\FS@entfehlende{#2}%
	\IfValueT {#1} {%
	    \renewcaptionname{\languagename}{\FS@excmissing@title}{#1}%
	}%
}
\NewDocumentCommand \fehlende {o m} {%
	\renewcommand\FS@fehlende{#2}%
    \IfValueT {#1} {%
	    \renewcaptionname{\languagename}{\FS@missing@title}{#1}%
	}%
}

\AtBeginDocument{
    \ifmitgliederliste
        \RenewDocumentCommand \anwesende {o m} {%
		    \renewcommand{\FS@anwesende}{#2}%
		    \IfValueT {#1} {%
	            \renewcaptionname{\languagename}{\FS@attending@title}{#1}%
	        }%
	    }
    \fi
}

\renewcommand \date [1]        {\renewcommand{\FS@date}{#1}}
\newcommand \beginn [1]        {\renewcommand{\FS@beginn}{#1}}
\newcommand \Ende [1]          {\renewcommand{\FS@ende}{#1}}
\newcommand \titel [1]         {\renewcommand{\FS@titel}{#1}}
\newcommand \sitzungsnr [1]    {\renewcommand{\FS@sitzungsnr}{#1}}
\newcommand \gremiums [1]      {\renewcommand{\FS@gremiums}{#1}}
\newcommand \oldfsr [1]        {\renewcommand{\FS@oldfsr}{#1}}
\newcommand \newfsr [1]        {\renewcommand{\FS@newfsr}{#1}}
\newcommand \gremiumprefix [1] {\def\FS@gremiumprefix {#1}}


\newcommand \anhang [1] {\newcommand\FS@following{#1}}

%% SEITEN-EINSTELLUNGEN
%% siehe: https://tex.stackexchange.com/questions/541381/how-would-i-go-about-to-get-fold-marks-with-scrartcl
%%

\pagestyle{scrheadings}
\cfoot{
	\iffusszeile
			\footnotesize \FS@titel~\FS@date@prefix~\FS@date\\
	\fi
	Seite \thepage
	}
\ofoot{}
\ifoot{}

\newcommand*\foldmarklength{2mm}
\newcommand*\punchmarklength{4mm}
\newcommand*\markhpos{3.5mm}
\newcommand*\markthickness{.2mm}
\newcommand*\tfoldmarkvpos{.34\paperheight}
\newcommand*\bfoldmarkvpos{.67\paperheight}

\newcommand*\leftmarkline[1]{%
  \parbox[c][\layerheight][b]{\layerwidth}{%
    \hspace*{\markhpos}\rule{#1}{\markthickness}%
}}
\newif\ifFoldmark\Foldmarktrue
\newif\ifPunchmark\Punchmarktrue
\DeclareNewLayer[{
  background,
  innermargin,
  oddpage,% in twoside mode only on odd pages!
  height=\tfoldmarkvpos,
  contents={\ifFoldmark\leftmarkline{\foldmarklength}\fi}
}]{tfoldmark}
\DeclareNewLayer[{
  clone=tfoldmark,
  height=\bfoldmarkvpos
}]{bfoldmark}
\DeclareNewLayer[{
  clone=tfoldmark,
  height=.5\paperheight,
  contents={\ifPunchmark\leftmarkline{\punchmarklength}\fi}
}]{punchmark}

\newlength{\disttobordernorth}
\newlength{\disttobordereast}
\newlength{\logosize}

\setlength{\disttobordernorth}{1cm}
\setlength{\disttobordereast}{1.25cm}
\setlength{\logosize}{28mm}

\DeclareNewLayer[
  foreground,
  align=tr,
  area={\dimexpr \paperwidth-\disttobordereast\relax}{\disttobordernorth}{\logosize}{\logosize},
  contents={%
    \includegraphics[width=\logosize]{fs-logo-transparent.png}
    \ifinternet
        \vspace{1\parskip}
        \begin{flushright}
	    \linespread{0.9}\selectfont
	    \begingroup\footnotesize\hypersetup{urlcolor=black}
	        \FS@internetslogan\\[1ex]
	        \href{https://fsmath.uni-bonn.de}{fsmath.uni-bonn.de}
	        %\url{fsmath.uni-bonn.de}
	    \endgroup
	    \end{flushright}
    \fi
}
]{box-logo}

\DeclareLayer[clone=scrheadings.foot.oneside]{customfoot1}
\DeclareLayer[clone=scrheadings.foot.odd]{customfoot2}
\DeclareLayer[clone=scrheadings.foot.even]{customfoot3}

% add the wanted fold marks to the layer page style(s) used on subsequent pages
\DeclareNewPageStyleByLayers{firstpage}{tfoldmark,bfoldmark,punchmark, customfoot1, customfoot2, customfoot3, box-logo}

%%
%% LAYOUT
%%
%%

% use sans serif font
\renewcommand{\familydefault}{\sfdefault}

% spread lines a bit
\linespread {1.07}\selectfont

% link colors
\hypersetup{%
	colorlinks=true,%
	linkcolor=orange,%
	citecolor=olive,%
	urlcolor=cyan%
}

\DeclareNewSectionCommand[%
    level=1,
    afterskip=-1\parskip,          % Abstand nach dem TOP
    beforeskip=0pt,          % Abstand vor dem TOP
    font=\normalsize,        % Schriftgrösse
    indent=\TOPindent,    % Einrückung des TOPs         
    runin=false,			 % TOP soll freistehen (Text startet also in neuer Zeile)
    tocindent=1.5em,
    toclevel=1,
    tocnumwidth=2.3em,       
    tocstyle=section,
    style=section
]{TOP}

\renewcommand\TOPformat{%
    \FS@top@abbrev~\theTOP:~%
}

\setcounter{TOP}{-1}


%%%
%%% Main Code Part
%%%
\newlength{\termwidth}
\setlength{\termwidth}{\textwidth - 4cm}


\newcommand{\termtable}
{%
\noindent\itshape Also. Um das hier zu ändern, muss das Kommando {\normalfont \texttt{\textbackslash termtable}} erneuert werden.

	\begin{tabular}{rl}
		07.01.2021            & Spieleabend \\
		10.01.2021            & Matheball \\
		17. -- 18.01.2021     & Fachschaftsfahrt \\
		21.01.2021            & Spieleabend \\
		24.--26.01.2021       & KoMa \\
	\end{tabular}
}

\newcommand{\termine}{
	\parbox[t]{\termwidth}{\vspace{1mm}
	{
		\vspace{2.5ex}
		\centerline{\large\bfseries Kommende Termine}}
		\vspace{2ex}
		%\hspace{3ex}
		\linespread{1.3}\selectfont\termtable
		\vspace{2ex}
	}
}


%TEST

\newcommand{\sitzungsbreak}[1]{%
    \begingroup%
        \par\centering\bfseries%
        \rule[0.6ex]{1.5cm}{1pt} #1 \rule[0.6ex]{1.5cm}{1pt}\par%
    \endgroup%
}

\newenvironment{nominationtable} {
    Es werden folgende Personen nominiert:
    \begingroup\par\centering
        \begin{tabular}{llc}\toprule
            Nominiert & Nominiert von & Annahme der Nominierung\\\midrule
}{
            \bottomrule
        \end{tabular}
    \par\endgroup%
}

%\usepackage{forloop}
%\newcounter{ct}

%\newenvironment{electiontable}[1]{%
%    Das Ergebnis der Wahl ist:%
%    \begingroup\par\centering%
%        \begin{tabular}{l *{#1}{c} }\toprule%
%            Kandidierende%
%            \forloop{ct}{1}{\not{\value{ct} > #1}}%
%            {%
%	            & \arabic{ct}. Wahlgang
%            }
%            \\\midrule%
%}{%
%        \bottomrule%
%    \end{tabular}%
%    \par\endgroup%
%}

\newenvironment{antragstable}[1]{%
    \begingroup\par\centering%
        \begin{tabular}{l *{#1}{c} }\toprule%
}{%
        \bottomrule%
        \end{tabular}%
    \par\endgroup%
}


\AtBeginDocument{
    \thispagestyle{firstpage}

    \providecommand{\FS@gremiumprefix}{\texttt{\textbackslash gremiumprefix}}
    \expandafter\ifstrequal\expandafter{\FS@gremium}{FSR}{%
        \def\FS@gremiumprefix{\FS@fsr@prefix}%
        \gremiums{FSR}%
        \unterschrifttrue%
    }{}
    \expandafter\ifstrequal\expandafter{\FS@gremium}{FSV}{%
        \def\FS@gremiumprefix{\FS@fsv@prefix}%
        \gremiums{FSV}%
        \unterschrifttrue%
    }{}

	\ifdefined\FS@titel
	\else
	  \ifkonsti
	    \newcommand \FS@titel {\FS@minutes@title{} \FS@session@prefix{} \FS@constituent{} \FS@gremiums\FS@session@shorttitle}
	  \else
	      \ifuseordentliche
            \ifordentlichesitzung
              \newcommand \FS@sitzungsart {\FS@session@regular}
            \else
              \newcommand \FS@sitzungsart {\FS@session@special}
            \fi
            \newcommand \FS@titel {\FS@minutes@title{} \FS@session@prefix{} \FS@sitzungsnr.~\FS@sitzungsart\ \FS@session@title{} \FS@gremiumprefix\ \FS@gremiums}
          \else
            \newcommand \FS@titel {\FS@minutes@title{} \FS@session@prefix{} \FS@gremiums\FS@session@shorttitle{}}
          \fi
      \fi
	\fi
	
	\noindent
	\ifterminliste
		{
		\setlength \fboxrule {1pt}
		\fbox{\termine}
		}
	\fi
%	\logobox
	\vspace{1cm}
	
	\ifFS@raggedtitle \def \FS@titleformatting {\raggedright}
    \else \def \FS@titleformatting {}
    \fi
	\begin{addmargin}[\TOPindent]{0cm}
	    % formerly: \textwidth - \TOPindentcorrection
		\parbox[t]{\dimexpr%
		            % Actual width of the line:
		            \paperwidth - \oddsidemargin - \logosize - \disttobordereast + \TOPindent
		            % add some spacing from the Logo
		            - 0.5\disttobordereast%
		            \relax}{\Large\bfseries\FS@titleformatting%
		\FS@titel~\FS@date@prefix~\FS@date}

		\vspace{2\baselineskip}
		{\def\arraystretch{1.2}
		\noindent\begin{tabularx}{\textwidth - \TOPindentcorrection}{@{}>{\bfseries}lX@{}}
			\FS@beginn@title    & \FS@beginn \\[1ex]
			\FS@ende@title      & \FS@ende \\[1ex]
			\ifmitgliederliste
				\FS@attendingmembers@title		& \FS@mitglieder \\[1ex]
			\fi
			\FS@attending@title			    & \FS@anwesende \\[1ex]
			\ifdefined\FS@entfehlende
				\FS@excmissing@title	& \FS@entfehlende \\[1ex]
			\fi
			\ifdefined\FS@fehlende
				\FS@missing@title	& \FS@fehlende \\[1ex]
			\fi
			\ifleitung
				\FS@head@title:	            & \FS@leiter\\[1ex]
				\FS@minutestaker@title:			& \FS@protokollant\\[1ex]
			\fi
		\end{tabularx}
		}
		\vspace{\baselineskip}
	\end{addmargin}
	
	
}

\AtEndDocument{
\ifunterschrift
    \ifleitung
        \vspace{2cm}
        \begin{addmargin}[\TOPindent]{0cm}
        \begin{tabularx}{\textwidth}{Xp{2cm}X@{}}
        	\cmidrule{1-1}\cmidrule{3-3}
        	   \scriptsize\parbox[t]{\linewidth}{\FS@leiter}
        	&& \scriptsize\parbox[t]{\linewidth}{\FS@protokollant} \\
        	   \scriptsize \FS@head@title
        	&& \scriptsize \FS@minutestaker@title\\
        \end{tabularx}
        \ifkonsti
            \\[2cm]
            \begin{tabularx}{\textwidth}{Xp{2cm}X@{}}
            	\cmidrule{1-1}\cmidrule{3-3}
            	   \scriptsize\parbox[t]{\linewidth}{\FS@oldfsr}
                && \scriptsize\parbox[t]{\linewidth}{\FS@newfsr} \\
            	   \scriptsize \FS@fsr@oldboard
            	&& \scriptsize\FS@fsr@newboard\\
            \end{tabularx}
        \fi
        \end{addmargin}
    \fi
\fi



%reverse indentation as there are no TOPs in the appendix
\clearpage
\addtolength{\oddsidemargin}{\TOPindent}
\addtolength{\textwidth}{-\TOPindent}

\ifdefined\FS@following
	\FS@following
\fi
}
