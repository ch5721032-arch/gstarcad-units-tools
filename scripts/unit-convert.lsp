;; unit-convert.lsp - Scale selected objects between drawing units
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
