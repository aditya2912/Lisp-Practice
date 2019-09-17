;; Successfully loaded a png image in contrast to the bmp images which I have been doing previously.

(ql:quickload :sdl2)
(ql:quickload :sdl2-image)

;; Exposes render_window_and_surface macro
(load "window_renderer_macro.lisp")

(defun list_of_formats ()
  (sdl2-image:init '(:png :bmp :jpeg)))

(defun load-surface (filename &optional pixel-format)
  (sdl2:convert-surface-format (sdl2-image:load-image filename) pixel-format))

(defun main ()
  (render_window_and_surface (window screen-surface)
    (sdl2-image:init  '(:png))
    (let ((image-surface
	   (load-surface "/home/aditya/Downloads/ssjblue.png"
			 (sdl2:surface-format-format screen-surface)))
	  (rect (sdl2:make-rect 0 0 640 480)))
      (sdl2:with-event-loop (:method :poll)
	(:quit () t)
	(:keydown
	 (:keysym keysym)
	 (case (sdl2:scancode keysym)
	   (:scancode-escape (sdl2:push-quit-event))))
	(:idle ()
	       (sdl2:blit-scaled image-surface
				 nil
				 screen-surface
				 rect)
	       (sdl2:update-window window))))))


(main)
