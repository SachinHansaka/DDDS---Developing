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
        detection_process = subprocess.Popen('/Users/chalana/Desktop/DDDS---Developing/App/Combined_Detection.py')
        #return 'Detection started!'



    elif request.form['submit_button'] == 'Stop':
        # Find the process ID of the running script
        detection_process.terminate()
        #return 'Detection stopped!'

    return render_template('new2.html')

if __name__ == '__main__':
    app.run()



