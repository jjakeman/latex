\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uq-report}[11/24/2018 v0.1 report article class]

% Passes and class options to the underlying article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\newif\ifmy@logo
\DeclareOption{logo}{\my@logotrue}
\DeclareOption{nologo}{\my@logofalse}
\ExecuteOptions{nologo}
\newif\ifmy@widepage
\DeclareOption{widepage}{\my@widepagetrue}
\DeclareOption{standardpage}{\my@widepagefalse}
\ExecuteOptions{widepage}
\newif\ifmy@titlepageheader
\DeclareOption{titlepageheader}{\my@titlepageheadertrue}
\DeclareOption{notitlepageheader}{\my@titlepageheaderfalse}
\ExecuteOptions{titlepageheader}
\ProcessOptions\relax
\ProcessOptions


% Load LaTeX's article class with the `twoside option
\LoadClass[twoside]{article}

% Redefine the page margins
% TODO: Adjust margins to your liking
\ifmy@widepage
\RequirePackage[left=1.0in, right=1.0in, top=1.0in,
bottom=1.0in]{geometry}
\else
\RequirePackage[left=3.0cm, right=3.0cm, top=3.0cm,
bottom=3.0cm]{geometry}
\fi

% Remove the numbers from all the headings (\section, \subsection, etc.)
%\setcounter{secnumdepth}{-1}

% Define colors
\RequirePackage[table]{xcolor}
\definecolor{darkblue}{RGB}{39, 92, 115}
\definecolor{lightblue}{RGB}{78,184,210}
\definecolor{midblue}{RGB}{54,125,155}

\ifmy@titlepageheader
\definecolor{titlepagetext}{RGB}{255,255,255}%white
\else
\definecolor{titlepagetext}{RGB}{39, 92, 115}%darkblue
\fi

% Color section headings
\RequirePackage{sectsty}
\sectionfont{\color{midblue}}
\subsectionfont{\color{midblue}}
\subsubsectionfont{\color{midblue}}

% Color caption and table labels, e.g. Figure 1:
\RequirePackage{subcaption}
\captionsetup[figure]{labelfont={color=midblue}}
\captionsetup[table]{labelfont={color=midblue},position=top}

\newcommand*\samethanks[1][\value{footnote}]{\footnotemark[#1]}

\newcommand\@shortauthor{}
% define \theshortauthor to what is given
\newcommand\shortauthor[1]{\renewcommand\@shortauthor{#1}}


\RequirePackage{fancyhdr}% http://ctan.org/pkg/fancyhdr

\renewenvironment{abstract}{%
\begin{flushleft}
\begin{minipage}{0.625\textwidth}
\abstractname\par\rule{\textwidth}{1pt}}
{\par\noindent\rule{\textwidth}{1pt}\end{minipage}\hspace{0.04\textwidth}
\begin{minipage}{0.325\textwidth}
{\color{midblue} \large\textsc{Article Info}}\par
  \rule{\textwidth}{1pt}\par
{\color{darkblue}Correspondence:}\par 
{\@corauthor\par \@coremail}\\\\
\ifx\@funding\@notempty
{\color{darkblue}Disclosure:}\par \@funding\\\\
\fi
{\color{darkblue}Keywords:}\par \@keywords\par
\rule{\textwidth}{1pt}\par
\end{minipage}
\end{flushleft}
\vspace{.1cm}
{\color{gray}\hrule height 2pt}}

\setlength{\headheight}{21pt}%
\fancypagestyle{uqheader}{%
  \fancyhf{}% Clear all headers/footers
  \fancyhead[LO]{\raisebox{-.5\baselineskip}[0pt][0pt]{\bf \color{midblue} \@shorttitle}}
  \fancyhead[LE]{\raisebox{-.5\baselineskip}[0pt][0pt]{\bf \color{midblue} \thepage}}
  \fancyhead[RE]{\raisebox{-.5\baselineskip}[0pt][0pt]{\bf \color{midblue} \@shortauthor}}
  \fancyhead[RO]{\raisebox{-.5\baselineskip}[0pt][0pt]{\bf \color{midblue} \thepage}}
  \renewcommand{\headrulewidth}{2pt}% 2pt header rule
  \renewcommand{\headrule}{\hbox to\headwidth{%
    \color{gray}\leaders\hrule height \headrulewidth\hfill}}
  \renewcommand{\footrulewidth}{0pt}% No footer rule
}

% Define style of embedded code boxes
\RequirePackage[most]{tcolorbox}
\tcbuselibrary{listings,skins}
\usetikzlibrary{positioning}

\lstdefinestyle{mycodestyle}{
language=C++,
%backgroundcolor=\color{gray!20!white},
basicstyle=\footnotesize,
keywordstyle=\color{blue},
                stringstyle=\color{red},
                commentstyle=\color{red},
                morecomment=[l][\color{magenta}]{\#},
}

\newtcblisting{codelisting}[2][]{
    arc=0pt, outer arc=0pt,
    listing only, 
    listing style=mycodestyle,
    title=\Large#2,
    colbacktitle=gray!60,
    title style={left color=darkblue, right color=lightblue!70, shading angle=45},
interior style={left color=gray!20,right color=white,shading angle=135},
enhanced, drop shadow,
    #1
  }

\newcommand\@reportname{}
\newcommand\reportname[1]{\renewcommand\@reportname{#1}}

\newcommand\@website{}
\newcommand\website[1]{\renewcommand\@website{#1}}

\newcommand\@logofigright{}
\newcommand\logofigright[1]{\renewcommand\@logofigright{#1}}


\newcommand\@logofigleft{}
\newcommand\logofigleft[1]{\renewcommand\@logofigleft{#1}}

\newcommand\@shorttitle{}
\newcommand\shorttitle[1]{\renewcommand\@shorttitle{#1}}

\newcommand\@funding{}
\newcommand\funding[1]{\renewcommand\@funding{#1}}

\newcommand\@corauthor{}
\newcommand\corauthor[1]{\renewcommand\@corauthor{#1}}

\newcommand\@coremail{}
\newcommand\coremail[1]{\renewcommand\@coremail{#1}}

\newcommand\@keywords{}
\newcommand\keywords[1]{\renewcommand\@keywords{#1}}

\newcommand\nomarkfootnote[1]{%
  \let\thefootnote\relax\footnotetext{#1}%
  \let\thefootnote\svthefootnote%
}

\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
    \ifmy@logo
    \def\headerbarwidth{0.525\paperwidth}
\else
\def\headerbarwidth{1\textwidth}
\fi

\begin{tikzpicture}[remember picture,overlay]
  \coordinate [below=3.5cm] (midpoint) at (current page.north);%jj
\ifmy@titlepageheader
\node [name=outercolourbar,
anchor=base,
rectangle, left color=darkblue, right color =darkblue!40,
text = white,
minimum width=\headerbarwidth,%jj
minimum height=3.1cm,%jj
text width=\headerbarwidth] at (midpoint) {};
\node [name=colourbar,
anchor=base,
rectangle,left color=darkblue, right color=lightblue!70,
shading = axis,shading angle=45,
text = white,
minimum width=\headerbarwidth,%%jj
minimum height=2.8cm,%%jj
text width=\headerbarwidth,] at (midpoint) {};
\fi
\ifx\@website\@empty
\def\reportnamegap{-.25cm}
\def\reportnamefontsize{\Huge}
\else
\def\reportnamegap{-0.75cm}
\def\reportnamefontsize{\LARGE}
\fi
\node [below=\reportnamegap of midpoint, name=reportname,text = white, text width=0.8\paperwidth, align=flush center]  {
  %{\LARGE\bf \color{titlepagetext}\@title}%
  \textsc{\reportnamefontsize\color{titlepagetext} \@reportname}%
  %bf does not work with textsc it stops textsc from being applied
};
\node [below=.25cm of reportname, name=website,text = white, text width=0.8\paperwidth, align=flush center]  {
  \color{titlepagetext} \@website%
};
\ifmy@logo
% Define the point where the logo will go
\coordinate [right=0.44\textwidth] (logo) at (midpoint.east);%jj
% Set coordinate system origin
\begin{scope}[shift=(logo)]
  % Include the logo
\node {\includegraphics[width=3cm]{\@logofigright}};
\end{scope}
\coordinate [left=0.44\textwidth] (logoleft) at (midpoint.west);%jj
% Set coordinate system origin
\begin{scope}[shift=(logoleft)]
  % Include the logo
\node {\includegraphics[width=3cm]{\@logofigleft}};
\end{scope}
\fi

\end{tikzpicture}

\vspace{1cm}
{\color{gray}\hrule height 2pt}
\vskip .75cm
\begin{flushleft}
  {
  %\color{gray}
    {\LARGE\@title\par}
    \vskip .3cm
    {\normalsize \@author\par}
  }
\end{flushleft}
  \end{center}%
  \par
  \vskip 0cm% shift abstract
}

\usepackage{amsthm}
\renewenvironment{proof}{{\bfseries {\color{midblue}Proof}}}{\qed}
% declare a new theorem style
\newtheoremstyle{mystyle}%
{3pt}% Space above
{3pt}% Space below 
{\itshape}% Body font
{}% Indent amount
{\bfseries\color{midblue}}% Theorem head font
{.}% Punctuation after theorem head
{.5em}% Space after theorem head 
{}% Theorem head spec (can be left empty, meaning ‘normal’)
\theoremstyle{mystyle}

\usepackage{enumitem}
\setlist[itemize]{label=\textcolor{midblue}{\textbullet}}
\setlist[enumerate]{label=\textcolor{midblue}{\bf \theenumi.}}

%\newcommand{\keywords}[1]{{{\small\bfseries{\color{darkblue}Keywords.}} #1}}
\newcommand{\amsid}[1]{{{\small\bfseries{\color{darkblue}AMS
      classifications.}} #1}}
\renewcommand*\abstractname{{\color{midblue} \large\textsc{Abstract}}}

\newtheorem{lemma}{Lemma}
\numberwithin{lemma}{section} % make lemma have section number in numbering

\newtheorem{definition}{Definition}
%\numberwithin{definition}{section} % make definition have section number in numbering

\newtheorem{remark}{Remark}
\numberwithin{remark}{section} % make remark have section number in numbering

\newtheorem{assumption}{Assumption}
\endinput
