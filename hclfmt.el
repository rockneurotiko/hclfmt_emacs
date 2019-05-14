(defvar hclfmt-version "0.1", "HCL Format Version")

(defvar hclfmt-binary "hclfmt" "Path of hclfmt binary")

(defun hclfmt--show-execute-errors (code output)
  (when (/= code 0)
    (message (concat "hclfmt error: " output))))

(defun hclfmt--process-exit-code-and-output (program args)
  "Run PROGRAM with ARGS and return the exit code and output in a list."
  (with-temp-buffer
    (list (apply 'call-process program nil (current-buffer) nil args)
          (buffer-string))))

(defun hclfmt--execute (command)
  (let* ((parts (split-string command))
         (program (car parts))
         (args (cdr parts)))
    (hclfmt--process-exit-code-and-output program args)))

(defun hclfmt--format-code (codepath)
  (let ((cmd (format "%s -w %s" hclfmt-binary codepath)))
    (apply 'hclfmt--show-execute-errors (hclfmt--execute cmd))))

(defun hclfmt--format-current-buffer ()
  (interactive)
  (when (not (eq nil hclfmt-binary))
    (hclfmt--format-code buffer-file-name)
    (revert-buffer :ignore-auto :noconfirm)))

;;;###autoload
(defun hclfmt-after-save ()
  (interactive)
  (when (eq major-mode 'hcl-mode)
    (hclfmt--format-current-buffer)))

;; (add-hook 'after-save-hook #'hclfmt-after-save)

(provide 'hclfmt)
