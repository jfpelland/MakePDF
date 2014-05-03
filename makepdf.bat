
::     Copyright Jean-Francois Larcher-Pelland 2014
:: Distributed under the Boost Software License, Version 1.0.
::    (See accompanying file LICENSE_1_0.txt or copy at
::          http://www.boost.org/LICENSE_1_0.txt)

@echo off

:: Check command-line args
if "%1"=="/clean" goto clean
if "%1"=="/cleanall" goto cleanall
if "%1"=="/help" goto help
if "%1"=="/?" goto help

:build
if "%1" == "/v" (
	set input=%2
	set output=%3
) else (
	set quiet=-quiet
	set input=%1
	set output=%2
)
if "%output%"=="" set output=%input%

pdflatex -c-style-errors -enable-8bit-chars -interaction=nonstopmode %quiet% -job-name=%output% %input%
goto end

:clean
del /s /q *.aux *.log *.out
goto end

:cleanall
del /s /q *.pdf *.aux *.log *.out
goto end

:help
set "TAB=  "
echo Creates PDF files from LaTeX source using pdflatex.
echo.
echo To create a PDF:
echo makepdf [/v] infile [outfile]
echo.
echo %TAB%infile  Input file.
echo %TAB%outfile Output destination. If this is not specified, the output is "<infile>.pdf"
echo %TAB%/v      Verbose mode.
echo.
echo To remove intermediate files generated by pdflatex:
echo makepdf /clean
echo.
echo To remove all files generated by pdflatex:
echo makepdf /cleanall
echo.
echo To display this message:
echo makepdf [/help ^| /?] 
echo.
echo Extensions for infile (.tex) or outfile (.pdf) should not be specified.
echo The script will run correctly if they are, however, the output names may be slightly silly. E.g., executing
echo "makepdf apples.tex" will create a file called apples.tex.pdf and executing "makepdf apples.tex apples.pdf"
echo will create a file called apples.pdf.pdf.
echo.

:end