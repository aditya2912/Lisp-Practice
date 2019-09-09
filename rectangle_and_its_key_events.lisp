(ql:quickload :sdl2)

(defparameter *width* 640)
(defparameter *height* 480)
(defparameter *x_coord* 0)
(defparameter *y_coord* 0)
(defparameter *rect_height* 30)
(defparameter *rect_width* 10)
(defparameter *color_codings* '(#xFF #x00))
(defparameter *r* #x00)
(defparameter *g* #x00)
(defparameter *b* #x00)


(defun calculate_random (index)
  (if (= index 0)
      (car *color_codings*)
      (cadr *color_codings*)))


(defmacro with-window-renderer ((window renderer) &body body)
  `(sdl2:with-init (:video)
     (sdl2:with-window (,window
			:title "Draw rect"
			:w *width*
			:h *height*
			:flags '(:shown))
       (sdl2:with-renderer (,renderer ,window :index -1 :flags '(accelerated))
	 ,@body))))

; set-render-draw-color after :idle and till render-fill-rect are the 4 lines which render a rectangle on the screen
(defun main_code ()
  (with-window-renderer (window renderer)
    (sdl2:with-event-loop (:method :poll)
      (:quit () t)
      (:keydown
       (:keysym keysym)
       (case (sdl2:scancode keysym)
	 (:scancode-down (setf *y_coord* (+ *y_coord* 5)))
	 (:scancode-up (setf *y_coord* (- *y_coord* 5)))
	 (:scancode-left (setf *x_coord* (- *x_coord* 5)))
	 (:scancode-right (setf *x_coord* (+ *x_coord* 5)))
	 (:scancode-escape (sdl2:push-quit-event)
			   (setf *rect_height* 20)
			   (setf *rect_width* 20)
			   (setf *x_coord* 2)
			   (setf *y_coord* 2))
	 (:scancode-d (setf *rect_height* (+ *rect_height* 5)))
	 (:scancode-s (setf *rect_width* (+ *rect_width* 5)))
	 (:scancode-a (setf *rect_height* (- *rect_height* 5)))
	 (:scancode-w (setf *rect_width* (- *rect_width* 5)))
	 (:scancode-p (setf *r* (calculate_random (random (length *color_codings*))))
		      (setf *g* (calculate_random (random (length *color_codings*))))
		      (setf *b* (calculate_random (random (length *color_codings*)))))))

      (:idle ()
	     (when (> *x_coord* *width*)
	       (setf *x_coord* 0))

	     (when (> *y_coord* *height*)
	       (setf *y_coord* 0))

	     (when (< *x_coord* 0)
	       (setf *x_coord* *width*))

	     (when (< *y_coord* 0)
	       (setf *y_coord* *height*))


	     (sdl2:set-render-draw-color renderer #xFF #xFF #xFF #xFF) ;; this color coding scheme is for the background color
	     (sdl2:render-clear renderer)
	     (sdl2:set-render-draw-color renderer
					 *r*
					 *g*
					 *b*
					 #xFF)
	    ; (sdl2:set-render-draw-color renderer #x00 #x00 #x00 #xFF) ;; this color coding scheme is for the small rectangle
	     (sdl2:render-fill-rect renderer
				    (sdl2:make-rect *x_coord*              ;; this value represents the x coordinate of the shape
						    *y_coord*              ;; this value represents the y coordinate of the shape
						    *rect_height*          ;; this value represents the height of the shape
						    *rect_width*           ;; this value represents the width of the shape
						    ))
	     (sdl2:render-present renderer)))))

(main_code)
