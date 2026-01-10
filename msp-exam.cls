% msp-exam.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msp-exam}[2026/01/06 v2.1 Fixed Restore LongProblem]

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
\RequirePackage{enumitem} 
\RequirePackage{fancyhdr}
\RequirePackage[most]{tcolorbox}
\RequirePackage{ulem} 
\RequirePackage{calc} 
\RequirePackage{varwidth} 
\RequirePackage{environ} % 用于捕获环境内容

% --- 3. 颜色定义 ---
\definecolor{mainblue}{RGB}{0, 80, 160}
\definecolor{accentteal}{RGB}{0, 128, 128}
\definecolor{paperbg}{RGB}{253, 252, 245} 
\definecolor{derivbg}{RGB}{255, 250, 240} 
\definecolor{derivframe}{RGB}{210, 180, 140} 

% --- 4. 链接设置 ---
\hypersetup{
    colorlinks=true,
    linkcolor=mainblue,
    filecolor=magenta,      
    urlcolor=cyan,
}

% --- 5. 题目计数器 ---
\newcounter{probcount}[section]
\renewcommand{\theprobcount}{\thesection.\arabic{probcount}}

% =========================================================
%  A. 恢复标准题目环境 (用于解答题、填空题)
% =========================================================

% 1. 标准题目 (不跨页) - 恢复原版
\newtcolorbox{problem}[1][]{
    enhanced,
    unbreakable, 
    colback=gray!5,
    colframe=gray!60!black,
    title={%
        \begin{varwidth}{0.9\linewidth}
            \refstepcounter{probcount}\textbf{问题 \theprobcount} \quad #1
        \end{varwidth}%
    },
    fonttitle=\bfseries\large,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=mainblue, sharp corners},
    top=4mm,
    bottom=2mm,
    before skip=10pt,
    after skip=10pt
}

% 2. 长题目 (允许跨页) - 【已恢复，您截图报错就是因为缺这个】
\newtcolorbox{longproblem}[1][]{
    enhanced,
    breakable,   % <--- 允许跨页
    colback=gray!5,
    colframe=gray!60!black,
    title={%
        \begin{varwidth}{0.9\linewidth}
            \refstepcounter{probcount}\textbf{问题 \theprobcount} \quad #1
        \end{varwidth}%
    },
    fonttitle=\bfseries\large,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=mainblue, sharp corners},
    top=4mm,
    bottom=2mm,
    before skip=10pt,
    after skip=10pt
}

% =========================================================
%  B. 新增：选择题专用环境 (自动双页显示)
% =========================================================

% 定义一个内部盒子用于 Choice 逻辑 (用户不直接使用这个)
\newtcolorbox{innerchoicebox}[1][]{
    enhanced,
    unbreakable, 
    colback=gray!5,
    colframe=gray!60!black,
    title={%
        \begin{varwidth}{0.9\linewidth}
            \refstepcounter{probcount}\textbf{问题 \theprobcount} \quad #1
        \end{varwidth}%
    },
    fonttitle=\bfseries\large,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=mainblue, sharp corners},
    top=4mm,
    bottom=2mm,
    before skip=10pt,
    after skip=10pt
}

% 定义 choiceproblem 环境：先打印题干，换页，再打印题干+解析
\NewEnviron{choiceproblem}[1][]{
    % --- 第1遍：仅题干 (Student View) ---
    \showanswersfalse
    \begin{innerchoicebox}[#1]
        \BODY
    \end{innerchoicebox}
    \clearpage
    
    % --- 第2遍：题干 + 解析 (Teacher View) ---
    \addtocounter{probcount}{-1} % 回退计数器，保持题号一致
    \showanswerstrue
    \begin{innerchoicebox}[#1]
        \BODY
    \end{innerchoicebox}
    \clearpage
}

% =========================================================
%  C. 其他组件 (解析、推导、填空)
% =========================================================

% 智能开关逻辑
\newif\ifshowanswers
\showanswersfalse 

% 解析环境 (Solution) - 根据 ifshowanswers 自动显隐
\NewEnviron{solution}{
    \ifshowanswers
        \par\vspace{1mm}\noindent\textbf{\color{accentteal}【答】}\par
        \color{black!90}
        \leftskip=1em
        \BODY
        \par\vspace{2mm}\leftskip=0em
    \fi
}

% 推导专用盒子 (Derivation)
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
    borderline west={3pt}{0pt}{derivframe}, 
    sharp corners
}

% 智能填空逻辑
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

% 列表与版式优化
\setlist[enumerate]{label=\arabic*., itemsep=2pt, topsep=2pt}
\ctexset{
    chapter/format = \Huge\bfseries\centering,
    section/format = \Large\bfseries,
}
\setlength{\lineskiplimit}{2pt}
\setlength{\lineskip}{2pt}
\endinput