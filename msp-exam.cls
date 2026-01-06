% msp-exam.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msp-exam}[2026/01/06 v1.5 Modern Signal Processing Exam Summary Class]

% --- 1. 基类 ---
\LoadClass[a4paper,12pt,oneside]{ctexbook}

% --- 2. 宏包 ---
\RequirePackage{geometry}
\geometry{left=2.5cm, right=2.5cm, top=3cm, bottom=2.5cm, headheight=15pt}

\RequirePackage{amsmath, amssymb, amsfonts, bm}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{hyperref}
\RequirePackage{xcolor}
\RequirePackage{enumitem} % 列表定制
\RequirePackage{fancyhdr}
\RequirePackage[most]{tcolorbox}
\RequirePackage{ulem} 
\RequirePackage{calc} 

% --- 3. 颜色定义 ---
\definecolor{mainblue}{RGB}{0, 80, 160}
\definecolor{accentteal}{RGB}{0, 128, 128}
\definecolor{paperbg}{RGB}{253, 252, 245} % 羊皮纸色背景
\definecolor{derivbg}{RGB}{255, 250, 240} % 推导框背景
\definecolor{derivframe}{RGB}{210, 180, 140} % 推导框边框

% --- 4. 链接设置 ---
\hypersetup{
    colorlinks=true,
    linkcolor=mainblue,
    filecolor=magenta,      
    urlcolor=cyan,
}

% --- 5. 题目环境 (Problem) ---
\newcounter{probcount}[section]
\renewcommand{\theprobcount}{\thesection.\arabic{probcount}}

\newtcolorbox{problem}[1][]{
    enhanced,
    unbreakable, 
    colback=gray!5,
    colframe=gray!60!black,
    title={\refstepcounter{probcount}\textbf{问题 \theprobcount} \quad #1},
    fonttitle=\bfseries\large,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=mainblue, sharp corners},
    top=4mm,
    bottom=2mm,
    before skip=10pt,
    after skip=10pt
}

% --- 6. 解析环境 (Solution) ---
\newenvironment{solution}{
    \par\vspace{1mm}\noindent\textbf{\color{accentteal}【答】}\par
    \color{black!90}
    \leftskip=1em
}{
    \par\vspace{2mm}\leftskip=0em
}

% --- 7. 新增：推导专用盒子 (Derivation) ---
% 用于Q5中的LMS推导过程，模仿Markdown引用块样式
\newtcolorbox{derivation}[1][推导过程]{
    enhanced,
    breakable,
    colback=derivbg,
    colframe=derivframe,
    coltitle=black!80,
    title={\textbf{#1}},
    fonttitle=\bfseries\small,
    attach boxed title to top left={yshift*=-\tcboxedtitleheight/2, xshift=5mm},
    boxed title style={colback=derivbg, boxrule=0.5pt, colframe=derivframe},
    left=4mm, right=4mm, top=4mm, bottom=2mm,
    borderline west={3pt}{0pt}{derivframe}, % 左侧加粗线
    sharp corners
}

% --- 8. 智能填空逻辑 (保持不变) ---
\newif\ifshowanswers
\showanswersfalse 

\newlength{\blankwidth} 
\newlength{\blankdepth} 

\newcommand{\blank}[1]{%
    \ifshowanswers
        \settodepth{\blankdepth}{\textbf{#1}}%
        \setlength{\ULdepth}{\blankdepth + 0.2ex}%
        \uline{\hspace{0.5em}\textbf{\color{blue}#1}\hspace{0.5em}}%
    \else
        \settowidth{\blankwidth}{#1}%
        \ifdim\blankwidth < 1.5cm
            \uline{\hspace{2cm}}% 
        \else
            \uline{\hspace{1em}\phantom{#1}\hspace{1em}}% 
        \fi
    \fi
}

\newcommand{\note}[1]{%
    \ifshowanswers
        \quad {\small\color{red!70!black}(\textbf{注：}#1)}%
    \fi
}

% --- 9. 列表与版式优化 ---
\setlist[enumerate]{label=\arabic*., itemsep=2pt, topsep=2pt}
\ctexset{
    chapter/format = \Huge\bfseries\centering,
    section/format = \Large\bfseries,
}
\setlength{\lineskiplimit}{2pt}
\setlength{\lineskip}{2pt}
\endinput