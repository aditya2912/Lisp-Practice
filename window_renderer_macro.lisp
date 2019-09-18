;; The following is a common macro used for rendering a basic window in common lisp using sdl2. 
;; Since the same code was being used multiple times at multiple locations, So i decided to mrite it in a seperate file and use wherever required.
(defmacro render_window_and_surface ((window surface) &body body)
  `(sdl2:with-init (:video)
     (sdl2:with-window (,window
			:title "Phenomenal"
			:w 640
			:h 480
			:flags '(:shown))
       (let ((,surface (sdl2:get-window-surface ,window)))
	 ,@body))))


(defmacro render_window_with_index_and_renderer ((window renderer) &body body)
  `(sdl2:with-init (:video)
     (sdl2:with-window (,window
			:title "Plain and Simple"
			:w *screen_width*
			:h *screen_height*
			:flags '(:shown))
       (sdl2:with-renderer (,renderer ,window :index -2 :flags '(:accelerated))
	 ,@body))))
