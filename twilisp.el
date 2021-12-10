;;; A very simple elisp library to make requests to twilio from Emacs
;;; Copyright (c) 2021, Rahul Singh
;;; Author: Rahul Singh <rsingh@arrsingh.com>

(require 'request)

(custom-set-variables '(request-log-level 'blather)
                                   '(request-message-level 'blather))

(defun send-sms (sid auth-token to from msg)
  "Sends an SMS message via Twilio"
  (let ((auth-header (concat "Basic " (base64-encode-string (concat sid ":" auth-token) t))))
    (request (format "https://api.twilio.com/2010-04-01/Accounts/%s/Messages.json" sid)
      :type "POST"
      :auth "basic"
      :headers `(("Authorization" . ,auth-header))
      :parser 'json-read
      :data `(("To" . ,to)
              ("From" . ,from)
              ("Body" . ,msg)))))
