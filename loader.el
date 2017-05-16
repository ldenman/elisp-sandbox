(defun loader-run (el-file)
  (load-theme 'misterioso)
  (load-file "common.el")
  (load-file el-file)
  (load-file "package-demo/package-demo.el")
  (load-file (concat el-file ".demo"))
  (kill-emacs 0))
(loader-run (getenv "ELFILE"))
;(loader-run "vanilla.el")
