(require 'rcirc)
(require 'auth-source)

(rcirc-track-minor-mode 1)

(setq rcirc-fill-flag nil
      rcirc-fill-column nil
      rcirc-default-full-name "Max Martin"
      rcirc-buffer-maximum-lines nil
      rcirc-prompt "%t> "
      rcirc-notify-timeout 120)

(setq rcirc-keywords
      '("dataeng"
        "support!"
        "free!"
        "timbers"
        "banjo"
        "netrunner"
        "wackadoo"
        "cowbell!"
        "coinscope"
        "gardener"))

(defun my-rcirc-profile (host user nick port)
  "Search auth-info for an entry matching HOST, USER, and PORT."
  (let* (
         (auth-info
          (car
           (auth-source-search
            :max 1
            :host host
            :user-name user
            :nick nick
            :port port
            :create nil)))
         (password (funcall (plist-get auth-info :secret))))
    (list
     host
     :nick user
     :password password
     :full-name user
     :port port
     :encryption 'tls)))

(setq rcirc-server-alist
       (list
        (my-rcirc-profile "chat.banksimple.com" "max" "m4x" 9999)
        (my-rcirc-profile "74.207.243.87" "maxmartin/lambda" "maxmartin" 6007)))

(provide 'init-rcirc)
