% Anecdote Class
%
% A memoir-based documentclass with a contemporary style for books with a lighter content.
%
% https://github.com/profound-labs/anecdote
%
% http://profound-labs.github.io/projects/anecdote/
%
% (c) Gambhiro Bhikkhu, 2017
% gambhiro.bhikkhu.85@gmail.com
%
% LPPL LaTeX Pubic Project Licence
%

% TODO: document interfaces
% TODO: test document to compile

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anecdote}[2017/08/19 v0.11 A memoir-based documentclass with a contemporary style for books.]

% ========================
% Preliminary Declarations
% ========================

\newif\ifdesktopversion
\desktopversionfalse

\newif\ifoverleaf
\overleaffalse

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /BOOK/.cd,
  babelLanguage/.default=british,
  babelLanguage/.store in=\BOOK@babelLanguage,
  desktopVersion/.code=\desktopversiontrue,
  overleaf/.code=\overleaftrue,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/BOOK}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

\LoadClass[11pt,twoside]{memoir}

% \raggedbottom stops these warnings:
%
% Underfull \vbox (badness 10000) has occurred while \output is active
%
% by not streching the glue in vertical spaces, such as before and after chapter
% and section headings. The bottom of the pages will be uneven.
%
% Default is \flushbottom. The small streches are good because an even page
% bottom is better. When it causes large streches, it is better to put in
% a \clearpage manually.
%
% NOTE use the 'bottom' footmisc option when using \raggedbottom.

% NOTE Using \raggedbottom in this book. There are many quotes and the pages
% frequently have to break early anyway.
\raggedbottom

% \raggedbottomsection only affects pages where the section header was moved to
% the next page.

\raggedbottomsection

% === Color Profile ===

% Embed a color profile in the PDF for correctly interpreting CMYK images.

% \ifoverleaf\relax
% \else
% 
% \immediate\pdfobj stream attr{/N 4} file{assets/other/UncoatedFOGRA29.icc}
% \pdfcatalog{%
%   /OutputIntents [ <<
%   /Type /OutputIntent
%   /S/GTS_PDFX
%   /DestOutputProfile \the\pdflastobj\space 0 R
%   /OutputConditionIdentifier (Uncoated FOGRA29 (ISO 12647-2:2004))
%   /Info(Uncoated FOGRA29 (ISO 12647-2:2004))
%   /RegistryName (http://www.color.org/)
%   >> ]
% }
% 
% \fi

% === Book Core ===

%\RequirePackage{silence}
%\WarningsOff

\RequirePackage[\BOOK@babelLanguage]{babel}
\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage[geometry]{ifsym}
\RequirePackage{textcomp}
% Don't use the [cmyk] option. Specify the color model in the color definitions.
\RequirePackage{xcolor}
\RequirePackage{xcoffins}
\RequirePackage{graphicx}
% Add your \graphicspath declaration to your local style.
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{footnote}
\RequirePackage{ifthen}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{longtable}
\RequirePackage{environ}
\RequirePackage{pageslts}
\RequirePackage{array}
\RequirePackage{ragged2e}

\RequirePackage{tikz}
\usetikzlibrary{positioning}

% === Define colors ===

% Define text colors as Gray color values.
\definecolor{textbody}{gray}{0.05}% 95% is good for contrast, on yellowish paper it is not harsh.
\definecolor{footnoterule}{gray}{0.5}
\definecolor{header}{gray}{0.2}
\definecolor{footer}{gray}{0.3}
\definecolor{chapternum}{gray}{0.8}
\definecolor{chaptertitle}{gray}{0.3}
\definecolor{chaptertitlefootnote}{gray}{0.4}
\definecolor{chapterauthor}{gray}{0.3}
\definecolor{chapternote}{gray}{0.3}
\definecolor{section}{gray}{0.2}
\definecolor{tocleftside}{gray}{0.5}
\definecolor{tocleftsidepart}{gray}{0.2}
\definecolor{partname}{gray}{0.5}
\definecolor{parttitle}{gray}{0.3}
\definecolor{linkborder}{rgb}{0.4,0.4,1}% light blue
\definecolor{link}{rgb}{0.2,0.2,1}% not so light blue

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{ Ligatures={TeX}, Path = {./assets/fonts/}, }

% If -- dashes don't work for your font, try
% Renderer = Basic
% http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

\setmainfont[
  ItalicFont = EBGaramond12-Italic.otf,
  %BoldFont = GenBkBasB.ttf,
  %BoldItalicFont = GenBkBasBI.ttf,
  Contextuals = NoAlternate,% Disables long tail Q, as in Queen
]{EBGaramond12-Regular.otf}

\newfontfamily\crimsonRomanFont[
  SmallCapsFeatures= { LetterSpace = 0.2 },
  BoldFont = Crimson-Semibold.otf,
  ItalicFont = Crimson-Italic.otf,
]{Crimson-Roman.otf}

\newfontfamily\merriweatherSansFont[
  ItalicFont = MerriweatherSans-Italic.otf,
]{MerriweatherSans-Regular.otf}

\newfontfamily\merriweatherSansLightFont[
  ItalicFont = MerriweatherSans-LightItalic.otf,
]{MerriweatherSans-Light.otf}

\newfontfamily\alegreyaSansLightFont[
  ItalicFont = Alegreya-Italic.otf,
]{AlegreyaSansX-Light.ttf}

\newfontfamily\tocBackmatterFont[
  ItalicFont = AlegreyaSans-LightItalic.ttf,
]{AlegreyaSansX-Light.ttf}

%\newfontfamily\AlegreyaSansThinFont[
%  ItalicFont = AlegreyaSans-ThinItalic.otf,
%]{AlegreyaSans-Thin.otf}

% header and footer

\newcommand\headerFont\alegreyaSansLightFont
\newcommand\footerFont\alegreyaSansLightFont
\newcommand\pageNumFont\merriweatherSansFont

% chapter and section

\newcommand\partTitleFont\alegreyaSansLightFont

\newcommand\chapterNameFont\alegreyaSansLightFont
\newcommand\chapterTitleFont\alegreyaSansLightFont
\newcommand\chapterNumberFont\merriweatherSansLightFont
\newcommand\chapterAuthorFont\alegreyaSansLightFont
\newcommand\chapterNoteFont\alegreyaSansLightFont

\newcommand\sectionFont\alegreyaSansLightFont

% quote

\newcommand\sideruleQuoteFont\alegreyaSansLightFont

% toc

\newcommand\tocFont\alegreyaSansLightFont
\newcommand\tocFontOldNum\alegreyaSansLightFont

\newcommand\tocPageNumFont\merriweatherSansLightFont

\newcommand\tocChapterFont\alegreyaSansLightFont
\newcommand\tocChapterNoteFont\alegreyaSansLightFont

% Some default font sizes, use \renewcommand to adjust

\newcommand{\chapterNameSize}{\@setfontsize          \chapterNameSize          {22}{24}}
\newcommand{\chapterNumberSize}{\@setfontsize        \chapterNumberSize        {38}{38}}
\newcommand{\chapterTitleSize}{\@setfontsize         \chapterTitleSize         {17}{19}}
\newcommand{\chapterTitleFootnoteSize}{\@setfontsize \chapterTitleFootnoteSize {16}{30}}
\newcommand{\chapterAuthorSize}{\@setfontsize        \chapterAuthorSize        {12}{14}}
\newcommand{\chapterNoteSize}{\@setfontsize          \chapterNoteSize          {10}{13}}
\newcommand{\footerSize}{\@setfontsize               \footerSize               {7}{8}}
\newcommand{\headerSize}{\@setfontsize               \headerSize               {7}{8}}
\newcommand{\pageNumSize}{\@setfontsize              \pageNumSize              {9}{9}}

\newcommand{\smaller}{\@setfontsize\smaller{9}{11}}

\newcommand{\copyrightsize}{\@setfontsize\copyrightsize{9}{11}}

\newcommand{\urlsize}{\@setfontsize\urlsize{6.8}{7}}

% foreign language wrappers

\newfontfamily\thaiFont{Kinnari.ttf}

\newcommand*\thai[1]{{\thaiFont #1}}

% === microtype ===

\RequirePackage[final,babel=true]{microtype}

\SetTracking[spacing={400,100,}]{encoding=*, family={AlegreyaSansX-Light.ttf}}{20}
\SetTracking[spacing={400,100,}]{encoding=*, family={EBGaramond12-Regular.otf}}{20}

% === hyperref ===

\RequirePackage{hyperxmp}
\RequirePackage{hyperref}

% https://tex.stackexchange.com/questions/32076/incorrect-toc-index-cross-references-when-resetting-memoir-class-counters
% hypertexnames=true

\hypersetup{
  unicode=true,
  bookmarksopen=true,
  bookmarksopenlevel=3,
  hypertexnames=true,
  linktocpage=true,
  plainpages=false,
  breaklinks
}

\ifdesktopversion
% Colors: in the desktop version, use colored link text
\hypersetup{
  colorlinks=true,
  linkcolor=link,
  citecolor=link,
  filecolor=link,
  urlcolor=link,
}
\else
% Colors: in the print version, set link colors to text color, so that it doesn't interfere with printing
\hypersetup{
  colorlinks=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody,
}
\fi

\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% How to reset chapter and section counter with \part
% https://tex.stackexchange.com/questions/54383/how-to-reset-chapter-and-section-counter-with-part
\@addtoreset{chapter}{part}

% === penalties and hyphenation ===

% memoir's more allowing penalties
\midsloppy

\ifthenelse{\equal{\BOOK@babelLanguage}{british}}{
  \renewcommand\britishhyphenmins{{3}{3}}
  \addto\captionsbritish{
    \renewcommand{\bibname}{References}
  }
}{}
\ifthenelse{\equal{\BOOK@babelLanguage}{italian}}{
  \renewcommand\italianhyphenmins{{3}{3}}
}{}
\ifthenelse{\equal{\BOOK@babelLanguage}{portuguese}}{
  \renewcommand\portuguesehyphenmins{{3}{3}}
  % If using babel, captions names have to be renamed like this
  \addto\captionsportuguese{
    \renewcommand{\contentsname}{Índice}
    \renewcommand{\bibname}{Referências}
  }
  % Portuguese repeats hyphen
  % http://tex.stackexchange.com/a/247298/831
  % generates a hyphen that will repeat on a new line
  \defineshorthand{"-}{\babelhyphen{repeat}}
}{}

\hyphenpenalty=700
\exhyphenpenalty=50
\doublehyphendemerits=900
%\finalhyphendemerits=5000 % default is 5000

% It is more effective to \mbox{...} the words to avoid hyphenation.
\brokenpenalty=5000 % penalty for page break after a hyphenated line

\RequirePackage[defaultlines=2,all]{nowidow}

% === common hyphenation exceptions and corrections ===

\hyphenation{season wisdom develop-ment respon-sible pheno-mena
philo-sophical munindo amaravati thai-land}

%\hyphenation{accur-ately argu-men-ta-tive attach Ayu-dhaya becomes
%ben-e-fi-cial capa-bil-ity car-ry car-ry-ing cere-monies cere-mony
%ces-sa-tion chal-lenge chal-leng-ing clas-si-fi-ca-tion
%clas-si-fi-ca-tions clas-si-fied com-mu-nity con-di-tion
%con-di-tioned con-struc-tions con-tem-plate con-tem-plat-ing
%con-tem-pla-tion cul-ti-vate cul-ti-vates cul-ti-vat-ing
%cul-ti-vation def-i-ni-tion de-ter-mine de-ter-mined dhamma dhammas
%dis-cern-ment dis-con-tent dis-cur-sive dying em-pha-size
%enlight-ened equa-nim-ity es-pe-cial-ly estab-lish exist-ence
%ex-pe-ri-ence hap-pen-ing having ig-no-rance immedi-ately
%im-per-ma-nent in-nu-mer-a-ble in-se-cu-ri-ty in-spir-ing
%in-struct-ed in-ves-ti-gate in-ves-ti-ga-tion iso-late iso-lat-ed
%Keuan lay-peo-ple ma-te-ri-al mat-u-ra-tion medi-tate medi-ta-tion
%medi-ta-tive mental mon-as-teries mon-as-tery Nana-chat or-dain
%or-dain-ed or-di-na-tion orig-inate oth-er-wise pene-trat-ing
%per-son-al per-son-al-ity phe-nom-e-na phe-nom-e-non po-si-tion
%pow-er pow-ers pre-vi-ous pro-lif-er-ate pro-lif-er-ating
%pro-lif-er-a-tions puthu-jjana quest-ion rec-i-ta-tion
%sat-is-fac-tory sen-sa-tion sen-sa-tions sim-i-lar suf-fer-ing
%sup-po-si-tion syn-on-y-mous tem-per-a-ment tem-per-a-ments tong-rat
%tran-scend tran-scend-ent tran-scends un-con-di-tioned under-stand
%under-stood un-hap-pi-ness un-sat-is-fac-tori-ness un-sat-is-fac-tory
%ven-er-able wea-ri-ness what-ev-er when-ever wher-ever whole-hearted
%whole-heart-edly wrong-do-ing}

% === soul settings ===

\sodef\soTocChapter{}{.1em}{.5em plus.1em}{.1em plus.1em minus.1em}
\sodef\soSection{}{.07em}{.4em plus.1em}{.1em plus.1em minus.1em}

% Use \textls letterspacing (for uppercase chapter titles for example)
% with microtype instead, because soul swallows
% accented characters at the end of words.

% === Custom commands and environments ===

% https://tex.stackexchange.com/questions/4839/raggedleft-paragraph-in-a-table

% Use with: \begin{tabular}{L{30mm}R{30mm}}

\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

% Allows hyphenation:
% \newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}}p{#1}}
% \newcolumntype{R}[1]{>{\RaggedLeft\hspace{0pt}}p{#1}}

\newcommand\dividerRule{%
{\centering\bigskip
{\color[gray]{0.6}\rule{0.6\linewidth}{0.2pt}}
\par\bigskip}%
}

\newcommand\emptysheet{%
  \cleardoublepage
  \thispagestyle{empty}\mbox{}\newpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand\emptydoublepage\emptysheet

\newcommand\emptypage{%
  \clearpage
  \thispagestyle{empty}\mbox{}\newpage
}

\newcommand{\emptyUntilEven}{%
  \ifodd\thepage%
  \clearpage\thispagestyle{empty}\null%
  \fi%
}

\newcounter{pageRem}
\newcounter{origPage}

% Add empty pages for a total page count divisible by 8 without remainder.
\newcommand{\emptyUntilModEight}{%
  \setcounter{origPage}{\theCurrentPage}%
  \setcounter{pageRem}{1 + 8 - ( \theCurrentPage - ( ( \theCurrentPage / 8 ) * 8) )}%
  %\typeout{hey: \theCurrentPage, \theorigPage, \thepageRem}% NOTE only for debugging
  \loop%
    \addtocounter{pageRem}{-1}%
  \ifnum\thepageRem>0%
    \clearpage%
    \thispagestyle{empty}\mbox{}%
    %hey \theorigPage \space \thepageRem% NOTE only for debugging
  \repeat%
}

\newcommand*{\subtitle}[1]{\def\@thesubtitle{#1}}
\newcommand*{\editionInfo}[1]{\def\@theEditionInfo{#1}}
\newcommand*{\digitalEditionInfo}[1]{\def\@theDigitalEditionInfo{#1}}
\newcommand*{\printedByInfo}[1]{\def\@thePrintedByInfo{#1}}
\newcommand*{\publisher}[1]{\def\@thePublisher{#1}}
\newcommand*{\ISBN}[1]{\def\@theISBN{#1}}

\newcommand\thesubtitle{\@thesubtitle}
\newcommand\theEditionInfo{\@theEditionInfo}
\newcommand\theDigitalEditionInfo{\@theDigitalEditionInfo}
\newcommand\thePrintedByInfo{\@thePrintedByInfo}
\newcommand\thePublisher{\@thePublisher}
\newcommand\theISBN{\@theISBN}

\newsavebox{\quotepagebox}
\newenvironment{quotepage}[1]
  {\begin{lrbox}{\quotepagebox}\begin{minipage}{#1}
   \setlength{\parskip}{0.6\baselineskip}
   \setlength{\parindent}{0pt}}
  {\end{minipage}\end{lrbox}%
   \begin{tikzpicture}[remember picture,overlay]
   \node at (current page.center) {\usebox{\quotepagebox}};
   \end{tikzpicture}}

\newenvironment{packeditemize}%
{\begin{itemize}[
  itemindent=0pt,
  leftmargin=15pt,
  rightmargin=0pt,
  itemsep=4pt,
  topsep=0pt,
  parsep=0pt,
  partopsep=0pt,
]%
}{\end{itemize}}

\newcommand\speakerName[1]{%
  % The hangindent only works with alternating speakers.
  %\par\hangindent=1pc%
  {\color[gray]{0.25}\crimsonRomanFont\scshape\MakeLowercase{#1}}\quad}

\newlength\qw
\setlength\qw{17pt}% same as parindent for smallpage

\newcommand{\question}[1]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \ifthenelse{\equal{#1}{}}{\textit{Q:}\space}{\textit{#1}\space}%
}

\newcommand{\questionBi}[2]{%
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #1}
  \smallskip%
  \par\noindent\hangindent=\qw%
  \textit{Q: #2}
}

\newcommand{\answer}[1]{%
  \smallskip%
  \par\noindent%
  \ifthenelse{\equal{#1}{}}{\textit{A:}\space}{\textit{#1}\space}%
}

% If class option desktopVersion is used, show content in a paper sized
% minipage, empty page otherwise.
% Redefine \color{desktopcoverbg} to change page background color.
\newcommand\desktopCover[1]{%
\thispagestyle{empty}\mbox{}
\ifdesktopversion
\AddToShipoutPictureFG*{\put(0,0){%
\begin{minipage}[b][\paperheight][c]{\paperwidth}%
#1
\end{minipage}}}
\fi
\clearpage
}

% === titlepage ===

\newlength{\titleLength}
\newlength{\xheight}

% === quotes ===

\newlength{\quoteMargin}
\setlength{\quoteMargin}{18pt}

% FIXME
%\setlength{\footnotemargin}{\quoteMargin}

\newenvironment{openingVerse}%
{%
  \cleartoverso%
  \thispagestyle{empty}%
  \mbox{}\vfill%
  \begin{verse}%
}%
{%
  \par\end{verse}%
  \vfill\mbox{}%
}

% for sutta verses and other short stanzas
\renewenvironment{verse}
{\begin{centering}%
    \itshape}%
{\par\end{centering}}

\newcommand{\verseRef}[1]{%
  {\centering\itshape\footnotesize #1\par}%
}

% for short quotes
\renewenvironment{quote}%
{\list{}{%
    \raggedright
    \itshape
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        8pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

% for longer sutta and book quotes
\renewenvironment{quotation}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   0pt
    \parsep        8pt
    \topsep        8pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newcommand{\quoteTitle}[1]{%
  {%
    \centering\upshape%
    \sectionFont\fontsize{8}{10}\selectfont%
    \color{section}%
    \textls{\MakeUppercase{#1}}%
    \par%
  }%
}

\newcommand{\quoteRef}[1]{%
  {\smallskip\itshape\footnotesize #1\par}%
}

\newcommand{\quoteRefInline}[1]{%
  {\hfill\itshape\footnotesize #1}%
}

\newcommand{\noteRef}[1]{%
  {\raggedleft\fontsize{8}{8}\selectfont #1\par}
}

\newenvironment{speaker}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    \quoteMargin
    \rightmargin   \quoteMargin
    \parsep        8pt
    \topsep        0pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newenvironment{image}%
{\list{}{%
    \centering
    \listparindent 0pt
    \itemindent    \listparindent
    \leftmargin    0pt
    \rightmargin   0pt
    \parsep        8pt
    \topsep        8pt
    \partopsep     0pt}%
\item[]}%
{\endlist}

\newlength{\quoteRuleWidth}
\newlength{\quoteTopBotSep}
\newlength{\quoteHeight}

\setlength{\quoteTopBotSep}{15pt}

\newcommand{\sideruleQuoteFmt}[1]{%
  \begin{minipage}{\linewidth - 40pt}%
    \sideruleQuoteFont\Large\color[gray]{0.2}%
    #1%
  \end{minipage}%
}

\definecolor{quoteRuleFill}{gray}{0.95}
\definecolor{quoteRule}{gray}{0.7}

% #1: quote rule width
\NewEnviron{siderule-quote}[1][8pt]%
{%
  \setlength{\quoteRuleWidth}{#1}%
  \settototalheight{\quoteHeight}{\sideruleQuoteFmt{\BODY}}%
  \begin{tikzpicture}%
    \node (box) [draw=none, rectangle,
    minimum width={\linewidth - \quoteRuleWidth},
    minimum height={\quoteHeight + 2\quoteTopBotSep},
    inner sep=0pt, fill=quoteRuleFill] {};
    %
    \node (a) [above left=0pt and 0pt of box.north west] {};
    \node (b) [below left=0pt and 0pt of box.south west] {};
    %
    \draw [line width=\quoteRuleWidth, draw=quoteRule] (a) -- (b);
    %
    \node (quote) [below right=\quoteTopBotSep and {20pt - 0.5\quoteRuleWidth} of box.north west,
                   anchor=north west, draw=none, inner sep=0pt] {%
      \sideruleQuoteFmt{\BODY}%
    };
  \end{tikzpicture}%
}

\newlength{\diaItemIndent}
\setlength{\diaItemIndent}{-\quoteMargin}
\newlength{\diaLeftMargin}
\setlength{\diaLeftMargin}{2\quoteMargin}

\newenvironment{dialogue}%
{\list{}{%
    \listparindent 0pt
    \itemindent    \diaItemIndent
    \leftmargin    \diaLeftMargin
    \rightmargin   0pt
    \parsep        4pt
    \topsep        0pt
    \partopsep     0pt}%
\relax}%
{\endlist}

\newcommand\photoFullBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \includegraphics[height={\paperheight + 6mm}]{#1}%
    }%
  }%
}

\newcommand\photoSideBleed[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \includegraphics[width={\paperwidth + 6mm}]{#1}%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoSideBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \color[gray]{0.8}%
        \rule{\paperwidth + 6mm}{0.5\paperheight}%
      \end{minipage}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{0mm}){%
      \begin{minipage}[b][\paperheight][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

\newcommand\photoFullBleedPlaceholder[1]{%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \color[gray]{0.8}%
      \rule{\paperwidth + 6mm}{\paperheight + 6mm}%
    }%
  }%
  \AddToShipoutPictureFG*{%
    \put(\LenToUnit{-3mm},\LenToUnit{-3mm}){%
      \begin{minipage}[b][\paperheight + 6mm][c]{\paperwidth + 6mm}%
        \HUGE\centering
        \color{white}%
        #1%
      \end{minipage}%
    }%
  }%
}

% #1: photo
\newcommand{\chapterPhotoPagePortrait}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=100mm]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% #1: width
% #2: photo
\newcommand{\chapterPhotoInlinePortrait}[2][0.9\linewidth]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=#1]{#2}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

% #1: photo
\newcommand{\chapterPhotoPageLandscape}[1]{%
  \clearpage%
  \mbox{}\vfill%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vfill\mbox{}%
  \clearpage%
}

% The width only makes sense at \linewidth. Copy the macro inline and add trim
% and clip option on the photo if necessary.
%
% #1: photo
\newcommand{\chapterPhotoInlineLandscape}[1]{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  {\centering%
    \includegraphics[width=\linewidth]{#1}%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

\newcommand\sectionBreak{%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \normalfont%
    \fontsize{20}{20}\selectfont%
    \color[gray]{0.7}%
    $\cdot$\quad$\cdot$\quad$\cdot$%
  \par}%
  \vspace{8pt \@plus 15pt \@minus 0pt}%
}

\newcommand\quoteBreak{%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
  \par%
  {%
    \centering%
    \fontsize{8}{8}\selectfont%
    \color[gray]{0.4}%
    \FilledDiamondshape%
  \par}%
  \vspace{0pt \@plus 5pt \@minus 0pt}%
}

% glossary as item list

\newenvironment{glossarydescription}%
{\list{}{%
    \labelwidth\z@ \itemindent-\leftmargin
    \labelsep 2pt
    \let\makelabel\glossaryDescriptionlabel}}%
{\endlist}

\newcommand*{\glossaryDescriptionlabel}[1]{%
  \normalfont\textbf{#1}%
  \hspace*{\labelsep}%
}

% === Color specs ===

\newcommand\modelTmp{}
\newcommand\specTextbody{}
\newcommand\specChaptertitle{}
\newcommand\specSection{}
\newcommand\specFootnote{}
\newcommand\specFooter{}

\newcommand\extractSpecs{%
  \extractcolorspecs{textbody}{\modelTmp}{\specTextbody}%
  \extractcolorspecs{chaptertitle}{\modelTmp}{\specChaptertitle}%
  \extractcolorspecs{section}{\modelTmp}{\specSection}%
  \extractcolorspecs{footnote}{\modelTmp}{\specFootnote}%
  \extractcolorspecs{footer}{\modelTmp}{\specFooter}%
}

% #1: description title of specs, such as 'variation A, base colors'
\newcommand{\printSpecs}[1]{%
  \cleartoverso%
  \mbox{}\vfill
  \thispagestyle{empty}%
  \extractSpecs%

  #1

  \begin{tabular}{@{} l l}
    Chapter title & \specChaptertitle \\
    Text body & \specTextbody \\
    Section & \specSection \\
    Footnote & \specFootnote \\
    Footer & \specFooter \\
  \end{tabular}%
  \vfill\mbox{}%
}

% === Renewing package macros ===

\addtodef{\mainmatter}{}{%
  \setcounter{chapter}{0}%
}

\addtodef{\appendix}{}{%
  % Not adding vspace here because it interferes with the closing '.' of the
  % section list. The vertical space is added in \titlecontents{appendix}.
  \bookmarksetup{startatroot}%
}

\addtodef{\backmatter}{}{%
  \addtocontents{toc}{\addvspace{15pt}}%
  \bookmarksetup{startatroot}%
}

%\renewenvironment{quote}%
%{\small
%\list{}{\rightmargin\leftmargin}%
%\item[]}%
%{\endlist}

\newcommand\quoteref[1]{%
\par
{\footnotesize #1}
\par
}

% adapted from base/latex.ltx
\def\footnoterule{%
  \kern-3\p@
  {\color{footnoterule}\rule{\columnwidth}{0.25pt}}%
  \vspace*{7pt}%
  \kern 2.6\p@}

\renewcommand*{\notesname}{Notes}
\renewcommand*{\notedivision}{\chapter{\notesname}}
%\renewcommand*{\notedivision}{\section*{\notesname}}
\renewcommand*{\pagenotesubhead}[3]{}
\renewcommand*{\notenumintext}[1]{\textsuperscript{\thinspace [#1]}}
\renewcommand{\prenoteinnotes}{\par\noindent\hangindent=17pt}
\renewcommand{\postnoteinnotes}{\par\vspace*{0.5\baselineskip}}

% === Page styles ===

\nouppercaseheads

% define page styles with names about "what it does"

\newcommand{\sepline}{%
  \hspace{6pt}%
  \raisebox{-0.3\baselineskip}{\rule{0.2pt}{1.2\baselineskip}}%
  \hspace{6pt}%
}
\makepagestyle{topbottomcentered}
\makeevenhead{topbottomcentered}{}{\headerFont\headerSize\color{header}\textit{\thetitle}}{}
\makeevenfoot{topbottomcentered}{}{\footerFont\footerSize\color{footer}\thepage}{}
\makeoddhead{topbottomcentered}{}{\headerFont\headerSize\color{header}\textit{\leftmark}}{}
\makeoddfoot{topbottomcentered}{}{\footerFont\footerSize\color{footer}\thepage}{}
\makepsmarks{topbottomcentered}{%
  \nouppercaseheads
  \createmark{chapter}{left}{nonumber}{}{}
  \createmark{section}{right}{nonumber}{}{}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\makepagestyle{bottomcorner}
\makeevenhead{bottomcorner}{}{}{}
\makeevenfoot{bottomcorner}{%
  \pageNumFont\pageNumSize%
  \color{footer}%
  \thepage
}{}{}
\makeoddhead{bottomcorner}{}{}{}
\makeoddfoot{bottomcorner}{}{}{%
  \pageNumFont\pageNumSize%
  \color{footer}%
  \thepage
}

\makepagestyle{bottomcenter}
\makeevenhead{bottomcenter}{}{}{}
\makeevenfoot{bottomcenter}{}{%
  \pageNumFont\pageNumSize%
  \color{footer}%
  \thepage%
}{}
\makeoddhead{bottomcenter}{}{}{}
\makeoddfoot{bottomcenter}{}{%
  \pageNumFont\pageNumSize%
  \color{footer}%
  \thepage%
}{}

% alias the pagestyles into semantic names, "where it is used"

\aliaspagestyle{normalpage}{bottomcorner}
\aliaspagestyle{chapter}{empty}
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{afterpart}{empty}

\pagestyle{normalpage}

% === TOC settings ===

\maxtocdepth{chapter}

% the right TOC margin
\contentsmargin{0pt}

\newlength\tocLeftWidth
\setlength\tocLeftWidth{10mm}

% Roman numerals in the chapter title TOC chapter entries.
%\renewcommand\thechapter{\Roman{chapter}}

% Fixes Undefined control sequence error for \@chapapp@head
\renewcommand\chapternumberline[1]{\numberline{#1}}
\renewcommand\partnumberline[1]{\numberline{#1}}

% Fixes Missing number error when chapter number is not numeric, as in
% Appendix A
\let\ttll@appendix\ttll@chapter

\newcommand*\l@chapternote{\@nodottedtocline{0}{\tocLeftWidth}{0.5pc}{0pt}}

\def\@nodottedtocline#1#2#3#4#5#6{%
  \ifnum #1>\c@tocdepth \else
    %\vskip \z@ \@plus.2\p@
    \vspace*{3pt}
    {\fontsize{11}{15}\itshape\tocFont\selectfont
     \leftskip #2\relax
     \rightskip \@tocrmarg
     \advance\rightskip #3\relax
     \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #4\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#5}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{\,}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalsize\normalfont}%
     \par}%
    \vspace*{5pt}%
  \fi}

\def\tocChapterNote#1{%
  \addcontentsline{toc}{chapternote}{%
    \noexpand\numberline{}\tocChapterNoteFont\fontsize{10}{12}\selectfont #1%
  }%
}

% FIXME: the first Part heading in the TOC will also add that 20pt
% vspace. How to add it only before a Part that follows a Chapter?

\newcounter{tocpart}

\titlecontents{part}[\tocLeftWidth]
{\addtocounter{tocpart}{1}\addvspace{25pt}\fontsize{13}{13}\tocChapterFont\selectfont}%
{%
  \contentsmargin{0pt}%
  \lsstyle
  \MakeUppercase
}
{\contentsmargin{0pt}\itshape}
{\hfill\color[gray]{0.2}\pageNumSize\tocPageNumFont\thecontentspage}

\titlecontents{chapter}[\tocLeftWidth]
{\addvspace{12pt}\fontsize{12}{13}\tocChapterFont\selectfont}%
{%
  \contentsmargin{0pt}%
  \makebox[0pt][r]{%
    \color[gray]{0.5}%
    \fontsize{12}{12}\tocPageNumFont\selectfont%
    \arabic{tocpart}.\thecontentslabel%
    \hspace*{0.7em}%
  }%
}
{\contentsmargin{0pt}\tocBackmatterFont\itshape}
{\hfill\color[gray]{0.2}\pageNumSize\tocPageNumFont\thecontentspage}

\titlecontents{appendix}[\tocLeftWidth]
{\addvspace{30pt}\fontsize{13}{13}\tocChapterFont\selectfont}%
{\contentsmargin{0pt}\itshape}
{\contentsmargin{0pt}\itshape}
{\enspace\hfill\normalsize\tocPageNumFont\thecontentspage}
[\addvspace{0pt}]

% === Book styles ===

% === Part styles ===

\newif\ifthisparthastitle
\thisparthastitletrue

\newif\ifthisparthasnote
\thisparthasnotefalse

\newcommand*{\thePartNote}{}
\newcommand*{\partNote}[1]{%
  \thisparthasnotetrue%
  \renewcommand*\thePartNote{#1}%
}

\renewcommand{\partnamefont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\partnumfont}{\Huge\partTitleFont\color{partname}}
\renewcommand{\parttitlefont}{\fontsize{17}{25}\partTitleFont\lsstyle\color{parttitle}\MakeUppercase}
\renewcommand*{\midpartskip}{\par\vskip 10pt}%

% FIXME: Currently, if there isn't a part title, we have to do
% \part{\space} to still create the part line in the TOC and the
% bookmark index.
%
% It would be better if the index had ``Part One'', and the TOC would
% handle it better too.

\long\def\@part[#1]#2{%
  \M@gettitle{#1}%
  \phantomsection
  \ifnum \c@secnumdepth >-2\relax
  \refstepcounter{part}%
  \addcontentsline{toc}{part}%
  {\protect\partnumberline{\thepart}#1}%
  \mempartinfo{\thepart}{#1}{#2}%
  \else
  \addcontentsline{toc}{part}{#1}%
  \mempartinfo{}{#1}{#2}%
  \fi
  \partmark{#1}%
  {%
    \centering
    \ifthisparthastitle
      \printparttitle{#2}
    \else
      \global\thisparthastitletrue
    \fi
    \par%
  }%
\@endpart}

% === Chapter styles ===

\setsecnumdepth{chapter}

% define chapter styles with "fantasy" names

\newif\ifchapterauthor
\chapterauthorfalse

\newcommand*{\theChapterAuthor}{}
\newcommand*{\chapterAuthor}[1]{%
  \chapterauthortrue%
  \renewcommand*{\theChapterAuthor}{#1}%
}

\newcommand\chapterAuthorFmt[1]{%
  \chapterAuthorFont\chapterAuthorSize\color{chapterauthor}%
  #1%
}

\newif\ifchapternote
\chapternotefalse

\newcommand\chapterNoteFmt[1]{%
  \setlength{\parskip}{10pt}%
  \chapterNoteFont\chapterNoteSize\color{chapternote}%
  \itshape #1%
}

\newcommand{\theChapterNote}{}
\newcommand{\chapterNote}[1]{%
  \chapternotetrue%
  \renewcommand*\theChapterNote{#1}%
}

\newif\ifchapterfootnote
\chapterfootnotefalse

\newcommand*{\theChapterFootnoteMark}{}
\newcommand*{\theChapterFootnoteText}{}
\newcommand*{\chapterFootnote}[2][\footnotemark]{%
  \chapterfootnotetrue%
  \renewcommand*\theChapterFootnoteMark{#1}%
  \renewcommand*\theChapterFootnoteText{\footnotetext{#2}}%
}

\newlength\chapterTitleLeftSkip
\setlength{\chapterTitleLeftSkip}{17pt}

\newlength\chapterNumberWidth
\newlength\chapterTitleYOffset

\newlength\offsetAmount
\setlength{\offsetAmount}{4pt}%

\newif\ifthistitleoffset

\NewCoffin\ChapterWrapBox
\NewCoffin\ChapterNumberBox
\NewCoffin\ChapterNumberRuleBox
\NewCoffin\ChapterTitleBox

\newcommand\titlealign{}

\makechapterstyle{shedir}{
  \chapterstyle{default}
  \setlength{\beforechapskip}{20mm}
  \setlength{\chapterTitleLeftSkip}{0pt}
  \renewcommand\printchaptername{}
  \renewcommand\chapternamenum{}
  \renewcommand\chapnumfont{\chapterNumberFont\chapterNumberSize}
  \if@mainmatter
    \setlength{\chapterNumberWidth}{\widthof{\chapnumfont 99.} + 20pt}
  \else
    \setlength{\chapterNumberWidth}{0pt}
  \fi
  \renewcommand\printchapternum{}
  \renewcommand\afterchapternum{}
  \renewcommand\printchapternonum{}
  \renewcommand\chaptitlefont{\chapterTitleFont\chapterTitleSize}
  \renewcommand\titlealign{\if@mainmatter \raggedright \else \centering \fi}
  \renewcommand*\printchaptertitle[1]{%
    \SetHorizontalCoffin\ChapterNumberBox{%
      \parbox{\chapterNumberWidth}{%
        \if@mainmatter
          \chapnumfont\color{chapternum}%
          \hspace*{\chapterTitleLeftSkip}\arabic{part}.\thechapter%
        \else
          \mbox{}%
        \fi
      }%
    }%
    \SetHorizontalCoffin\ChapterTitleBox{%
      \parbox{\linewidth - \chapterTitleLeftSkip - \chapterNumberWidth}{%
        \titlealign
        \chaptitlefont\color{chaptertitle}%
        \textls*{\MakeUppercase{##1}}%
        \ifchapterfootnote%
          \hspace*{2pt}\theChapterFootnoteMark%
        \fi%
        \ifchapterauthor%
          \vskip 0.5\onelineskip%
          \chapterAuthorFmt{\theChapterAuthor}%
          \global\chapterauthorfalse%
        \fi%
        \ifchapternote%
          \vskip 0.5\onelineskip%
          \chapterNoteFmt{\theChapterNote}%
          \global\chapternotefalse%
        \fi%
        \ifchapterfootnote%
          \theChapterFootnoteText%
          \global\chapterfootnotefalse%
        \fi%
      }%
    }%
    \ifthistitleoffset
      \setlength{\chapterTitleYOffset}{\offsetAmount}%
    \else
      \setlength{\chapterTitleYOffset}{0pt}%
    \fi
    \JoinCoffins\ChapterNumberBox[r,t]\ChapterTitleBox[l,t](0pt, \chapterTitleYOffset)%
    \global\thistitleoffsetfalse
    \JoinCoffins\ChapterWrapBox\ChapterNumberBox%
    %
    \raggedright\hspace*{\chapterTitleLeftSkip}%
    \TypesetCoffin\ChapterWrapBox%
  }
  \setlength{\afterchapskip}{2.5\onelineskip}
  \renewcommand\afterchaptertitle{\par\nobreak\vskip \afterchapskip}%
}

\makechapterstyle{shedir-high}{
  \chapterstyle{shedir}
  \setlength{\beforechapskip}{-\baselineskip}
}

\makechapterstyle{shedir-toc}{
  \chapterstyle{shedir-high}
  \setlength{\chapterTitleLeftSkip}{6pc}
  \setlength{\afterchapskip}{1.5\onelineskip}
  \renewcommand\titlealign{\raggedright}
}

% Commands to assign the chapter styles to book parts. Use \renewcommand
% to adjust.

% No numbers in chapter mark
%\createmark{chapter}{left}{nonumber}{}{}

\newcommand\frontmatterChapterStyle{\chapterstyle{shedir-high}}
\newcommand\mainmatterChapterStyle{\chapterstyle{shedir}}
\newcommand\appendixChapterStyle{\chapterstyle{shedir-high}}
\newcommand\backmatterChapterStyle{\chapterstyle{shedir-high}}

% append them to the macros
\addtodef{\frontmatter}{}{%
  \frontmatterChapterStyle%
  \pagestyle{bottomcenter}%
}
\addtodef{\mainmatter}{}{%
  \mainmatterChapterStyle%
  \pagestyle{normalpage}%
}
\addtodef{\appendix}{}{%
  \appendixChapterStyle%
  \pagestyle{bottomcenter}%
}
\addtodef{\backmatter}{}{%
  \backmatterChapterStyle%
  \pagestyle{bottomcenter}%
}

% === Section styles ===

% TODO: could use \makeheadstyles to keep bundle different chapter and
% section style together. See memoir manual '6.9 Predefined heading
% styles'.

% No glue after section headers. It is better to break the page early. With
% glue, (eg \setaftersecskip{2.3ex \@plus .2ex}), when nowidow moves some lines
% to the next page, the space after the section header will strech a lot to shift
% the bottom lines to the bottom of the text block.
%
% With no glue, the space will be at the bottom of the text block instead.

\setbeforesecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersecskip{1ex}

\setbeforesubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsecskip{2.3ex}

\setbeforesubsubsecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersubsubsecskip{2.3ex}

% Roman numerals for section numbering.
%\renewcommand*{\thesection}{\roman{section}}
%\setsechook{\setsecnumformat{\thesection.\space}}

\newcommand\sectionFmt[1]{%
  \sectionFont\fontsize{9}{12}\selectfont%
  \color{section}%
  \memRTLraggedright%
  \textls*{\MakeUppercase{#1}}%
}

\newcommand\subsectionFmt[1]{%
  \sectionFont\fontsize{10}{13}\selectfont%
  \color{section}%
  \memRTLraggedright%
  \textls{\MakeUppercase{#1}}%
}

\newcommand\subsubsectionFmt[1]{%
  \normalfont\normalsize\itshape\color[gray]{0.1}%
  \memRTLraggedright%
  #1
}

\setsecheadstyle{\sectionFmt}
\setsubsecheadstyle{\subsectionFmt}
\setsubsubsecheadstyle{\subsubsectionFmt}

% === Page geometry and layout ===

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\newlength\BOOK@paperHeight
\newlength\BOOK@paperWidth

\def\BOOK@fontSizePt{}
\def\BOOK@lineHeightPt{}

% === normalsize ===

\def\BOOK@fontSizePt{11}
\def\BOOK@lineHeightPt{15}

\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\BOOK@fontSizePt\BOOK@lineHeightPt
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \color{textbody}
  \let\@listi\@listI}
\normalsize

% === indentations ===

\setlength{\vgap}{1.5em}
\setlength{\vindent}{\vgap}
\setlength{\vleftmargin}{2em}

\setlength{\parskip}{5pt}
\setlength{\parindent}{0pt}

% === setup page layout ===

\setlength{\BOOK@paperHeight}{8in}
\setlength{\BOOK@paperWidth}{5.25in}

\ifshowtrims
  \stockaiv% use A4 paper size to show trims
  \setlength{\paperheight}{\BOOK@paperHeight}
  \setlength{\paperwidth}{\BOOK@paperWidth}
  \trimXmarks
  \trimLmarks
  \quarkmarks
  \settrims{0.5\stockheight - 0.5\paperheight}{0.5\stockwidth - 0.5\paperwidth}
  \settrimmedsize{\BOOK@paperHeight}{\BOOK@paperWidth}{*}
\else\relax
  \setstocksize{\BOOK@paperHeight}{\BOOK@paperWidth}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
\fi

\settypeblocksize{28\baselineskip + \topskip}{*}{0.577}% 1/1.732 (sqrt(3)), Hexagon
\setlrmargins{*}{20mm}{*}%
\setulmargins{*}{*}{1.701}% Tall Pentagon, 1.701

\setlength{\footskip}{45pt}

% Fixes these warnings:
%
% Overfull \vbox (1.4pt too high) has occurred while \output is active
\addtolength{\headheight}{2pt}

% This will also typeout values in pt (default)
\checkandfixthelayout
% It is useful to see layout values in mm too.
\settypeoutlayoutunit{mm}
\typeoutlayout

\usepackage[superscript]{cite}

\renewcommand\OverciteFont{\fontsize{9}{\baselineskip}\selectfont}

\renewcommand{\@citess}[1]{\mbox{\hspace*{1pt}$\m@th^{\hbox{\OverciteFont{#1}}}$}}

% === Packages to be loaded LAST ===

% NOTE use the 'bottom' footmisc option when using \raggedbottom.

\RequirePackage[perpage,symbol*,bottom,norule,multiple]{footmisc}

% NOTE if you have a quote margin, the \footnotemargin can be set equal to that
% in your local.sty
\setlength{\footnotemargin}{2em}

\renewcommand{\footnotelayout}{\hangpara{\footnotemargin}{1}}

% Asterisks for the first three footnotes, then numbers produced by the
% 'symbol*' option.
\DefineFNsymbols{anecdote}{*{**}{***}}
\setfnsymbol{anecdote}
