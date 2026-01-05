% msp-exam.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msp-exam}[2026/01/05 v1.4 Modern Signal Processing Exam Summary Class]

% --- 1. 保留原有基类 (ctexbook) ---
\LoadClass[a4paper,12pt,oneside]{ctexbook}

% --- 2. 保留原有基础宏包 ---
\RequirePackage{geometry}
% 【修改点】：在 geometry 中显式设置 headheight 为 15pt，消除 fancyhdr 警告
\geometry{left=2.5cm, right=2.5cm, top=3cm, bottom=2.5cm, headheight=15pt}

\RequirePackage{amsmath, amssymb, amsfonts, bm}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{hyperref}
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage[most]{tcolorbox}

% --- 3. 新增：填空题专用宏包 ---
\RequirePackage{ulem} % 用于下划线
\RequirePackage{calc} % 用于长度计算

% --- 4. 保留原有链接设置 ---
\hypersetup{
    colorlinks=true,
    linkcolor=blue!60!black,
    filecolor=magenta,      
    urlcolor=cyan,
}

% --- 5. 保留原有题目(problem)与解析(solution)环境 ---
\newcounter{probcount}[section]
\renewcommand{\theprobcount}{\thesection.\arabic{probcount}}

% 【保持不变】：unbreakable 参数确保了题目和答案会被锁在同一个盒子里，
% 绝对不会从中间断开。如果一页放不下，整道题会自动跳到下一页。
\newtcolorbox{problem}[1][]{
    enhanced,
    unbreakable, 
    colback=gray!5,
    colframe=gray!50!black,
    title={\refstepcounter{probcount}\textbf{题目 \theprobcount} \quad #1},
    fonttitle=\bfseries,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=blue!60!black, sharp corners},
    top=3mm
}

\newenvironment{solution}{
    \par\vspace{2mm}\noindent\textbf{\color{teal}【解析】}\par
    \color{black!80}
    \leftskip=1em
}{
    \par\vspace{3mm}\leftskip=0em
}

% --- 6. 核心逻辑升级：智能填空 (Smart Blank Logic) ---

% 定义答案显示开关
\newif\ifshowanswers
\showanswersfalse % 默认关闭

% 定义长度变量
\newlength{\blankwidth} 
\newlength{\blankdepth} 

% 填空命令 \blank{答案}
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

% 注解/提示命令 \note{内容}
\newcommand{\note}[1]{%
    \ifshowanswers
        \quad {\small\color{red!70!black}(\textbf{注：}#1)}%
    \fi
}

% --- 7. 修改页眉页脚 ---
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\leftmark} 
\fancyhead[R]{%
    \ifshowanswers
        \textbf{\color{red}【答案版】} 现代信号处理期末复习%
    \else
        现代信号处理期末复习%
    \fi
}
\fancyfoot[C]{\thepage}

% --- 8. 格式微调 ---
\ctexset{
    chapter/format = \Huge\bfseries\centering,
    section/format = \Large\bfseries,
}

\setlength{\lineskiplimit}{2pt}
\setlength{\lineskip}{2pt}