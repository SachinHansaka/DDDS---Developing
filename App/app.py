from flask import Flask, render_template, request, redirect
import subprocess

app = Flask(__name__)

@app.route('/')
#@app.route('/home')
def home():  # put application's code here
    return render_template("new2.html")

@app.route('/startstop', methods=['POST',"GET"])
def start_stop():
    if request.form['submit_button'] == 'Start':
        global detection_process
        subprocess.Popen('/Users/chalana/Desktop/Driver-drowsiness-detection-system-alert-app/Drowsiness detection with GUI/Combined_Detection.py')
        #return redirect("new2.html")
    elif request.form['submit_button'] == 'Stop':
        detection_process.terminate()
    return render_template('new2.html')

if __name__ == '__main__':
    app.run()



