#!/usr/bin/env python3

#  WARNING: no longer need for this proxy!!!!!

# This simple wrapper calls Neovim Remote and passes arguments from Unity
# USe with Unity args:
# --remote $(File) -c $(Line)

import sys
#from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QMessageBox
from subprocess import call

#n = 'Number of arguments: ' + str(len(sys.argv)) + ' arguments.\nArgument List: ' + str(sys.argv)
# Call nvr
s = sys.argv;
s[0] = "/usr/bin/nvr"
#s[2] = s[2].replace('\'','')
call(s)

# Popup terminal
# call(["/usr/bin/bash", "-c", "echo 'dropterminal()' | awesome-client "])


#def window():
#   app = QApplication(sys.argv)
#   b = QPushButton()
#   b.setText(n)
#   b.clicked.connect(lambda: app.quit())
#   b.show()
#   sys.exit(app.exec_())
#
#if __name__ == '__main__': 
#   window()
