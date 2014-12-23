;; Init file to use with the orgmode plugin.

;; Load org-mode
;; Requires org-mode v8.x

;; Uncomment these lines and change the path to your org source to
;; add use it.
;; (let* ((org-lisp-dir "~/.emacs.d/src/org/lisp"))
;;   (when (file-directory-p org-lisp-dir)
;;       (add-to-list 'load-path org-lisp-dir)
;;       (require 'org)))

(require 'ox-html)

;;; Custom configuration for the export. ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Add any custom configuration that you would like to 'conf.el'.
(setq
 org-export-with-toc nil
 org-export-with-section-numbers nil
 org-startup-folded 'showeverything)

;; Load additional configuration from conf.el
(let ((conf (expand-file-name "conf.el" (file-name-directory load-file-name))))
  (if (file-exists-p conf)
      (load-file conf)))

;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load Nikola macros
(setq nikola-macro-templates
      (with-current-buffer
          (find-file
           (expand-file-name "macros.org" (file-name-directory load-file-name)))
        (org-macro--collect-macros)))


;;; Code highlighting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use pygments highlighting for code


(defconst org-pygments-language-alist
  '(
    ("asymptote" . "asymptote")
    ("awk" . "awk")
    ("C" . "c")
    ("cpp" . "cpp")
    ("clojure" . "clojure")
    ("css" . "css")
    ("D" . "d")
    ("emacs-lisp" . "scheme")
    ("F90" . "fortran")
    ("gnuplot" . "gnuplot")
    ("groovy" . "groovy")
    ("haskell" . "haskell")
    ("java" . "java")
    ("js" . "js")
    ("julia" . "julia")
    ("latex" . "latex")
    ("lisp" . "lisp")
    ("makefile" . "makefile")
    ("matlab" . "matlab")
    ("mscgen" . "mscgen")
    ("ocaml" . "ocaml")
    ("octave" . "octave")
    ("perl" . "perl")
    ("picolisp" . "scheme")
    ("python" . "python")
    ("R" . "r")
    ("ruby" . "ruby")
    ("sass" . "sass")
    ("scala" . "scala")
    ("scheme" . "scheme")
    ("sh" . "sh")
    ("sql" . "sql")
    ("sqlite" . "sqlite3")
    ("tcl" . "tcl")
    )
  "Alist between org-babel languages and Pygments lexers.

See: http://orgmode.org/worg/org-contrib/babel/languages.html and
http://pygments.org/docs/lexers/ for adding new languages to the
mapping. ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Export function used by Nikola.
(defun nikola-html-export (infile outfile)
  "Export the body only of the input file and write it to
specified location."

  (with-current-buffer (find-file infile)
    (org-macro-replace-all nikola-macro-templates)
    (org-html-export-as-html nil nil t t)
    (write-file outfile nil)))
