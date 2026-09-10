;; set-units.lsp - Set drawing units from a short menu
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
