# GstarCAD Units Tools

Set drawing units from a menu, convert a model between mm, cm, m, inches and feet, and check unit settings before sharing.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Mixed units are one of the most common sources of scale errors when drawings are exchanged between teams. These utilities set the drawing units from a short menu, scale an existing model between mm, cm, m, inches and feet, and print the current INSUNITS/LUNITS settings for a quick sanity check.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/set-units.lsp` | ;; set-units.lsp - Set drawing units from a short menu
;; Command: UNITSET
;; Usage: APPLOAD -> UNITSET -> choose mm / cm / m / inch / feet
(defun c:UNITSET ( / opt )
  (initget "MM CM M INCH FEET")
  (setq opt (getkword "\nDrawing units [MM/CM/M/INCH/FEET] <MM>: "))
  (if (null opt) (setq opt "MM"))
  (setq opt (strcase opt))
  (cond
    ((= opt "MM")   (setvar "INSUNITS" 4))
    ((= opt "CM")   (setvar "INSUNITS" 5))
    ((= opt "M")    (setvar "INSUNITS" 6))
    ((= opt "INCH") (setvar "INSUNITS" 1))
    ((= opt "FEET") (setvar "INSUNITS" 2))
  )
  (princ (strcat "\nDrawing units set to " opt "."))
  (princ)
)
 |
| `scripts/unit-convert.lsp` | ;; unit-convert.lsp - Scale selected objects between drawing units
;; Command: UNITCONV
;; Usage: convert a drawing modelled in mm to m, or inches to mm, and so on
(defun c:UNITCONV ( / ss from to f table )
  (setq ss (ssget))
  (if ss
    (progn
      (initget "MM CM M INCH FEET")
      (setq from (getkword "\nFrom unit [MM/CM/M/INCH/FEET] <MM>: "))
      (if (null from) (setq from "MM"))
      (initget "MM CM M INCH FEET")
      (setq to (getkword "\nTo unit [MM/CM/M/INCH/FEET] <M>: "))
      (if (null to) (setq to "M"))
      (setq table '(("MM" . 1.0) ("CM" . 10.0) ("M" . 1000.0)
                    ("INCH" . 25.4) ("FEET" . 304.8)))
      (setq f (/ (cdr (assoc (strcase from) table))
                 (cdr (assoc (strcase to) table))))
      (command "_.SCALE" ss "" "0,0" f)
      (princ (strcat "\nScaled by " (rtos f 2 6) " ("
                     (strcase from) " -> " (strcase to) ")."))
    )
  )
  (princ)
)
 |
| `scripts/unit-info.lsp` | ;; unit-info.lsp - Report the current drawing unit settings
;; Command: UNITINFO
(defun c:UNITINFO ( / ins )
  (setq ins (getvar "INSUNITS"))
  (princ (strcat "\nINSUNITS = " (itoa ins) "  ("
                 (cond ((= ins 1) "inches")
                       ((= ins 2) "feet")
                       ((= ins 4) "millimeters")
                       ((= ins 5) "centimeters")
                       ((= ins 6) "meters")
                       (T "unitless or other")) ")"))
  (princ (strcat "\nLUNITS = " (itoa (getvar "LUNITS"))
                 "  LUPREC = " (itoa (getvar "LUPREC"))))
  (princ (strcat "\nCheck that client and sharing requirements match these settings."))
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
