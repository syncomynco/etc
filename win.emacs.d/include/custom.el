(defun insert-commit-date-time ()
  (setq lpt (parse-time-string (current-time-string)))
  (insert (format "%02d/%02d/%02d" (nth 3 lpt)(nth 4 lpt)(nth 5 lpt)))
)


;;(parse-time-string (current-time-string))
  
;;(insert-commit-date-time)
;;  (insert (format-time-string "dd/mm/yy HH:mm")))
;;(insert ( format "%02d/%02d/%04d" (parse-time-string (current-time-string))))
;;(print (parse-time-sting (current-time-string))
 
;;(aref (parse-time-string (current-time-string)) )
