(leaf ellama
  :ensure t
  :added "2024-08-19"
  :init
  (require 'llm-ollama)
  :custom
  ;; (ellama-keymap-prefix . "C-c e")
  (ellama-language . "Japanese")
  (ellama-naming-scheme . 'ellama-generate-name-by-llm)
  :config
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "codestral:22b-v0.1-q4_K_S"
           :embedding-model "codestral:22b-v0.1-q4_K_S"))
  (setopt ellama-translation-provider
          (make-llm-ollama
           :chat-model "aya:35b-23-q4_K_S"
           :embedding-model "aya:35b-23-q4_K_S"))

  ;; Naming new sessions with llm
  (setopt ellama-naming-provider 
	      (make-llm-ollama
	       :chat-model "llama3.1:8b" ;-instruct-q8_0
	       :embedding-model "nomic-embed-text"
	       :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)

  ;; ellama-provider-select
  (setopt ellama-providers
          '(("codestral" . (make-llm-ollama
                            :chat-model "codestral:22b-v0.1-q4_K_S"
                            :embedding-model "codestral:22b-v0.1-q4_K_S"))
            ("gemma2" . (make-llm-ollama
                         :chat-model "gemma2:27b-instruct-q4_K_S"
                         :embedding-model "gemma2:27b-instruct-q4_K_S"))
            ("command-r" . (make-llm-ollama
                            :chat-model "command-r:35b"
                            :embedding-model "command-r:35b"))
            ("llama3.1" . (make-llm-ollama
                           :chat-model "llama3.1:8b"
                           :embedding-model "llama3.1:8b"))))
  ;; `(ellama-provider . ,(make-llm-ollama
  ;;                       :chat-model "codestral:22b-v0.1-q4_K_S"
  ;;                       :embedding-model "codestral:22b-v0.1-q4_K_S"))
  ;; `(ellama-translation-provider . ,(make-llm-ollama
  ;;                                   :chat-model "aya:35b-23-q4_K_S"
  ;;                                   :embedding-model "aya:35b-23-q4_K_S"))

  ;; ;; Naming new sessions with llm
  ;; `(ellama-naming-provider .
  ;;                          ,(make-llm-ollama
  ;;                            :chat-model "llama3:8b-instruct-q8_0"
  ;;                            :embedding-model "nomic-embed-text"
  ;;                            :default-chat-non-standard-params '(("stop" . ("\n")))))
  ;; (ellama-naming-scheme . 'ellama-generate-name-by-llm)
  ;; ;; Translation llm provider
  ;; `(ellama-translation-provider .
  ;;                               ,(make-llm-ollama
  ;;   			                  :chat-model "phi3:14b-medium-128k-instruct-q6_K"
  ;;   			                  :embedding-model "nomic-embed-text"))

  ;; ;; ellama-provider-select
  ;; `(ellama-providers .
  ;;                    '(("codestral" . ,(make-llm-ollama
  ;;                                       :chat-model "codestral:22b-v0.1-q4_K_S"
  ;;                                       :embedding-model "codestral:22b-v0.1-q4_K_S"))
  ;;                      ("gemma2" . ,(make-llm-ollama
  ;;                                    :chat-model "gemma2:27b-instruct-q4_K_S"
  ;;                                    :embedding-model "gemma2:27b-instruct-q4_K_S"))
  ;;                      ("command-r" . ,(make-llm-ollama
  ;;                                       :chat-model "command-r:35b"
  ;;                                       :embedding-model "command-r:35b"))
  ;;                      ("llama3.1" . ,(make-llm-ollama
  ;;                                      :chat-model "llama3.1:8b"
  ;;                                      :embedding-model "llama3.1:8b"))))
  )
