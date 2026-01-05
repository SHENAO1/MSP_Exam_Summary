% msp-exam.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msp-exam}[2026/01/05 v1.0 Modern Signal Processing Exam Summary Class]

% 基于 ctexbook 开发，方便中文排版
\LoadClass[a4paper,12pt,oneside]{ctexbook}

% --- 基础宏包 ---
\RequirePackage{geometry}
\geometry{left=2.5cm, right=2.5cm, top=3cm, bottom=2.5cm} % 页边距
\RequirePackage{amsmath, amssymb, amsfonts, bm} % 数学公式与粗体
\RequirePackage{graphicx} % 图片支持
\RequirePackage{float}    % 图片浮动控制
\RequirePackage{hyperref} % 超链接与目录跳转
\RequirePackage{xcolor}   % 颜色支持
\RequirePackage{enumitem} % 列表定制
\RequirePackage{fancyhdr} % 页眉页脚

% --- 装饰性宏包 (tcolorbox) ---
\RequirePackage[most]{tcolorbox}

% --- 链接颜色设置 ---
\hypersetup{
    colorlinks=true,
    linkcolor=blue!60!black,
    filecolor=magenta,      
    urlcolor=cyan,
}

% --- 题目与解析环境设计 ---

% 定义计数器
\newcounter{probcount}[section] % 题目编号跟随小节（如 1.1.1）
\renewcommand{\theprobcount}{\thesection.\arabic{probcount}}

% 1. 题目环境 (带灰色背景框，禁止跨页)
\newtcolorbox{problem}[1][]{
    enhanced,
    unbreakable, % <--- 【关键修改】将 breakable 改为 unbreakable
    colback=gray!5, % 背景淡灰
    colframe=gray!50!black, % 边框深灰
    title={\refstepcounter{probcount}\textbf{题目 \theprobcount} \quad #1},
    fonttitle=\bfseries,
    attach boxed title to top left={yshift=-2mm, xshift=2mm},
    boxed title style={colback=blue!60!black, sharp corners},
    top=3mm
}

% 2. 解析环境 (默认隐藏，这里设为显示，带左侧竖线)
\newenvironment{solution}{
    \par\vspace{2mm}\noindent\textbf{\color{teal}【解析】}\par
    \color{black!80}
    \leftskip=1em
}{
    \par\vspace{3mm}\leftskip=0em
}

% --- 页眉页脚设置 ---
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\leftmark} % 左上角显示章标题
\fancyhead[R]{现代信号处理期末复习}
\fancyfoot[C]{\thepage}

% --- 章节标题格式微调 ---
\ctexset{
    chapter/format = \Huge\bfseries\centering,
    section/format = \Large\bfseries,
}