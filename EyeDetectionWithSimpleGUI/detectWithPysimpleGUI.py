import PySimpleGUI as sg
#Import necessary libraries
from scipy.spatial import distance
from imutils import face_utils
import pygame #For playing sound
import time
import dlib
import cv2

#Initialize Pygame and load music
pygame.mixer.init()
pygame.mixer.music.load('alert.wav')

#Minimum threshold of eye aspect ratio below which alarm is triggerd
EYE_ASPECT_RATIO_THRESHOLD = 0.3

#Minimum consecutive frames for which eye ratio is below threshold for alarm to be triggered
EYE_ASPECT_RATIO_CONSEC_FRAMES = 50

#COunts no. of consecutuve frames below threshold value
COUNTER = 0

#Load face cascade which will be used to draw a rectangle around detected faces.
face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

def eye_aspect_ratio(eye):
    A = distance.euclidean(eye[1], eye[5])
    B = distance.euclidean(eye[2], eye[4])
    C = distance.euclidean(eye[0], eye[3])

    ear = (A + B) / (2 * C)
    return ear

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')

(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS['left_eye']
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS['right_eye']

video_capture = cv2.VideoCapture(0)

time.sleep(2)

# stop_button_pressed = False
#
# def stop_button_callback():
#     global stop_button_pressed
#     stop_button_pressed = True


layout = [[sg.Text('Driver Drowsiness Detection')],
[sg.Image(filename='', key='image')],
[sg.Button('Start'), sg.Button('Stop'), sg.Button('Exit')]]

window = sg.Window('Driver Drowsiness Detection', layout, size=(200, 100))#.Layout(layout)

while True:

    event, values = window.Read()

    if event in (None, 'Exit'):
        break
    if event == 'Start':
        while True:

            ret, frame = video_capture.read()
            frame = cv2.flip(frame, 1)
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)


            faces = detector(gray, 0)

            face_rectangle = face_cascade.detectMultiScale(gray, 1.3, 5)

            for (x, y, w, h) in face_rectangle:
                cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)

            for face in faces:
                shape = predictor(gray, face)
                shape = face_utils.shape_to_np(shape)

                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]

                leftEyeAspectRatio = eye_aspect_ratio(leftEye)
                rightEyeAspectRatio = eye_aspect_ratio(rightEye)

                leftEyeHull = cv2.convexHull(leftEye)
                rightEyeHull = cv2.convexHull(rightEye)
                cv2.drawContours(frame, [leftEyeHull], -1, (0, 255, 0), 1)
                cv2.drawContours(frame, [rightEyeHull], -1, (0, 255, 0), 1)

                if (leftEyeAspectRatio + rightEyeAspectRatio) / 2 < EYE_ASPECT_RATIO_THRESHOLD:
                    counter += 1
                    if counter >= EYE_ASPECT_RATIO_CONSEC_FRAMES:
                        pygame.mixer.music.play(-1)
                        cv2.putText(frame, "You are Drowsy", (150, 200), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (0, 0, 255), 2)
                        # cv2.putText(frame, "DROWSINESS ALERT!", (10, 30),
                        # cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
                else:
                    pygame.mixer.music.stop()
                    counter = 0



            cv2.imshow("Drowsiness Detection", frame)
            key = cv2.waitKey(1) & 0xFF

            if key == ord("q") or event == 'Stop':
                break

        # window.refresh()
        #
        # event, values = window.Read()








video_capture.release()
cv2.destroyAllWindows()

