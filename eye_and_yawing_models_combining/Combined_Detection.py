from scipy.spatial import distance as dist
from imutils import face_utils
import pygame #For playing sound
import time
import dlib
import cv2
import numpy as np

#--------Initialize Pygame and load music------
pygame.mixer.init()
pygame.mixer.music.load('Alarm.wav')

#--------Minimum threshold of eye aspect ratio below which alarm is triggerd-------
EYE_ASPECT_RATIO_THRESHOLD = 0.3

#--------Minimum consecutive frames for which eye ratio is below threshold for alarm to be triggered-------
EYE_ASPECT_RATIO_CONSEC_FRAMES = 30

#-------COunts no. of consecutuve frames below threshold value---------
COUNTER = 0

#--------Load face cascade which will be used to draw a rectangle around detected faces---------.
face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

#--------This function calculates and return eye aspect ratio---------
def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])

    ear = (A+B) / (2*C)
    return ear

def cal_yawn(shape):
    top_lip = shape[50:53]
    top_lip = np.concatenate((top_lip, shape[61:64]))

    low_lip = shape[56:59]
    low_lip = np.concatenate((low_lip, shape[65:68]))

    top_mean = np.mean(top_lip, axis=0)
    low_mean = np.mean(low_lip, axis=0)

    distance = dist.euclidean(top_mean, low_mean)
    return distance

#-------Load face detector and predictor, uses dlib shape predictor file------
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')

#------Extract indexes of facial landmarks for the left and right eye------
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS['left_eye']
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS['right_eye']

# --------Variables-------
yawn_thresh = 35
ptime = 0

#--------Start webcam video capture---------
video_capture = cv2.VideoCapture(0)

#---------Give some time for camera to initialize(not required)-----------
time.sleep(2)

while(True):
    #------------------ Read each frame and flip it, and convert to grayscale ---------------
    ret, frame = video_capture.read()

    if not ret:
        break

    frame = cv2.flip(frame, 1)

    # ---------FPS------------#
    ctime = time.time()
    fps = int(1 / (ctime - ptime))
    ptime = ctime
    cv2.putText(frame, f'FPS:{fps}', (frame.shape[1] - 120, frame.shape[0] - 20), cv2.FONT_HERSHEY_PLAIN, 2,
                (0, 200, 0), 3)


    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # ------------------ Detect facial points through detector function ------------------
    faces = detector(gray, 0)

    # ---------------- Detect faces through haarcascade_frontalface_default.xml -------------
    face_rectangle = face_cascade.detectMultiScale(gray, 1.3, 5)

    # ------------- Draw rectangle around each face detected ----------
    for (x, y, w, h) in face_rectangle:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)

    #Detect facial points
    for face in faces:

        # ----- Detecting landMarks --------
        shapes = predictor(gray, face)
        shape = face_utils.shape_to_np(shapes)

        #----------- Get array of coordinates of leftEye and rightEye -------------
        leftEye = shape[lStart:lEnd]
        rightEye = shape[rStart:rEnd]

        # -------------- Calculate aspect ratio of both eyes ---------------
        leftEyeAspectRatio = eye_aspect_ratio(leftEye)
        rightEyeAspectRatio = eye_aspect_ratio(rightEye)

        eyeAspectRatio = (leftEyeAspectRatio + rightEyeAspectRatio) / 2

        # --------------- Use hull to remove convex contour discrepencies and draw eye shape around eyes -----------
        leftEyeHull = cv2.convexHull(leftEye)
        rightEyeHull = cv2.convexHull(rightEye)
        cv2.drawContours(frame, [leftEyeHull], -1, (0, 255, 0), 1)
        cv2.drawContours(frame, [rightEyeHull], -1, (0, 255, 0), 1)

        # -------Detecting/Marking the lower and upper lip--------#
        lip = shape[48:60]
        cv2.drawContours(frame, [lip], -1, (0, 165, 255), thickness=3)

        # -------Calculating the lip distance-----#
        lip_dist = cal_yawn(shape)

        #-----Detect if eye aspect ratio is less than threshold-----
        if(eyeAspectRatio < EYE_ASPECT_RATIO_THRESHOLD):
            COUNTER += 1
            #-------If no. of frames is greater than threshold frames-------
            if COUNTER >= EYE_ASPECT_RATIO_CONSEC_FRAMES:
                pygame.mixer.music.play(-1)
                cv2.putText(frame, "You are Drowsy", (150, 200), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (0, 0, 255), 2)
        elif lip_dist > yawn_thresh:
            pygame.mixer.music.play(-1)
            cv2.putText(frame, f'you are Yawning!', (frame.shape[1] // 2 - 170, frame.shape[0] // 2),
                        cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 200), 2)
        else:
            pygame.mixer.music.stop()
            COUNTER = 0

    #------------- Display the frame -------------
    cv2.imshow("Video", frame)

    # ------------ Exit the loop if the 'q' key is pressed --------------
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# --------------- Finally when video capture is over, release the video capture and destroyAllWindows -----------
video_capture.release()
cv2.destroyAllWindows()