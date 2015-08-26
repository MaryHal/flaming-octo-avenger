;;; Project ---  FOA Project file for Emacs users.
;;; Commentary:
;;;    Eval this file!

;;; Code:

(require 'projectile)

(puthash (projectile-project-root)
         "ninja"
         projectile-compilation-cmd-map)

(puthash (projectile-project-root)
         "LUA_CPATH='./libbarrage.so' love ."
         projectile-test-cmd-map)

(global-set-key (kbd "<f5>") (lambda()
                               (interactive)
                               (cd (projectile-project-root))
                               (shell-command "python bootstrap.py --cxx=clang --luajit")
                               ))

(global-set-key (kbd "C-<f5>") (lambda()
                                 (interactive)
                                 (cd (projectile-project-root))
                                 (shell-command "python bootstrap.py --debug --cxx=clang")
                                 ))

(global-set-key (kbd "<f6>") #'projectile-compile-project)
(global-set-key (kbd "<f7>") #'projectile-test-project)

(provide 'project)
;;; project.el ends here
