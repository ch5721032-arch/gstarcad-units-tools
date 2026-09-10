;; unit-info.lsp - Report the current drawing unit settings
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
