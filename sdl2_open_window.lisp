(ql:quickload :sdl2)

(defparameter *screen_width* 640)
(defparameter *screen_height* 480)

;; This macro renders a window with the specified attributes
(defmacro window_surface ((window surface) &body body)
  `(sdl2:with-init (:video)
     (sdl2:with-window (,window
			:title "Plain and Simple"
			:w *screen_width*
			:h *screen_height*
			:flags '(:shown))
       (let ((,surface (sdl2:get-window-surface ,window)))
	 ,@body))))


;; After calling the window surface macro and specifying the required events, we get a plain and simple window
;; Removing all the "image" references, we will get the minimum code required to render a window
;; Side Note -> Instead of using &key args in main function, we can manually specify the delay time as done below.
(defun main_function ()
  (window_surface (window screen-surface)
    (sdl2:with-event-loop (:method :poll)
      (:quit () t)
      (:idle ()
	     (sdl2:update-window window)
	     (sdl2:delay 100)))))


;; Any error in the image path would lead to a blank screen. So, path has to be accurate.
(defun main_function_with_image ()
  (window_surface (window screen-surface)
    (let ((background_image (sdl2:load-bmp "/home/aditya/Downloads/hello_world.bmp")))
      (sdl2:with-event-loop (:method :poll)
	(:quit () t)
	(:idle ()
	       (sdl2:blit-surface background_image nil screen-surface nil)
	       (sdl2:update-window window)
	       (sdl2:delay 100))))))

(main_function_with_image)


(main_function)
